# Introduction

OSI 是 open system interconnection 的縮寫

#TODO

資料在 OSI model 中的不同層有不同的名稱：

|OSI Layer|Name of Data|
|:-:|:-:|
|Application Layer|Message|
|Transport Layer|Segment|
|Network Layer|Datagram|
|Data-Linke Layer|Frame|
|Physical Layer|Bit|

# Application Layer (Layer 7)

常見的 application layer protocol 包括 `HTTP`、`FTP`、`WS`、`DHCP` 等。

#TODO

# Transport Layer (Layer 4)

Transport layer protocol 只有 `TCP` 與 `UDP` 兩種。

關於 TCP 的更多細節請見[本文](</Network/TCP.draft.md>)。

#TODO

# Network Layer (Layer 3)

Network layer protocol 有 `IP`、`ICMP` 與 `ARP` 三種（其實嚴格來說，[ARP](</Network/MAC Address & ARP.md>) 是介於 network layer 與 data-link layer 間的 protocol）。

#TODO

# Data-Link Layer (Layer 2)

Data-link layer 有時也被稱為 link layer。

# Physical Layer (Layer 1)

#TODO

# 參考資料

#TODO

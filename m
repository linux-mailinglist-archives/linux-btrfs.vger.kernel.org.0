Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC92E25C301
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgICOmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgICOif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 10:38:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78844C061251
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 06:13:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a17so3172320wrn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2lmN5M8l8QQvP/jy3zfOHn6wE4gXKnd3Wqlx8VfYcCQ=;
        b=lFTxgd7SXajovK0NS0yX4RSEaNcuoB67bKpnsYx0xeDR6dCn8qzmAD5V6wUcC3U9JT
         B1gUSkLlZ3cJqrHFO+NpWj07yJXH5jfRpp/2P1oDxX5Z4z4ZrVNXP6AvmG9y0DuvVjaB
         7r2voY89NuQR+4TV1M6ZZ47NmvjajJDSTSWJLgHpWNDoO6cUl63jUVYpkqjbkOs1VEjN
         +jvr0u7HXx5l8rhOiz9uWCs7wpIvRJcFtPvgrs6dbjh4/n82fvFrulWq4PZWcxPPT2Fn
         +CZzEYp2d6rqA+4MnQdy96HwtjxD/NaLD4OAFxTWcd8IN3we/Ga98Ucpgl+y2XGouV6W
         etHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2lmN5M8l8QQvP/jy3zfOHn6wE4gXKnd3Wqlx8VfYcCQ=;
        b=DxuydINNDbN/hOkY1OjDTOHGmhig2I8+jVhvqP8CnV8h9o+OKvWnDib0d11n8nJfbe
         VE9ZYfKk6T2T7in5x3LGzuHhKoNEUkD4VleqS34S/hvXEKyah7T8o9yVMOCoEL3CcAso
         gaJgHQSg+SXB7Ud2RN0iuNCxC35exZaY/wS5vOlxhuVVxmNFNEu3j0+Iggxr0lG5Jjnv
         fZlQhDK7RYmGXX/tHayby70QEAJ4TK2l5MRBdzPKo7QeeUlOJkmoxs1wKAD7vs5SLwhx
         9Xpyu2M0v8B54x4Am+2iJpPbnJPcwRoVctoNjTZT/tXohkWLMuSyBKszzycPB6z/BlmP
         70vA==
X-Gm-Message-State: AOAM531qRWHSWNW79na5QTcTw3T9J0SNYrvLX27uE54QeXQUdnmOo5hV
        jwkyWEvPoQS7NLQanJu0b/w2WX4UG9g=
X-Google-Smtp-Source: ABdhPJxmhdtGVaXXQ9Os4CEtGPF0q64oCW5pc9kmLrr6KQwyXEuw0rulv7OZBOfn12ebHFfNoX43dQ==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr2433524wrt.409.1599138830369;
        Thu, 03 Sep 2020 06:13:50 -0700 (PDT)
Received: from ?IPv6:2001:718:2:119a:147:32:132:32? ([2001:718:2:119a:147:32:132:32])
        by smtp.gmail.com with ESMTPSA id b194sm4699158wmd.42.2020.09.03.06.13.49
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:13:49 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>
Subject: Btrfs RAID-10 performance
Message-ID: <b12ff987-e631-8202-246e-1b72142ab8e3@gmail.com>
Date:   Thu, 3 Sep 2020 15:13:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

we are using btrfs RAID-10 (/data, 4.7TB) on a physical Supermicro 
server with Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz and 125GB of RAM. 
We run 'btrfs scrub start -B -d /data' every Sunday as a cron task. It 
takes about 50 minutes to finish.

# uname -a
Linux imap 4.9.0-12-amd64 #1 SMP Debian 4.9.210-1 (2020-01-20) x86_64 
GNU/Linux

RAID is a composition of 16 harddrives. Harddrives are connected via 
AVAGO MegaRAID SAS 9361-8i as a RAID-0 devices. All harddrives are SAS 
2.5" 15k drives.

Server serves as a IMAP with Dovecot 2.2.27-3+deb9u6, 4104 accounts, 
Mailbox format, LMTP delivery.

We run 'rsync' to remote NAS daily. It takes about 6.5 hours to finish, 
12'265'387 files last night.


Last half year, we encoutered into performace troubles. Server load 
grows up to 30 in rush hours, due to IO waits. We tried to attach next 
harddrives (the 838G ones in a list below) and increase a free space by 
rebalace. I think, it helped a little bit, not not so rapidly.

Is this a reasonable setup and use case for btrfs RAID-10? If so, are 
there some recommendations to achieve better performance?

Thank you. With kind regards
Milo



# megaclisas-status
-- Controller information --
-- ID | H/W Model                  | RAM    | Temp | BBU    | Firmware
c0    | AVAGO MegaRAID SAS 9361-8i | 1024MB | 72C  | Good   | FW: 
24.16.0-0082

-- Array information --
-- ID | Type   |    Size |  Strpsz | Flags | DskCache |   Status |  OS 
Path | CacheCade |InProgress
c0u0  | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdq | None      |None
c0u1  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sda | None      |None
c0u2  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdb | None      |None
c0u3  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdc | None      |None
c0u4  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdd | None      |None
c0u5  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sde | None      |None
c0u6  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdf | None      |None
c0u7  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdg | None      |None
c0u8  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdh | None      |None
c0u9  | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdi | None      |None
c0u10 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdj | None      |None
c0u11 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdk | None      |None
c0u12 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdl | None      |None
c0u13 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdm | None      |None
c0u14 | RAID-0 |    558G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdn | None      |None
c0u15 | RAID-0 |    838G |  256 KB | RA,WB |  Enabled |  Optimal | 
/dev/sdr | None      |None

-- Disk information --
-- ID   | Type | Drive Model                       | Size     | Status 
        | Speed    | Temp | Slot ID  | LSI ID
c0u0p0  | HDD  | SEAGATE ST900MP0006 N003WAG0Q3S3  | 837.8 Gb | Online, 
Spun Up | 12.0Gb/s | 53C  | [8:14]   | 32
c0u1p0  | HDD  | HGST HUC156060CSS200 A3800XV250TJ | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 38C  | [8:0]    | 12
c0u2p0  | HDD  | HGST HUC156060CSS200 A3800XV3XT4J | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 43C  | [8:1]    | 11
c0u3p0  | HDD  | HGST HUC156060CSS200 ADB05ZG4XLZU | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 46C  | [8:2]    | 25
c0u4p0  | HDD  | HGST HUC156060CSS200 A3800XV3DWRL | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 48C  | [8:3]    | 14
c0u5p0  | HDD  | HGST HUC156060CSS200 A3800XV3XZTL | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 52C  | [8:4]    | 18
c0u6p0  | HDD  | HGST HUC156060CSS200 A3800XV3VSKJ | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 55C  | [8:5]    | 15
c0u7p0  | HDD  | SEAGATE ST600MP0006 N003WAF1LWKE  | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 56C  | [8:6]    | 28
c0u8p0  | HDD  | HGST HUC156060CSS200 A3800XV3XTDJ | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 55C  | [8:7]    | 20
c0u9p0  | HDD  | HGST HUC156060CSS200 A3800XV3T8XL | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 57C  | [8:8]    | 19
c0u10p0 | HDD  | HGST HUC156060CSS200 A7030XHL0ZYP | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 61C  | [8:9]    | 23
c0u11p0 | HDD  | HGST HUC156060CSS200 ADB05ZG4VR3P | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 60C  | [8:10]   | 24
c0u12p0 | HDD  | SEAGATE ST600MP0006 N003WAF195KA  | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 60C  | [8:11]   | 29
c0u13p0 | HDD  | SEAGATE ST600MP0006 N003WAF1LTZW  | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 56C  | [8:12]   | 26
c0u14p0 | HDD  | SEAGATE ST600MP0006 N003WAF1LWH6  | 558.4 Gb | Online, 
Spun Up | 12.0Gb/s | 55C  | [8:13]   | 27
c0u15p0 | HDD  | SEAGATE ST900MP0006 N003WAG0Q414  | 837.8 Gb | Online, 
Spun Up | 12.0Gb/s | 47C  | [8:15]   | 33



# btrfs --version
btrfs-progs v4.7.3



# btrfs fi show
Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
         Total devices 16 FS bytes used 3.49TiB
         devid    1 size 558.41GiB used 448.66GiB path /dev/sda
         devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
         devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
         devid    5 size 558.41GiB used 448.66GiB path /dev/sde
         devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
         devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
         devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
         devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
         devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
         devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
         devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
         devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
         devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
         devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
         devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
         devid   19 size 837.84GiB used 448.66GiB path /dev/sdq



# btrfs fi df /data/
Data, RAID10: total=3.48TiB, used=3.47TiB
System, RAID10: total=256.00MiB, used=320.00KiB
Metadata, RAID10: total=21.00GiB, used=18.17GiB
GlobalReserve, single: total=512.00MiB, used=0.00B



I do not attach whole dmesg log. It is almost empty, without errors. 
Only lines about BTRFS are about relocations, like:

BTRFS info (device sda): relocating block group 29435663220736 flags 65
BTRFS info (device sda): found 54460 extents
BTRFS info (device sda): found 54459 extents

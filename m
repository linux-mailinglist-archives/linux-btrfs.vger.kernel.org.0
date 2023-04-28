Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63EE6F1D4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbjD1RUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbjD1RUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 13:20:35 -0400
Received: from web08-new.wopsa.net (web08-new.wopsa.net [85.118.206.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4D2D50
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grim.se;
        s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5uK24FEJx2pz7AF0duBT68dea7Sgh60V5wYNIVSX0RI=; b=b69YvM4hAHyQqaj9i4ZyYrV3h6
        WWzESIbbpqgr3z7sA+imx+WXk/E9rLOCaO9bBD7f7KJo+dF1DyCkUbzT60NFcoz+SvL3bfATCSMGh
        8m6O/zg9NzLh85DM+Jvq4BI9EwArpzogJ5kUunLQw1FzekP3bkp7WvuZrEN9WM9Kbw//TfxumNnUH
        B2z5UYxeyOBl6bM7WKDarMKnNarzP5qrL4BF3uXMx84Rh22BuWZsEZQf53YgsbqJuyGi4DBntDL49
        bH2Z5jZEdQSYqtJDO/P7uNYfS9FTBiR1lfjlhQluHa/GNk1iKznGNqTJftcZVI1D07+QHuOwGFiR/
        cSDNokWA==;
Received: from 213-66-205-249-no2550.tbcn.telia.com ([213.66.205.249]:38552 helo=[192.168.1.64])
        by web08-new.wopsa.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gunnar1@grim.se>)
        id 1psRlj-00Goaw-2Z
        for linux-btrfs@vger.kernel.org;
        Fri, 28 Apr 2023 19:20:29 +0200
Message-ID: <6553b40d-b674-3731-8644-b738c0ee21a0@grim.se>
Date:   Fri, 28 Apr 2023 19:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     linux-btrfs@vger.kernel.org
Content-Language: sv-SE
From:   Gunnar Grim <gunnar1@grim.se>
Subject: Tree block corrupted, bad tree block start
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - web08-new.wopsa.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grim.se
X-Get-Message-Sender-Via: web08-new.wopsa.net: authenticated_id: gunnar@grim.se
X-Authenticated-Sender: web08-new.wopsa.net: gunnar@grim.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

My clonezilla cloned root partition on my new SSD logs an error once 
every minute:

BTRFS error (device nvme0n1p1): bad tree block start, want 1603822157824 
have 0

The partition mounts fine and everything seems to work except for the 
above logging and that both balance and scrub fails.

I have tried to find if there is an unreadable file with
     find /xxxx -type f -exec cp {} /dev/null ;
where xxxx is all directories in / except dev, proc and sys. No error 
was reported.
Apparently all files on the root partition can be accessed and fully 
read, still I get all those BTRFS errors logged.

I don't dare run btrfs check --repair because of allthe warnings here: 
https://btrfs.readthedocs.io/en/latest/btrfs-check.html

Should I run btrfs check --repair or is there some less dangerous way to 
fix the problem?

TIA,
Gunnar

Below is the output from various commands:

Output of uname -a

Linux gunnar 5.14.21-150400.24.60-default #1 SMP PREEMPT_DYNAMIC Wed Apr 
12 12:13:32 UTC 2023 (93dbe2e) x86_64 x86_64 x86_64 GNU/Linux

Output of btrfs --version

btrfs-progs v5.14

Output of btrfs fi show

Label: none  uuid: 02e6a056-947f-41c5-a1f0-bf3a613864d4
         Total devices 1 FS bytes used 66.22GiB
         devid    1 size 202.86GiB used 80.03GiB path /dev/nvme0n1p1

Label: none  uuid: 727abbd3-c7cc-4eaf-bf56-4ae088176abc
         Total devices 1 FS bytes used 399.20GiB
         devid    1 size 1.62TiB used 401.02GiB path /dev/nvme0n1p2

Label: none  uuid: 38ba5ab4-cba0-40ec-ba77-d0c7bd3780aa
         Total devices 1 FS bytes used 22.20GiB
         devid    1 size 60.00GiB used 31.07GiB path /dev/sda3


Output of btrfs fi df /

Data, single: total=77.00GiB, used=63.86GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=3.00GiB, used=2.37GiB
GlobalReserve, single: total=188.12MiB, used=0.00B

Output of dmesg

[ 9612.419056] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9643.152148] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9673.884090] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9704.596570] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9735.336245] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9766.026138] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9796.751880] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9827.464856] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9858.188082] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0
[ 9888.911285] BTRFS error (device nvme0n1p1): bad tree block start, 
want 1603822157824 have 0

Output of btrfs-check /dev/nvme0n1p1 (unmouted from rescue USB)

Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 02e6a056-947f-41c5-a1f0-bf3a613864d4
The following tree block(s) is corrupted in tree 7761:
     tree block bytenr: 1603858104320, level: 2, node key: (11723738, 
96, 3471)
found 70855102464 bytes used, error(s) found
total csum bytes: 58760784
total tree bytes: 2535309312
total fs tree bytes: 2338357248
total extent tree bytes: 114114560
btree space waste bytes: 439342803
file data blocks allocated: 682434134016
  referenced 231583764480

Output of btrfs balance start

[  +2,912330] BTRFS info (device nvme0n1p1): balance: start -d -m -s
[  +0,000091] BTRFS info (device nvme0n1p1): relocating block group 
1611841667072 flags data
[  +0,777521] BTRFS info (device nvme0n1p1): found 10 extents, stage: 
move data extents
[  +0,113849] BTRFS info (device nvme0n1p1): found 10 extents, stage: 
update data pointers
[  +0,060942] BTRFS info (device nvme0n1p1): relocating block group 
1611808112640 flags system
[  +0,000052] BTRFS error (device nvme0n1p1): bad tree block start, want 
1603822157824 have 0
[  +0,033844] BTRFS info (device nvme0n1p1): found 1 extents, stage: 
move data extents
[  +0,034096] BTRFS info (device nvme0n1p1): relocating block group 
1603822157824 flags metadata
[  +0,020984] BTRFS error (device nvme0n1p1): bad tree block start, want 
1603822157824 have 0
[  +0,000093] BTRFS error (device nvme0n1p1): bad tree block start, want 
1603822157824 have 0
[  +0,013843] BTRFS info (device nvme0n1p1): balance: ended with status: -5

Output of btrfs scrub start -B /

scrub done for 02e6a056-947f-41c5-a1f0-bf3a613864d4
Scrub started:    Fri Apr 28 10:22:16 2023
Status:           finished
Duration:         0:00:22
Total to scrub:   80.03GiB
Rate:             3.01GiB/s
Error summary:    csum=1
   Corrected:      0
   Uncorrectable:  1
   Unverified:     0
ERROR: there are uncorrectable errors



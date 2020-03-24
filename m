Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F32191A6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCXUAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 16:00:04 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:57019 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgCXUAE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 16:00:04 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id GpiSjILgLa1lLGpiTjGnjj; Tue, 24 Mar 2020 21:00:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585080001; bh=PFHp31sdzHRXIJBIB0fxzXTkw3uVzgqeTAXJxKSUOXE=;
        h=From;
        b=iR0XYwbV7wq8UGwY5jRWdJYRsulzoX47ZlwMvAIMcjYObPKVu1/BLgMsgDdQeGNqw
         LRkiMVcZP2vcmEgha+i3fVSLiSuV9Yyk+dYPMWLsiOl162ImiB8275Z9hl7yq/AskU
         Nom/A4Uk1kPXKh3HpUGxW6s8x/k3gErcW3tPRV4z6TYGMD3A4FuJ3a0XPZ+b63lnN+
         0JLbAdH6vPMshDp5w8xpn2KjUpSKy8apaxFcHd3JaASnqq4vgXrkghimmoItDMnq32
         1x8nyQgdAZrzfxACWS8FXKD4+MHv0OxSaaKytG7Ai2utQr9QJx7btlmzmJ1bdI8h+N
         W9XfvCGRiKflA==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=IkcTkHD0fZMA:10 a=moNAUu42ALSoEGsHl9UA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: btrfs-progs: RAID1C3/C4 missing some info in btrfs_raid_array
Message-ID: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
Date:   Tue, 24 Mar 2020 21:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPsoEs3U8wZfQnz0/dkC0p8vtCgnSCrODhZJN2hoKvrJ7KVXlxTI3qlNvZqr+q3Fe9S0rJKchPZVI1fqk3Pdp8/vXX2TybMrpAyUSWQTd8qilr23dQyE
 Fib4goFlRyuJ9ZkXU0gy3wcfmFhSNrEaigkqiZBLvpN+xfvOJrqEDkDHlauEavjkEg40fE0J0mDSZYxebhk9i+/cFmtWNPo0CpI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

I noticed that in btrfs-progs - volumes.c in the array "btrfs_raid_array", the info
raid_name and bg_flag are missing for the item BTRFS_RAID_RAID1C3 and BTRFS_RAID_RAID1C4.

Is it wanted ? Which is the reason to do that ?

BR
G.Baroncelli
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

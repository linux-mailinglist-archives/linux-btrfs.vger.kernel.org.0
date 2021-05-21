Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2167E38CB3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhEUQoT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 12:44:19 -0400
Received: from mail.dubielvitrum.pl ([91.194.229.150]:34585 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237750AbhEUQoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 12:44:12 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 12:44:12 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id B906B9D5CB2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 18:34:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oxedGncqGJBa for <linux-btrfs@vger.kernel.org>;
        Fri, 21 May 2021 18:34:28 +0200 (CEST)
Received: from [192.168.55.108] (93.159.186.235.studiowik.net.pl [93.159.186.235])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id B653E9D5AB5
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 18:34:28 +0200 (CEST)
To:     linux-btrfs@vger.kernel.org
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Btrfs not using all devices in raid1
Message-ID: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
Date:   Fri, 21 May 2021 18:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello!

Why Btrfs is not using /dev/sdc2?
There is no line "Data,RAID1" for this disk.
Isn't it supposed to use disk that has most of free space?

Thanks for help :) :)
Using Btrfs in production.


Here are some command outputs:



### btrfs fi show /

Label: none  uuid: ea6ae51d-d9b0-4628-a8f3-3406e1dc59c6
     Total devices 4 FS bytes used 2.96TiB
     devid    1 size 7.25TiB used 3.20TiB path /dev/sda2
     devid    2 size 7.25TiB used 3.20TiB path /dev/sdb2
     devid    3 size 7.25TiB used 3.21TiB path /dev/sdd2
     devid    4 size 7.25TiB used 32.00MiB path /dev/sdc2



### btrfs fi df /

Data, RAID1: total=4.49TiB, used=2.90TiB
System, RAID1: total=64.00MiB, used=784.00KiB
Metadata, RAID1: total=321.00GiB, used=56.08GiB
GlobalReserve, single: total=512.00MiB, used=0.00B



### btrfs dev usa /

/dev/sda2, ID: 1
    Device size:             7.25TiB
    Device slack:              0.00B
    Data,RAID1:              2.99TiB
    Metadata,RAID1:        210.00GiB
    System,RAID1:           64.00MiB
    Unallocated:             4.05TiB

/dev/sdb2, ID: 2
    Device size:             7.25TiB
    Device slack:              0.00B
    Data,RAID1:              3.00TiB
    Metadata,RAID1:        210.00GiB
    Unallocated:             4.04TiB

/dev/sdc2, ID: 4
    Device size:             7.25TiB
    Device slack:              0.00B   ... no Data/RAID1
    System,RAID1:           32.00MiB
    Unallocated:             7.25TiB

/dev/sdd2, ID: 3
    Device size:             7.25TiB
    Device slack:              0.00B
    Data,RAID1:              2.99TiB
    Metadata,RAID1:        222.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             4.04TiB



### time btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /

Done, had to relocate 0 out of 4922 chunks

real    0m0,522s
user    0m0,000s
sys    0m0,033s



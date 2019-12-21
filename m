Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15A1288C4
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLUK7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 05:59:54 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47137 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLUK7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 05:59:53 -0500
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.155] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E8BE4C0005;
        Sat, 21 Dec 2019 10:59:51 +0000 (UTC)
To:     "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Subject: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
Message-ID: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
Date:   Sat, 21 Dec 2019 11:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

After writing files and snapshots WITHOUT errors on an external BTRFS FS 
with 500+ GB of free space, using kernel 5.4.5-arch1-1, I dismount the 
FS then remount it normally, and then it says the FS has 0 space free left !

Checking the disk on another machine with

[moksha ~]# uname -r
5.4.2-1-MANJARO

And... How can this be ?

root@moksha:~# df -h /run/media/myself/MyVolume
Filesystem           Size  Used Avail Use% Mounted on
/dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww   1,9T 1,2T     0 100% 
/run/media/myself/MyVolume

root@moksha:~# btrfs fi sh
Label: 'MyVolume'  uuid: xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
         Total devices 1 FS bytes used 1.19TiB
         devid    1 size 1.82TiB used 1.20TiB path 
/dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww

root@moksha:~# btrfs fi df /run/media/myself/MyVolume
Data, single: total=1.18TiB, used=1.18TiB
System, DUP: total=8.00MiB, used=160.00KiB
Metadata, DUP: total=7.00GiB, used=6.88GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

root@moksha:~# umount /run/media/myself/MyVolume

root@moksha:~# btrfs check /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
UUID: xxxxxxxxx-yyyy-zzzz-tttt-wwwwwww
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots

(Still running since a while, no errors...)

TIA for any help.

Kind regards.


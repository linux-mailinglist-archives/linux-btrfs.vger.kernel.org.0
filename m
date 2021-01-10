Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964892F05DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbhAJHlm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 10 Jan 2021 02:41:42 -0500
Received: from mail.eclipso.de ([217.69.254.104]:50102 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbhAJHlm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 02:41:42 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 611993EE
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 08:41:01 +0100 (CET)
Date:   Sun, 10 Jan 2021 08:41:00 +0100
MIME-Version: 1.0
Message-ID: <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: Re: cloning a btrfs drive with send and receive: clone is bigger
                than  the original?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <Cedric.dewijs@eclipso.eu>
Cc:     <arvidjaar@gmail.com>, <linux-btrfs@vger.kernel.org>
In-Reply-To: <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
        <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
        <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've tested some more.

Repeatedly sending the difference between two consecutive snapshots creates a structure on the target drive where all the snapshots share data. So 10 snapshots of 10 files of 100MB takes up 1GB, as expected.

Repeatedly sending the difference between the first snapshot and each next snapshot creates a structure on the target drive where the snapshots are independent, so they don't share any data. How can that be avoided?

Script (version that sends the difference between the first snapshot and each current snapshot):
# cat ~/btrfs-send-test.sh 
#!/bin/bash

btrfs subvolume delete /mnt/send/storage
btrfs subvolume delete /mnt/send/snapshots/*
btrfs subvolume delete /mnt/send/snapshots/
btrfs subvolume delete /mnt/rec/diff
btrfs subvolume delete /mnt/rec/snapshots/*
btrfs subvolume delete /mnt/rec/snapshots/
sync
btrfs subvolume create /mnt/send/storage
btrfs subvolume create /mnt/send/snapshots/
btrfs subvolume create /mnt/rec/diff
btrfs subvolume create /mnt/rec/snapshots

btrfs subvolume snapshot -r /mnt/send/storage/ /mnt/send/snapshots/0
btrfs send /mnt/send/snapshots/0 | btrfs receive /mnt/rec/snapshots

onelesscounter=0
counter=1
while [ $counter -le 10 ]
do
	dd if=/dev/urandom of=/mnt/send/storage/file$( printf %03d "$counter" ).bin bs=1M count=100
	md5sum /mnt/send/storage/file$( printf %03d "$counter" ).bin >> /mnt/send/storage/md5sums.txt
	btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/snapshots/$counter
	btrfs send -p /mnt/send/snapshots/0 /mnt/send/snapshots/$counter -f /mnt/rec/diff/$counter
	#btrfs send -p /mnt/send/snapshots/$onelesscounter /mnt/send/snapshots/$counter -f /mnt/rec/diff/$counter 
	btrfs receive -f /mnt/rec/diff/$counter /mnt/rec/snapshots
	((counter++))
	((onelesscounter++))
done
echo All done

# df -h
/dev/sda3       5.0G 1007M  3.6G  22% /mnt/send
/dev/sdd2       932G   11G  919G   2% /mnt/rec

# ls -lh /mtn/rec/diff
total 5.4G
-rw------- 1 root root  101M Jan 10 09:17 1
-rw------- 1 root root 1001M Jan 10 09:19 10
-rw------- 1 root root  201M Jan 10 09:17 2
-rw------- 1 root root  301M Jan 10 09:17 3
-rw------- 1 root root  401M Jan 10 09:17 4
-rw------- 1 root root  501M Jan 10 09:17 5
-rw------- 1 root root  601M Jan 10 09:18 6
-rw------- 1 root root  701M Jan 10 09:18 7
-rw------- 1 root root  801M Jan 10 09:18 8
-rw------- 1 root root  901M Jan 10 09:18 9

#rm /mtn/rec/diff/*
#sync

# df -h
/dev/sda3       5.0G 1007M  3.6G  22% /mnt/send
/dev/sdd2       932G  5.4G  924G   1% /mnt/rec  <= all data is individually stored in the snapshots?



---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!



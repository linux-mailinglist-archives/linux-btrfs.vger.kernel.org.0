Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4610D1A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfK2G4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 01:56:35 -0500
Received: from mailproxy02.manitu.net ([217.11.48.66]:58166 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfK2G4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 01:56:34 -0500
Received: from [IPv6:2003:c4:5f47:6700:1771:1cbd:391a:a730] (p200300C45F47670017711CBD391AA730.dip0.t-ipconnect.de [IPv6:2003:c4:5f47:6700:1771:1cbd:391a:a730])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: robin@jahr2038problem.de)
        by mailproxy02.manitu.net (Postfix) with ESMTPSA id 6040210200CF
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 07:56:33 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   btrfsquestion@jahr2038problem.de
Subject: Timestamp received snapshot is strange
Message-ID: <9011c74e-fe92-8baf-5175-98141d9e63ce@jahr2038problem.de>
Date:   Fri, 29 Nov 2019 07:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a question regarding the timestapmp of snapshots on a BTRFS system

I tried to send snapshots as part of backup to another system but I hit 
a problem.
Most snapshots had the timestamp based on the receiving time and a few 
had the timestamp the original snapshot was created.
Here is an ls

  LANG=C ls -lah
total 0
drwxr-xr-x 1 root root 1.7K Nov 28 20:36 .
drwxr-xr-x 1 root root   38 Nov 12 14:19 ..
drwxr-xr-x 1 root root   10 Nov 16 18:38 home-snapshot-16.11.2019-10:07
drwxr-xr-x 1 root root   10 Nov 16 19:41 home-snapshot-16.11.2019-18:49
drwxr-xr-x 1 root root   10 Nov 17 11:38 home-snapshot-17.11.2019-10:43
drwxr-xr-x 1 root root   10 Nov 19 08:00 home-snapshot-19.11.2019-07:21
drwxr-xr-x 1 root root   10 Nov 22 20:44 home-snapshot-22.11.2019-20:14
drwxr-xr-x 1 root root   10 Nov 23 18:22 home-snapshot-23.11.2019-17:29
drwxr-xr-x 1 root root   10 Nov 23 18:00 home-snapshot-23.11.2019-18:00
drwxr-xr-x 1 root root   10 Nov 24 14:29 home-snapshot-23.11.2019-19:03
drwxr-xr-x 1 root root   10 Nov 24 14:56 home-snapshot-24.11.2019-09:50
drwxr-xr-x 1 root root   10 Nov 24 15:03 home-snapshot-24.11.2019-10:31
drwxr-xr-x 1 root root   10 Nov 24 15:07 home-snapshot-24.11.2019-10:53
drwxr-xr-x 1 root root   10 Nov 24 15:10 home-snapshot-24.11.2019-11:01
drwxr-xr-x 1 root root   10 Nov 24 15:17 home-snapshot-24.11.2019-11:32
drwxr-xr-x 1 root root   10 Nov 24 15:30 home-snapshot-24.11.2019-12:32
drwxr-xr-x 1 root root   10 Nov 24 15:30 home-snapshot-24.11.2019-13:33
drwxr-xr-x 1 root root   10 Nov 24 15:35 home-snapshot-24.11.2019-14:34
drwxr-xr-x 1 root root   10 Nov 24 15:56 home-snapshot-24.11.2019-15:34
drwxr-xr-x 1 root root   10 Nov 24 17:28 home-snapshot-24.11.2019-16:34
drwxr-xr-x 1 root root   10 Nov 28 08:34 home-snapshot-24.11.2019-18:59
drwxr-xr-x 1 root root   10 Nov 28 08:38 home-snapshot-25.11.2019-07:12
drwxr-xr-x 1 root root   10 Nov 28 08:48 home-snapshot-25.11.2019-19:33
drwxr-xr-x 1 root root   10 Nov 28 08:52 home-snapshot-26.11.2019-07:23
drwxr-xr-x 1 root root   10 Nov 28 09:02 home-snapshot-26.11.2019-19:24
drwxr-xr-x 1 root root   10 Nov 28 09:10 home-snapshot-27.11.2019-07:26
drwxr-xr-x 1 root root   10 Nov 28 09:22 home-snapshot-27.11.2019-19:30
drwxr-xr-x 1 root root   10 Nov 28 09:30 home-snapshot-27.11.2019-20:31
drwxr-xr-x 1 root root   10 Nov 27 21:32 home-snapshot-27.11.2019-21:32
drwxr-xr-x 1 root root   10 Nov 28 20:48 home-snapshot-28.11.2019-08:15

this is a view from the source

drwxr-xr-x 1 root root   10 Nov 24 16:34 home-snapshot-24.11.2019-16:34
drwxr-xr-x 1 root root   10 Nov 24 18:59 home-snapshot-24.11.2019-18:59
drwxr-xr-x 1 root root   10 Nov 25 07:12 home-snapshot-25.11.2019-07:12
drwxr-xr-x 1 root root   10 Nov 25 19:33 home-snapshot-25.11.2019-19:33
drwxr-xr-x 1 root root   10 Nov 26 07:23 home-snapshot-26.11.2019-07:23
drwxr-xr-x 1 root root   10 Nov 26 19:24 home-snapshot-26.11.2019-19:24
drwxr-xr-x 1 root root   10 Nov 27 07:26 home-snapshot-27.11.2019-07:26
drwxr-xr-x 1 root root   10 Nov 27 19:30 home-snapshot-27.11.2019-19:30
drwxr-xr-x 1 root root   10 Nov 27 20:31 home-snapshot-27.11.2019-20:31
drwxr-xr-x 1 root root   10 Nov 27 21:32 home-snapshot-27.11.2019-21:32
drwxr-xr-x 1 root root   10 Nov 28 07:14 home-snapshot-28.11.2019-07:14
drwxr-xr-x 1 root root   10 Nov 28 08:15 home-snapshot-28.11.2019-08:15
drwxr-xr-x 1 root root   10 Nov 28 09:15 home-snapshot-28.11.2019-09:15
drwxr-xr-x 1 root root   10 Nov 28 19:33 home-snapshot-28.11.2019-19:33

As you can see on the last two snapshots of the receiving site the 
snapshot "home-snapshot-27.11.2019-21:32" is the only one with a date 
based on receiving time. I wrote that script to transfer the snapshots

#!/bin/bash
snapshotdir=$1
remotedest=$2
remotesnapshotdir=$3
localsnapshot=$(ls -t $snapshotdir |head -n 1)
lastremotesnapshot=$(ssh -l root $remotedest "ls -t $remotesnapshotdir | 
head -n 1")
if [ "$lastremotesnapshot" == "" ]; then
   echo Fehler bei der SSH Verbindung
   exit 1
fi
#alte snapshots aufäumen
foundposition=$(ls -tr $snapshotdir |grep -n $lastremotesnapshot |cut 
-f1 -d:)
nextsnapshot=`ls -tr $snapshotdir | head -n $((foundposition+1))|tail -n 1`
if [ "$foundposition" -ge 11 ]; then
   ls $snapshotdir -tr|head -n $((foundposition -10)) |awk -v 
dir="$snapshotdir" '{print "btrfs subvolume delete "dir""$1}' |sh
fi
if [ "$lastremotesnapshot" != "$localsnapshot" ]; then
   if [ -d $snapshotdir$lastremotesnapshot ]; then
     btrfs send -p $snapshotdir$lastremotesnapshot 
$snapshotdir$nextsnapshot |lzop -1 | ssh -l root $remotedest "lzop -d | 
btrfs receive $remotesnapshotdir"
     if [ "$?" -ne 0 ]; then
       exit 1
     fi
     $0 $1 $2 $3
     exit $?
   else
     echo Snapshot Ursprung fehlt bitte Manuell übertragen
     exit 1
   fi
else
   echo Snapshots bereits aktuell
   exit 0
fi

But that scriped fails if it ancounters a problem with the order of the 
snapshots.

But what is the reason of the different timestamps? And how can I avoid it?

recieving site

uname -a
Linux miniserver 4.19.82-gentoo #4 SMP Tue Nov 19 19:55:09 CET 2019 
x86_64 AMD A4-5000 APU with Radeon(TM) HD Graphics AuthenticAMD 
GNU/Linux btrfs --version
btrfs-progs v5.3.1

sending site

uname -a
Linux robindesk 5.3.13-arch1-1 #1 SMP PREEMPT Sun, 24 Nov 2019 10:15:50 
+0000 x86_64 GNU/Linux
btrfs --version
btrfs-progs v5.3.1


greetings



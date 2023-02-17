Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374D669B19D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBQRMa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 17 Feb 2023 12:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQRM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 12:12:29 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65B656B6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 09:12:26 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4C50F5409EE;
        Fri, 17 Feb 2023 17:12:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3226D540729;
        Fri, 17 Feb 2023 17:12:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676653944; a=rsa-sha256;
        cv=none;
        b=PvP/pvLQdRYpM8EAguxhDAL5lxCLO0z42F++ID8GwSNTARKH2SxPhen7BCQk2T8IQg/onv
        JTHC3TAZvrtZmz0TzuvrM0W6gcQxphlGpnRl8dQfrpmik8IWyPu1hKdVDeloiqsUJ++svg
        MaaWl2n85DGfh1jGe/zgADdIZqB+G1OsNZT6qgKCRlOsEahhBTtTmI21PhJuP36ro79uqd
        TGLo5lslaxf9tS9nk4SxPO2bjQ5NoAJD37vdg/XQMXk04io2/3+ngo+CGUfo73rpPocNZ/
        /XkK7o9c+o9fpJCmTdbp9x/SZLdgoLJo7gQxpMCu2UdGVdiYReUDguOzK1UCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676653944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGtRrbfgtsQP/5RMbhJIoO39mXgGUIFtCKet++uV5ns=;
        b=hXtin8NxiGoMugNN1ulkfV9lkGzA+9+PUI9LD81DH37CxsnX1+RLcfl6G/KjSBvz7e092V
        507AYQcMV0C4couOOnxlXXWvBBCfbb+XlvO2HNrQF5/aTxX7XcXmuAeOiCSJovkvieE/gm
        vXTbfNMlJH/tUcm9ADzzbWoqI3PIKsMDeeF+xFp2Db3360iqKsXBRxlbBEEXQD+LxMuUCu
        7zZMWYgLMq0yCM3UKrDJYF4cHUVZj6pSz76FBiPzPEpRyMuy+svuoobZ2pLoD4D6Ae4AUG
        ZuMpDsg7Sok85MeW9W3WKf/UL59XERMjj9a9Xp4Of1s5iaclwGKMM5DrrjIvOQ==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-ckdrb;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Ruddy-Hysterical: 2799d1d518cc1009_1676653945001_2409675679
X-MC-Loop-Signature: 1676653945001:2369849462
X-MC-Ingress-Time: 1676653945001
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.30.49 (trex/6.7.1);
        Fri, 17 Feb 2023 17:12:24 +0000
Received: from p5b071f3f.dip0.t-ipconnect.de ([91.7.31.63]:47686 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pT4HT-0000qZ-Kn;
        Fri, 17 Feb 2023 17:12:22 +0000
Message-ID: <d02fb95aecf51439c7784c990784f73a11412e4b.camel@scientia.org>
Subject: Re: back&forth send/receiving?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Date:   Fri, 17 Feb 2023 18:12:11 +0100
In-Reply-To: <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
         <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
         <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
         <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
         <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
         <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.2
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Andrei.



On Mon, 2023-02-06 at 09:46 +0300, Andrei Borzenkov wrote:
> OK, that's not exactly "all on different mediums", but rather several
> (independent) chains of incremental snapshots, with each chain on a
> different medium.

Yes.



> You can always incrementally send, there is no problem. To actually
> receive *and apply* incremental stream you need base snapshot (or
> identical copy of base snapshot) to apply the changes to.

Back then in my first thread[0] about this, I had the impression that
it is not ought to work:
Hugo Mills said so in [1].
You also commented and I'm not sure whether I understood it correctly
back then,... but the following paragraph of yours I'd understand that
it's not intended to work, right?

> So if you
> make copy1 your new master, there is no way to continue incremental
> send/receive to copy2, copy3, ... because copy2, copy3, ... do not
> have snapshots present on copy1.
> 
> Same if you would copy/clone copy1 to another HDD.

Below you'll find a simulation of what I'd do in my use case.
First starting off with one master and a few copies (each of which
receive the line of incremental snapshots) and then I decommission
master and introduce a new-master (filling it with data from copy1) and
then continue with the incremental snapshots from that new-master to
the copies.

And... it does seem to work (already).
I'm just still not sure whether it's really safe or just a
"coincidence" that it does work:

--------------------------------------------------------------------

// make a few mountpoints and empty image-files (with btrfs on them)
// that will be used to simulate different HDDs
// new-master is not used in the beginning
// <dir># being a root-user prompt

~# mkdir -p mnt/{master,new-master,copy1,copy2}
~# truncate -s 1G {master,new-master,copy1,copy2}.img
~# for n in master new-master copy1 copy2; do mkfs.btrfs -L $n $n.img; done
...
~# mount master.img mnt/master/
~# mount copy1.img mnt/copy1/
~# mount copy2.img mnt/copy2/


// simulate adding some data

~# cd mnt/master/
~/mnt/master# btrfs subvolume create data
Create subvolume './data'
~/mnt/master# echo REV1 > data/small-file


// the first ever round of snapshots (on master) and backups of that
// snapshot from master to the copyN HDDs
// send|receive is obviously non-incremental
//
// I run receive with /usr/bin/time -v to see how much was actually written:
// "File system outputs" is in 512B blocks

~/mnt/master# btrfs subvolume snapshot -r data/ snap-1
Create a readonly snapshot of 'data/' in './snap-1'
~/mnt/master# btrfs send snap-1 | /usr/bin/time -v btrfs receive ~/mnt/copy1/
At subvol snap-1
At subvol snap-1
	Command being timed: "btrfs receive /root/mnt/copy1/"
	User time (seconds): 0.00
	System time (seconds): 0.00
	Percent of CPU this job got: 6%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.09
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3524
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 186
	Voluntary context switches: 9
	Involuntary context switches: 11
	Swaps: 0
	File system inputs: 0
	File system outputs: 424
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
~/mnt/master# btrfs send snap-1 | /usr/bin/time -v btrfs receive ~/mnt/copy2/
At subvol snap-1
At subvol snap-1
	Command being timed: "btrfs receive /root/mnt/copy2/"
	User time (seconds): 0.00
	System time (seconds): 0.00
	Percent of CPU this job got: 1%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.40
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3488
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 184
	Voluntary context switches: 7
	Involuntary context switches: 10
	Swaps: 0
	File system inputs: 0
	File system outputs: 424
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

// at this point, snap-1 from master should be on copy1 and copy2


// simulate some more changes of files on the master using a "big" file
// this time to see whether incremental send|receive works

~/mnt/master# dd if=/dev/urandom of=data/big-file bs=1M count=512
512+0 records in
512+0 records out
536870912 bytes (537 MB, 512 MiB) copied, 2,74663 s, 195 MB/s
~/mnt/master# echo REV2 > data/small-file


// the second round of snapshots (on master) and backups of that
// snapshot from master to the copyN HDDs
// this time with INCREMENTAL send|receive

~/mnt/master# btrfs subvolume snapshot -r data/ snap-2
Create a readonly snapshot of 'data/' in './snap-2'
~/mnt/master# btrfs send -p snap-1 snap-2 | /usr/bin/time -v btrfs receive ~/mnt/copy1/
At subvol snap-2
At snapshot snap-2
	Command being timed: "btrfs receive /root/mnt/copy1/"
	User time (seconds): 0.12
	System time (seconds): 0.82
	Percent of CPU this job got: 29%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:03.27
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3600
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 201
	Voluntary context switches: 156
	Involuntary context switches: 7802
	Swaps: 0
	File system inputs: 0
	File system outputs: 1049640
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
~/mnt/master# btrfs send -p snap-1 snap-2 | /usr/bin/time -v btrfs receive ~/mnt/copy2/
At subvol snap-2
At snapshot snap-2
	Command being timed: "btrfs receive /root/mnt/copy2/"
	User time (seconds): 0.06
	System time (seconds): 0.76
	Percent of CPU this job got: 35%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.32
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3576
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 203
	Voluntary context switches: 52
	Involuntary context switches: 11726
	Swaps: 0
	File system inputs: 0
	File system outputs: 1049512
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

// at this point, both copyN HDDs should have snap-2
// in bot cases File system outputs: was around 1049640
// which is ~500MB... obviously, since the big-file was new


// just for convenience, some UUIDs from the (old) master

~/mnt/master# cd 
~# btrfs subvolume list -paguqR mnt/master/
ID 256 gen 8 parent 5 top level 5 parent_uuid -                                    received_uuid -                                    uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 path data
ID 257 gen 7 parent 5 top level 5 parent_uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 received_uuid -                                    uuid 6fb6191a-413e-4d46-aa65-0fb30dd8a606 path snap-1
ID 265 gen 8 parent 5 top level 5 parent_uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 received_uuid -                                    uuid f38aaffc-226f-d748-949e-5c9677440e14 path snap-2


// at this point, master HDD breaks or is simply scheduled to be
// replaced by a new one (here I really use a new one, and DON'T make
// e.g. copy1 the new master)

~# umount mnt/master 
~# rm -f master.img ; rmdir mnt/master/
~# mount new-master.img mnt/new-master/


// next, I populate the new master with the latest data from copy1 HDD
// obviously, non-incrementally

~# cd mnt/copy1/
~/mnt/copy1# btrfs send snap-2 | /usr/bin/time -v btrfs receive ~/mnt/new-master/
At subvol snap-2
At subvol snap-2
	Command being timed: "btrfs receive /root/mnt/new-master/"
	User time (seconds): 0.09
	System time (seconds): 0.55
	Percent of CPU this job got: 22%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.85
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3452
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 197
	Voluntary context switches: 63
	Involuntary context switches: 8513
	Swaps: 0
	File system inputs: 0
	File system outputs: 1049608
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

// again, ~500MB transferred, just as expected


// now, I create a new working area of the received snapshot on the new master
// this is simply a RW snapshot of that, and will be the place where I add new files
// modify or delete existing ones

~/mnt/copy1# cd ../new-master/
~/mnt/new-master# btrfs subvolume snapshot snap-2 data
Create a snapshot of 'snap-2' in './data'


// just a poor check whether the files are still in the most recent state

~/mnt/new-master# cat data/small-file 
REV2
~/mnt/new-master# diff data/big-file ../copy1/snap-2/big-file  ; echo $?
0


// simulate another round of modifying files on the (now new) master

~/mnt/new-master# dd if=/dev/urandom of=data/medium-file bs=1M count=5
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0339809 s, 154 MB/s
~/mnt/new-master# echo REV3 > data/small-file


// the third round of snapshots (now on/from the new master) and
// backups of that snapshot from (new) master to the copyN HDDs
// important point: again INCREMENTAL send|receive

~/mnt/new-master# btrfs subvolume snapshot -r data/ snap-3
Create a readonly snapshot of 'data/' in './snap-3'
~/mnt/new-master# btrfs send -p snap-2 snap-3 | /usr/bin/time -v btrfs receive ~/mnt/copy1/
At subvol snap-3
At snapshot snap-3
	Command being timed: "btrfs receive /root/mnt/copy1/"
	User time (seconds): 0.00
	System time (seconds): 0.01
	Percent of CPU this job got: 5%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.33
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3524
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 200
	Voluntary context switches: 27
	Involuntary context switches: 184
	Swaps: 0
	File system inputs: 0
	File system outputs: 10696
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
~/mnt/new-master# btrfs send -p snap-2 snap-3 | /usr/bin/time -v btrfs receive ~/mnt/copy2/
At subvol snap-3
At snapshot snap-3
	Command being timed: "btrfs receive /root/mnt/copy2/"
	User time (seconds): 0.00
	System time (seconds): 0.01
	Percent of CPU this job got: 6%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.39
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 3564
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 198
	Voluntary context switches: 19
	Involuntary context switches: 192
	Swaps: 0
	File system inputs: 0
	File system outputs: 10824
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

// at this point, the copyN HDDs should have snap-3 from the new master
// created incrementally, using their snap-2 (which they've still received
// from the OLD master... and which was also received on new master from copy1)
// File system outputs is in both cases ~ 10824, which is a bit more than 5 MB,...
// just the newly added medium-file in run 3... especially no 500 MB from
// the big-file, so seems, that incremental send|receive did in fact work


// "verifying" this:

~/mnt/new-master# cd ..
~/mnt# md5sum new-master/data/small-file copy1/snap-3/small-file copy2/snap-3/small-file
78a0b89f84b68d690067b06522b39452  new-master/data/small-file
78a0b89f84b68d690067b06522b39452  copy1/snap-3/small-file
78a0b89f84b68d690067b06522b39452  copy2/snap-3/small-file
~/mnt# md5sum new-master/data/medium-file copy1/snap-3/medium-file copy2/snap-3/medium-file 
06352daf5656d20a870405d82d1e6d79  new-master/data/medium-file
06352daf5656d20a870405d82d1e6d79  copy1/snap-3/medium-file
06352daf5656d20a870405d82d1e6d79  copy2/snap-3/medium-file
~/mnt# md5sum new-master/data/big-file copy1/snap-3/big-file copy2/snap-3/big-file 
4b0fe1b47cd2be7dcdf7337a7b0782ae  new-master/data/big-file
4b0fe1b47cd2be7dcdf7337a7b0782ae  copy1/snap-3/big-file
4b0fe1b47cd2be7dcdf7337a7b0782ae  copy2/snap-3/big-file



// looking at the UUIDs

~/mnt# btrfs subvolume list -paguqR  new-master/
ID 256 gen  9 parent 5 top level 5 parent_uuid -                                    received_uuid f38aaffc-226f-d748-949e-5c9677440e14 uuid 4a098904-a9a0-214b-8009-88a70f0bbe77 path snap-2
ID 265 gen 11 parent 5 top level 5 parent_uuid 4a098904-a9a0-214b-8009-88a70f0bbe77 received_uuid -                                    uuid 22d82a1b-f764-5243-8f43-3f8f492b718e path data
ID 266 gen 10 parent 5 top level 5 parent_uuid 22d82a1b-f764-5243-8f43-3f8f492b718e received_uuid -                                    uuid 76db9591-2d8c-094a-9f78-c976bd4d3264 path snap-3
~/mnt# btrfs subvolume list -paguqR  copy1/
ID 256 gen  9 parent 5 top level 5 parent_uuid -                                    received_uuid 6fb6191a-413e-4d46-aa65-0fb30dd8a606 uuid fbc5489d-3738-694c-ba5e-ba36987f832b path snap-1
ID 257 gen 13 parent 5 top level 5 parent_uuid fbc5489d-3738-694c-ba5e-ba36987f832b received_uuid f38aaffc-226f-d748-949e-5c9677440e14 uuid 720bda11-1b92-fc45-8bb0-2a35a4c86f9d path snap-2
ID 266 gen 16 parent 5 top level 5 parent_uuid 720bda11-1b92-fc45-8bb0-2a35a4c86f9d received_uuid 76db9591-2d8c-094a-9f78-c976bd4d3264 uuid a77f24e1-f357-2148-9ca5-1240c4056cf3 path snap-3
~/mnt# btrfs subvolume list -paguqR  copy2/
ID 256 gen 10 parent 5 top level 5 parent_uuid -                                    received_uuid 6fb6191a-413e-4d46-aa65-0fb30dd8a606 uuid 5e73c53e-98b5-b44c-9d39-812c67f43fad path snap-1
ID 257 gen 14 parent 5 top level 5 parent_uuid 5e73c53e-98b5-b44c-9d39-812c67f43fad received_uuid f38aaffc-226f-d748-949e-5c9677440e14 uuid 33d07ed9-e216-954e-9c0c-b8f115546522 path snap-2
ID 264 gen 16 parent 5 top level 5 parent_uuid 33d07ed9-e216-954e-9c0c-b8f115546522 received_uuid 76db9591-2d8c-094a-9f78-c976bd4d3264 uuid 6bbf4bfd-5f9e-a347-89e4-6f58d6bfd035 path snap-3

from above:
~# btrfs subvolume list -paguqR mnt/master/
ID 256 gen 8 parent 5 top level 5 parent_uuid -                                    received_uuid -                                    uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 path data
ID 257 gen 7 parent 5 top level 5 parent_uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 received_uuid -                                    uuid 6fb6191a-413e-4d46-aa65-0fb30dd8a606 path snap-1
ID 265 gen 8 parent 5 top level 5 parent_uuid 5bc13acd-01f8-774f-913b-2833d0b99ed2 received_uuid -                                    uuid f38aaffc-226f-d748-949e-5c9677440e14 path snap-2


// AFAICS, the UUIDs are all correct (as far as they should have been in a chain)
--------------------------------------------------------------------


So from what I can tell... it actually does already work.
I'm just not really sure whether this is expected and can be considered
to be production ready... or whether it's just coincidence, that I
could do this "back & forth" send|receive.



> You need data at the exact point in time. According to your
> description each of copy1, copy2, ... captures different points in
> time.

They may or may not be.
Sometimes, I just send the same snapshot (e.g. from some specific date)
to all copyN ... sometimes the most recent one of all of them is
different.

But I always keep on (old) master the snapshot that are most recent on
each of copyN, so that I can continue from there, when I do the next
round of snapshot.

Of course, for the case when I switch from a old to a new master, I
would need the exactly same snapshot on all of copyN, so that I can
incrementally send|receive from the NEW master to the copyN.

It wouldn't need to be the most recent snapshot, AFAIU.

If e.g. I had the following snapshots:
copy1:
2023-01-01
2023-02-02

copy2:
2023-01-01
2023-01-15

and then want to switch from old to new master:
I'd use first copy1/2023-01-01 (NOT the most recent) to populate new-
master. And then copy1/2023-02-02 to bring new-master up2date.

Now in order to send a future new-master/2023-03-20 to copy1, I could
use 2023-02-02 as parent.
But not so for copy2.

However, I'd expect/hope, that for copy2, I could use the new-
master/2023-01-01 to still incrementally send|receive from new-master
to copy2.
It might of course require a bit more data than if I'd were able to use
2023-02-02, but still better than sending several TB from scratch.




Thanks,
Chris.


[0] https://lore.kernel.org/linux-btrfs/157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net/
[1]
https://lore.kernel.org/linux-btrfs/20210129192058.GN4090@savella.carfax.org.uk/

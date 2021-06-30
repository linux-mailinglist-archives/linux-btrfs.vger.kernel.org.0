Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004643B8020
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhF3JjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 05:39:12 -0400
Received: from www378.your-server.de ([78.47.166.48]:60146 "EHLO
        www378.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhF3JjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 05:39:11 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 05:39:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bock.nu;
        s=default2006; h=MIME-Version:Content-Type:Subject:To:From:Message-ID:Date:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References; bh=TNEgy1TL4ZoWit9vql5ya/YLq9p0TnTa+PGFmCLJ73c=; b=bk
        Z7GJ6NAYE9tjZmtZPoTKP9jbr8CIwV54sfzTUUBHHvfhvsVYxBbh6FMtIupItJgU1Iw2wSrceLL+s
        0IuYoUa3K+pbTpYh+Pd5JT1GEfFbVkkVeRGTihUTJZnVKtOtlW2mfkaGc8zfOG/sghziK3osy55JL
        X+Z+81iWzDIG3QQgRKWBIUehDeVztpmzFGHPAm1ad16u5ngy4fqWk4zYzudLhj2Q+lSLIxe+0+9MT
        V8XsRsgmHWo3G4ge9JXlzAuZttP7pf7QmYU764FOl7rjWTBNEi/wOcktJTlwhOoytZLzwy/Jmim/n
        0BIretkJaNofnL51D/e7eatGs5iP5F7Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www378.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <bernhard@bock.nu>)
        id 1lyWP3-0009nY-C4
        for linux-btrfs@vger.kernel.org; Wed, 30 Jun 2021 11:21:05 +0200
Received: from [192.168.0.32] (helo=webmail.your-server.de)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <bernhard@bock.nu>)
        id 1lyWP3-000Euz-93
        for linux-btrfs@vger.kernel.org; Wed, 30 Jun 2021 11:21:05 +0200
Received: from p200300c98f39330008E00aF63a4f6cD7.dip0.t-ipconnect.de
 (p200300c98f39330008E00aF63a4f6cD7.dip0.t-ipconnect.de
 [2003:c9:8f39:3300:8e0:af6:3a4f:6cd7]) by webmail.your-server.de (Horde
 Framework) with HTTPS; Wed, 30 Jun 2021 11:21:05 +0200
Date:   Wed, 30 Jun 2021 11:21:05 +0200
Message-ID: <20210630112105.Horde.--esBg1nCMcX5WI6c4tluy4@webmail.your-server.de>
From:   Bernhard Bock <bernhard@bock.nu>
To:     linux-btrfs@vger.kernel.org
Subject: recover from BTRFS critical: corrupt leaf: invalid extent length
User-Agent: Horde Application Framework 5
Content-Type: multipart/mixed; boundary="=_soRrXPz4ZQjklNzjuL32Qol"
MIME-Version: 1.0
X-Authenticated-Sender: bernhard@bock.nu
X-Virus-Scanned: Clear (ClamAV 0.103.2/26216/Tue Jun 29 13:09:49 2021)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This message is in MIME format.

--=_soRrXPz4ZQjklNzjuL32Qol
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline

Hi,

I found one of our servers with a read-only btrfs this morning.
dmesg says:

BTRFS critical (device dm-1): corrupt leaf: block=6404379377664  
slot=66 extent bytenr=3138606432256 len=18446619972284938920 invalid  
extent length, have 18446619972284938920 expect aligned to 4096
...
BTRFS error (device dm-1): block=6404379377664 write time tree block  
corruption detected

(more dmesg log statements in attached file).

The server has ECC RAM with no recorded memory errors in the system  
event log, FWIW.

More details:

# uname -a
Linux epyc 5.8.0-55-generic #62~20.04.1-Ubuntu SMP Wed Jun 2 08:55:04  
UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

# btrfs fi show
Label: none  uuid: b5aa9ceb-e88b-4689-8df3-9dcb769921e7
	Total devices 1 FS bytes used 6.51TiB
	devid    1 size 15.00TiB used 6.52TiB path /dev/mapper/vg_data-data

# btrfs fi df /srv
Data, single: total=6.50TiB, used=6.50TiB
System, DUP: total=8.00MiB, used=720.00KiB
Metadata, DUP: total=11.00GiB, used=9.92GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

# btrfsck --force --readonly /dev/mapper/vg_data-data
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/mapper/vg_data-data
UUID: b5aa9ceb-e88b-4689-8df3-9dcb769921e7
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
checksum verify failed on 4064351748096 found 000000A9 wanted FFFFFFD7
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 7154631286784 bytes used, no error found
total csum bytes: 6968339112
total tree bytes: 10673291264
total fs tree bytes: 2195308544
total extent tree bytes: 732889088
btree space waste bytes: 1172229075
file data blocks allocated: 10644722380800
  referenced 8686442565632

Any advice on next steps is welcome.

Thanks,
Bernhard


--=_soRrXPz4ZQjklNzjuL32Qol
Content-Type: text/plain; name=dmesg
Content-Disposition: attachment; size=46985; filename=dmesg

Jun 30 03:30:47 epyc backup.sh[3178407]: Delete subvolume (no-commit): '/srv/backup/snapshots/keepass/2021-05-30'
Jun 30 03:31:00 epyc backup.sh[3178408]: no parent snapshot found, will read all files
Jun 30 03:31:51 epyc kernel: [929434.961426] BTRFS critical (device dm-1): corrupt leaf: block=6404379377664 slot=66 extent bytenr=3138606432256 len=18446619972284938920 invalid extent length, have 18446619972284938920 expect aligned to 4096
Jun 30 03:31:51 epyc kernel: [929434.961483] BTRFS info (device dm-1): leaf 6404379377664 gen 4685626 total ptrs 131 free space 5557 owner 2
Jun 30 03:31:51 epyc kernel: [929434.961484] 	item 0 key (3138602971136 168 57344) itemoff 16233 itemsize 50
Jun 30 03:31:51 epyc kernel: [929434.961485] 		extent refs 2 gen 3322064 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961485] 		ref#0: shared data backref parent 2228988559360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961486] 		ref#1: shared data backref parent 2228324384768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961487] 	item 1 key (3138603028480 168 49152) itemoff 16183 itemsize 50
Jun 30 03:31:51 epyc kernel: [929434.961488] 		extent refs 2 gen 3324892 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961488] 		ref#0: shared data backref parent 2228988559360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961488] 		ref#1: shared data backref parent 2228324384768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961489] 	item 2 key (3138603077632 168 49152) itemoff 16133 itemsize 50
Jun 30 03:31:51 epyc kernel: [929434.961490] 		extent refs 2 gen 3327675 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961490] 		ref#0: shared data backref parent 2228988559360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961490] 		ref#1: shared data backref parent 2228324384768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961491] 	item 3 key (3138603126784 168 49152) itemoff 16083 itemsize 50
Jun 30 03:31:51 epyc kernel: [929434.961492] 		extent refs 2 gen 3345829 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961492] 		ref#0: shared data backref parent 2228988559360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961492] 		ref#1: shared data backref parent 2228324384768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961493] 	item 4 key (3138603175936 168 65536) itemoff 16030 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961493] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961494] 		ref#0: extent data backref root 277 objectid 43200 offset 16908288 count 1
Jun 30 03:31:51 epyc kernel: [929434.961495] 	item 5 key (3138603241472 168 65536) itemoff 15977 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961495] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961496] 		ref#0: extent data backref root 277 objectid 43200 offset 17039360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961497] 	item 6 key (3138603307008 168 61440) itemoff 15924 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961497] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961497] 		ref#0: extent data backref root 277 objectid 43200 offset 17170432 count 1
Jun 30 03:31:51 epyc kernel: [929434.961498] 	item 7 key (3138603372544 168 65536) itemoff 15871 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961498] 		extent refs 1 gen 4443749 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961499] 		ref#0: extent data backref root 7393 objectid 478 offset 3887726592 count 1
Jun 30 03:31:51 epyc kernel: [929434.961500] 	item 8 key (3138603438080 168 57344) itemoff 15818 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961500] 		extent refs 1 gen 4511913 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961500] 		ref#0: extent data backref root 277 objectid 41708 offset 61034496 count 1
Jun 30 03:31:51 epyc kernel: [929434.961501] 	item 9 key (3138603495424 168 57344) itemoff 15765 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961502] 		extent refs 1 gen 4511913 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961502] 		ref#0: extent data backref root 277 objectid 41708 offset 61165568 count 1
Jun 30 03:31:51 epyc kernel: [929434.961503] 	item 10 key (3138603552768 168 28672) itemoff 15712 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961503] 		extent refs 1 gen 4512027 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961503] 		ref#0: extent data backref root 277 objectid 43100 offset 89526272 count 1
Jun 30 03:31:51 epyc kernel: [929434.961504] 	item 11 key (3138603597824 168 12288) itemoff 15659 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961505] 		extent refs 1 gen 4531483 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961505] 		ref#0: extent data backref root 277 objectid 43250 offset 19189760 count 1
Jun 30 03:31:51 epyc kernel: [929434.961506] 	item 12 key (3138603610112 168 16384) itemoff 15606 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961506] 		extent refs 1 gen 4604134 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961506] 		ref#0: extent data backref root 277 objectid 43296 offset 109379584 count 1
Jun 30 03:31:51 epyc kernel: [929434.961507] 	item 13 key (3138603626496 168 49152) itemoff 15553 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961508] 		extent refs 1 gen 4514861 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961508] 		ref#0: extent data backref root 277 objectid 43250 offset 19808256 count 1
Jun 30 03:31:51 epyc kernel: [929434.961509] 	item 14 key (3138603675648 168 49152) itemoff 15500 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961509] 		extent refs 1 gen 4684678 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961509] 		ref#0: extent data backref root 277 objectid 36390 offset 83148800 count 1
Jun 30 03:31:51 epyc kernel: [929434.961510] 	item 15 key (3138603724800 168 45056) itemoff 15447 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961511] 		extent refs 1 gen 4684678 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961511] 		ref#0: extent data backref root 277 objectid 36390 offset 83279872 count 1
Jun 30 03:31:51 epyc kernel: [929434.961512] 	item 16 key (3138603786240 168 57344) itemoff 15394 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961512] 		extent refs 3 gen 4514861 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961512] 		ref#0: extent data backref root 277 objectid 43250 offset 20201472 count 3
Jun 30 03:31:51 epyc kernel: [929434.961513] 	item 17 key (3138603843584 168 49152) itemoff 15341 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961514] 		extent refs 4 gen 4531405 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961514] 		ref#0: extent data backref root 277 objectid 43250 offset 19181568 count 4
Jun 30 03:31:51 epyc kernel: [929434.961515] 	item 18 key (3138603896832 168 73728) itemoff 15288 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961515] 		extent refs 1 gen 3287846 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961516] 		ref#0: extent data backref root 277 objectid 40941 offset 44302336 count 1
Jun 30 03:31:51 epyc kernel: [929434.961516] 	item 19 key (3138603970560 168 61440) itemoff 15235 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961517] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961517] 		ref#0: extent data backref root 277 objectid 43200 offset 17301504 count 1
Jun 30 03:31:51 epyc kernel: [929434.961518] 	item 20 key (3138604032000 168 61440) itemoff 15182 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961518] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961519] 		ref#0: extent data backref root 277 objectid 43200 offset 17432576 count 1
Jun 30 03:31:51 epyc kernel: [929434.961520] 	item 21 key (3138604093440 168 61440) itemoff 15129 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961520] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961520] 		ref#0: extent data backref root 277 objectid 43200 offset 17563648 count 1
Jun 30 03:31:51 epyc kernel: [929434.961521] 	item 22 key (3138604158976 168 57344) itemoff 15076 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961521] 		extent refs 1 gen 4511913 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961522] 		ref#0: extent data backref root 277 objectid 41708 offset 61296640 count 1
Jun 30 03:31:51 epyc kernel: [929434.961523] 	item 23 key (3138604216320 168 57344) itemoff 15023 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961523] 		extent refs 1 gen 4511913 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961523] 		ref#0: extent data backref root 277 objectid 41708 offset 61427712 count 1
Jun 30 03:31:51 epyc kernel: [929434.961524] 	item 24 key (3138604273664 168 49152) itemoff 14970 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961524] 		extent refs 1 gen 4683683 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961525] 		ref#0: extent data backref root 277 objectid 36390 offset 125284352 count 1
Jun 30 03:31:51 epyc kernel: [929434.961526] 	item 25 key (3138604322816 168 24576) itemoff 14917 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961526] 		extent refs 1 gen 4684228 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961526] 		ref#0: extent data backref root 277 objectid 45336 offset 7405568 count 1
Jun 30 03:31:51 epyc kernel: [929434.961527] 	item 26 key (3138604347392 168 12288) itemoff 14864 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961528] 		extent refs 1 gen 4604149 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961528] 		ref#0: extent data backref root 277 objectid 43296 offset 98934784 count 1
Jun 30 03:31:51 epyc kernel: [929434.961529] 	item 27 key (3138604363776 168 12288) itemoff 14811 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961529] 		extent refs 1 gen 3668124 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961529] 		ref#0: extent data backref root 7393 objectid 472 offset 4559392768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961530] 	item 28 key (3138604376064 168 53248) itemoff 14758 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961531] 		extent refs 1 gen 3580612 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961531] 		ref#0: extent data backref root 277 objectid 40975 offset 92631040 count 1
Jun 30 03:31:51 epyc kernel: [929434.961532] 	item 29 key (3138604429312 168 57344) itemoff 14705 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961532] 		extent refs 1 gen 3580612 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961532] 		ref#0: extent data backref root 277 objectid 40975 offset 92762112 count 1
Jun 30 03:31:51 epyc kernel: [929434.961533] 	item 30 key (3138604486656 168 57344) itemoff 14652 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961534] 		extent refs 1 gen 3580612 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961534] 		ref#0: extent data backref root 277 objectid 40975 offset 92893184 count 1
Jun 30 03:31:51 epyc kernel: [929434.961535] 	item 31 key (3138604544000 168 45056) itemoff 14599 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961535] 		extent refs 1 gen 3580612 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961535] 		ref#0: extent data backref root 277 objectid 40975 offset 93024256 count 1
Jun 30 03:31:51 epyc kernel: [929434.961536] 	item 32 key (3138604589056 168 45056) itemoff 14546 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961537] 		extent refs 1 gen 3580613 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961537] 		ref#0: extent data backref root 277 objectid 40975 offset 101568512 count 1
Jun 30 03:31:51 epyc kernel: [929434.961538] 	item 33 key (3138604638208 168 45056) itemoff 14493 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961538] 		extent refs 1 gen 3580606 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961538] 		ref#0: extent data backref root 277 objectid 40975 offset 56885248 count 1
Jun 30 03:31:51 epyc kernel: [929434.961539] 	item 34 key (3138604683264 168 262144) itemoff 14440 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961540] 		extent refs 1 gen 4241410 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961540] 		ref#0: extent data backref root 1 objectid 1332 offset 0 count 1
Jun 30 03:31:51 epyc kernel: [929434.961541] 	item 35 key (3138604945408 168 90112) itemoff 14387 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961541] 		extent refs 1 gen 3288087 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961542] 		ref#0: extent data backref root 277 objectid 40963 offset 2228224 count 1
Jun 30 03:31:51 epyc kernel: [929434.961543] 	item 36 key (3138605035520 168 86016) itemoff 14334 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961543] 		extent refs 1 gen 3288087 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961543] 		ref#0: extent data backref root 277 objectid 40963 offset 2359296 count 1
Jun 30 03:31:51 epyc kernel: [929434.961544] 	item 37 key (3138605121536 168 86016) itemoff 14281 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961545] 		extent refs 1 gen 3288087 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961545] 		ref#0: extent data backref root 277 objectid 40963 offset 2490368 count 1
Jun 30 03:31:51 epyc kernel: [929434.961546] 	item 38 key (3138605207552 168 262144) itemoff 14228 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961546] 		extent refs 1 gen 3592793 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961546] 		ref#0: extent data backref root 277 objectid 41331 offset 74752000 count 1
Jun 30 03:31:51 epyc kernel: [929434.961547] 	item 39 key (3138605469696 168 69632) itemoff 14175 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961548] 		extent refs 1 gen 3287995 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961548] 		ref#0: extent data backref root 277 objectid 40945 offset 7340032 count 1
Jun 30 03:31:51 epyc kernel: [929434.961549] 	item 40 key (3138605539328 168 65536) itemoff 14122 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961549] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961549] 		ref#0: extent data backref root 277 objectid 43200 offset 17694720 count 1
Jun 30 03:31:51 epyc kernel: [929434.961550] 	item 41 key (3138605604864 168 65536) itemoff 14069 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961551] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961551] 		ref#0: extent data backref root 277 objectid 43200 offset 17825792 count 1
Jun 30 03:31:51 epyc kernel: [929434.961552] 	item 42 key (3138605670400 168 61440) itemoff 14016 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961552] 		extent refs 1 gen 4514467 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961552] 		ref#0: extent data backref root 277 objectid 43200 offset 17956864 count 1
Jun 30 03:31:51 epyc kernel: [929434.961553] 	item 43 key (3138605731840 168 32768) itemoff 13963 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961554] 		extent refs 1 gen 4614552 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961554] 		ref#0: extent data backref root 2558 objectid 211488 offset 0 count 1
Jun 30 03:31:51 epyc kernel: [929434.961555] 	item 44 key (3138605764608 168 53248) itemoff 13910 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961555] 		extent refs 1 gen 753743 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961556] 		ref#0: extent data backref root 277 objectid 30529 offset 24399872 count 1
Jun 30 03:31:51 epyc kernel: [929434.961557] 	item 45 key (3138605830144 168 32768) itemoff 13857 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961557] 		extent refs 1 gen 747485 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961557] 		ref#0: extent data backref root 277 objectid 29093 offset 31285248 count 1
Jun 30 03:31:51 epyc kernel: [929434.961558] 	item 46 key (3138605862912 168 8192) itemoff 13804 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961558] 		extent refs 1 gen 1092200 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961559] 		ref#0: extent data backref root 277 objectid 30636 offset 49274880 count 1
Jun 30 03:31:51 epyc kernel: [929434.961560] 	item 47 key (3138605871104 168 65536) itemoff 13751 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961560] 		extent refs 1 gen 1151017 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961560] 		ref#0: extent data backref root 277 objectid 33402 offset 46661632 count 1
Jun 30 03:31:51 epyc kernel: [929434.961561] 	item 48 key (3138605936640 168 8192) itemoff 13698 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961562] 		extent refs 1 gen 1524599 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961562] 		ref#0: extent data backref root 277 objectid 35992 offset 107028480 count 1
Jun 30 03:31:51 epyc kernel: [929434.961563] 	item 49 key (3138605944832 168 4096) itemoff 13645 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961563] 		extent refs 1 gen 2835347 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961563] 		ref#0: extent data backref root 277 objectid 39385 offset 23449600 count 1
Jun 30 03:31:51 epyc kernel: [929434.961564] 	item 50 key (3138605948928 168 16384) itemoff 13592 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961565] 		extent refs 1 gen 1124539 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961565] 		ref#0: extent data backref root 277 objectid 31135 offset 17391616 count 1
Jun 30 03:31:51 epyc kernel: [929434.961566] 	item 51 key (3138605965312 168 16384) itemoff 13539 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961566] 		extent refs 1 gen 1239768 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961566] 		ref#0: extent data backref root 277 objectid 6435 offset 103280640 count 1
Jun 30 03:31:51 epyc kernel: [929434.961567] 	item 52 key (3138605981696 168 40960) itemoff 13486 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961568] 		extent refs 2 gen 943453 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961568] 		ref#0: extent data backref root 277 objectid 31114 offset 41226240 count 2
Jun 30 03:31:51 epyc kernel: [929434.961569] 	item 53 key (3138606022656 168 16384) itemoff 13433 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961569] 		extent refs 1 gen 1375623 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961569] 		ref#0: extent data backref root 277 objectid 34957 offset 84828160 count 1
Jun 30 03:31:51 epyc kernel: [929434.961570] 	item 54 key (3138606039040 168 16384) itemoff 13380 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961571] 		extent refs 1 gen 1538117 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961571] 		ref#0: extent data backref root 277 objectid 35992 offset 106905600 count 1
Jun 30 03:31:51 epyc kernel: [929434.961572] 	item 55 key (3138606055424 168 45056) itemoff 13327 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961572] 		extent refs 1 gen 743362 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961573] 		ref#0: extent data backref root 277 objectid 30460 offset 110972928 count 1
Jun 30 03:31:51 epyc kernel: [929434.961574] 	item 56 key (3138606104576 168 57344) itemoff 13274 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961574] 		extent refs 1 gen 717416 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961574] 		ref#0: extent data backref root 277 objectid 29093 offset 30859264 count 1
Jun 30 03:31:51 epyc kernel: [929434.961575] 	item 57 key (3138606161920 168 32768) itemoff 13221 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961575] 		extent refs 1 gen 1119931 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961576] 		ref#0: extent data backref root 277 objectid 31135 offset 17375232 count 1
Jun 30 03:31:51 epyc kernel: [929434.961577] 	item 58 key (3138606194688 168 16384) itemoff 13168 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961577] 		extent refs 1 gen 3662554 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961577] 		ref#0: extent data backref root 7393 objectid 472 offset 549814272 count 1
Jun 30 03:31:51 epyc kernel: [929434.961578] 	item 59 key (3138606227456 168 49152) itemoff 13115 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961579] 		extent refs 1 gen 1153868 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961579] 		ref#0: extent data backref root 277 objectid 33684 offset 7864320 count 1
Jun 30 03:31:51 epyc kernel: [929434.961580] 	item 60 key (3138606284800 168 32768) itemoff 13062 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961580] 		extent refs 1 gen 867959 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961580] 		ref#0: extent data backref root 277 objectid 31024 offset 80240640 count 1
Jun 30 03:31:51 epyc kernel: [929434.961581] 	item 61 key (3138606317568 168 16384) itemoff 13009 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961582] 		extent refs 1 gen 1135765 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961582] 		ref#0: extent data backref root 277 objectid 31114 offset 16486400 count 1
Jun 30 03:31:51 epyc kernel: [929434.961583] 	item 62 key (3138606333952 168 16384) itemoff 12956 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961583] 		extent refs 1 gen 1482316 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961583] 		ref#0: extent data backref root 277 objectid 28178 offset 2826240 count 1
Jun 30 03:31:51 epyc kernel: [929434.961584] 	item 63 key (3138606350336 168 16384) itemoff 12903 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961585] 		extent refs 1 gen 1095019 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961585] 		ref#0: extent data backref root 277 objectid 29093 offset 55992320 count 1
Jun 30 03:31:51 epyc kernel: [929434.961586] 	item 64 key (3138606366720 168 40960) itemoff 12850 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961586] 		extent refs 1 gen 1119694 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961586] 		ref#0: extent data backref root 277 objectid 30993 offset 121679872 count 1
Jun 30 03:31:51 epyc kernel: [929434.961587] 	item 65 key (3138606407680 168 24576) itemoff 12797 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961588] 		extent refs 1 gen 1284060 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961588] 		ref#0: extent data backref root 260 objectid 1373587 offset 11558912 count 1
Jun 30 03:31:51 epyc kernel: [929434.961589] 	item 66 key (3138606432256 168 18446619972284938920) itemoff 12744 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961589] 		extent refs 1 gen 1122987 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961590] 		ref#0: extent data backref root 277 objectid 22863 offset 22618112 count 1
Jun 30 03:31:51 epyc kernel: [929434.961591] 	item 67 key (3138606481408 168 16384) itemoff 12691 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961591] 		extent refs 1 gen 1538153 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961591] 		ref#0: extent data backref root 277 objectid 36032 offset 26218496 count 1
Jun 30 03:31:51 epyc kernel: [929434.961592] 	item 68 key (3138606497792 168 24576) itemoff 12638 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961592] 		extent refs 1 gen 1202426 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961593] 		ref#0: extent data backref root 277 objectid 33188 offset 90484736 count 1
Jun 30 03:31:51 epyc kernel: [929434.961594] 	item 69 key (3138606522368 168 16384) itemoff 12585 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961594] 		extent refs 1 gen 1107011 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961594] 		ref#0: extent data backref root 277 objectid 29093 offset 62849024 count 1
Jun 30 03:31:51 epyc kernel: [929434.961595] 	item 70 key (3138606538752 168 40960) itemoff 12506 itemsize 79
Jun 30 03:31:51 epyc kernel: [929434.961595] 		extent refs 3 gen 4621546 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961596] 		ref#0: extent data backref root 260 objectid 5246407 offset 5881856 count 1
Jun 30 03:31:51 epyc kernel: [929434.961596] 		ref#1: shared data backref parent 4065031684096 count 1
Jun 30 03:31:51 epyc kernel: [929434.961597] 		ref#2: shared data backref parent 2228651180032 count 1
Jun 30 03:31:51 epyc kernel: [929434.961598] 	item 71 key (3138606583808 168 16384) itemoff 12453 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961598] 		extent refs 1 gen 1094906 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961598] 		ref#0: extent data backref root 277 objectid 30636 offset 45948928 count 1
Jun 30 03:31:51 epyc kernel: [929434.961599] 	item 72 key (3138606600192 168 24576) itemoff 12400 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961600] 		extent refs 1 gen 1124270 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961600] 		ref#0: extent data backref root 277 objectid 31114 offset 7991296 count 1
Jun 30 03:31:51 epyc kernel: [929434.961601] 	item 73 key (3138606628864 168 32768) itemoff 12347 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961601] 		extent refs 1 gen 930701 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961601] 		ref#0: extent data backref root 277 objectid 30993 offset 111398912 count 1
Jun 30 03:31:51 epyc kernel: [929434.961602] 	item 74 key (3138606669824 168 8192) itemoff 12294 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961603] 		extent refs 1 gen 1092200 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961603] 		ref#0: extent data backref root 277 objectid 30636 offset 49324032 count 1
Jun 30 03:31:51 epyc kernel: [929434.961604] 	item 75 key (3138606686208 168 8192) itemoff 12241 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961604] 		extent refs 1 gen 887634 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961604] 		ref#0: extent data backref root 277 objectid 29093 offset 86048768 count 1
Jun 30 03:31:51 epyc kernel: [929434.961605] 	item 76 key (3138606694400 168 16384) itemoff 12188 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961606] 		extent refs 1 gen 1155055 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961606] 		ref#0: extent data backref root 277 objectid 31961 offset 4427776 count 1
Jun 30 03:31:51 epyc kernel: [929434.961607] 	item 77 key (3138606723072 168 4096) itemoff 12135 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961607] 		extent refs 1 gen 948311 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961608] 		ref#0: extent data backref root 257 objectid 893212 offset 0 count 1
Jun 30 03:31:51 epyc kernel: [929434.961609] 	item 78 key (3138606727168 168 8192) itemoff 12082 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961609] 		extent refs 1 gen 1524746 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961609] 		ref#0: extent data backref root 277 objectid 34418 offset 121237504 count 1
Jun 30 03:31:51 epyc kernel: [929434.961610] 	item 79 key (3138606735360 168 4096) itemoff 12029 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961611] 		extent refs 1 gen 948311 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961611] 		ref#0: extent data backref root 257 objectid 893213 offset 0 count 1
Jun 30 03:31:51 epyc kernel: [929434.961612] 	item 80 key (3138606739456 168 8192) itemoff 11976 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961612] 		extent refs 1 gen 1705725 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961612] 		ref#0: extent data backref root 258 objectid 21739 offset 15302656 count 1
Jun 30 03:31:51 epyc kernel: [929434.961613] 	item 81 key (3138606751744 168 16384) itemoff 11923 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961614] 		extent refs 1 gen 1405842 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961614] 		ref#0: extent data backref root 7393 objectid 472 offset 717537280 count 1
Jun 30 03:31:51 epyc kernel: [929434.961615] 	item 82 key (3138606768128 168 4096) itemoff 11870 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961615] 		extent refs 1 gen 948311 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961615] 		ref#0: extent data backref root 257 objectid 893354 offset 0 count 1
Jun 30 03:31:51 epyc kernel: [929434.961616] 	item 83 key (3138606772224 168 32768) itemoff 11817 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961617] 		extent refs 1 gen 1265431 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961617] 		ref#0: extent data backref root 277 objectid 34573 offset 42983424 count 1
Jun 30 03:31:51 epyc kernel: [929434.961618] 	item 84 key (3138606809088 168 24576) itemoff 11764 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961618] 		extent refs 1 gen 939462 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961618] 		ref#0: extent data backref root 277 objectid 25612 offset 46399488 count 1
Jun 30 03:31:51 epyc kernel: [929434.961619] 	item 85 key (3138606833664 168 24576) itemoff 11711 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961620] 		extent refs 1 gen 1671695 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961620] 		ref#0: extent data backref root 277 objectid 2658 offset 75583488 count 1
Jun 30 03:31:51 epyc kernel: [929434.961621] 	item 86 key (3138606870528 168 16384) itemoff 11658 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961621] 		extent refs 1 gen 1363702 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961622] 		ref#0: extent data backref root 277 objectid 29093 offset 82214912 count 1
Jun 30 03:31:51 epyc kernel: [929434.961623] 	item 87 key (3138606886912 168 20480) itemoff 11605 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961623] 		extent refs 1 gen 1375643 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961623] 		ref#0: extent data backref root 277 objectid 34957 offset 84951040 count 1
Jun 30 03:31:51 epyc kernel: [929434.961624] 	item 88 key (3138606915584 168 8192) itemoff 11552 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961624] 		extent refs 1 gen 884837 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961625] 		ref#0: extent data backref root 277 objectid 29093 offset 37191680 count 1
Jun 30 03:31:51 epyc kernel: [929434.961626] 	item 89 key (3138606931968 168 8192) itemoff 11499 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961626] 		extent refs 1 gen 872459 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961626] 		ref#0: extent data backref root 277 objectid 27724 offset 80953344 count 1
Jun 30 03:31:51 epyc kernel: [929434.961627] 	item 90 key (3138606940160 168 16384) itemoff 11446 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961628] 		extent refs 1 gen 941448 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961628] 		ref#0: extent data backref root 277 objectid 28512 offset 118710272 count 1
Jun 30 03:31:51 epyc kernel: [929434.961629] 	item 91 key (3138606956544 168 8192) itemoff 11393 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961629] 		extent refs 1 gen 910815 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961629] 		ref#0: extent data backref root 277 objectid 27722 offset 43302912 count 1
Jun 30 03:31:51 epyc kernel: [929434.961630] 	item 92 key (3138606964736 168 45056) itemoff 11340 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961631] 		extent refs 1 gen 1123843 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961631] 		ref#0: extent data backref root 277 objectid 33360 offset 102170624 count 1
Jun 30 03:31:51 epyc kernel: [929434.961632] 	item 93 key (3138607009792 168 24576) itemoff 11287 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961632] 		extent refs 1 gen 1363583 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961632] 		ref#0: extent data backref root 277 objectid 530 offset 120320000 count 1
Jun 30 03:31:51 epyc kernel: [929434.961633] 	item 94 key (3138607034368 168 12288) itemoff 11234 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961634] 		extent refs 1 gen 1673388 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961634] 		ref#0: extent data backref root 277 objectid 37847 offset 1507328 count 1
Jun 30 03:31:51 epyc kernel: [929434.961635] 	item 95 key (3138607046656 168 16384) itemoff 11181 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961635] 		extent refs 1 gen 941463 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961636] 		ref#0: extent data backref root 277 objectid 28512 offset 113999872 count 1
Jun 30 03:31:51 epyc kernel: [929434.961637] 	item 96 key (3138607063040 168 24576) itemoff 11128 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961637] 		extent refs 1 gen 1119997 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961637] 		ref#0: extent data backref root 277 objectid 29093 offset 34111488 count 1
Jun 30 03:31:51 epyc kernel: [929434.961638] 	item 97 key (3138607087616 168 16384) itemoff 11075 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961638] 		extent refs 1 gen 1483414 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961639] 		ref#0: extent data backref root 277 objectid 33188 offset 66809856 count 1
Jun 30 03:31:51 epyc kernel: [929434.961640] 	item 98 key (3138607104000 168 8192) itemoff 11022 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961640] 		extent refs 1 gen 1041261 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961640] 		ref#0: extent data backref root 277 objectid 30435 offset 91967488 count 1
Jun 30 03:31:51 epyc kernel: [929434.961641] 	item 99 key (3138607120384 168 180224) itemoff 10969 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961642] 		extent refs 1 gen 867773 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961642] 		ref#0: extent data backref root 277 objectid 30803 offset 121139200 count 1
Jun 30 03:31:51 epyc kernel: [929434.961643] 	item 100 key (3138607300608 168 110592) itemoff 10916 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961643] 		extent refs 1 gen 867805 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961643] 		ref#0: extent data backref root 277 objectid 31429 offset 2228224 count 1
Jun 30 03:31:51 epyc kernel: [929434.961644] 	item 101 key (3138607411200 168 98304) itemoff 10863 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961645] 		extent refs 1 gen 867805 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961645] 		ref#0: extent data backref root 277 objectid 31429 offset 2621440 count 1
Jun 30 03:31:51 epyc kernel: [929434.961646] 	item 102 key (3138607509504 168 73728) itemoff 10810 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961646] 		extent refs 1 gen 867805 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961646] 		ref#0: extent data backref root 277 objectid 31429 offset 14155776 count 1
Jun 30 03:31:51 epyc kernel: [929434.961647] 	item 103 key (3138607583232 168 12288) itemoff 10757 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961648] 		extent refs 1 gen 884041 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961648] 		ref#0: extent data backref root 277 objectid 31546 offset 80596992 count 1
Jun 30 03:31:51 epyc kernel: [929434.961649] 	item 104 key (3138607607808 168 8192) itemoff 10704 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961649] 		extent refs 1 gen 1041445 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961650] 		ref#0: extent data backref root 277 objectid 29093 offset 91521024 count 1
Jun 30 03:31:51 epyc kernel: [929434.961651] 	item 105 key (3138607616000 168 16384) itemoff 10651 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961651] 		extent refs 1 gen 990439 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961651] 		ref#0: extent data backref root 277 objectid 6515 offset 36548608 count 1
Jun 30 03:31:51 epyc kernel: [929434.961652] 	item 106 key (3138607632384 168 8192) itemoff 10598 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961652] 		extent refs 1 gen 872360 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961653] 		ref#0: extent data backref root 277 objectid 29093 offset 58769408 count 1
Jun 30 03:31:51 epyc kernel: [929434.961654] 	item 107 key (3138607640576 168 16384) itemoff 10298 itemsize 300
Jun 30 03:31:51 epyc kernel: [929434.961654] 		extent refs 20 gen 1555474 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961654] 		ref#0: extent data backref root 260 objectid 2525013 offset 712704 count 1
Jun 30 03:31:51 epyc kernel: [929434.961655] 		ref#1: shared data backref parent 6404754423808 count 1
Jun 30 03:31:51 epyc kernel: [929434.961655] 		ref#2: shared data backref parent 6404492050432 count 1
Jun 30 03:31:51 epyc kernel: [929434.961656] 		ref#3: shared data backref parent 6404334731264 count 1
Jun 30 03:31:51 epyc kernel: [929434.961656] 		ref#4: shared data backref parent 6404274257920 count 1
Jun 30 03:31:51 epyc kernel: [929434.961657] 		ref#5: shared data backref parent 6404154933248 count 1
Jun 30 03:31:51 epyc kernel: [929434.961657] 		ref#6: shared data backref parent 5894391332864 count 1
Jun 30 03:31:51 epyc kernel: [929434.961658] 		ref#7: shared data backref parent 5893838241792 count 1
Jun 30 03:31:51 epyc kernel: [929434.961658] 		ref#8: shared data backref parent 4848645193728 count 1
Jun 30 03:31:51 epyc kernel: [929434.961659] 		ref#9: shared data backref parent 4064753188864 count 1
Jun 30 03:31:51 epyc kernel: [929434.961659] 		ref#10: shared data backref parent 4064677740544 count 1
Jun 30 03:31:51 epyc kernel: [929434.961660] 		ref#11: shared data backref parent 3673526517760 count 1
Jun 30 03:31:51 epyc kernel: [929434.961660] 		ref#12: shared data backref parent 3095403806720 count 1
Jun 30 03:31:51 epyc kernel: [929434.961661] 		ref#13: shared data backref parent 3095327326208 count 1
Jun 30 03:31:51 epyc kernel: [929434.961661] 		ref#14: shared data backref parent 3095164747776 count 1
Jun 30 03:31:51 epyc kernel: [929434.961662] 		ref#15: shared data backref parent 3095154917376 count 1
Jun 30 03:31:51 epyc kernel: [929434.961662] 		ref#16: shared data backref parent 3094854959104 count 1
Jun 30 03:31:51 epyc kernel: [929434.961663] 		ref#17: shared data backref parent 2228271251456 count 1
Jun 30 03:31:51 epyc kernel: [929434.961663] 		ref#18: shared data backref parent 1447340752896 count 1
Jun 30 03:31:51 epyc kernel: [929434.961664] 		ref#19: shared data backref parent 1446796492800 count 1
Jun 30 03:31:51 epyc kernel: [929434.961664] 	item 108 key (3138607656960 168 24576) itemoff 10245 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961665] 		extent refs 1 gen 1363678 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961665] 		ref#0: extent data backref root 277 objectid 29093 offset 91807744 count 1
Jun 30 03:31:51 epyc kernel: [929434.961666] 	item 109 key (3138607681536 168 16384) itemoff 10192 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961666] 		extent refs 1 gen 1484620 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961667] 		ref#0: extent data backref root 277 objectid 33570 offset 111316992 count 1
Jun 30 03:31:51 epyc kernel: [929434.961668] 	item 110 key (3138607706112 168 32768) itemoff 10139 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961668] 		extent refs 1 gen 1384311 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961668] 		ref#0: extent data backref root 277 objectid 34985 offset 35049472 count 1
Jun 30 03:31:51 epyc kernel: [929434.961669] 	item 111 key (3138607738880 168 24576) itemoff 10086 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961669] 		extent refs 1 gen 1363678 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961670] 		ref#0: extent data backref root 277 objectid 29093 offset 91848704 count 1
Jun 30 03:31:51 epyc kernel: [929434.961671] 	item 112 key (3138607767552 168 16384) itemoff 10033 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961671] 		extent refs 1 gen 1052632 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961671] 		ref#0: extent data backref root 277 objectid 29722 offset 131026944 count 1
Jun 30 03:31:51 epyc kernel: [929434.961672] 	item 113 key (3138607788032 168 8192) itemoff 9980 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961673] 		extent refs 1 gen 1017494 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961673] 		ref#0: extent data backref root 277 objectid 29724 offset 47067136 count 1
Jun 30 03:31:51 epyc kernel: [929434.961674] 	item 114 key (3138607808512 168 16384) itemoff 9927 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961674] 		extent refs 1 gen 1109107 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961674] 		ref#0: extent data backref root 277 objectid 31114 offset 8286208 count 1
Jun 30 03:31:51 epyc kernel: [929434.961675] 	item 115 key (3138607824896 168 32768) itemoff 9874 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961676] 		extent refs 1 gen 1350038 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961676] 		ref#0: extent data backref root 277 objectid 34904 offset 36446208 count 1
Jun 30 03:31:51 epyc kernel: [929434.961677] 	item 116 key (3138607857664 168 393216) itemoff 9821 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961677] 		extent refs 1 gen 867799 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961677] 		ref#0: extent data backref root 277 objectid 31407 offset 67239936 count 1
Jun 30 03:31:51 epyc kernel: [929434.961678] 	item 117 key (3138608250880 168 122880) itemoff 9768 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961679] 		extent refs 1 gen 867805 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961679] 		ref#0: extent data backref root 277 objectid 31429 offset 4718592 count 1
Jun 30 03:31:51 epyc kernel: [929434.961680] 	item 118 key (3138608386048 168 32768) itemoff 9715 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961680] 		extent refs 1 gen 706255 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961681] 		ref#0: extent data backref root 277 objectid 29093 offset 85852160 count 1
Jun 30 03:31:51 epyc kernel: [929434.961682] 	item 119 key (3138608418816 168 65536) itemoff 9662 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961682] 		extent refs 1 gen 693319 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961682] 		ref#0: extent data backref root 277 objectid 29093 offset 64782336 count 1
Jun 30 03:31:51 epyc kernel: [929434.961683] 	item 120 key (3138608484352 168 12288) itemoff 9609 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961684] 		extent refs 1 gen 1673391 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961684] 		ref#0: extent data backref root 277 objectid 37847 offset 4501504 count 1
Jun 30 03:31:51 epyc kernel: [929434.961685] 	item 121 key (3138608496640 168 8192) itemoff 9556 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961685] 		extent refs 1 gen 784028 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961685] 		ref#0: extent data backref root 277 objectid 27722 offset 115007488 count 1
Jun 30 03:31:51 epyc kernel: [929434.961686] 	item 122 key (3138608504832 168 16384) itemoff 9503 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961687] 		extent refs 1 gen 1124495 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961687] 		ref#0: extent data backref root 277 objectid 31133 offset 68730880 count 1
Jun 30 03:31:51 epyc kernel: [929434.961688] 	item 123 key (3138608521216 168 24576) itemoff 9450 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961688] 		extent refs 1 gen 1124541 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961688] 		ref#0: extent data backref root 277 objectid 31133 offset 70115328 count 1
Jun 30 03:31:51 epyc kernel: [929434.961689] 	item 124 key (3138608545792 168 49152) itemoff 9397 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961690] 		extent refs 1 gen 753743 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961690] 		ref#0: extent data backref root 277 objectid 30529 offset 25055232 count 1
Jun 30 03:31:51 epyc kernel: [929434.961691] 	item 125 key (3138608594944 168 16384) itemoff 9344 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961691] 		extent refs 1 gen 784031 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961691] 		ref#0: extent data backref root 277 objectid 27722 offset 114933760 count 1
Jun 30 03:31:51 epyc kernel: [929434.961692] 	item 126 key (3138608611328 168 32768) itemoff 9291 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961693] 		extent refs 1 gen 743147 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961693] 		ref#0: extent data backref root 277 objectid 30452 offset 72249344 count 1
Jun 30 03:31:51 epyc kernel: [929434.961694] 	item 127 key (3138608644096 168 65536) itemoff 8991 itemsize 300
Jun 30 03:31:51 epyc kernel: [929434.961694] 		extent refs 20 gen 1555474 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961695] 		ref#0: extent data backref root 260 objectid 2525013 offset 655360 count 1
Jun 30 03:31:51 epyc kernel: [929434.961695] 		ref#1: shared data backref parent 6404754423808 count 1
Jun 30 03:31:51 epyc kernel: [929434.961696] 		ref#2: shared data backref parent 6404492050432 count 1
Jun 30 03:31:51 epyc kernel: [929434.961696] 		ref#3: shared data backref parent 6404334731264 count 1
Jun 30 03:31:51 epyc kernel: [929434.961697] 		ref#4: shared data backref parent 6404274257920 count 1
Jun 30 03:31:51 epyc kernel: [929434.961697] 		ref#5: shared data backref parent 6404154933248 count 1
Jun 30 03:31:51 epyc kernel: [929434.961698] 		ref#6: shared data backref parent 5894391332864 count 1
Jun 30 03:31:51 epyc kernel: [929434.961698] 		ref#7: shared data backref parent 5893838241792 count 1
Jun 30 03:31:51 epyc kernel: [929434.961699] 		ref#8: shared data backref parent 4848645193728 count 1
Jun 30 03:31:51 epyc kernel: [929434.961699] 		ref#9: shared data backref parent 4064753188864 count 1
Jun 30 03:31:51 epyc kernel: [929434.961700] 		ref#10: shared data backref parent 4064677740544 count 1
Jun 30 03:31:51 epyc kernel: [929434.961700] 		ref#11: shared data backref parent 3673526517760 count 1
Jun 30 03:31:51 epyc kernel: [929434.961701] 		ref#12: shared data backref parent 3095403806720 count 1
Jun 30 03:31:51 epyc kernel: [929434.961701] 		ref#13: shared data backref parent 3095327326208 count 1
Jun 30 03:31:51 epyc kernel: [929434.961702] 		ref#14: shared data backref parent 3095164747776 count 1
Jun 30 03:31:51 epyc kernel: [929434.961702] 		ref#15: shared data backref parent 3095154917376 count 1
Jun 30 03:31:51 epyc kernel: [929434.961702] 		ref#16: shared data backref parent 3094854959104 count 1
Jun 30 03:31:51 epyc kernel: [929434.961703] 		ref#17: shared data backref parent 2228271251456 count 1
Jun 30 03:31:51 epyc kernel: [929434.961703] 		ref#18: shared data backref parent 1447340752896 count 1
Jun 30 03:31:51 epyc kernel: [929434.961704] 		ref#19: shared data backref parent 1446796492800 count 1
Jun 30 03:31:51 epyc kernel: [929434.961705] 	item 128 key (3138608709632 168 24576) itemoff 8938 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961705] 		extent refs 1 gen 1363693 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961705] 		ref#0: extent data backref root 277 objectid 29093 offset 82886656 count 1
Jun 30 03:31:51 epyc kernel: [929434.961706] 	item 129 key (3138608738304 168 24576) itemoff 8885 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961707] 		extent refs 1 gen 1285864 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961707] 		ref#0: extent data backref root 260 objectid 1373587 offset 12001280 count 1
Jun 30 03:31:51 epyc kernel: [929434.961708] 	item 130 key (3138608762880 168 32768) itemoff 8832 itemsize 53
Jun 30 03:31:51 epyc kernel: [929434.961708] 		extent refs 1 gen 1405842 flags 1
Jun 30 03:31:51 epyc kernel: [929434.961709] 		ref#0: extent data backref root 7393 objectid 472 offset 712409088 count 1
Jun 30 03:31:51 epyc kernel: [929434.961710] BTRFS error (device dm-1): block=6404379377664 write time tree block corruption detected
Jun 30 03:31:55 epyc systemd-resolved[2913800]: Using degraded feature set (UDP) for DNS server fd00::42:d0:cc:0:1.
Jun 30 03:32:13 epyc kernel: [929456.915490] BTRFS: error (device dm-1) in btrfs_commit_transaction:2366: errno=-5 IO failure (Error while writing out transaction)
Jun 30 03:32:13 epyc kernel: [929456.915567] BTRFS info (device dm-1): forced readonly
Jun 30 03:32:13 epyc kernel: [929456.915570] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
Jun 30 03:32:13 epyc kernel: [929456.915576] BTRFS: error (device dm-1) in cleanup_transaction:1939: errno=-5 IO failure
Jun 30 03:32:13 epyc kernel: [929456.925866] BTRFS warning (device dm-1): Skipping commit of aborted transaction.
Jun 30 03:32:13 epyc kernel: [929456.925876] BTRFS: error (device dm-1) in cleanup_transaction:1939: errno=-5 IO failure

--=_soRrXPz4ZQjklNzjuL32Qol--


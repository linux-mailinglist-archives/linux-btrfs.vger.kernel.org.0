Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB5BBDFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 23:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbfIWVeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 17:34:08 -0400
Received: from know-smtprelay-omd-9.server.virginmedia.net ([81.104.62.41]:39581
        "EHLO know-smtprelay-omd-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfIWVeH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 17:34:07 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id CVy8if8gSVaV8CVy8it0Jr; Mon, 23 Sep 2019 22:34:04 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=PcnReBpd c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=yeImiaDjqKufKzWRaMYA:9 a=Qbr2Dyur14vGXd6u:21
 a=FWhdp3n6k_Q4SbSP:21 a=QEXdDO2ut3YA:10
Subject: Re: Balance ENOSPC during balance despite additional storage added
From:   Peter Chant <pete@petezilla.co.uk>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
 <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk>
Message-ID: <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
Date:   Mon, 23 Sep 2019 22:33:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGI+Si94TUh6yRWTEyHENw1EWsbvIYPhqaKjgjaZvG4u0rZwc32zgv71hcqpO4Nb/xxcJlt7lhQWysp69O0BND8RUNcv3LJ0heqFwzQU//IVVP7kHElo
 9sIjN16Kvt6Tnr2slq64fYiU/Ol8mFIDOV2CteOzf6bS0MfqN4X4BZ4DpebE6jf5B5NQHWFAeC+sRGNZ1/C1bL1OdKYya/wSSSg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/23/19 7:55 PM, Pete wrote:

> I'm not sure the balance is resolving anything.  The filesystem has not
> gone read only.  I'll try an unfiltered balance now to see how that goes.
> 

OK, result of unfiltered balance:

root@phoenix:/var/lib/lxc# btrfs bal start /var/lib/lxc
WARNING:

        Full balance without filters requested. This operation is very
        intense and takes potentially very long. It is recommended to
        use the balance filters to narrow down the scope of balance.
        Use 'btrfs balance start --full-balance' option to skip this
        warning. The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting balance without any filters.
ERROR: error during balancing '/var/lib/lxc': No space left on device
There may be more info in syslog - try dmesg | tail
root@phoenix:/var/lib/lxc#

OK, here is the output in the last 100 lines of dmesg.  The line 'unable
to make block group nnnnnnnnnnnnnnn ro' is repeated, I presume that is
relevant.  I'm noting no other ill effects, if I'd not tried the balance
I would not know anything is amiss.

root@phoenix:/var/lib/lxc# dmesg | tail -n 100
[ 1880.155026] BTRFS info (device dm-4): sinfo_used=19522584576
bg_num_bytes=54394880 min_allocable=1048576
[ 1880.155027] BTRFS info (device dm-4): space_info 4 has
18446744065997733888 free, is not full
[ 1880.155029] BTRFS info (device dm-4): space_info total=11811160064,
used=10509664256, pinned=0, reserved=131072, may_use=9013182464, readonly=0
[ 1880.155029] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155030] BTRFS info (device dm-4): trans_block_rsv: size 262144
reserved 262144
[ 1880.155031] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155031] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155032] BTRFS info (device dm-4): delayed_refs_rsv: size
17514102784 reserved 8475983872
[ 1880.155049] BTRFS info (device dm-4): unable to make block group
1608583741440 ro
[ 1880.155050] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=54394880 min_allocable=1048576
[ 1880.155051] BTRFS info (device dm-4): space_info 4 has
18446744067071213568 free, is not full
[ 1880.155052] BTRFS info (device dm-4): space_info total=12884901888,
used=10509664256, pinned=0, reserved=131072, may_use=9013444608, readonly=0
[ 1880.155053] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155053] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155054] BTRFS info (device dm-4): chunk_block_rsv: size 393216
reserved 393216
[ 1880.155054] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155055] BTRFS info (device dm-4): delayed_refs_rsv: size
17515151360 reserved 8476639232
[ 1880.155080] BTRFS info (device dm-4): unable to make block group
1607509999616 ro
[ 1880.155081] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=78774272 min_allocable=1048576
[ 1880.155081] BTRFS info (device dm-4): space_info 4 has
18446744067071213568 free, is not full
[ 1880.155083] BTRFS info (device dm-4): space_info total=12884901888,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155083] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155084] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155085] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155086] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155087] BTRFS info (device dm-4): delayed_refs_rsv: size
17515937792 reserved 8476606464
[ 1880.155097] BTRFS info (device dm-4): unable to make block group
1607509999616 ro
[ 1880.155098] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=78774272 min_allocable=1048576
[ 1880.155098] BTRFS info (device dm-4): space_info 4 has
18446744068144955392 free, is not full
[ 1880.155099] BTRFS info (device dm-4): space_info total=13958643712,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155100] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155100] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155101] BTRFS info (device dm-4): chunk_block_rsv: size 393216
reserved 393216
[ 1880.155101] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155101] BTRFS info (device dm-4): delayed_refs_rsv: size
17516199936 reserved 8476606464
[ 1880.155106] BTRFS info (device dm-4): unable to make block group
1606436257792 ro
[ 1880.155106] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=183910400 min_allocable=1048576
[ 1880.155107] BTRFS info (device dm-4): space_info 4 has
18446744068144955392 free, is not full
[ 1880.155107] BTRFS info (device dm-4): space_info total=13958643712,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155108] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155108] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155109] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155109] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155110] BTRFS info (device dm-4): delayed_refs_rsv: size
17515937792 reserved 8476606464
[ 1880.155116] BTRFS info (device dm-4): unable to make block group
1606436257792 ro
[ 1880.155116] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=183910400 min_allocable=1048576
[ 1880.155117] BTRFS info (device dm-4): space_info 4 has
18446744069218697216 free, is not full
[ 1880.155118] BTRFS info (device dm-4): space_info total=15032385536,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155118] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155118] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155119] BTRFS info (device dm-4): chunk_block_rsv: size 393216
reserved 393216
[ 1880.155119] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155120] BTRFS info (device dm-4): delayed_refs_rsv: size
17516199936 reserved 8476606464
[ 1880.155123] BTRFS info (device dm-4): unable to make block group
1605362515968 ro
[ 1880.155124] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=14385152 min_allocable=1048576
[ 1880.155124] BTRFS info (device dm-4): space_info 4 has
18446744069218697216 free, is not full
[ 1880.155125] BTRFS info (device dm-4): space_info total=15032385536,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155126] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155126] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155126] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155127] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155127] BTRFS info (device dm-4): delayed_refs_rsv: size
17515937792 reserved 8476606464
[ 1880.155133] BTRFS info (device dm-4): unable to make block group
1605362515968 ro
[ 1880.155134] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=14385152 min_allocable=1048576
[ 1880.155134] BTRFS info (device dm-4): space_info 4 has
18446744070292439040 free, is not full
[ 1880.155135] BTRFS info (device dm-4): space_info total=16106127360,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155136] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155136] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155136] BTRFS info (device dm-4): chunk_block_rsv: size 393216
reserved 393216
[ 1880.155137] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155137] BTRFS info (device dm-4): delayed_refs_rsv: size
17516199936 reserved 8476606464
[ 1880.155141] BTRFS info (device dm-4): unable to make block group
1525872066560 ro
[ 1880.155141] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=303333376 min_allocable=1048576
[ 1880.155142] BTRFS info (device dm-4): space_info 4 has
18446744070292439040 free, is not full
[ 1880.155143] BTRFS info (device dm-4): space_info total=16106127360,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155143] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155144] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155144] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155144] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155145] BTRFS info (device dm-4): delayed_refs_rsv: size
17515937792 reserved 8476606464
[ 1880.155150] BTRFS info (device dm-4): unable to make block group
1525872066560 ro
[ 1880.155151] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=303333376 min_allocable=1048576
[ 1880.155151] BTRFS info (device dm-4): space_info 4 has
18446744071366180864 free, is not full
[ 1880.155152] BTRFS info (device dm-4): space_info total=17179869184,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155152] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155153] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155153] BTRFS info (device dm-4): chunk_block_rsv: size 393216
reserved 393216
[ 1880.155154] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155154] BTRFS info (device dm-4): delayed_refs_rsv: size
17516199936 reserved 8476606464
[ 1880.155157] BTRFS info (device dm-4): unable to make block group
1524798324736 ro
[ 1880.155158] BTRFS info (device dm-4): sinfo_used=19523239936
bg_num_bytes=105562112 min_allocable=1048576
[ 1880.155158] BTRFS info (device dm-4): space_info 4 has
18446744071366180864 free, is not full
[ 1880.155159] BTRFS info (device dm-4): space_info total=17179869184,
used=10509664256, pinned=0, reserved=163840, may_use=9013411840, readonly=0
[ 1880.155159] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536805376
[ 1880.155160] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[ 1880.155160] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[ 1880.155161] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[ 1880.155161] BTRFS info (device dm-4): delayed_refs_rsv: size
17515937792 reserved 8476606464
[ 1880.155167] BTRFS info (device dm-4): unable to make block group
1524798324736 ro




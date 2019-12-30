Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84F512CD7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfL3IKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 03:10:43 -0500
Received: from mout.web.de ([212.227.15.4]:42883 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfL3IKn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 03:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577693436;
        bh=kxBBUWYi5kQ+ZvpcqPdOrS+u8bBLrthnKW+MKEY2lIk=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=sHfw0ktw3U6y/oqqF1VCsXSKXaNx0Myv5EDeGM2uELT8/u/6jB/o/1/6+eO824Ymu
         V76vp2hP1UCmrCuIpkDUDCSL46pIzO3fkFcxe62yyszEqxtNbv10CHfln5ObjUTbKw
         /TiKpFeg50Z3B3h98zg4iAOKFgfgjUYEpkTyaAVg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.16] ([80.142.201.69]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHcb-1jHU7t2E9V-00WE6U; Mon, 30
 Dec 2019 09:10:36 +0100
From:   Matthias Neuer <mneuer@web.de>
Subject: Re: invalid root item size
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <19acbd39-475f-bd72-e280-5f6c6496035c@web.de>
 <CAJCQCtQ-ApthkeKtSgsFN+JuTpPoX0OFubOGQdbz=OnNkphB_w@mail.gmail.com>
 <2cd36d11-8a71-513b-1991-076135bb2bcb@web.de>
 <CAJCQCtRSq5mexYyJQaxRFSY3ieuFAednoCZ_dHaJuJn5h495+w@mail.gmail.com>
Message-ID: <6ac1d319-4657-65e0-ed25-e50ded45273f@web.de>
Date:   Mon, 30 Dec 2019 09:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRSq5mexYyJQaxRFSY3ieuFAednoCZ_dHaJuJn5h495+w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------2B38DA7E4C57ECD9BE39B859"
Content-Language: en-US
X-Provags-ID: V03:K1:3qYEdwr8qmpSrVmBGqXOU1rGxAOZX40yFrEKwnTl1QWPpeLBR41
 N5dKtfbcaLzxymTelhV/7moTAoE5HVNaiHd148OSj74uXt1KbZA1w2FuiCZvlTlzXfQ3xiS
 oSAyFYezE+hEgL8aZUIdCwisFzlbKRvj9RomntRkOrwbZ2X+xlt7wpra/Jmf6XnhXxKyp9u
 8s1wmyAYiMA8/kZJxZI8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnAYXzYsFyc=:BgUS5A3RQUNyZnZ7E4Bpig
 NPjxIDlHmE5zJDaGX055h8nPQizJGOQcbg4Dl7SiaYqLKT7LjeNSuDVr1NZAOV2mdFSLDdAkI
 KHiG9w61tuXVatyoQiR0q6wXZkfjmz3TfgemXJ7G8/iwOwk2u9SAM1iDL/CjpqSAoi4fpZK4U
 1d6Gr/RYap3GzR+2AXF0h3ijeJeY9MmdOXhsy1P4TZ2mKRc6bB6oiv+4ivBxquhPAoG2hUrby
 VGSVRTHcU6JO6mGsZV+LWE07B+87Li2dSN/tpTfoCWeSDnR56KUsrtoMcXqEtD1GRX6EVL03v
 rCn0j1wa0yVOYRS1YRNPiKfRQSBMad5u0zliHaBg0R4++LLz2ebicIAKpMM6mPCJt4lUlNHlS
 QGP2bBvhtQV2jM2DxS3wnd0OAC7ayTYoVUkn58I6eQaiDt5SrjcuGg6hlYLAdGeU1eHQi/pfi
 1sBdV2RX1sPU1O/xALtDuHi+PBMzBJZXyplyUdRCbQ3YG3ssiNvKSPm0lgvlgivPPu745OidK
 mA8pM0KGLC2OipvhOJqwQgVBJesOdNhTdE87KdZYs1TMSC2SUYoPBJT9Ygp7kzDYVJvBj0+0B
 ulwSTlO54xblhrPNy5dpKTc9AxTKjPdIYx619YQ8uyjTkKQNzP4YdQj3z00VCPjiHO2Q1OKLL
 7aYRXcPW1dMXrZhDIZmUMScC/7ZombNX7HeaEZjLIqyk+ZZCOmrsWStiNvCJS4L8xdBFbXDGw
 lXma8nUHT617Rtf7JkuQoBoD87PxmL0bUPmXmDiXOVOlRr5FQRQ54nRZPRIQtFEcK3C0LEfah
 EbnZ0xmn+p55ZEiqba07JI3Pq8DB7Qofmm5DFlpUDQSlUo2/G3BXOdAJo7ecFNzbcd8G93ewj
 ehdVh7/MSPispDH7t8ZSWJ+hNES0Ij6f+h3W/w44Gl+RnOjr0iV5G2qvl0cYQsCY7IJUCNJAg
 70kj1cjdYJGZ1xOqFkXupD5cbWa5skYuo42ffxxlh+RoqXzIdxJePiW5NPjyqboPPMjU78DG1
 NIgFb9SUV7NkzVsb/Iv43V0d7iz0PzLksR0u4vqzcBwgTr2YxV0jL8A+0M6efr3p6I5QTBPbX
 L4m9JajL5Y4OLDxGIBVYvb4f0c+tMrf8IaIvrJ7NqHxvBc9b3BtsCf9WAxWa8ndxyAz8SuWen
 8HN5opzydmKAzJSPWhACVwlHZpaMTISHgPyE79gBC1Rv9hyTxztEnslI14YNHrAAq5S40W5Mt
 AgI1dVsbiVd6Bx79tURnbWzsd7OM24Uh03w+Hww==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B38DA7E4C57ECD9BE39B859
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


>>
>> Here I can't spot a filename.
>
> This is a node. It points to leafs. So what we're looking for depends
> on the exact kernel error that you got the block number from.

Ah, ok. So when I do a

# btrfs insp dump-t -b 285405184 --follow /dev/sda8

I get quite a lengthy output with leafes (and filenames) in it (see attach=
ment).
The last line is

ERROR: child eb corrupted: parent bytenr=3D285405184 item=3D13 parent leve=
l=3D1 child level=3D1

I give you an idea how the errors appear in journalctl:

[...]
Dec 30 08:46:27 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D60403712 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:46:28 matze-debian kernel: BTRFS critical (device sda7): corrupt=
 leaf: root=3D1 block=3D63807488 slot=3D26, invalid root item size, have 2=
39 expect 439
Dec 30 08:46:43 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D64675840 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:47:03 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D60923904 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:47:05 matze-debian kernel: BTRFS critical (device sda7): corrupt=
 leaf: root=3D1 block=3D56455168 slot=3D26, invalid root item size, have 2=
39 expect 439
Dec 30 08:47:19 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D64929792 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:47:45 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D61784064 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:48:11 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D64499712 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:48:21 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D62066688 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:48:52 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D64860160 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:49:23 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D62222336 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:49:28 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D65261568 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:50:31 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D65839104 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:51:16 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D63418368 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:51:32 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D65859584 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:51:57 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D63668224 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:52:18 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D66072576 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:52:48 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D64548864 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:52:50 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D66195456 slot=3D21, invalid root item size, have 2=
39 expect 439
Dec 30 08:53:24 matze-debian kernel: BTRFS critical (device sda8): corrupt=
 leaf: root=3D1 block=3D64688128 slot=3D32, invalid root item size, have 2=
39 expect 439
Dec 30 08:53:26 matze-debian kernel: BTRFS critical (device sda5): corrupt=
 leaf: root=3D1 block=3D66277376 slot=3D21, invalid root item size, have 2=
39 expect 439
[...]

The difference in root item size seems to be the same all the time ("have =
239 expect 439").

> So btrfs check has no errors but you're still seeing corruption
> messages from the kernel? What about using check with the
> --mode=3Dlowmem option? It's a lot slower.

Exactly. This is the output when running the check with lowmem:

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sda8
UUID: d6954ba3-3d50-4886-ae3f-a92a5ca83923
found 17174376448 bytes used, no error found
total csum bytes: 16457960
total tree bytes: 241557504
total fs tree bytes: 190373888
total extent tree bytes: 23085056
btree space waste bytes: 67493294
file data blocks allocated: 23684820992
  referenced 16014913536

>> I backup up all my data.
>> I wonder if these errors would be gone if I reinstalled my system and c=
opied back my data.
>> Would cost me a few hours but maybe not more than trying to fix this.
>
> If it's not causing grief yet, I'd give it a few days for a developer
> to reply about what might be going on. And whether it can be fixed.
>
> But yes, this is metadata corruption. So a new file system won't have
> the problem.

I thought so, but was not completely sure. So I don't have a problem waiti=
ng a few days.

Regards,
Matthias

--------------2B38DA7E4C57ECD9BE39B859
Content-Type: text/x-log;
 name="btrfs.285405184.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="btrfs.285405184.log"

btrfs-progs v5.4
node 285405184 level 1 items 61 free 60 generation 295475 owner FS_TREE
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	key (3516683 DIR_INDEX 3) block 300871680 gen 295475
	key (3516699 INODE_ITEM 0) block 300953600 gen 295475
	key (3516703 INODE_ITEM 0) block 300957696 gen 295475
	key (3516708 INODE_ITEM 0) block 301015040 gen 295475
	key (3516713 INODE_ITEM 0) block 301092864 gen 295475
	key (3516716 INODE_REF 3516669) block 301326336 gen 295475
	key (3516734 INODE_ITEM 0) block 299872256 gen 295475
	key (3516760 INODE_ITEM 0) block 232648704 gen 295425
	key (3516869 INODE_ITEM 0) block 236732416 gen 295426
	key (3516983 INODE_ITEM 0) block 61214720 gen 295147
	key (3516989 INODE_REF 1332998) block 285138944 gen 295474
	key (3516994 INODE_REF 1332998) block 42741760 gen 295123
	key (3517014 EXTENT_DATA 0) block 133730304 gen 295316
	key (3517028 EXTENT_DATA 0) block 42749952 gen 295123
	key (3517051 INODE_ITEM 0) block 301330432 gen 295475
	key (3517278 INODE_ITEM 0) block 39383040 gen 295123
	key (3517279 EXTENT_DATA 0) block 42758144 gen 295123
	key (3517282 EXTENT_DATA 0) block 44212224 gen 295127
	key (3517326 INODE_ITEM 0) block 31232000 gen 295168
	key (3517380 INODE_ITEM 0) block 29921280 gen 295168
	key (3517404 INODE_ITEM 0) block 34881536 gen 295169
	key (3517693 INODE_ITEM 0) block 31338496 gen 295168
	key (3517694 INODE_REF 1332998) block 76279808 gen 295154
	key (3517697 INODE_ITEM 0) block 279601152 gen 295466
	key (3517714 INODE_ITEM 0) block 133726208 gen 295316
	key (3517724 INODE_REF 1332998) block 35565568 gen 295172
	key (3517745 INODE_REF 1332998) block 31219712 gen 295168
	key (3517799 INODE_ITEM 0) block 32735232 gen 295168
	key (3517895 INODE_ITEM 0) block 50614272 gen 295133
	key (3517902 EXTENT_DATA 0) block 50130944 gen 295133
	key (3517909 EXTENT_DATA 0) block 52219904 gen 295135
	key (3517914 INODE_REF 1332998) block 52719616 gen 295135
	key (3517928 INODE_REF 1332998) block 135065600 gen 295316
	key (3517944 INODE_REF 1332998) block 135098368 gen 295316
	key (3517970 EXTENT_DATA 0) block 76419072 gen 295150
	key (3517988 INODE_REF 1332998) block 134750208 gen 295316
	key (3518000 INODE_ITEM 0) block 134791168 gen 295316
	key (3518014 INODE_ITEM 0) block 62775296 gen 295149
	key (3518018 EXTENT_DATA 8192) block 79409152 gen 295163
	key (3518028 EXTENT_DATA 12288) block 283504640 gen 295474
	key (3518032 EXTENT_DATA 0) block 283484160 gen 295474
	key (3518037 INODE_ITEM 0) block 283791360 gen 295474
	key (3518082 INODE_ITEM 0) block 32157696 gen 295168
	key (3518107 INODE_ITEM 0) block 285437952 gen 295475
	key (3518161 INODE_ITEM 0) block 35807232 gen 295172
	key (3518161 INODE_REF 3504139) block 51822592 gen 295224
	key (3518193 INODE_ITEM 0) block 285536256 gen 295471
	key (3518205 EXTENT_DATA 126976) block 281796608 gen 295471
	key (3518208 INODE_ITEM 0) block 130437120 gen 295269
	key (3518219 EXTENT_DATA 0) block 283009024 gen 295473
	key (3518247 INODE_ITEM 0) block 282075136 gen 295473
	key (3518250 INODE_REF 528) block 283881472 gen 295473
	key (3518465 INODE_ITEM 0) block 228093952 gen 295422
	key (3518918 INODE_ITEM 0) block 228143104 gen 295422
	key (3518947 EXTENT_DATA 0) block 124354560 gen 295289
	key (3519052 INODE_ITEM 0) block 124669952 gen 295289
	key (3519062 EXTENT_DATA 0) block 282337280 gen 295473
	key (3519069 EXTENT_DATA 0) block 126033920 gen 295263
	key (3519086 INODE_ITEM 0) block 113582080 gen 295276
	key (3519090 INODE_ITEM 0) block 261554176 gen 295445
	key (3519132 INODE_ITEM 0) block 126877696 gen 295269
leaf 300871680 items 11 free space 1323 generation 295475 owner FS_TREE
leaf 300871680 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516683 DIR_INDEX 3) itemoff 3927 itemsize 68
		location key (3516685 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: ccd7f4a21d3c0db5273d42ab17a676ceb436ca
	item 1 key (3516685 INODE_ITEM 0) itemoff 3767 itemsize 160
		generation 295081 transid 295082 size 746 nbytes 746
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603165.87996157 (2019-12-29 08:06:05)
		ctime 1577603165.87996157 (2019-12-29 08:06:05)
		mtime 1577603165.87996157 (2019-12-29 08:06:05)
		otime 1577603165.87996157 (2019-12-29 08:06:05)
	item 2 key (3516685 INODE_REF 3516683) itemoff 3719 itemsize 48
		index 3 namelen 38 name: ccd7f4a21d3c0db5273d42ab17a676ceb436ca
	item 3 key (3516685 EXTENT_DATA 0) itemoff 2952 itemsize 767
		generation 295082 type 0 (inline)
		inline extent data size 746 ram_bytes 746 compression 0 (none)
	item 4 key (3516687 INODE_ITEM 0) itemoff 2792 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603165.91996157 (2019-12-29 08:06:05)
		mtime 1577603165.91996157 (2019-12-29 08:06:05)
		otime 1577603165.91996157 (2019-12-29 08:06:05)
	item 5 key (3516687 INODE_REF 3516669) itemoff 2780 itemsize 12
		index 5 namelen 2 name: 76
	item 6 key (3516687 DIR_ITEM 1099393758) itemoff 2712 itemsize 68
		location key (3516688 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 1920791521724aeecb4ac94cd03fd63c60cd12
	item 7 key (3516687 DIR_INDEX 3) itemoff 2644 itemsize 68
		location key (3516688 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 1920791521724aeecb4ac94cd03fd63c60cd12
	item 8 key (3516688 INODE_ITEM 0) itemoff 2484 itemsize 160
		generation 295081 transid 295082 size 817 nbytes 817
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603165.91996157 (2019-12-29 08:06:05)
		ctime 1577603165.91996157 (2019-12-29 08:06:05)
		mtime 1577603165.91996157 (2019-12-29 08:06:05)
		otime 1577603165.91996157 (2019-12-29 08:06:05)
	item 9 key (3516688 INODE_REF 3516687) itemoff 2436 itemsize 48
		index 3 namelen 38 name: 1920791521724aeecb4ac94cd03fd63c60cd12
	item 10 key (3516688 EXTENT_DATA 0) itemoff 1598 itemsize 838
		generation 295082 type 0 (inline)
		inline extent data size 817 ram_bytes 817 compression 0 (none)
leaf 300953600 items 7 free space 2585 generation 295475 owner FS_TREE
leaf 300953600 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516699 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.47996170 (2019-12-29 08:06:06)
		mtime 1577603166.47996170 (2019-12-29 08:06:06)
		otime 1577603165.991996169 (2019-12-29 08:06:05)
	item 1 key (3516699 INODE_REF 3516669) itemoff 3823 itemsize 12
		index 6 namelen 2 name: 5b
	item 2 key (3516699 DIR_ITEM 1929324877) itemoff 3755 itemsize 68
		location key (3516700 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 3574aa9921afa49466924c24c79d4f1d8d0b56
	item 3 key (3516699 DIR_INDEX 3) itemoff 3687 itemsize 68
		location key (3516700 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 3574aa9921afa49466924c24c79d4f1d8d0b56
	item 4 key (3516700 INODE_ITEM 0) itemoff 3527 itemsize 160
		generation 295081 transid 295082 size 698 nbytes 698
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603165.991996169 (2019-12-29 08:06:05)
		ctime 1577603166.47996170 (2019-12-29 08:06:06)
		mtime 1577603166.47996170 (2019-12-29 08:06:06)
		otime 1577603165.991996169 (2019-12-29 08:06:05)
	item 5 key (3516700 INODE_REF 3516699) itemoff 3479 itemsize 48
		index 3 namelen 38 name: 3574aa9921afa49466924c24c79d4f1d8d0b56
	item 6 key (3516700 EXTENT_DATA 0) itemoff 2760 itemsize 719
		generation 295082 type 0 (inline)
		inline extent data size 698 ram_bytes 698 compression 0 (none)
leaf 300957696 items 16 free space 1276 generation 295475 owner FS_TREE
leaf 300957696 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516703 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295081 transid 295475 size 152 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 10 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603216.800202039 (2019-12-29 08:06:56)
		mtime 1577603216.800202039 (2019-12-29 08:06:56)
		otime 1577603166.115996171 (2019-12-29 08:06:06)
	item 1 key (3516703 INODE_REF 3516669) itemoff 3823 itemsize 12
		index 7 namelen 2 name: cb
	item 2 key (3516703 DIR_ITEM 2660956293) itemoff 3755 itemsize 68
		location key (3516704 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a41d3e9cedc2f71981f4cb74cf1ca75bddc22c
	item 3 key (3516703 DIR_ITEM 2698105465) itemoff 3687 itemsize 68
		location key (3516739 INODE_ITEM 0) type FILE
		transid 295082 data_len 0 name_len 38
		name: 96666aac5c430826258c0850f55978bff9bc14
	item 4 key (3516703 DIR_INDEX 3) itemoff 3619 itemsize 68
		location key (3516704 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a41d3e9cedc2f71981f4cb74cf1ca75bddc22c
	item 5 key (3516703 DIR_INDEX 5) itemoff 3551 itemsize 68
		location key (3516739 INODE_ITEM 0) type FILE
		transid 295082 data_len 0 name_len 38
		name: 96666aac5c430826258c0850f55978bff9bc14
	item 6 key (3516704 INODE_ITEM 0) itemoff 3391 itemsize 160
		generation 295081 transid 295099 size 592 nbytes 592
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.841283729 (2019-12-29 08:15:30)
		ctime 1577603166.119996171 (2019-12-29 08:06:06)
		mtime 1577603166.119996171 (2019-12-29 08:06:06)
		otime 1577603166.115996171 (2019-12-29 08:06:06)
	item 7 key (3516704 INODE_REF 3516703) itemoff 3343 itemsize 48
		index 3 namelen 38 name: a41d3e9cedc2f71981f4cb74cf1ca75bddc22c
	item 8 key (3516704 EXTENT_DATA 0) itemoff 2730 itemsize 613
		generation 295082 type 0 (inline)
		inline extent data size 592 ram_bytes 592 compression 0 (none)
	item 9 key (3516706 INODE_ITEM 0) itemoff 2570 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.123996171 (2019-12-29 08:06:06)
		mtime 1577603166.123996171 (2019-12-29 08:06:06)
		otime 1577603166.123996171 (2019-12-29 08:06:06)
	item 10 key (3516706 INODE_REF 3516669) itemoff 2558 itemsize 12
		index 8 namelen 2 name: 64
	item 11 key (3516706 DIR_ITEM 2882672853) itemoff 2490 itemsize 68
		location key (3516707 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a0e5bae5a9a681758a5016728ef0c301e97626
	item 12 key (3516706 DIR_INDEX 3) itemoff 2422 itemsize 68
		location key (3516707 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a0e5bae5a9a681758a5016728ef0c301e97626
	item 13 key (3516707 INODE_ITEM 0) itemoff 2262 itemsize 160
		generation 295081 transid 295099 size 517 nbytes 517
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.889283878 (2019-12-29 08:15:30)
		ctime 1577603166.123996171 (2019-12-29 08:06:06)
		mtime 1577603166.123996171 (2019-12-29 08:06:06)
		otime 1577603166.123996171 (2019-12-29 08:06:06)
	item 14 key (3516707 INODE_REF 3516706) itemoff 2214 itemsize 48
		index 3 namelen 38 name: a0e5bae5a9a681758a5016728ef0c301e97626
	item 15 key (3516707 EXTENT_DATA 0) itemoff 1676 itemsize 538
		generation 295082 type 0 (inline)
		inline extent data size 517 ram_bytes 517 compression 0 (none)
leaf 301015040 items 18 free space 156 generation 295475 owner FS_TREE
leaf 301015040 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516708 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.175996171 (2019-12-29 08:06:06)
		mtime 1577603166.175996171 (2019-12-29 08:06:06)
		otime 1577603166.175996171 (2019-12-29 08:06:06)
	item 1 key (3516708 INODE_REF 3516669) itemoff 3823 itemsize 12
		index 9 namelen 2 name: 9e
	item 2 key (3516708 DIR_ITEM 400541337) itemoff 3755 itemsize 68
		location key (3516709 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a2be2b1795aeb9da945216e8b6cd63a93d9827
	item 3 key (3516708 DIR_INDEX 3) itemoff 3687 itemsize 68
		location key (3516709 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: a2be2b1795aeb9da945216e8b6cd63a93d9827
	item 4 key (3516709 INODE_ITEM 0) itemoff 3527 itemsize 160
		generation 295081 transid 295099 size 940 nbytes 940
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.925283990 (2019-12-29 08:15:30)
		ctime 1577603166.175996171 (2019-12-29 08:06:06)
		mtime 1577603166.175996171 (2019-12-29 08:06:06)
		otime 1577603166.175996171 (2019-12-29 08:06:06)
	item 5 key (3516709 INODE_REF 3516708) itemoff 3479 itemsize 48
		index 3 namelen 38 name: a2be2b1795aeb9da945216e8b6cd63a93d9827
	item 6 key (3516709 EXTENT_DATA 0) itemoff 2518 itemsize 961
		generation 295082 type 0 (inline)
		inline extent data size 940 ram_bytes 940 compression 0 (none)
	item 7 key (3516710 INODE_ITEM 0) itemoff 2358 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 13 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 8 key (3516710 INODE_REF 3516669) itemoff 2346 itemsize 12
		index 10 namelen 2 name: 3a
	item 9 key (3516710 DIR_ITEM 2587066073) itemoff 2278 itemsize 68
		location key (3516711 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: fb8963bb9da0ecb9491671bf04de8671114189
	item 10 key (3516710 DIR_INDEX 3) itemoff 2210 itemsize 68
		location key (3516711 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: fb8963bb9da0ecb9491671bf04de8671114189
	item 11 key (3516711 INODE_ITEM 0) itemoff 2050 itemsize 160
		generation 295081 transid 295099 size 1067 nbytes 1067
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.925283990 (2019-12-29 08:15:30)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 12 key (3516711 INODE_REF 3516710) itemoff 2002 itemsize 48
		index 3 namelen 38 name: fb8963bb9da0ecb9491671bf04de8671114189
	item 13 key (3516711 EXTENT_DATA 0) itemoff 914 itemsize 1088
		generation 295082 type 0 (inline)
		inline extent data size 1067 ram_bytes 1067 compression 0 (none)
	item 14 key (3516712 INODE_ITEM 0) itemoff 754 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 15 key (3516712 INODE_REF 3516669) itemoff 742 itemsize 12
		index 11 namelen 2 name: 70
	item 16 key (3516712 DIR_ITEM 1841514705) itemoff 674 itemsize 68
		location key (3516713 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 42b236097a2b4673b3643cfc7dc9d1ecade27c
	item 17 key (3516712 DIR_INDEX 3) itemoff 606 itemsize 68
		location key (3516713 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 42b236097a2b4673b3643cfc7dc9d1ecade27c
leaf 301092864 items 11 free space 798 generation 295475 owner FS_TREE
leaf 301092864 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516713 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295081 transid 295099 size 771 nbytes 771
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.929284002 (2019-12-29 08:15:30)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 1 key (3516713 INODE_REF 3516712) itemoff 3787 itemsize 48
		index 3 namelen 38 name: 42b236097a2b4673b3643cfc7dc9d1ecade27c
	item 2 key (3516713 EXTENT_DATA 0) itemoff 2995 itemsize 792
		generation 295082 type 0 (inline)
		inline extent data size 771 ram_bytes 771 compression 0 (none)
	item 3 key (3516714 INODE_ITEM 0) itemoff 2835 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 4 key (3516714 INODE_REF 3516669) itemoff 2823 itemsize 12
		index 12 namelen 2 name: bf
	item 5 key (3516714 DIR_ITEM 3601105778) itemoff 2755 itemsize 68
		location key (3516715 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: cd6085ac0a328d4365f6ba88d9387bb5f31f1b
	item 6 key (3516714 DIR_INDEX 3) itemoff 2687 itemsize 68
		location key (3516715 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: cd6085ac0a328d4365f6ba88d9387bb5f31f1b
	item 7 key (3516715 INODE_ITEM 0) itemoff 2527 itemsize 160
		generation 295081 transid 295099 size 1225 nbytes 1225
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.929284002 (2019-12-29 08:15:30)
		ctime 1577603166.187996171 (2019-12-29 08:06:06)
		mtime 1577603166.187996171 (2019-12-29 08:06:06)
		otime 1577603166.187996171 (2019-12-29 08:06:06)
	item 8 key (3516715 INODE_REF 3516714) itemoff 2479 itemsize 48
		index 3 namelen 38 name: cd6085ac0a328d4365f6ba88d9387bb5f31f1b
	item 9 key (3516715 EXTENT_DATA 0) itemoff 1233 itemsize 1246
		generation 295082 type 0 (inline)
		inline extent data size 1225 ram_bytes 1225 compression 0 (none)
	item 10 key (3516716 INODE_ITEM 0) itemoff 1073 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603166.191996172 (2019-12-29 08:06:06)
		mtime 1577603166.191996172 (2019-12-29 08:06:06)
		otime 1577603166.191996172 (2019-12-29 08:06:06)
leaf 301326336 items 13 free space 914 generation 295475 owner FS_TREE
leaf 301326336 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516716 INODE_REF 3516669) itemoff 3983 itemsize 12
		index 13 namelen 2 name: 54
	item 1 key (3516716 DIR_ITEM 32582581) itemoff 3915 itemsize 68
		location key (3516717 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: ea09e8f8972a2cda36ff407e28e3045083a3f9
	item 2 key (3516716 DIR_INDEX 3) itemoff 3847 itemsize 68
		location key (3516717 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: ea09e8f8972a2cda36ff407e28e3045083a3f9
	item 3 key (3516717 INODE_ITEM 0) itemoff 3687 itemsize 160
		generation 295081 transid 295099 size 921 nbytes 921
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603730.965284114 (2019-12-29 08:15:30)
		ctime 1577603166.191996172 (2019-12-29 08:06:06)
		mtime 1577603166.191996172 (2019-12-29 08:06:06)
		otime 1577603166.191996172 (2019-12-29 08:06:06)
	item 4 key (3516717 INODE_REF 3516716) itemoff 3639 itemsize 48
		index 3 namelen 38 name: ea09e8f8972a2cda36ff407e28e3045083a3f9
	item 5 key (3516717 EXTENT_DATA 0) itemoff 2697 itemsize 942
		generation 295082 type 0 (inline)
		inline extent data size 921 ram_bytes 921 compression 0 (none)
	item 6 key (3516730 INODE_ITEM 0) itemoff 2537 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603168.11996195 (2019-12-29 08:06:08)
		mtime 1577603168.11996195 (2019-12-29 08:06:08)
		otime 1577603168.11996195 (2019-12-29 08:06:08)
	item 7 key (3516730 INODE_REF 3516669) itemoff 2525 itemsize 12
		index 14 namelen 2 name: dd
	item 8 key (3516730 DIR_ITEM 3114184300) itemoff 2457 itemsize 68
		location key (3516732 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: afcba039bb1ed829ddaaa84c62228ec22e02a9
	item 9 key (3516730 DIR_INDEX 3) itemoff 2389 itemsize 68
		location key (3516732 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: afcba039bb1ed829ddaaa84c62228ec22e02a9
	item 10 key (3516732 INODE_ITEM 0) itemoff 2229 itemsize 160
		generation 295081 transid 295082 size 921 nbytes 921
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603168.11996195 (2019-12-29 08:06:08)
		ctime 1577603168.11996195 (2019-12-29 08:06:08)
		mtime 1577603168.11996195 (2019-12-29 08:06:08)
		otime 1577603168.11996195 (2019-12-29 08:06:08)
	item 11 key (3516732 INODE_REF 3516730) itemoff 2181 itemsize 48
		index 3 namelen 38 name: afcba039bb1ed829ddaaa84c62228ec22e02a9
	item 12 key (3516732 EXTENT_DATA 0) itemoff 1239 itemsize 942
		generation 295082 type 0 (inline)
		inline extent data size 921 ram_bytes 921 compression 0 (none)
leaf 299872256 items 12 free space 1632 generation 295475 owner FS_TREE
leaf 299872256 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516734 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295081 transid 295475 size 76 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577648299.155762390 (2019-12-29 20:38:19)
		ctime 1577603212.28201977 (2019-12-29 08:06:52)
		mtime 1577603212.28201977 (2019-12-29 08:06:52)
		otime 1577603212.28201977 (2019-12-29 08:06:52)
	item 1 key (3516734 INODE_REF 3516669) itemoff 3823 itemsize 12
		index 15 namelen 2 name: 53
	item 2 key (3516734 DIR_ITEM 1587417268) itemoff 3755 itemsize 68
		location key (3516735 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 0d3d9384b60a51e02120c2d1f9c28885c80333
	item 3 key (3516734 DIR_INDEX 3) itemoff 3687 itemsize 68
		location key (3516735 INODE_ITEM 0) type FILE
		transid 295081 data_len 0 name_len 38
		name: 0d3d9384b60a51e02120c2d1f9c28885c80333
	item 4 key (3516735 INODE_ITEM 0) itemoff 3527 itemsize 160
		generation 295081 transid 295099 size 643 nbytes 643
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 15 flags 0x0(none)
		atime 1577603731.665286286 (2019-12-29 08:15:31)
		ctime 1577603212.28201977 (2019-12-29 08:06:52)
		mtime 1577603212.28201977 (2019-12-29 08:06:52)
		otime 1577603212.28201977 (2019-12-29 08:06:52)
	item 5 key (3516735 INODE_REF 3516734) itemoff 3479 itemsize 48
		index 3 namelen 38 name: 0d3d9384b60a51e02120c2d1f9c28885c80333
	item 6 key (3516735 EXTENT_DATA 0) itemoff 2815 itemsize 664
		generation 295083 type 0 (inline)
		inline extent data size 643 ram_bytes 643 compression 0 (none)
	item 7 key (3516739 INODE_ITEM 0) itemoff 2655 itemsize 160
		generation 295082 transid 295083 size 478 nbytes 478
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603216.800202039 (2019-12-29 08:06:56)
		ctime 1577603216.800202039 (2019-12-29 08:06:56)
		mtime 1577603216.800202039 (2019-12-29 08:06:56)
		otime 1577603216.800202039 (2019-12-29 08:06:56)
	item 8 key (3516739 INODE_REF 3516703) itemoff 2607 itemsize 48
		index 5 namelen 38 name: 96666aac5c430826258c0850f55978bff9bc14
	item 9 key (3516739 EXTENT_DATA 0) itemoff 2108 itemsize 499
		generation 295083 type 0 (inline)
		inline extent data size 478 ram_bytes 478 compression 0 (none)
	item 10 key (3516742 INODE_ITEM 0) itemoff 1948 itemsize 160
		generation 295082 transid 295475 size 0 nbytes 0
		block group 0 mode 40755 links 1 uid 1000 gid 1000 rdev 0
		sequence 885 flags 0x0(none)
		atime 1577648299.119763610 (2019-12-29 20:38:19)
		ctime 1577648225.318022457 (2019-12-29 20:37:05)
		mtime 1577648225.318022457 (2019-12-29 20:37:05)
		otime 1577603219.756202078 (2019-12-29 08:06:59)
	item 11 key (3516742 INODE_REF 1108381) itemoff 1932 itemsize 16
		index 9888 namelen 6 name: doomed
leaf 232648704 items 8 free space 1941 generation 295425 owner FS_TREE
leaf 232648704 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516760 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295082 transid 295425 size 13690 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 17 flags 0x0(none)
		atime 1577646534.335819804 (2019-12-29 20:08:54)
		ctime 1577646534.390560456 (2019-12-29 20:08:54)
		mtime 1577646534.390560456 (2019-12-29 20:08:54)
		otime 1577603220.972202094 (2019-12-29 08:07:00)
	item 1 key (3516760 INODE_REF 1332998) itemoff 3785 itemsize 50
		index 614554 namelen 40 name: 7C2276051B70C3FBF5F3F5F304F4F26AC55728A0
	item 2 key (3516760 EXTENT_DATA 0) itemoff 3732 itemsize 53
		generation 295084 type 1 (regular)
		extent data disk byte 1111887872 nr 16384
		extent data offset 0 nr 4096 ram 16384
		extent compression 0 (none)
	item 3 key (3516760 EXTENT_DATA 4096) itemoff 3679 itemsize 53
		generation 295425 type 1 (regular)
		extent data disk byte 1114071040 nr 8192
		extent data offset 0 nr 8192 ram 8192
		extent compression 0 (none)
	item 4 key (3516760 EXTENT_DATA 12288) itemoff 3626 itemsize 53
		generation 295424 type 1 (regular)
		extent data disk byte 1112834048 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 5 key (3516761 INODE_ITEM 0) itemoff 3466 itemsize 160
		generation 295082 transid 295084 size 1254 nbytes 1254
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577603221.180202097 (2019-12-29 08:07:01)
		ctime 1577603221.180202097 (2019-12-29 08:07:01)
		mtime 1577603221.180202097 (2019-12-29 08:07:01)
		otime 1577603221.180202097 (2019-12-29 08:07:01)
	item 6 key (3516761 INODE_REF 1332998) itemoff 3416 itemsize 50
		index 614555 namelen 40 name: 8612E74972B8D7D2C4D76F4B41215603D10FFEC1
	item 7 key (3516761 EXTENT_DATA 0) itemoff 2141 itemsize 1275
		generation 295084 type 0 (inline)
		inline extent data size 1254 ram_bytes 1254 compression 0 (none)
leaf 236732416 items 10 free space 477 generation 295426 owner FS_TREE
leaf 236732416 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516869 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295082 transid 295084 size 1159 nbytes 1159
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 4 flags 0x0(none)
		atime 1577603222.704202117 (2019-12-29 08:07:02)
		ctime 1577603222.708202117 (2019-12-29 08:07:02)
		mtime 1577603222.708202117 (2019-12-29 08:07:02)
		otime 1577603222.704202117 (2019-12-29 08:07:02)
	item 1 key (3516869 INODE_REF 1332998) itemoff 3785 itemsize 50
		index 614556 namelen 40 name: 77857276CF37108D3445A6328103499B2CE4BE7F
	item 2 key (3516869 EXTENT_DATA 0) itemoff 2605 itemsize 1180
		generation 295084 type 0 (inline)
		inline extent data size 1159 ram_bytes 1159 compression 0 (none)
	item 3 key (3516968 INODE_ITEM 0) itemoff 2445 itemsize 160
		generation 295083 transid 295085 size 1331 nbytes 1331
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 8 flags 0x0(none)
		atime 1577603225.202147 (2019-12-29 08:07:05)
		ctime 1577603225.202147 (2019-12-29 08:07:05)
		mtime 1577603225.202147 (2019-12-29 08:07:05)
		otime 1577603225.202147 (2019-12-29 08:07:05)
	item 4 key (3516968 INODE_REF 1332998) itemoff 2395 itemsize 50
		index 614557 namelen 40 name: C3D206B7025DB46DADB5ABFED48F74EB4AE67161
	item 5 key (3516968 EXTENT_DATA 0) itemoff 1043 itemsize 1352
		generation 295085 type 0 (inline)
		inline extent data size 1331 ram_bytes 1331 compression 0 (none)
	item 6 key (3516970 INODE_ITEM 0) itemoff 883 itemsize 160
		generation 295083 transid 295426 size 9173 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 14 flags 0x0(none)
		atime 1577646534.331909757 (2019-12-29 20:08:54)
		ctime 1577646539.333698255 (2019-12-29 20:08:59)
		mtime 1577646539.333698255 (2019-12-29 20:08:59)
		otime 1577603225.768202157 (2019-12-29 08:07:05)
	item 7 key (3516970 INODE_REF 1332998) itemoff 833 itemsize 50
		index 614558 namelen 40 name: 984D0298A3ADE5899014838536D4285D513EE7BE
	item 8 key (3516970 EXTENT_DATA 0) itemoff 780 itemsize 53
		generation 295426 type 1 (regular)
		extent data disk byte 1103192064 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 9 key (3516970 EXTENT_DATA 4096) itemoff 727 itemsize 53
		generation 295425 type 1 (regular)
		extent data disk byte 1114861568 nr 8192
		extent data offset 0 nr 8192 ram 8192
		extent compression 0 (none)
leaf 61214720 items 7 free space 975 generation 295147 owner FS_TREE
leaf 61214720 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516983 INODE_ITEM 0) itemoff 3835 itemsize 160
		generation 295084 transid 295123 size 1140 nbytes 1140
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603256.576125927 (2019-12-29 08:07:36)
		mtime 1577603256.576125927 (2019-12-29 08:07:36)
		otime 1577603256.576125927 (2019-12-29 08:07:36)
	item 1 key (3516983 INODE_REF 1332998) itemoff 3785 itemsize 50
		index 614559 namelen 40 name: FC0089B289F366E4923E6EF7DE5F4154360E14BE
	item 2 key (3516983 EXTENT_DATA 0) itemoff 2624 itemsize 1161
		generation 295087 type 0 (inline)
		inline extent data size 1140 ram_bytes 1140 compression 0 (none)
	item 3 key (3516988 INODE_ITEM 0) itemoff 2464 itemsize 160
		generation 295086 transid 295123 size 1083 nbytes 1083
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603262.28120996 (2019-12-29 08:07:42)
		mtime 1577603262.28120996 (2019-12-29 08:07:42)
		otime 1577603262.28120996 (2019-12-29 08:07:42)
	item 4 key (3516988 INODE_REF 1332998) itemoff 2414 itemsize 50
		index 614560 namelen 40 name: 2EA587074CEBC957548F87D2FC2E70EEF111CDC4
	item 5 key (3516988 EXTENT_DATA 0) itemoff 1310 itemsize 1104
		generation 295087 type 0 (inline)
		inline extent data size 1083 ram_bytes 1083 compression 0 (none)
	item 6 key (3516989 INODE_ITEM 0) itemoff 1150 itemsize 160
		generation 295086 transid 295123 size 64478 nbytes 65536
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603262.532120630 (2019-12-29 08:07:42)
		mtime 1577603262.532120630 (2019-12-29 08:07:42)
		otime 1577603262.532120630 (2019-12-29 08:07:42)
leaf 285138944 items 14 free space 385 generation 295474 owner FS_TREE
leaf 285138944 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3516989 INODE_REF 1332998) itemoff 3945 itemsize 50
		index 614561 namelen 40 name: A7D0FAD6FFBB81DD4BA2AB45F64F48776F6836E5
	item 1 key (3516989 EXTENT_DATA 0) itemoff 3892 itemsize 53
		generation 295087 type 1 (regular)
		extent data disk byte 1213902848 nr 65536
		extent data offset 0 nr 65536 ram 65536
		extent compression 0 (none)
	item 2 key (3516990 INODE_ITEM 0) itemoff 3732 itemsize 160
		generation 295086 transid 295123 size 1083 nbytes 1083
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603262.612120571 (2019-12-29 08:07:42)
		mtime 1577603262.612120571 (2019-12-29 08:07:42)
		otime 1577603262.608120575 (2019-12-29 08:07:42)
	item 3 key (3516990 INODE_REF 1332998) itemoff 3682 itemsize 50
		index 614562 namelen 40 name: 1F9AF639CFF5ACA28E33551236E110C2D5D99CA9
	item 4 key (3516990 EXTENT_DATA 0) itemoff 2578 itemsize 1104
		generation 295087 type 0 (inline)
		inline extent data size 1083 ram_bytes 1083 compression 0 (none)
	item 5 key (3516991 INODE_ITEM 0) itemoff 2418 itemsize 160
		generation 295086 transid 295123 size 1083 nbytes 1083
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603262.652120543 (2019-12-29 08:07:42)
		mtime 1577603262.652120543 (2019-12-29 08:07:42)
		otime 1577603262.652120543 (2019-12-29 08:07:42)
	item 6 key (3516991 INODE_REF 1332998) itemoff 2368 itemsize 50
		index 614563 namelen 40 name: D3B37B2CE9AA6B3F018BCA2EB9D5D0ABD394E747
	item 7 key (3516991 EXTENT_DATA 0) itemoff 1264 itemsize 1104
		generation 295087 type 0 (inline)
		inline extent data size 1083 ram_bytes 1083 compression 0 (none)
	item 8 key (3516992 INODE_ITEM 0) itemoff 1104 itemsize 160
		generation 295086 transid 295474 size 580466 nbytes 581632
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 60 flags 0x0(none)
		atime 1577648215.790275031 (2019-12-29 20:36:55)
		ctime 1577648215.790275031 (2019-12-29 20:36:55)
		mtime 1577648215.790275031 (2019-12-29 20:36:55)
		otime 1577603262.684120520 (2019-12-29 08:07:42)
	item 9 key (3516992 INODE_REF 1332998) itemoff 1054 itemsize 50
		index 614564 namelen 40 name: E34E67AA76175644B8EFCE7EBA7C8F0D0F24142A
	item 10 key (3516992 EXTENT_DATA 0) itemoff 1001 itemsize 53
		generation 295122 type 1 (regular)
		extent data disk byte 3296342016 nr 581632
		extent data offset 0 nr 565248 ram 581632
		extent compression 0 (none)
	item 11 key (3516992 EXTENT_DATA 565248) itemoff 948 itemsize 53
		generation 295474 type 1 (regular)
		extent data disk byte 3252375552 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 12 key (3516992 EXTENT_DATA 577536) itemoff 895 itemsize 53
		generation 295473 type 1 (regular)
		extent data disk byte 3252293632 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 13 key (3516994 INODE_ITEM 0) itemoff 735 itemsize 160
		generation 295086 transid 295123 size 64334 nbytes 65536
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 12 flags 0x0(none)
		atime 1577604848.156072833 (2019-12-29 08:34:08)
		ctime 1577603266.172118274 (2019-12-29 08:07:46)
		mtime 1577603266.172118274 (2019-12-29 08:07:46)
		otime 1577603266.172118274 (2019-12-29 08:07:46)
parent transid verify failed on 42741760 wanted 295123 found 295530
parent transid verify failed on 42741760 wanted 295123 found 295530
parent transid verify failed on 42741760 wanted 295123 found 295530
Ignoring transid failure
leaf 42741760 items 30 free space 551 generation 295530 owner FS_TREE
leaf 42741760 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (1170611 EXTENT_DATA 266240) itemoff 3942 itemsize 53
		generation 114070 type 1 (regular)
		extent data disk byte 3527663616 nr 12288
		extent data offset 0 nr 8192 ram 12288
		extent compression 0 (none)
	item 1 key (1170611 EXTENT_DATA 274432) itemoff 3889 itemsize 53
		generation 114785 type 1 (regular)
		extent data disk byte 20168421376 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 2 key (1170611 EXTENT_DATA 278528) itemoff 3836 itemsize 53
		generation 115029 type 1 (regular)
		extent data disk byte 16818950144 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 3 key (1170611 EXTENT_DATA 282624) itemoff 3783 itemsize 53
		generation 115267 type 1 (regular)
		extent data disk byte 14796996608 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 4 key (1170611 EXTENT_DATA 286720) itemoff 3730 itemsize 53
		generation 116294 type 1 (regular)
		extent data disk byte 2191859712 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 5 key (1170611 EXTENT_DATA 290816) itemoff 3677 itemsize 53
		generation 116362 type 1 (regular)
		extent data disk byte 21387706368 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 6 key (1170611 EXTENT_DATA 294912) itemoff 3624 itemsize 53
		generation 117040 type 1 (regular)
		extent data disk byte 6497370112 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 7 key (1170611 EXTENT_DATA 299008) itemoff 3571 itemsize 53
		generation 118887 type 1 (regular)
		extent data disk byte 8105349120 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 8 key (1170611 EXTENT_DATA 303104) itemoff 3518 itemsize 53
		generation 118928 type 1 (regular)
		extent data disk byte 4367138816 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 9 key (1170611 EXTENT_DATA 307200) itemoff 3465 itemsize 53
		generation 118932 type 1 (regular)
		extent data disk byte 2318548992 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 10 key (1170611 EXTENT_DATA 311296) itemoff 3412 itemsize 53
		generation 119300 type 1 (regular)
		extent data disk byte 8403316736 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 11 key (1170611 EXTENT_DATA 315392) itemoff 3359 itemsize 53
		generation 119303 type 1 (regular)
		extent data disk byte 3400359936 nr 8192
		extent data offset 0 nr 4096 ram 8192
		extent compression 0 (none)
	item 12 key (1170611 EXTENT_DATA 319488) itemoff 3306 itemsize 53
		generation 119343 type 1 (regular)
		extent data disk byte 21678280704 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)
	item 13 key (1170632 INODE_ITEM 0) itemoff 3146 itemsize 160
		generation 104578 transid 294139 size 567 nbytes 567
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1575702174.835215822 (2019-12-07 08:02:54)
		ctime 1438448314.514063486 (2015-08-01 18:58:34)
		mtime 1438448314.514063486 (2015-08-01 18:58:34)
		otime 1438448314.514063486 (2015-08-01 18:58:34)
	item 14 key (1170632 INODE_REF 817) itemoff 3112 itemsize 34
		index 45994 namelen 24 name: plasma-overlay-appletsrc
	item 15 key (1170632 EXTENT_DATA 0) itemoff 2524 itemsize 588
		generation 104579 type 0 (inline)
		inline extent data size 567 ram_bytes 567 compression 0 (none)
	item 16 key (1170635 INODE_ITEM 0) itemoff 2364 itemsize 160
		generation 104578 transid 294139 size 29438 nbytes 32768
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 6 flags 0x0(none)
		atime 1575702189.671328324 (2019-12-07 08:03:09)
		ctime 1438448335.222366444 (2015-08-01 18:58:55)
		mtime 1438448335.222366444 (2015-08-01 18:58:55)
		otime 1438448335.218366387 (2015-08-01 18:58:55)
	item 17 key (1170635 INODE_REF 5537) itemoff 2318 itemsize 46
		index 741 namelen 36 name: 816bd26a0e15b80e10d26a753014cd8a.png
	item 18 key (1170635 EXTENT_DATA 0) itemoff 2265 itemsize 53
		generation 104578 type 1 (regular)
		extent data disk byte 3526041600 nr 32768
		extent data offset 0 nr 32768 ram 32768
		extent compression 0 (none)
	item 19 key (1170636 INODE_ITEM 0) itemoff 2105 itemsize 160
		generation 104578 transid 294139 size 15544 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 4 flags 0x0(none)
		atime 1575702189.679328377 (2019-12-07 08:03:09)
		ctime 1438448335.238366669 (2015-08-01 18:58:55)
		mtime 1438448335.238366669 (2015-08-01 18:58:55)
		otime 1438448335.234366612 (2015-08-01 18:58:55)
	item 20 key (1170636 INODE_REF 5537) itemoff 2059 itemsize 46
		index 743 namelen 36 name: eed0f01548ff782ebe5feef130978aa5.png
	item 21 key (1170636 EXTENT_DATA 0) itemoff 2006 itemsize 53
		generation 104578 type 1 (regular)
		extent data disk byte 3526090752 nr 16384
		extent data offset 0 nr 16384 ram 16384
		extent compression 0 (none)
	item 22 key (1170637 INODE_ITEM 0) itemoff 1846 itemsize 160
		generation 104578 transid 294139 size 24433 nbytes 24576
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1575702189.671328324 (2019-12-07 08:03:09)
		ctime 1438448335.250366839 (2015-08-01 18:58:55)
		mtime 1438448335.250366839 (2015-08-01 18:58:55)
		otime 1438448335.242366726 (2015-08-01 18:58:55)
	item 23 key (1170637 INODE_REF 5537) itemoff 1800 itemsize 46
		index 745 namelen 36 name: b2b0821a2ac38a2981f7636103b9f513.png
	item 24 key (1170637 EXTENT_DATA 0) itemoff 1747 itemsize 53
		generation 104578 type 1 (regular)
		extent data disk byte 3526176768 nr 24576
		extent data offset 0 nr 24576 ram 24576
		extent compression 0 (none)
	item 25 key (1170638 INODE_ITEM 0) itemoff 1587 itemsize 160
		generation 104578 transid 294139 size 16992 nbytes 20480
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 5 flags 0x0(none)
		atime 1575702189.679328377 (2019-12-07 08:03:09)
		ctime 1438448335.258366952 (2015-08-01 18:58:55)
		mtime 1438448335.258366952 (2015-08-01 18:58:55)
		otime 1438448335.254366894 (2015-08-01 18:58:55)
	item 26 key (1170638 INODE_REF 5537) itemoff 1541 itemsize 46
		index 747 namelen 36 name: eee0565306942dd11ea97feca15b4e9a.png
	item 27 key (1170638 EXTENT_DATA 0) itemoff 1488 itemsize 53
		generation 104578 type 1 (regular)
		extent data disk byte 3526201344 nr 20480
		extent data offset 0 nr 20480 ram 20480
		extent compression 0 (none)
	item 28 key (1170684 INODE_ITEM 0) itemoff 1328 itemsize 160
		generation 104581 transid 295530 size 10547304 nbytes 10551296
		block group 0 mode 100644 links 1 uid 1000 gid 1000 rdev 0
		sequence 57241 flags 0x10(PREALLOC)
		atime 1577690632.826809841 (2019-12-30 08:23:52)
		ctime 1577690633.122962183 (2019-12-30 08:23:53)
		mtime 1577690633.122962183 (2019-12-30 08:23:53)
		otime 1438448452.227839945 (2015-08-01 19:00:52)
	item 29 key (1170684 INODE_REF 273) itemoff 1301 itemsize 27
		index 48 namelen 17 name: icon-cache.kcache
leaf 133730304 items 25 free space 1213 generation 295316 owner FS_TREE
leaf 133730304 flags 0x1(WRITTEN) backref revision 1
fs uuid d6954ba3-3d50-4886-ae3f-a92a5ca83923
chunk uuid d8f00ac1-fb3b-474e-9957-ebfd773fa8af
	item 0 key (3517014 EXTENT_DATA 0) itemoff 3942 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1121017856 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 1 key (3517015 INODE_ITEM 0) itemoff 3782 itemsize 160
		generation 295090 transid 295123 size 10719 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 7 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.531827216 (2019-12-29 08:32:38)
		mtime 1577604758.531827216 (2019-12-29 08:32:38)
		otime 1577603374.100711926 (2019-12-29 08:09:34)
	item 2 key (3517015 INODE_REF 1332998) itemoff 3732 itemsize 50
		index 614570 namelen 40 name: 234723439C3E610E4ED9A0738A9755994F307FAB
	item 3 key (3517015 EXTENT_DATA 0) itemoff 3679 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1129644032 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 4 key (3517016 INODE_ITEM 0) itemoff 3519 itemsize 160
		generation 295090 transid 295123 size 10012 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 59 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.531827216 (2019-12-29 08:32:38)
		mtime 1577604758.531827216 (2019-12-29 08:32:38)
		otime 1577603374.128712012 (2019-12-29 08:09:34)
	item 5 key (3517016 INODE_REF 1332998) itemoff 3469 itemsize 50
		index 614571 namelen 40 name: 6816CF7FCB3F2CB8197687185B7B4342179FF715
	item 6 key (3517016 EXTENT_DATA 0) itemoff 3416 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1133162496 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 7 key (3517017 INODE_ITEM 0) itemoff 3256 itemsize 160
		generation 295090 transid 295123 size 9214 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 9 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.531827216 (2019-12-29 08:32:38)
		mtime 1577604758.531827216 (2019-12-29 08:32:38)
		otime 1577603374.128712012 (2019-12-29 08:09:34)
	item 8 key (3517017 INODE_REF 1332998) itemoff 3206 itemsize 50
		index 614572 namelen 40 name: 408F6B7F588862A035A30243624BE5E20E981513
	item 9 key (3517017 EXTENT_DATA 0) itemoff 3153 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1133207552 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 10 key (3517018 INODE_ITEM 0) itemoff 2993 itemsize 160
		generation 295090 transid 295123 size 9256 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 9 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.531827216 (2019-12-29 08:32:38)
		mtime 1577604758.531827216 (2019-12-29 08:32:38)
		otime 1577603374.128712012 (2019-12-29 08:09:34)
	item 11 key (3517018 INODE_REF 1332998) itemoff 2943 itemsize 50
		index 614573 namelen 40 name: E3FA9F0AB40F2AD7B1CD2928D8278B94841E506A
	item 12 key (3517018 EXTENT_DATA 0) itemoff 2890 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1133453312 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 13 key (3517019 INODE_ITEM 0) itemoff 2730 itemsize 160
		generation 295090 transid 295123 size 10021 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 9 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.535827242 (2019-12-29 08:32:38)
		mtime 1577604758.535827242 (2019-12-29 08:32:38)
		otime 1577603374.132712024 (2019-12-29 08:09:34)
	item 14 key (3517019 INODE_REF 1332998) itemoff 2680 itemsize 50
		index 614574 namelen 40 name: 481815EFB458714CF7A1C6EFB7C466ECAA3D50FD
	item 15 key (3517019 EXTENT_DATA 0) itemoff 2627 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1133772800 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 16 key (3517020 INODE_ITEM 0) itemoff 2467 itemsize 160
		generation 295090 transid 295123 size 12155 nbytes 12288
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 7 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577604758.535827242 (2019-12-29 08:32:38)
		mtime 1577604758.535827242 (2019-12-29 08:32:38)
		otime 1577603374.132712024 (2019-12-29 08:09:34)
	item 17 key (3517020 INODE_REF 1332998) itemoff 2417 itemsize 50
		index 614575 namelen 40 name: 979D0CE9B15D5B5D2E7259284F3DFFE01237DECA
	item 18 key (3517020 EXTENT_DATA 0) itemoff 2364 itemsize 53
		generation 295119 type 1 (regular)
		extent data disk byte 1136852992 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 19 key (3517021 INODE_ITEM 0) itemoff 2204 itemsize 160
		generation 295090 transid 295316 size 14682 nbytes 16384
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 35 flags 0x0(none)
		atime 1577629815.873963679 (2019-12-29 15:30:15)
		ctime 1577629815.873963679 (2019-12-29 15:30:15)
		mtime 1577629815.873963679 (2019-12-29 15:30:15)
		otime 1577603374.156712100 (2019-12-29 08:09:34)
	item 20 key (3517021 INODE_REF 1332998) itemoff 2154 itemsize 50
		index 614576 namelen 40 name: 06C0A08B0360A63EE9A0978DA091DC4B70DFEAA7
	item 21 key (3517021 EXTENT_DATA 0) itemoff 2101 itemsize 53
		generation 295092 type 1 (regular)
		extent data disk byte 1117655040 nr 16384
		extent data offset 0 nr 4096 ram 16384
		extent compression 0 (none)
	item 22 key (3517021 EXTENT_DATA 4096) itemoff 2048 itemsize 53
		generation 295316 type 1 (regular)
		extent data disk byte 1380732928 nr 12288
		extent data offset 0 nr 12288 ram 12288
		extent compression 0 (none)
	item 23 key (3517028 INODE_ITEM 0) itemoff 1888 itemsize 160
		generation 295092 transid 295123 size 1298 nbytes 1298
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0
		sequence 3 flags 0x0(none)
		atime 1577604848.160072838 (2019-12-29 08:34:08)
		ctime 1577603402.472788756 (2019-12-29 08:10:02)
		mtime 1577603402.472788756 (2019-12-29 08:10:02)
		otime 1577603402.472788756 (2019-12-29 08:10:02)
	item 24 key (3517028 INODE_REF 1332998) itemoff 1838 itemsize 50
		index 614577 namelen 40 name: 47AE3470F13DD0194C83AFE95C15FD7E830DB1D7
parent transid verify failed on 42749952 wanted 295123 found 295530
parent transid verify failed on 42749952 wanted 295123 found 295530
parent transid verify failed on 42749952 wanted 295123 found 295530
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D285405184 item=3D13 parent leve=
l=3D1 child level=3D1



--------------2B38DA7E4C57ECD9BE39B859--

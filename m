Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82387128D53
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLVKEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 05:04:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:54513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfLVKEE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 05:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577009040;
        bh=7zDPuYJKjtOG8koPP/ZHg21FJ4e9JwI+nQqmWGJWz1Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dMKfMGOr0eQ+edazpZEEFPOu69Pj0vAn82J0n/LkAoV+vACwoQt5b4Swzaf0tuHBN
         Z/aQib3PZTQ3uoS4ot25eEsMSoVUA7UxWrG+EyQvLJ1DPOZd+0zZmx7go1ktud1hhL
         tkUb+5+eiKfc+Otqcc95Kei2Iw6c8bhmp+C3azqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bukephalos.localnet ([46.93.61.118]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1i5DM109E9-00e90g; Sun, 22
 Dec 2019 11:04:00 +0100
From:   jollemeyer@gmx.de
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: read time block corruption on root partition, Not booting
Date:   Sun, 22 Dec 2019 11:03:58 +0100
Message-ID: <3512999.4HXIEJrTBV@bukephalos>
In-Reply-To: <249711d9-5cbc-b56c-2226-33a9d42af521@gmx.com>
References: <af9d16c9-2bf5-46fa-a146-84c4f8f6cc31.maildroid@localhost> <a29a69bd-d3f3-44d2-af62-bb0b7a364ba5.maildroid@localhost> <249711d9-5cbc-b56c-2226-33a9d42af521@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qVO+eeVFlbRNiZSIXABxIqYR3P+6IWtuFEhjK9DiI2rLghd+Mj5
 uz+0w3KJTzjC/Qf/ZiwCoFPZF2Tzj2TPdicU/tvuMR0bZPOQbUxAZTpv3anRdI6YMY4xTVc
 LJBQdURaHFTvvucPzloxuDlVgkjZzgKhxeIz9fTqk75D5OusQe7OTjDIM4mD5dfnbkJj672
 ZVRi+msNBZ1Js1yjcVzlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0cHTldUionw=:iktqx0zn5Ze1YXyk94rtSz
 mKUuRsEXUp8R8r1MYaeuX+CARue9XplaQqFZOCSNfJ5FPvLu+e3Nv4/MtL+YSwe+zljOweH0V
 CY09F3QUWTItO66xDpV/aJHYkY7Siqg5ilLcLFzlU+TuUCVDCvty5UIzb6B2TfnJETFc3XRB9
 QNzknMB/e7kVb/dfrJEdQVa7cgoAf6FzwHHZBuKNNrRAPaF+YnZdWK7IJMKNsUFjQXBdHekx0
 ChqeGdEe88bwTWDYo4VdPVY+lgAHpIMMjjt2eJKUFoSe8Y2W9UQGC7Pt6QG2g1uTQ1HyjArFl
 0ApDUp5ciicPYevWEmGvhK6lvIXCTryzvIxAafFdgijiCCi2Ujrs3lI8+sGPX7Ra9rZuJXBMQ
 rsOxebHbrOQN/CIrkAftHOrTxTs4bdMO5nuCCCS/3PgJx+KoV82IMEKWM5yznQxt2SSWQQQl6
 X9xiviOcLgRe9fAcz9CfSPXUoQBUIghJjrO35s4arQp9bcfYDfoNwDhxF60FcGsCsRKlZ7WnL
 qcC4XEF9whxw6rcPGFwCntR5u+fkJ2HX3O8etZyp9CpKVr8qR3dXqAjGLuwVVB+aOZXw1rkjq
 YywteyhHMgjiYmYo3klauj4x1NRRmgon1iH8YZXAKEvW0I4G7YcPWCSOhkPUpu8arf9WqBBGD
 D1cqWu6j0FZtATB3XiQ+HjcxGMJNix8yjPcjb93/UqfkJ2InE23ZMFWwgWF7kSD/p4dcZKzEe
 k5ard2nF4fwckZOMaMMJN8pqvElpFV1dMXi5yT0FD29FLE5DfxuFFcPYybjJd73QPIZtfO0Xu
 SHq0/uo+V51dKqRFIgalk/vOHw0eFVNOzeCFn17/EEX7pygDd1OtXBY8zIXQdFj+zFKSClZKT
 jbVbHv+2mwLvG/zHdxzVMGUMlOitcHNL4W4E7QaRRO4Ka1qiJ5zlP851B7arp4Ugbi3bQy359
 9IZB0I/aTqU32LuKOP9X8u+NrM2jzMaUD3uvsAi/oIFV63ENQ1HNbKJwnYfHSai4jNa1fg0rc
 BHVV2qXFvo45sSoDjCsjKYgnUuDjqRZAlcEGRbf5y+x7uLe6C8gohKmX8uepxKWscbpolz2Pg
 LOHIvH4kZG1ImwCLOjgPmEg93HCyEe/c4m1kwWgc4UvEiptmJp+M48K0IwQoiCrx+RG88967b
 9/00OHSOQvO0lRYNWRf1jfYU00z7Waiul9FKiorKBX++NQeNE3u15lcKk49viQztGj7UqEwdj
 as/r/QEN3U2EBIxvsWH/0TFIeJDjroZZL8nuCideXQNb5z5P76nQa/lJMNP0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Qu,

I had a typo in my previous "btrfs dump tree" command (/dev/sda1 instead of=
 /
dev/sda). Now I got the output below:

btrfs-progs v5.4=20
leaf 2089035464704 items 145 free space 4973 generation 75450 owner=20
EXTENT_TREE
leaf 2089035464704 flags 0x1(WRITTEN) backref revision 1
fs uuid 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
chunk uuid d4aae6e9-9832-4da5-a269-0a46e54a4e33
	item 0 key (1937095585792 EXTENT_ITEM 4096) itemoff 16230 itemsize=20
53
		refs 1 gen 68673 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213512192 count 1
	item 1 key (1937095589888 EXTENT_ITEM 12288) itemoff 16177 itemsize=20
53
		refs 1 gen 54558 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
217124864 count 1
	item 2 key (1937095602176 EXTENT_ITEM 20480) itemoff 16124 itemsize=20
53
		refs 1 gen 39896 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209100800 count 1
	item 3 key (1937095622656 EXTENT_ITEM 4096) itemoff 16071 itemsize=20
53
		refs 1 gen 72453 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153509888 count 1
	item 4 key (1937095626752 EXTENT_ITEM 4096) itemoff 16018 itemsize=20
53
		refs 1 gen 72455 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
151752704 count 1
	item 5 key (1937095630848 EXTENT_ITEM 4096) itemoff 15965 itemsize=20
53
		refs 1 gen 72455 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
151773184 count 1
	item 6 key (1937095634944 EXTENT_ITEM 4096) itemoff 15912 itemsize=20
53
		refs 1 gen 54560 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
214171648 count 1
	item 7 key (1937095639040 EXTENT_ITEM 24576) itemoff 15859 itemsize=20
53
		refs 1 gen 39886 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208920576 count 1
	item 8 key (1937095663616 EXTENT_ITEM 16384) itemoff 15806 itemsize=20
53
		refs 1 gen 72307 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153587712 count 1
	item 9 key (1937095680000 EXTENT_ITEM 4096) itemoff 15753 itemsize=20
53
		refs 1 gen 41223 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
211927040 count 1
	item 10 key (1937095684096 EXTENT_ITEM 4096) itemoff 15700 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208539648 count 1
	item 11 key (1937095688192 EXTENT_ITEM 4096) itemoff 15647 itemsize=20
53
		refs 1 gen 56946 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
212344832 count 1
	item 12 key (1937095692288 EXTENT_ITEM 4096) itemoff 15594 itemsize=20
53
		refs 1 gen 57005 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207519744 count 1
	item 13 key (1937095696384 EXTENT_ITEM 4096) itemoff 15541 itemsize=20
53
		refs 1 gen 56911 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213823488 count 1
	item 14 key (1937095700480 EXTENT_ITEM 12288) itemoff 15488 itemsize=20
53
		refs 1 gen 54560 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
214171648 count 1
	item 15 key (1937095712768 EXTENT_ITEM 4096) itemoff 15435 itemsize=20
53
		refs 1 gen 40861 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210767872 count 1
	item 16 key (1937095716864 EXTENT_ITEM 20480) itemoff 15382 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208744448 count 1
	item 17 key (1937095737344 EXTENT_ITEM 4096) itemoff 15329 itemsize=20
53
		refs 1 gen 72774 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
158392320 count 1
	item 18 key (1937095741440 EXTENT_ITEM 4096) itemoff 15276 itemsize=20
53
		refs 1 gen 39691 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207007744 count 1
	item 19 key (1937095745536 EXTENT_ITEM 4096) itemoff 15223 itemsize=20
53
		refs 1 gen 73575 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153071616 count 1
	item 20 key (1937095749632 EXTENT_ITEM 20480) itemoff 15170 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112680960 count 1
	item 21 key (1937095770112 EXTENT_ITEM 12288) itemoff 15117 itemsize=20
53
		refs 1 gen 72406 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153088000 count 1
	item 22 key (1937095782400 EXTENT_ITEM 8192) itemoff 15064 itemsize=20
53
		refs 1 gen 39741 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210169856 count 1
	item 23 key (1937095790592 EXTENT_ITEM 12288) itemoff 15011 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207511552 count 1
	item 24 key (1937095802880 EXTENT_ITEM 12288) itemoff 14958 itemsize=20
53
		refs 1 gen 72451 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153509888 count 1
	item 25 key (1937095815168 EXTENT_ITEM 20480) itemoff 14905 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208592896 count 1
	item 26 key (1937095835648 EXTENT_ITEM 8192) itemoff 14852 itemsize=20
53
		refs 1 gen 72408 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
152940544 count 1
	item 27 key (1937095843840 EXTENT_ITEM 16384) itemoff 14799 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207536128 count 1
	item 28 key (1937095860224 EXTENT_ITEM 8192) itemoff 14746 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207536128 count 1
	item 29 key (1937095868416 EXTENT_ITEM 16384) itemoff 14693 itemsize=20
53
		refs 1 gen 40023 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210665472 count 1
	item 30 key (1937095884800 EXTENT_ITEM 4096) itemoff 14640 itemsize=20
53
		refs 1 gen 40689 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213577728 count 1
	item 31 key (1937095888896 EXTENT_ITEM 8192) itemoff 14587 itemsize=20
53
		refs 1 gen 72463 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153378816 count 1
	item 32 key (1937095897088 EXTENT_ITEM 4096) itemoff 14534 itemsize=20
53
		refs 1 gen 72464 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153612288 count 1
	item 33 key (1937095901184 EXTENT_ITEM 4096) itemoff 14481 itemsize=20
53
		refs 1 gen 72465 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
159203328 count 1
	item 34 key (1937095905280 EXTENT_ITEM 24576) itemoff 14428 itemsize=20
53
		refs 2 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112701440 count 2
	item 35 key (1937095929856 EXTENT_ITEM 4096) itemoff 14375 itemsize=20
53
		refs 1 gen 75359 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112668672 count 1
	item 36 key (1937095933952 EXTENT_ITEM 4096) itemoff 14322 itemsize=20
53
		refs 1 gen 75244 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
217157632 count 1
	item 37 key (1937095938048 EXTENT_ITEM 4096) itemoff 14269 itemsize=20
53
		refs 1 gen 75237 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209965056 count 1
	item 38 key (1937095942144 EXTENT_ITEM 4096) itemoff 14216 itemsize=20
53
		refs 1 gen 75276 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112517120 count 1
	item 39 key (1937095946240 EXTENT_ITEM 4096) itemoff 14163 itemsize=20
53
		refs 1 gen 75276 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112529408 count 1
	item 40 key (1937095950336 EXTENT_ITEM 4096) itemoff 14110 itemsize=20
53
		refs 1 gen 75253 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112689152 count 1
	item 41 key (1937095954432 EXTENT_ITEM 4096) itemoff 14057 itemsize=20
53
		refs 1 gen 75359 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
216440832 count 1
	item 42 key (1937095962624 EXTENT_ITEM 20480) itemoff 14004 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112611328 count 1
	item 43 key (1937095983104 EXTENT_ITEM 4096) itemoff 13951 itemsize=20
53
		refs 1 gen 74072 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112705536 count 1
	item 44 key (1937095987200 EXTENT_ITEM 12288) itemoff 13898 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112574464 count 1
	item 45 key (1937095999488 EXTENT_ITEM 4096) itemoff 13845 itemsize=20
53
		refs 1 gen 74191 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153755648 count 1
	item 46 key (1937096003584 EXTENT_ITEM 12288) itemoff 13792 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112582656 count 1
	item 47 key (1937096015872 EXTENT_ITEM 4096) itemoff 13739 itemsize=20
53
		refs 1 gen 74129 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
120496128 count 1
	item 48 key (1937096019968 EXTENT_ITEM 4096) itemoff 13686 itemsize=20
53
		refs 1 gen 75276 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112660480 count 1
	item 49 key (1937096024064 EXTENT_ITEM 4096) itemoff 13633 itemsize=20
53
		refs 1 gen 75276 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112484352 count 1
	item 50 key (1937096028160 EXTENT_ITEM 8192) itemoff 13580 itemsize=20
53
		refs 1 gen 75275 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112975872 count 1
	item 51 key (1937096036352 EXTENT_ITEM 8192) itemoff 13527 itemsize=20
53
		refs 1 gen 74069 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
111824896 count 1
	item 52 key (1937096048640 EXTENT_ITEM 16384) itemoff 13474 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112533504 count 1
	item 53 key (1937096069120 EXTENT_ITEM 16384) itemoff 13421 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112517120 count 1
	item 54 key (1937096085504 EXTENT_ITEM 8192) itemoff 13368 itemsize=20
53
		refs 1 gen 74068 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112058368 count 1
	item 55 key (1937096093696 EXTENT_ITEM 4096) itemoff 13315 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112545792 count 1
	item 56 key (1937096097792 EXTENT_ITEM 16384) itemoff 13262 itemsize=20
53
		refs 2 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112594944 count 2
	item 57 key (1937096118272 EXTENT_ITEM 4096) itemoff 13209 itemsize=20
53
		refs 1 gen 74269 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209960960 count 1
	item 58 key (1937096122368 EXTENT_ITEM 4096) itemoff 13156 itemsize=20
53
		refs 1 gen 74062 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208429056 count 1
	item 59 key (1937096126464 EXTENT_ITEM 4096) itemoff 13103 itemsize=20
53
		refs 1 gen 75359 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
216145920 count 1
	item 60 key (1937096130560 EXTENT_ITEM 4096) itemoff 13050 itemsize=20
53
		refs 1 gen 74062 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207757312 count 1
	item 61 key (1937096134656 EXTENT_ITEM 4096) itemoff 12997 itemsize=20
53
		refs 1 gen 75359 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153124864 count 1
	item 62 key (1937096138752 EXTENT_ITEM 8192) itemoff 12944 itemsize=20
53
		refs 1 gen 74062 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207216640 count 1
	item 63 key (1937096146944 EXTENT_ITEM 4096) itemoff 12891 itemsize=20
53
		refs 1 gen 74062 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207237120 count 1
	item 64 key (1937096151040 EXTENT_ITEM 4096) itemoff 12838 itemsize=20
53
		refs 1 gen 74062 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207392768 count 1
	item 65 key (1937096159232 EXTENT_ITEM 8192) itemoff 12785 itemsize=20
53
		refs 1 gen 72407 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
152551424 count 1
	item 66 key (1937096167424 EXTENT_ITEM 8192) itemoff 12732 itemsize=20
53
		refs 1 gen 40011 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209850368 count 1
	item 67 key (1937096175616 EXTENT_ITEM 4096) itemoff 12679 itemsize=20
53
		refs 1 gen 73578 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
157937664 count 1
	item 68 key (1937096179712 EXTENT_ITEM 8192) itemoff 12626 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208592896 count 1
	item 69 key (1937096187904 EXTENT_ITEM 12288) itemoff 12573 itemsize=20
53
		refs 1 gen 40013 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210305024 count 1
	item 70 key (1937096200192 EXTENT_ITEM 12288) itemoff 12520 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207486976 count 1
	item 71 key (1937096212480 EXTENT_ITEM 36864) itemoff 12467 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208711680 count 1
	item 72 key (1937096249344 EXTENT_ITEM 12288) itemoff 12414 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207499264 count 1
	item 73 key (1937096261632 EXTENT_ITEM 4096) itemoff 12361 itemsize=20
53
		refs 1 gen 56946 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213164032 count 1
	item 74 key (1937096269824 EXTENT_ITEM 20480) itemoff 12308 itemsize=20
53
		refs 1 gen 39895 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209117184 count 1
	item 75 key (1937096290304 EXTENT_ITEM 8192) itemoff 12255 itemsize=20
53
		refs 1 gen 40088 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209338368 count 1
	item 76 key (1937096298496 EXTENT_ITEM 32768) itemoff 12202 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207458304 count 1
	item 77 key (1937096331264 EXTENT_ITEM 4096) itemoff 12149 itemsize=20
53
		refs 1 gen 41067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
211718144 count 1
	item 78 key (1937096335360 EXTENT_ITEM 16384) itemoff 12096 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207458304 count 1
	item 79 key (1937096351744 EXTENT_ITEM 16384) itemoff 12043 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208711680 count 1
	item 80 key (1937096368128 EXTENT_ITEM 4096) itemoff 11990 itemsize=20
53
		refs 1 gen 40926 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210849792 count 1
	item 81 key (1937096372224 EXTENT_ITEM 28672) itemoff 11937 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207433728 count 1
	item 82 key (1937096400896 EXTENT_ITEM 4096) itemoff 11884 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207486976 count 1
	item 83 key (1937096404992 EXTENT_ITEM 4096) itemoff 11831 itemsize=20
53
		refs 1 gen 40812 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213110784 count 1
	item 84 key (1937096409088 EXTENT_ITEM 16384) itemoff 11778 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207433728 count 1
	item 85 key (1937096425472 EXTENT_ITEM 4096) itemoff 11725 itemsize=20
53
		refs 1 gen 41267 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
212492288 count 1048577
	item 86 key (1937096429568 EXTENT_ITEM 24576) itemoff 11672 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208617472 count 1
	item 87 key (1937096454144 EXTENT_ITEM 8192) itemoff 11619 itemsize=20
53
		refs 1 gen 72412 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
152326144 count 1
	item 88 key (1937096462336 EXTENT_ITEM 12288) itemoff 11566 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207446016 count 1
	item 89 key (1937096474624 EXTENT_ITEM 16384) itemoff 11513 itemsize=20
53
		refs 1 gen 74063 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209620992 count 1
	item 90 key (1937096499200 EXTENT_ITEM 4096) itemoff 11460 itemsize=20
53
		refs 1 gen 75244 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112607232 count 1
	item 91 key (1937096503296 EXTENT_ITEM 20480) itemoff 11407 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112472064 count 1
	item 92 key (1937096523776 EXTENT_ITEM 4096) itemoff 11354 itemsize=20
53
		refs 1 gen 75244 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
154136576 count 1
	item 93 key (1937096527872 EXTENT_ITEM 16384) itemoff 11301 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112488448 count 1
	item 94 key (1937096548352 EXTENT_ITEM 4096) itemoff 11248 itemsize=20
53
		refs 1 gen 74068 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112062464 count 1
	item 95 key (1937096552448 EXTENT_ITEM 4096) itemoff 11195 itemsize=20
53
		refs 1 gen 75244 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
215064576 count 1
	item 96 key (1937096556544 EXTENT_ITEM 4096) itemoff 11142 itemsize=20
53
		refs 1 gen 75251 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112447488 count 1
	item 97 key (1937096568832 EXTENT_ITEM 4096) itemoff 11089 itemsize=20
53
		refs 1 gen 75275 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112709632 count 1
	item 98 key (1937096572928 EXTENT_ITEM 4096) itemoff 11036 itemsize=20
53
		refs 1 gen 75275 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112979968 count 1
	item 99 key (1937096577024 EXTENT_ITEM 20480) itemoff 10983 itemsize=20
53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112427008 count 1
	item 100 key (1937096597504 EXTENT_ITEM 4096) itemoff 10930 itemsize=20
53
		refs 1 gen 75251 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112599040 count 1
	item 101 key (1937096601600 EXTENT_ITEM 20480) itemoff 10877=20
itemsize 53
		refs 1 gen 55931 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208011264 count 1
	item 102 key (1937096622080 EXTENT_ITEM 20480) itemoff 10824=20
itemsize 53
		refs 1 gen 55931 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209616896 count 1
	item 103 key (1937096642560 EXTENT_ITEM 20480) itemoff 10771=20
itemsize 53
		refs 1 gen 55931 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209956864 count 1
	item 104 key (1937096679424 EXTENT_ITEM 12288) itemoff 10718=20
itemsize 53
		refs 1 gen 74068 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112308224 count 1
	item 105 key (1937096691712 EXTENT_ITEM 24576) itemoff 10665=20
itemsize 53
		refs 1 gen 74067 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
112447488 count 1
	item 106 key (1937096716288 EXTENT_ITEM 28672) itemoff 10612=20
itemsize 53
		refs 2 gen 72306 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153755648 count 2
	item 107 key (1937096744960 EXTENT_ITEM 8192) itemoff 10559 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208723968 count 1
	item 108 key (1937096753152 EXTENT_ITEM 16384) itemoff 10506=20
itemsize 53
		refs 1 gen 40030 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210325504 count 1
	item 109 key (1937096769536 EXTENT_ITEM 8192) itemoff 10453 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208613376 count 1
	item 110 key (1937096777728 EXTENT_ITEM 16384) itemoff 10400=20
itemsize 53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208625664 count 1
	item 111 key (1937096794112 EXTENT_ITEM 24576) itemoff 10347=20
itemsize 53
		refs 1 gen 39897 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209080320 count 1
	item 112 key (1937096818688 EXTENT_ITEM 8192) itemoff 10294 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207417344 count 1
	item 113 key (1937096826880 EXTENT_ITEM 20480) itemoff 10241=20
itemsize 53
		refs 1 gen 39899 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208990208 count 1
	item 114 key (1937096847360 EXTENT_ITEM 4096) itemoff 10188 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208789504 count 1
	item 115 key (1937096851456 EXTENT_ITEM 8192) itemoff 10135 itemsize=20
53
		refs 1 gen 40020 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210382848 count 1
	item 116 key (1937096859648 EXTENT_ITEM 12288) itemoff 10082=20
itemsize 53
		refs 1 gen 39471 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207761408 count 1
	item 117 key (1937096871936 EXTENT_ITEM 12288) itemoff 10029=20
itemsize 53
		refs 1 gen 40015 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210296832 count 1
	item 118 key (1937096884224 EXTENT_ITEM 40960) itemoff 9976 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208674816 count 1
	item 119 key (1937096925184 EXTENT_ITEM 28672) itemoff 9923 itemsize=20
53
		refs 1 gen 39899 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209039360 count 1
	item 120 key (1937096953856 EXTENT_ITEM 4096) itemoff 9870 itemsize=20
53
		refs 1 gen 40812 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
213393408 count 1
	item 121 key (1937096957952 EXTENT_ITEM 4096) itemoff 9817 itemsize=20
53
		refs 1 gen 39474 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207761408 count 1
	item 122 key (1937096962048 EXTENT_ITEM 4096) itemoff 9764 itemsize=20
53
		refs 1 gen 54559 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
216350720 count 1
	item 123 key (1937096966144 EXTENT_ITEM 4096) itemoff 9711 itemsize=20
53
		refs 1 gen 72407 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
153227264 count 1
	item 124 key (1937096970240 EXTENT_ITEM 20480) itemoff 9658 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208674816 count 1
	item 125 key (1937096990720 EXTENT_ITEM 8192) itemoff 9605 itemsize=20
53
		refs 1 gen 40021 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210350080 count 1
	item 126 key (1937096998912 EXTENT_ITEM 4096) itemoff 9552 itemsize=20
53
		refs 1 gen 40088 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209866752 count 1
	item 127 key (1937097003008 EXTENT_ITEM 4096) itemoff 9499 itemsize=20
53
		refs 1 gen 41113 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
211963904 count 1
	item 128 key (1937097007104 EXTENT_ITEM 4096) itemoff 9446 itemsize=20
53
		refs 1 gen 40908 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
211116032 count 1
	item 129 key (1937097011200 EXTENT_ITEM 8192) itemoff 9393 itemsize=20
53
		refs 1 gen 72772 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
158105600 count 1
	item 130 key (1937097019392 EXTENT_ITEM 16384) itemoff 9340 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207421440 count 1
	item 131 key (1937097035776 EXTENT_ITEM 4096) itemoff 9287 itemsize=20
53
		refs 1 gen 40127 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208486400 count 1
	item 132 key (1937097039872 EXTENT_ITEM 28672) itemoff 9234 itemsize=20
53
		refs 1 gen 39897 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208941056 count 1
	item 133 key (1937097068544 EXTENT_ITEM 20480) itemoff 9181 itemsize=20
53
		refs 1 gen 39927 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209039360 count 1
	item 134 key (1937097093120 EXTENT_ITEM 4096) itemoff 9128 itemsize=20
53
		refs 1 gen 40127 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208900096 count 1
	item 135 key (1937097097216 EXTENT_ITEM 4096) itemoff 9075 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208367616 count 1
	item 136 key (1937097101312 EXTENT_ITEM 24576) itemoff 9022 itemsize=20
53
		refs 1 gen 39901 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209039360 count 1
	item 137 key (1937097125888 EXTENT_ITEM 16384) itemoff 8969 itemsize=20
53
		refs 1 gen 40082 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209321984 count 1
	item 138 key (1937097142272 EXTENT_ITEM 40960) itemoff 8916 itemsize=20
53
		refs 1 gen 39867 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208637952 count 1
	item 139 key (1937097183232 EXTENT_ITEM 20480) itemoff 8863 itemsize=20
53
		refs 1 gen 39966 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
209797120 count 1
	item 140 key (1937097203712 EXTENT_ITEM 20480) itemoff 8810 itemsize=20
53
		refs 1 gen 40127 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
208896000 count 1
	item 141 key (1937097224192 EXTENT_ITEM 16384) itemoff 8757 itemsize=20
53
		refs 1 gen 40024 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
210653184 count 1
	item 142 key (1937097240576 EXTENT_ITEM 4096) itemoff 8704 itemsize=20
53
		refs 1 gen 72442 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
151691264 count 1
	item 143 key (1937097244672 EXTENT_ITEM 8192) itemoff 8651 itemsize=20
53
		refs 1 gen 39528 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
207384576 count 1
	item 144 key (1937097252864 EXTENT_ITEM 12288) itemoff 8598 itemsize=20
53
		refs 1 gen 56865 flags DATA
		extent data backref root FS_TREE objectid 17045 offset=20
205619200 count 1


The full output of "btrfs check --readonly /dev/sda" command is as below:

[1/7] checking root items
[2/7] checking extents
incorrect local backref count on 1937096425472 root 5 owner 17045 offset=20
212492288 found 1 wanted 1048577 back 0x55f258caa470
backpointer mismatch on [1937096425472 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
found 1386975199232 bytes used, error(s) found
total csum bytes: 1352697008
total tree bytes: 1508327424
total fs tree bytes: 61161472
total extent tree bytes: 37421056
btree space waste bytes: 55303865
file data blocks allocated: 1388605296640
 referenced 1385670742016


I did "btrfs rescue zero-log /dev/sda" but that did not change the output o=
f=20
"btrfs check" performed afterwards.

regards,

J=C3=B6rg

Am Sonntag, 22. Dezember 2019, 01:59:16 CET schrieben Sie:
> On 2019/12/21 =E4=B8=8B=E5=8D=8810:55, jollemeyer@gmx.de wrote:
> > Dear Qu,
> >=20
> > the output is as follows:
> > #btrfs ins dump-tree - b 2089035464704 /dev/sda1
> > btrfs-progs v5.4
> > No mapping for 2089035464704 - 2089035481088
> > Couldn't map the block 2089035464704
> > Couldn't map the block 2089035464704
> > Bad tree Block 2089035464704, bytenr mismatch, want 2089035464704, have=
 0
> > ERROR: failed to read tree Block 2089035464704
>=20
> That's strange. The tree block isn't even mapped.
>=20
> But from the dmesg, it shows there is an extent item in log tree, which
> doesn't look sane.
>=20
> BTW, what's the stderr from `btrfs check` I guess you have only patesd
> the stdout thus no real error message.
>=20
> Anyway, you can solve it by `btrfs rescue zero-log`, but I doubt there
> are more problems than we expect.
>=20
> Thanks,
> Qu
>=20
> > Many thanks.
> >=20
> > J=C3=B6rg
> >=20
> > -----Original Message-----
> > From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> > To: jollemeyer@gmx.de, linux-btrfs@vger.kernel.org
> > Sent: Sa., 21 Dez. 2019 15:19
> > Subject: Re: read time block corruption on root partition, Not booting
> >=20
> > On 2019/12/21 =E4=B8=8B=E5=8D=8810:06, jollemeyer@gmx.de wrote:
> >> Dear all,
> >>=20
> >> on my BTRFS root partition (/dev/sda), a "read time block corruption" =
was
> >> detected. The system refuses to boot. Current kernel is 5.4.2-1-Manjar=
o.
> >>=20
> >> Systemd's journalctl generated the following output:
> >>=20
> >> Dez 21 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt
> >> leaf: block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 le=
n=3D4096
> >> invalid extent refs, have 1 expect >=3D inline 1048577 Dez 21 10:46:41
> >> Phoenix kernel: BTRFS error (device sda): block=3D2089035464704 read t=
ime
> >> tree block corruption detected Dez 21 10:46:41 Phoenix kernel: BTRFS
> >> critical (device sda): corrupt leaf: block=3D2089035464704 slot=3D85 e=
xtent
> >> bytenr=3D1937096425472 len=3D4096 invalid extent refs, have 1 expect >=
=3D
> >> inline 1048577 Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda=
):
> >> block=3D2089035464704 read time tree block corruption detected Dez 21
> >> 10:46:41 Phoenix kernel: BTRFS critical (device sda): corrupt leaf:
> >> block=3D2089035464704 slot=3D85 extent bytenr=3D1937096425472 len=3D40=
96 invalid
> >> extent refs, have 1 expect >=3D inline 1048577 Dez 21 10:46:41 Phoenix
> >> kernel: BTRFS error (device sda): block=3D2089035464704 read time tree
> >> block corruption detected Dez 21 10:46:41 Phoenix kernel: BTRFS critic=
al
> >> (device sda): corrupt leaf: block=3D2089035464704 slot=3D85 extent
> >> bytenr=3D1937096425472 len=3D4096 invalid extent refs, have 1 expect >=
=3D
> >> inline 1048577 Dez 21 10:46:41 Phoenix kernel: BTRFS error (device sda=
):
> >> block=3D2089035464704 read time tree block corruption detected Dez 21
> >> 10:46:41 Phoenix kernel: BTRFS: error (device sda) in
> >> btrfs_replay_log:2293: errno=3D-5 IO failure (Failed to recover log tr=
ee)>=20
> > "btrfs ins dump-tree -b 2089035464704 /dev/sda" output please.
> >=20
> > Thanks,
> > Qu
> >=20
> >> Dez 21 10:46:41 Phoenix kernel: ------------[ cut here ]------------
> >> Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 7 PID: 621 at
> >> fs/btrfs/block-group.c:132 btrfs_put_block_group+0x42/0x50 [btrfs] Dez
> >> 21 10:46:41 Phoenix kernel: Modules linked in: usblp snd_hda_codec_hdmi
> >> intel_rapl_msr snd_hda_codec_realtek intel_rapl_common
> >> snd_hda_codec_generic ext4 ledtrig_audio x86_pkg_temp_thermal
> >> intel_powerclamp coretemp crc16 kvm_intel mbcache i915 jbd2 kvm
> >> snd_hda_intel snd_intel_nhlt i2c_algo_bit irqbypass drm_kms_helper
> >> snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda_core mousedev
> >> ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel crypto_simd cryp=
td
> >> glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt snd_timer
> >> iTCO_vendor_support intel_uncore mei_me intel_rapl_perf input_leds
> >> agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich r8168(OE)
> >> sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid vboxpci(OE)
> >> vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables
> >> x_tables hid_generic usbhid hid btrfs libcrc32c crc32c_generic xor uas
> >> usb_storage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkbd libahci
> >> libps2 libata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_intel ehci_hcd
> >> i8042 serio Dez 21 10:46:41 Phoenix kernel: CPU: 7 PID: 621 Comm: mount
> >> Tainted: G           OE     5.4.2-1-MANJARO #1 Dez 21 10:46:41 Phoenix
> >> kernel: Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H=
77
> >> Pro4/MVP, BIOS P1.40 09/04/2012 Dez 21 10:46:41 Phoenix kernel: RIP:
> >> 0010:btrfs_put_block_group+0x42/0x50 [btrfs] Dez 21 10:46:41 Phoenix
> >> kernel: Code: 2d 48 83 7d 50 00 75 22 48 8b 85 e8 01 00 00 48 85 c0 75
> >> 1e 48 8b bd d8 00 00 00 e8 a8 08 66 d9 48 89 ef 5d e9 9f 08 66 d9 c3
> >> <0f> 0b eb da 0f 0b eb cf 0f 0b eb de 66 90 0f 1f 44 00 00 31 d2 e9 Dez
> >> 21 10:46:41 Phoenix kernel: RSP: 0018:ffffa95900f47ae8 EFLAGS: 00010206
> >> Dez 21 10:46:41 Phoenix kernel: RAX: 0000000000000001 RBX:
> >> ffff8a1eb7bfe0e0 RCX: 0000000000000000 Dez 21 10:46:41 Phoenix kernel:
> >> RDX: 0000000000000001 RSI: ffff8a1ecf5f0250 RDI: ffff8a1eb7bfe000 Dez =
21
> >> 10:46:41 Phoenix kernel: RBP: ffff8a1eb7bfe000 R08: 0000000000000000
> >> R09: 0000000000000001 Dez 21 10:46:41 Phoenix kernel: R10:
> >> 00000000003f6c00 R11: 0000000000000000 R12: ffff8a1ec81b0080 Dez 21
> >> 10:46:41 Phoenix kernel: R13: ffff8a1ec81b0090 R14: ffff8a1eb7bfe000
> >> R15: dead000000000100 Dez 21 10:46:41 Phoenix kernel: FS:=20
> >> 00007f77003d7500(0000) GS:ffff8a1ecf5c0000(0000) knlGS:0000000000000000
> >> Dez 21 10:46:41 Phoenix kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> >> 0000000080050033 Dez 21 10:46:41 Phoenix kernel: CR2: 0000559652364460
> >> CR3: 00000003fbaec005 CR4: 00000000001606e0 Dez 21 10:46:41 Phoenix
> >> kernel: Call Trace:
> >> Dez 21 10:46:41 Phoenix kernel:  btrfs_free_block_groups+0x11c/0x260
> >> [btrfs] Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0
> >> [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> >> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
> >> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
> >> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> >> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
> >> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
> >> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
> >> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
> >> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0=
xa9
> >> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> >> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89=
 01
> >> 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8
> >> a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7
> >> d8 64 89 01 48 Dez 21 10:46:41 Phoenix kernel: RSP:
> >> 002b:00007ffedb3135c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 Dez =
21
> >> 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204
> >> RCX: 00007f770055ae4e Dez 21 10:46:41 Phoenix kernel: RDX:
> >> 000055d9705f5650 RSI: 000055d9705f56f0 RDI: 000055d9705f73d0 Dez 21
> >> 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670
> >> R09: 0000000000000000 Dez 21 10:46:41 Phoenix kernel: R10:
> >> 0000000000000000 R11: 0000000000000246 R12: 0000000000000000 Dez 21
> >> 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650
> >> R15: 000055d9705f5440 Dez 21 10:46:41 Phoenix kernel: ---[ end trace
> >> 71465d442bb4c509 ]--- Dez 21 10:46:41 Phoenix kernel: ------------[ cut
> >> here ]------------ Dez 21 10:46:41 Phoenix kernel: WARNING: CPU: 0 PID:
> >> 621 at fs/btrfs/block-group.c:3166 btrfs_free_block_groups+0x1ea/0x260
> >> [btrfs] Dez 21 10:46:41 Phoenix kernel: Modules linked in: usblp
> >> snd_hda_codec_hdmi intel_rapl_msr snd_hda_codec_realtek
> >> intel_rapl_common snd_hda_codec_generic ext4 ledtrig_audio
> >> x86_pkg_temp_thermal intel_powerclamp coretemp crc16 kvm_intel mbcache
> >> i915 jbd2 kvm snd_hda_intel snd_intel_nhlt i2c_algo_bit irqbypass
> >> drm_kms_helper snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda_core
> >> mousedev ghash_clmulni_intel drm snd_hwdep snd_pcm aesni_intel
> >> crypto_simd cryptd glue_helper mei_hdcp intel_cstate iTCO_wdt intel_gtt
> >> snd_timer iTCO_vendor_support intel_uncore mei_me intel_rapl_perf
> >> input_leds agpgart i2c_i801 snd syscopyarea mei sysfillrect lpc_ich
> >> r8168(OE) sysimgblt soundcore fb_sys_fops evdev ie31200_edac mac_hid
> >> vboxpci(OE) vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) sg crypto_user
> >> ip_tables x_tables hid_generic usbhid hid btrfs libcrc32c crc32c_gener=
ic
> >> xor uas usb_storage raid6_pq sr_mod cdrom sd_mod ahci serio_raw atkbd
> >> libahci libps2 libata xhci_pci scsi_mod xhci_hcd ehci_pci crc32c_intel
> >> ehci_hcd i8042 serio Dez 21 10:46:41 Phoenix kernel: CPU: 0 PID: 621
> >> Comm: mount Tainted: G        W  OE     5.4.2-1-MANJARO #1 Dez 21
> >> 10:46:41 Phoenix kernel: Hardware name: To Be Filled By O.E.M. To Be
> >> Filled By O.E.M./H77 Pro4/MVP, BIOS P1.40 09/04/2012 Dez 21 10:46:41
> >> Phoenix kernel: RIP: 0010:btrfs_free_block_groups+0x1ea/0x260 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel: Code: 49 bd 22 01 00 00 00 00 ad de e8
> >> 51 13 d1 d9 e8 0c d3 4e d9 48 89 ef e8 64 9b ff ff 48 8b 85 00 10 00 00
> >> 49 39 c4 75 3c eb 5f <0f> 0b 31 c9 31 d2 4c 89 fe 48 89 ef e8 55 85 ff
> >> ff 48 8b 43 08 48 Dez 21 10:46:41 Phoenix kernel: RSP:
> >> 0018:ffffa95900f47af8 EFLAGS: 00010206 Dez 21 10:46:41 Phoenix kernel:
> >> RAX: ffff8a1eca367488 RBX: ffff8a1eca367488 RCX: 0000000000000000 Dez =
21
> >> 10:46:41 Phoenix kernel: RDX: 0000000000000001 RSI: ffff8a1eca364200
> >> RDI: 00000000ffffffff Dez 21 10:46:41 Phoenix kernel: RBP:
> >> ffff8a1ec81b0000 R08: 0000000000000000 R09: 0000000020000000 Dez 21
> >> 10:46:41 Phoenix kernel: R10: 0000000000000005 R11: ffffffffffd5ce37
> >> R12: ffff8a1ec81b1000 Dez 21 10:46:41 Phoenix kernel: R13:
> >> dead000000000122 R14: dead000000000100 R15: ffff8a1eca367400 Dez 21
> >> 10:46:41 Phoenix kernel: FS:  00007f77003d7500(0000)
> >> GS:ffff8a1ecf400000(0000) knlGS:0000000000000000 Dez 21 10:46:41 Phoen=
ix
> >> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Dez 21
> >> 10:46:41 Phoenix kernel: CR2: 0000559006e55d68 CR3: 00000003fbaec006
> >> CR4: 00000000001606f0 Dez 21 10:46:41 Phoenix kernel: Call Trace:
> >> Dez 21 10:46:41 Phoenix kernel:  open_ctree+0x187a/0x1bc0 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount_root+0x57b/0x670 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> >> Dez 21 10:46:41 Phoenix kernel:  fc_mount+0xe/0x30
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_kern_mount.part.0+0x71/0x90
> >> Dez 21 10:46:41 Phoenix kernel:  btrfs_mount+0x18e/0x930 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  ? filename_lookup+0x105/0x190
> >> Dez 21 10:46:41 Phoenix kernel:  ? legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  ? btrfs_remount+0x4d0/0x4d0 [btrfs]
> >> Dez 21 10:46:41 Phoenix kernel:  legacy_get_tree+0x27/0x40
> >> Dez 21 10:46:41 Phoenix kernel:  vfs_get_tree+0x25/0xb0
> >> Dez 21 10:46:41 Phoenix kernel:  do_mount+0x77a/0xa30
> >> Dez 21 10:46:41 Phoenix kernel:  ksys_mount+0x7e/0xc0
> >> Dez 21 10:46:41 Phoenix kernel:  __x64_sys_mount+0x21/0x30
> >> Dez 21 10:46:41 Phoenix kernel:  do_syscall_64+0x4e/0x140
> >> Dez 21 10:46:41 Phoenix kernel:  entry_SYSCALL_64_after_hwframe+0x44/0=
xa9
> >> Dez 21 10:46:41 Phoenix kernel: RIP: 0033:0x7f770055ae4e
> >> Dez 21 10:46:41 Phoenix kernel: Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89=
 01
> >> 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8
> >> a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7
> >> d8 64 89 01 48 Dez 21 10:46:41 Phoenix kernel: RSP:
> >> 002b:00007ffedb3135c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 Dez =
21
> >> 10:46:41 Phoenix kernel: RAX: ffffffffffffffda RBX: 00007f7700681204
> >> RCX: 00007f770055ae4e Dez 21 10:46:41 Phoenix kernel: RDX:
> >> 000055d9705f5650 RSI: 000055d9705f56f0 RDI: 000055d9705f73d0 Dez 21
> >> 10:46:41 Phoenix kernel: RBP: 000055d9705f5440 R08: 000055d9705f5670
> >> R09: 0000000000000000 Dez 21 10:46:41 Phoenix kernel: R10:
> >> 0000000000000000 R11: 0000000000000246 R12: 0000000000000000 Dez 21
> >> 10:46:41 Phoenix kernel: R13: 000055d9705f73d0 R14: 000055d9705f5650
> >> R15: 000055d9705f5440 Dez 21 10:46:41 Phoenix kernel: ---[ end trace
> >> 71465d442bb4c50a ]--- Dez 21 10:46:41 Phoenix kernel: BTRFS info (devi=
ce
> >> sda): space_info 1 has 733175808 free, is not full Dez 21 10:46:41
> >> Phoenix kernel: BTRFS info (device sda): space_info total=3D1386200694=
784,
> >> used=3D1385467318272, pinned=3D0, reserved=3D4096, may_use=3D0, readon=
ly=3D196608
> >> Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda):
> >> global_block_rsv: size 0 reserved 0 Dez 21 10:46:41 Phoenix kernel:
> >> BTRFS info (device sda): trans_block_rsv: size 0 reserved 0 Dez 21
> >> 10:46:41 Phoenix kernel: BTRFS info (device sda): chunk_block_rsv: size
> >> 0 reserved 0 Dez 21 10:46:41 Phoenix kernel: BTRFS info (device sda):
> >> delayed_block_rsv: size 0 reserved 0 Dez 21 10:46:41 Phoenix kernel:
> >> BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0 Dez 21
> >> 10:46:41 Phoenix kernel: BTRFS error (device sda): open_ctree failed --
> >> Subject: Unit process exited
> >> -- Defined-By: systemd
> >>=20
> >> Btrfs check --readonly /dev/sda also found errors:
> >>=20
> >> Opening filesystem to check...
> >> Checking filesystem on /dev/sda
> >> UUID: 014bdf0a-bcb3-4a7c-b58d-c1fc17281f7e
> >> found 1386975199232 bytes used, error(s) found
> >> total csum bytes: 1352697008
> >> total tree bytes: 1508327424
> >> total fs tree bytes: 61161472
> >> total extent tree bytes: 37421056
> >> btree space waste bytes: 55303865
> >> file data blocks allocated: 1388605296640
> >>=20
> >>  referenced 1385670742016
> >>=20
> >> Btrfs scrub does not recognize any errors.
> >>=20
> >> Kindly help me to recover this error.
> >>=20
> >> many thanks,
> >>=20
> >> J=C3=B6rg Meyer





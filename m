Return-Path: <linux-btrfs+bounces-540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59E8021AD
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 09:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C51F1C208E1
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9433D5;
	Sun,  3 Dec 2023 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="UDCvrknt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888B116
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 00:24:15 -0800 (PST)
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id EAD2E9F22B;
	Sun,  3 Dec 2023 09:24:12 +0100 (CET)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 3B38OBin2625316
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 3 Dec 2023 09:24:11 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 3B38OBin2625316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1701591851;
	bh=vePUPDeNPeoZp+WS/gVKqJjVldEu/rakQNaHL56iATE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UDCvrkntdIAG6HegyY43GN8oYMlGTPsBqmr4uh8MUcTdTYEyr5wKUD+80HTt/NCv2
	 L83GBj5jp6X+zYrKbkkpgYErZkUgjcy2a7nPb4NmnWmFtn01iCDIjPNdgBDK6ulPYe
	 rs2doueNUYH+08W0ZjsSUpWpv1bx+JUEYSpAeHEUWJ9m7HgyhPI1KGwF1pQa9QYj5G
	 Bc/0tzHDh+P7291f219J5RbFC2p6WzOpHrJceaGIkuGeSk93Khfp2hpLyR+cfBnKfv
	 WvtnUg5R6AvFwjQBz+91IXUx28XOIKLvZMbThx0lIXIeAIV2rPPGxFDmS+xv+gWaQv
	 OY2CdFUwTLOlcODAEvgJauVeHA2y2E1Kw0JXIfUGLthglUqc8Yq5Re4HhjakLyTUz4
	 ZXeLulnBZ3CCXPPntS044TfY5ALHpaVxcvUwhNq40HTgzX3r3Gu59basUIViF/0391
	 GrU2Fun7tAYevgv/qUyTuxWwyNpV92BFBht88P4I1mxBCguBznS6x9pWLII8vULh3i
	 Nic2Q8Vej8Pi8ZzXz9PDOT5vxts0zfgA70v0hqYorRBbrZysi48fWYQxD/JNvRUqzA
	 Zbesw9GnwrafnJ4jyLEyN5KS1hjc23f4D6mcFfjz6bGJ1FbZu9cAfc32oRWeAFvjtA
	 SR8SFK5Hd5J9X+Qk3PRMUa0Q=
Message-ID: <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
Date: Sun, 3 Dec 2023 09:24:10 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-GB
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
 <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.12.2023 22:56, Qu Wenruo wrote:
>>
>>>
>>> How can I find something about preallocation out?
>>
>> Above compsize is already showing there is some preallocated space.
>>
>> Thus I'm wondering if the preallocation is the cause.
>>
>> As should_nocow() would also check the PREALLOC inode flag, and tries
>> NOCOW path first (then falls to COW if needed)
>
> Yep, I just reproduced it, for any INODE with PREALLOC flag (aka, the
> file has some preallocated range), even we're writing into the range
> that needs COW anyway (e.g. new writes which would enlarge the file),
> the compression would not work anyway.
>
>  # mkfs.btrfs test.img
>  # mount test.img -o compress-force=zstd /mnt/btrfs
>  # fallocate -l 128k /mnt/btrfs/file1
>  # xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file1
>  # xfs_io -f -c "pwrite 128k 128k" /mnt/btrfs/file2
>  # sync
>
> Since file1 has 128K preallocated range, thus the inode has PREALLOC
> flag, and would lead to no compression:
>
>     item 6 key (257 INODE_ITEM 0) itemoff 15811 itemsize 160
>         generation 8 transid 8 size 262144 nbytes 262144
>         block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>         sequence 33 flags 0x10(PREALLOC) <<<<
>     item 7 key (257 INODE_REF 256) itemoff 15796 itemsize 15
>         index 2 namelen 5 name: file1
>     item 8 key (257 EXTENT_DATA 0) itemoff 15743 itemsize 53
>         generation 8 type 2 (prealloc)
>         prealloc data disk byte 13631488 nr 131072
>         prealloc data offset 0 nr 131072
>     item 9 key (257 EXTENT_DATA 131072) itemoff 15690 itemsize 53
>         generation 8 type 1 (regular)
>         extent data disk byte 13762560 nr 131072
>         extent data offset 0 nr 131072 ram 131072
>         extent compression 0 (none) <<<
>
> Meanwhile for the other file, which has no prealloc, would go regular
> compression path.
>
>     item 10 key (258 INODE_ITEM 0) itemoff 15530 itemsize 160
>         generation 8 transid 8 size 262144 nbytes 131072
>         block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>         sequence 32 flags 0x0(none)
>     item 11 key (258 INODE_REF 256) itemoff 15515 itemsize 15
>         index 3 namelen 5 name: file2
>     item 12 key (258 EXTENT_DATA 131072) itemoff 15462 itemsize 53
>         generation 8 type 1 (regular)
>         extent data disk byte 13893632 nr 4096
>         extent data offset 0 nr 131072 ram 131072
>         extent compression 3 (zstd)
>
> To me, this looks a bug, and the reason is exactly what I explained 
> before.
>
> The worst thing is, as long as the inode has PREALLOC flag, even if all
> preallocated extents are used, it would prevent compression from
> happening, forever for that inode.
>
> Let me try to fix the fallback to COW path to include compression.


Thank you for reproducting it. Think we nailed it down.

Is there a way to get the output of the file of the chunks/items?

Thnx.

Ciao,

Gerhard



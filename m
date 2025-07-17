Return-Path: <linux-btrfs+bounces-15540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF83B08E77
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFF23A5824
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jul 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4082ED85F;
	Thu, 17 Jul 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="S9G/dqC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9552DD608
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Jul 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759999; cv=none; b=Mkyt6HlP3MgUffTO+KG5bhgGbHLbTm5w5to2aR2Iw5ABr/AqhLEHuKLB1SpE4tNOk/VyB/JIL9L0JYrc1nAORRO3mLBarziwYbNh+QBCyL6x5kTFp062HysieZ7Hd8jQtXcgmnZZ8mg3SDsj5Xx8V1veLy2Gzq8fS6F/CSRJtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759999; c=relaxed/simple;
	bh=njdsir1oSB4CRgxBWYiIJn3Df+k9t+FxyGHsMykq0fY=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CyC/oBSK551ojE6kU2sjmkK7DJmVVxAGr9ImyvNBDGZFXOSzyqqwRAJWlmwvEDSMiQbhF6426eTj9nBVMiKKIUz3tR+zIzK1qiYIh08Tc6i+hZPpihRI0LvrrBorf4sRJ1YQMB7wAsV+d7eI8KwSqDH9xaR3kkQEcYLulvn4t5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=S9G/dqC0; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 6077729C4DC;
	Thu, 17 Jul 2025 14:39:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1752759558;
	bh=berWZ+VI9VcOFzdcuJ6FltfTiqGOT/vbimONh+nNfto=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=S9G/dqC0uKvyRfG4D49bV8Y28iSGPwrtk1PsMiOICcig0c+Cp7raZWKYyf5QsKFhi
	 VW9EB/ATWlLY89W/VnMosgzTDQzSbTZu2DyqmX65RKlF8NgGOI4ofCKV8lP9rD/Clv
	 VapzGg2lXRePN1BOCIodCEIq9UCtITtkOBgiPc7U=
Message-ID: <8dc2668f-9fa2-4a23-9735-36f7f2d520e8@harmstone.com>
Date: Thu, 17 Jul 2025 14:39:18 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [help me] corrupted filesystem, restoration methods exhausted.
To: PranshuTheGamer <12345qwertyman12345@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <CAPYq2E2V-sY9HcUOqCnz1hrHJmXSB0O2wHxFBeC62fjrMg+R4w@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAPYq2E2V-sY9HcUOqCnz1hrHJmXSB0O2wHxFBeC62fjrMg+R4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Have you done an extended SMART test on your disk? The most likely root cause is
that your disk is goosed.

On 16/07/2025 7.36 pm, PranshuTheGamer wrote:
> Hello.
> I was here 2 weeks ago, and this time I have another btrfs system
> corrupted for the same reason, sudden power loss. I clearly didn't
> learn from my mistakes. I shall attach a few commands and their
> outputs.
> 
>> sudo mount -o ro,compress=zstd,noatime,barrier,flushoncommit,rescue=all /dev/disk/by-label/WD-01\\x20Storage /run/media/shivangi/WD-01
> mount: /run/media/shivangi/WD-01: can't read superblock on /dev/sdc1.
>         dmesg(1) may have more information after failed mount system call.
> 
>> sudo dmesg
> [ 8832.794775] BTRFS: device label WD-01 Storage devid 1 transid 9193
> /dev/sdc1 (8:33) scanned by mount (18864)
> [ 8832.795869] BTRFS info (device sdc1 state S): first mount of
> filesystem 57e6e11e-33c5-4348-a737-2efe07548dbc
> [ 8832.795897] BTRFS info (device sdc1 state S): using crc32c
> (crc32c-x86) checksum algorithm
> [ 8832.795907] BTRFS info (device sdc1 state S): using free-space-tree
> [ 8832.804406] BTRFS error (device sdc1 state S): parent transid
> verify failed on logical 732954411008 mirror 1 wanted 9193 found 9191
> [ 8832.805077] BTRFS error (device sdc1 state S): parent transid
> verify failed on logical 732954411008 mirror 2 wanted 9193 found 9191
> [ 8832.805095] BTRFS warning (device sdc1 state S): couldn't read tree root
> [ 8832.805841] BTRFS error (device sdc1 state S): open_ctree failed: -5
> 
>> sudo btrfs restore -l /dev/disk/by-label/WD-01\\x20Storage
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> Ignoring transid failure
>   tree key (EXTENT_TREE ROOT_ITEM 0) 732954443776 level 2
>   tree key (DEV_TREE ROOT_ITEM 0) 30834688 level 1
>   tree key (FS_TREE ROOT_ITEM 0) 732809641984 level 2
>   tree key (CSUM_TREE ROOT_ITEM 0) 732954558464 level 2
>   tree key (UUID_TREE ROOT_ITEM 0) 732809723904 level 0
>   tree key (FREE_SPACE_TREE ROOT_ITEM 0) 732954542080 level 1
>   tree key (258 ROOT_ITEM 0) 1074905481216 level 1
>   tree key (259 ROOT_ITEM 0) 1074905546752 level 1
>   tree key (260 ROOT_ITEM 0) 1075680133120 level 2
>   tree key (261 ROOT_ITEM 0) 1074912346112 level 1
>   tree key (265 ROOT_ITEM 304) 1075044286464 level 1
>   tree key (266 ROOT_ITEM 305) 1075057786880 level 2
>   tree key (267 ROOT_ITEM 306) 1075066519552 level 1
>   tree key (270 ROOT_ITEM 338) 1075071647744 level 1
>   tree key (271 ROOT_ITEM 339) 1075072745472 level 2
>   tree key (272 ROOT_ITEM 340) 1075087720448 level 1
>   tree key (275 ROOT_ITEM 516) 1075088801792 level 1
>   tree key (276 ROOT_ITEM 517) 1075091931136 level 2
>   tree key (277 ROOT_ITEM 518) 1075105366016 level 1
>   tree key (279 ROOT_ITEM 0) 733124001792 level 2
>   tree key (281 ROOT_ITEM 819) 733086138368 level 2
>   tree key (282 ROOT_ITEM 829) 37928960 level 2
>   tree key (289 ROOT_ITEM 879) 733147119616 level 2
>   tree key (291 ROOT_ITEM 970) 733220503552 level 1
>   tree key (292 ROOT_ITEM 971) 733221715968 level 2
>   tree key (293 ROOT_ITEM 972) 733222060032 level 1
>   tree key (295 ROOT_ITEM 976) 732351725568 level 2
>   tree key (303 ROOT_ITEM 2159) 1075506905088 level 2
>   tree key (304 ROOT_ITEM 2429) 733309599744 level 2
>   tree key (306 ROOT_ITEM 2432) 733311385600 level 2
>   tree key (308 ROOT_ITEM 2434) 733312335872 level 1
>   tree key (309 ROOT_ITEM 5300) 732955852800 level 2
>   tree key (310 ROOT_ITEM 5547) 1074997673984 level 2
>   tree key (311 ROOT_ITEM 5548) 1075586596864 level 2
>   tree key (312 ROOT_ITEM 5634) 32423936 level 2
>   tree key (313 ROOT_ITEM 5657) 32456704 level 2
>   tree key (314 ROOT_ITEM 5658) 35717120 level 2
>   tree key (317 ROOT_ITEM 6878) 732579905536 level 2
>   tree key (318 ROOT_ITEM 8931) 732809347072 level 2
>   tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30523392 level 0
> 
> ^ These are a lot of snapshots btw
> 
> I ran `sudo btrfs inspect-internal dump-tree -b 1074905481216
> /dev/sdc1 > tree_258.txt` for each of these, then ran this script:
> for file in tree_*.txt; do
>    echo "\n========== $file =========="
>    echo "-- DIR_ITEM --"
>    grep -i 'DIR_ITEM' "$file" || echo "No DIR_ITEM found."
>    echo "-- INODE_ITEM --"
>    grep -i 'INODE_ITEM' "$file" || echo "No INODE_ITEM found."
> done | tee summary.txt,
> ^ which I have attached.
> 
> Then, in zsh i ran this script to list anything that can give me a
> name, because nothing is giving me any names to restore.
> 
> roots=(
>    258 259 260 261 265 266 267 270 271 272
>    275 276 277 279 281 282 289 291 292 293
>    295 303 304 306 308 309 310 311 312 313
>    314 317 318
> )
> 
> for root in $roots; do
>    echo "---- Trying root $root ----"
>    sudo btrfs restore --dry-run --verbose --root=$root
> /dev/disk/by-label/WD-01\ Storage /mnt/tmp 2>&1 | grep -E
> '^Restoring|^ignoring'
> done
> 
> The output was empty
> 
> Finally I ran:
> 
>> sudo btrfs restore --dry-run --verbose --i /dev/disk/by-label/WD-01\\x20Storage   /mnt/tmp | grep '^Restoring'
> 
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> parent transid verify failed on 732954411008 wanted 9193 found 9191
> Ignoring transid failure
> 
> So yeah I'm in deep stuff now. Please send help



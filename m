Return-Path: <linux-btrfs+bounces-15673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EBB12103
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844921CC4149
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A02EE5F1;
	Fri, 25 Jul 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="nSQjP3VB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83C5475E
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457853; cv=none; b=nv5l87XVpmXeP2OKj2G0L2jwGbV/vhPtjiz68hRMP6yOapKfN+4ISffg0potQDIw0TeeHD0yaAu5qzsGGvvux08tmBVb4I+NCTx83D/y07vIDxrhWu0qEekya/9GbVxKfq6Hf/L0YkmnmKNBiFTYxaGTrLZuGry+dyGMCBRfhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457853; c=relaxed/simple;
	bh=uKPepaKUL6EURbIiCP1vo3zvxEUTCB5v7p5uxSAObSM=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecfb2bNCS+4BJqPSRCGO/GgpbKfFaVpJIajgUO6GCljG37ilKTRkBE18fkSFcB3XpkCGkwDmEsztvH+wYOKVkp32EMoImInmGfSEs/HDooZnEGtT0pfnyUiN8aLQT1YZt8uyN6gg8rIiMCZ9mvspH4dexLiKGhuypzCgDJd9R9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=nSQjP3VB; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 2475D29F96D;
	Fri, 25 Jul 2025 16:37:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1753457837;
	bh=eZX9v6a7KRwCYdLjTlbDv2SA8WgN4SoDmm6VQI+awyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nSQjP3VBdVg6d6DFg9R3dujn4ZnH3ZjAtIWVr+n/LV9rba9USC/wvJcq8xTng4ky2
	 B2zJy/xJDXZvTtJykbnR/TqWB+qhBCTkOZlmasTSYXoWNn/cUHL+32QyIQscUlhptR
	 rqmtFZbETLp55REG5xvo/BGXcYG44Z9dBFnUEVS4=
Message-ID: <ca31ad8f-3bf7-4efa-80d9-93a8a115cba5@harmstone.com>
Date: Fri, 25 Jul 2025 16:37:16 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Russell Haley <yumpusamongus@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, Peter Jung <ptr1337@cachyos.org>,
 linux-btrfs@vger.kernel.org, dave@jikos.cz,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Burkov <boris@bur.io>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
 <23b4beab-e33e-4a3b-93d6-8ebeb2a881b9@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <23b4beab-e33e-4a3b-93d6-8ebeb2a881b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From that dump:

 >         item 0 key (TREE_LOG ROOT_ITEM 256) itemoff 15844 itemsize 439
 >                 generation 456818 root_dirid 0 bytenr 202645028864 byte_limit 0 bytes_used 0
...
 >         item 1 key (TREE_LOG ROOT_ITEM 258) itemoff 15405 itemsize 439
 >                 generation 456818 root_dirid 0 bytenr 202650877952 byte_limit 0 bytes_used 65536

"bytes_used 0" for the first one looks suspect to me. Maybe the problem is
that if you're doing fsync I/O to multiple subvolumes, the leaves are potentially
getting put in the wrong tree?

On 24/07/2025 3.24 am, Russell Haley wrote:
> On 7/7/25 6:00 AM, Qu Wenruo wrote:
>>
>>
>> 在 2025/7/7 20:16, Peter Jung 写道:
>>> Hi all,
>>>
>>> There has been increased reports of users reporting that they could
>>> not boot into their system anymore - sometimes after a needed force
>>> shutdown, but also according the users after a normal shutdown/reboot
>>> process.
>>>
>>> The filesystem can be accessible again, after running following
>>> command in the chroot:
>>>
>>> ```
>>> sudo btrfs rescue zero-log /dev/sdX
>>> ```
>>>
>>> There is no way to reproduce this constantly.
>>>
>>> Following commits did land in 6.15.3:
>>>
>>> btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
>>> btrfs: exit after state split error at set_extent_bit()
>>> btrfs: fix fsync of files with no hard links not persisting deletion
>>> btrfs: fix invalid data space release when truncating block in NOCOW mode
>>> btrfs: fix wrong start offset for delalloc space release during mmap
>>> write
>>> btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
>>> btrfs: scrub: update device stats when an error is detected
>>>
>>> Some reports:
>>> https://discussion.fedoraproject.org/t/fedora-kde-no-longer-booting-
>>> likely-filesystem-btrfs-corruption/157232/10
>>> https://www.reddit.com/r/cachyos/comments/1lmzmm4/
>>> failed_to_mount_on_real_rooted/
>>> https://www.reddit.com/r/cachyos/comments/1llin1n/
>>> error_failed_to_mount_uuid_on_real_root_cant_boot/
>>> https://www.reddit.com/r/cachyos/comments/1llrpcb/
>>> unable_to_boot_os_you_are_in_emergency_mode/
>>> https://www.reddit.com/r/cachyos/comments/1lr5nro/my_cachyos_is_down/
>>
>> Unfortunately none of those comment is helpful.
>>
>> They do not provide the dmesg of the mount failure, and that's the most
>> important info.
>>
>> If you got any new reports, please ask for the dmesg of inside the
>> emergency shell.
> 
> I think this is likely the same problem I ran into[1], and I collected
> dmesg and a dump of TREE_LOG in the bad state.
> 
> [1]
> https://lore.kernel.org/linux-btrfs/598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com/
> 
> Thanks,
> 
> Russell
> 
> 



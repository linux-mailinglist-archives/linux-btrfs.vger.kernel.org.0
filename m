Return-Path: <linux-btrfs+bounces-17977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7FBEBC7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 23:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8763BF6B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF332874E3;
	Fri, 17 Oct 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="fvOjO7FS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42724886E
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735060; cv=none; b=YopSX0rAQMpd47JPo5VZjcQLKyWF0kxHclxC/iYJtdhRlARokE0q2heaKMG37VcQgQ0FJiLnv12mHKAKcs5UmJ7M4wbmcdqcR9MCV9ywgF0jfwjxLSvTN+J07a7+/eoW3hPlYRv3ovG14ASriY97Fq0ttKF/cs5M7ZyLWIw9DB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735060; c=relaxed/simple;
	bh=YqrJNTkmfcX2G7leE44Z7WJxjGyZK0YKRfJ+reWXWoM=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvkv+KBLOl/FN3FC0d5nxjwwlBOElaDrs/XS42CP8nJGOxa6ICfErCYMStnAHYCpDiXN8fwXOgnpomiDeig0qpTeG1Qv3hpAW06mPAwds1DNsPNpsBzcO88qJrGUTO/2rcT1ol9oy95SbnWUIaqUB68wqOdpGg/mVMbo3/lFVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=fvOjO7FS; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [10.10.10.246] (hosp88.static.otenet.gr [94.70.250.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id BBB2E2CB71C;
	Fri, 17 Oct 2025 21:54:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760734491;
	bh=6VyK+gszEkezIQTL6RUK5/8lccPCpCNWG8U2SwNCa9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fvOjO7FSz9UwlwmJ+SOWoUv8PoEuJ/ThRNadHbvTYPgFUB3XwHRq9+aV4E3AoxJ79
	 +Lh4tzq2/dcK9V9WYqmwQTDcsjAzKhJwTc8SXNQiDh2K7J++eATwH/dnr5w9ALoro0
	 uFTBrgt0yMIlPz+kO4oC4czusEZzPG8iIQ/Ldrdw=
Message-ID: <19cb1c86-9076-4bf3-bf9a-716d34a70598@harmstone.com>
Date: Fri, 17 Oct 2025 23:54:53 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
 <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
Content-Language: en-GB
From: Mark Harmstone <mark@harmstone.com>
In-Reply-To: <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/10/25 22:10, Qu Wenruo wrote:
> 
> 
> 在 2025/10/15 22:41, Daniel Vacek 写道:
>> This series is a rebase of an older set of fscrypt related changes from
>> Sweet Tea Dorminy and Josef Bacik found here:
>> https://github.com/josefbacik/btrfs-progs/tree/fscrypt
> 
> I'm wondering if encryption (fscrypt) for btrfs is still being pushed.
> IIRC meta has given up the effort to push for this feature.
> 
> Thanks,
> Qu

It's come up again recently, it's something I'm intending to look at 
when I get the chance.

I'm hoping that remap-tree will make it a lot simpler: extents will have 
an address that won't change with relocation, meaning that this fits 
more nicely with fscrypt's design. IIRC Sweet Tea's design stores the 
nonce/IVs in the extent tree, which wouldn't need to be the case with 
remap-tree.

>>
>> The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
>> unprintable characters in names") and a bit of code style changes.
>>
>> The mentioned commit is no longer needed as a similar change was already
>> merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
>> characters in paths or xattrs").
>>
>> I just had to add one trivial fixup so that the fstests could parse the
>> output correctly.
>>
>> Daniel Vacek (1):
>>    btrfs-progs: string-utils: do not escape space while printing
>>
>> Josef Bacik (1):
>>    btrfs-progs: check: fix max inline extent size
>>
>> Sweet Tea Dorminy (6):
>>    btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
>>    btrfs-progs: start tracking extent encryption context info
>>    btrfs-progs: add inode encryption contexts
>>    btrfs-progs: interpret encrypted file extents.
>>    btrfs-progs: handle fscrypt context items
>>    btrfs-progs: check: update inline extent length checking
>>
>>   check/main.c                    | 36 ++++++++++--------
>>   common/string-utils.c           |  1 -
>>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>>   kernel-shared/ctree.h           |  3 +-
>>   kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
>>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
>>   kernel-shared/uapi/btrfs.h      |  1 +
>>   kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
>>   8 files changed, 186 insertions(+), 31 deletions(-)
>>
> 
> 



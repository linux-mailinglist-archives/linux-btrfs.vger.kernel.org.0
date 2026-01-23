Return-Path: <linux-btrfs+bounces-20955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJPhNi1Lc2lDugAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20955-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B17437D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 582D0301A108
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2A350290;
	Fri, 23 Jan 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="5lE4XZii"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310B350A3A
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163335; cv=none; b=Un4+5VHVXdjJyrB0zcStegQtAZiGjM8ld4nxUhU2mN2F7/amyPdBo5Z/qzPc19j8Tmr4L/++92plwyPfEldIQVSnpLLf1LcLlpPFILNnEkU+zhk0zOpT3o5h7ZZ0uUjVTVt3tk/FrA8HTs5WGBeJjz0AyRp4Xu/9WsGSA12qTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163335; c=relaxed/simple;
	bh=ZV6zTo4VX+FHcjiLWeAWbn8wKjDkJbVgQsf+uIa/06I=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6kNIMDGLU0V3N70dboMW/pAqudr8hgcWK+YeJ1oMKjz3LMN2+5ZmnCgoEp3+gnj0jYoIJPFWvlJw2aQX79XxqrlyOckkrC0Y1WaaDPzlNGPGqk2s/yJDSWAhCm3/DPLGi9NJK5XVPS0lOdDhTi2o563SXtRUfNrj2FgYFyNp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=5lE4XZii; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id C509B2F7EA7;
	Fri, 23 Jan 2026 10:15:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1769163317;
	bh=J5QnXM/p8i1i2Loj9uaymsEkBCGlF2fj5lpEaCWURF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=5lE4XZiirHxVaeAud/xyEpAcvvo/UmZnMl/VY/VBtFe4BCxEaTtgZ7MygG5jiVxuR
	 iR2bSF4dbmPpzPWDZHmEGYoMOKB06k0b5IeecICk6PrAA6XzZ3V7gNWo7H49KtHkTz
	 b6ZKoZxXdwN2B9nPd/lBjHM61MSAECodbV0OHc6w=
Message-ID: <1d4bf271-854d-4751-8512-24b908fe16cc@harmstone.com>
Date: Fri, 23 Jan 2026 10:15:17 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v8 00/17] Remap tree
To: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20260107141015.25819-1-mark@harmstone.com>
 <20260121221247.GR26902@twin.jikos.cz>
 <CAL3q7H6Da-MDdODqKvaCXAVN_AGEFUDyxua5ChKL-y5uFP0w8Q@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAL3q7H6Da-MDdODqKvaCXAVN_AGEFUDyxua5ChKL-y5uFP0w8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20955-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,suse.cz:email]
X-Rspamd-Queue-Id: DB3B17437D
X-Rspamd-Action: no action

On 23/01/2026 10.04 am, Filipe Manana wrote:
> On Wed, Jan 21, 2026 at 10:24 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Wed, Jan 07, 2026 at 02:09:00PM +0000, Mark Harmstone wrote:
>>> This is version 8 of the patch series for the new logical remapping tree
>>> feature - see the previous cover letters for more information including
>>> the rationale:
>>>
>>> * RFC: https://lore.kernel.org/all/20250515163641.3449017-1-maharmstone@fb.com/
>>> * Version 1: https://lore.kernel.org/all/20250605162345.2561026-1-maharmstone@fb.com/
>>> * Version 2: https://lore.kernel.org/all/20250813143509.31073-1-mark@harmstone.com/
>>> * Version 3: https://lore.kernel.org/all/20251009112814.13942-1-mark@harmstone.com/
>>> * Version 4: https://lore.kernel.org/all/20251024181227.32228-1-mark@harmstone.com/
>>> * Version 5: https://lore.kernel.org/all/20251110171511.20900-1-mark@harmstone.com/
>>> * Version 6: https://lore.kernel.org/all/20251114184745.9304-1-mark@harmstone.com/
>>> * Version 7: https://lore.kernel.org/all/20251124185335.16556-1-mark@harmstone.com/
>>>
>>> Changes since version 7:
>>> * renamed struct btrfs_remap to struct btrfs_remap_item
>>> * renamed BTRFS_BLOCK_GROUP_FLAGS_REMAP to BTRFS_BLOCK_GROUP_FLAGS_METADATA_REMAP
>>> * added unlikelies
>>> * renamed new commit_* fields in struct btrfs_block_group to last_*, and added
>>>    new patch renaming existing commit_used to last_used to match
>>> * merged do_copy() into copy_remapped_data()
>>> * initialized on-stack struct btrfs_remap_items
>>> * fixed comments
>>> * added other minor changes as suggested by David Sterba
>>>
>>> Mark Harmstone (17):
>>>    btrfs: add definitions and constants for remap-tree
>>>    btrfs: add METADATA_REMAP chunk type
>>>    btrfs: allow remapped chunks to have zero stripes
>>>    btrfs: remove remapped block groups from the free-space tree
>>>    btrfs: don't add metadata items for the remap tree to the extent tree
>>>    btrfs: rename struct btrfs_block_group field commit_used to last_used
>>>    btrfs: add extended version of struct block_group_item
>>>    btrfs: allow mounting filesystems with remap-tree incompat flag
>>>    btrfs: redirect I/O for remapped block groups
>>>    btrfs: handle deletions from remapped block group
>>>    btrfs: handle setting up relocation of block group with remap-tree
>>>    btrfs: move existing remaps before relocating block group
>>>    btrfs: replace identity remaps with actual remaps when doing
>>>      relocations
>>>    btrfs: add do_remap param to btrfs_discard_extent()
>>>    btrfs: allow balancing remap tree
>>>    btrfs: handle discarding fully-remapped block groups
>>>    btrfs: populate fully_remapped_bgs_list on mount
>>
>> Patches have been added to for-next. There were many coding style issues
>> which I've tried to fix. As this is a lot of new code it'll get updated
>> anyway, I realized that for this kind of initial batch the coding
>> style is quite important as we'd have to stick with until some random
>> change touches it. Please have a look for the differences. Thanks.

Thanks David.

> This is a huge amount of code and quite critical.
> Shouldn't we have test cases in fstests to exercise this feature?
> I didn't see any test cases submitted.

It is, but it's a no-op if the incompat flag set isn't set.

There will be fstests for this before I propose taking it out of 
EXPERIMENTAL.


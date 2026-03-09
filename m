Return-Path: <linux-btrfs+bounces-22291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBKaA4oMr2nHMwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-22291-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:08:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A423E413
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 19:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB95330B0E02
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2026 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD88332637;
	Mon,  9 Mar 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="0cpJv2ug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BB333424
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079242; cv=none; b=cVI/WBjgX0aLUQ3WdLoLwPHM4YJ2d2afpoP25/NTiCkoPOAqYxC9cmnkddP0EVmP69c9vhJ/m+rZANHFAx2UjoPcz3MZ2y97LCPUQFnO4mTVBxZmWUy/lqcObtFOpa1JtCH6/x2hKXM08+rCmOaHg9a2FPlEX2ojkrlhI71bTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079242; c=relaxed/simple;
	bh=uGiYQ6h/nhF6bZkkUhtP8e/i4EOwZmeQ0vvaLjNAvCE=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9dnVCP1PIUa5qk8fY7qpjIZCTsk5KQEhTmgtrLI/SCFTzFVcO+0QuV3PVAqYeVU0gSIyoQX9/a1pRBKAU01c9hEqMf86pR4M20gX1kYfarn76yPb41l5tFjchlPu5qwu2mAcpmcS8cbf4eivAnG2WH7hIBFQMtw+NIBYllG3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=0cpJv2ug; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 3EE1930CF2D;
	Mon,  9 Mar 2026 18:00:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1773079230;
	bh=eS67G69q/id9NK+d6/4APAYJggX0eaNwKU4Kx5FAxOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=0cpJv2ugHKTirbY4yz88OCA7UnCuATQ6WAVrvZ0kvtBgJjb8xLmGrgzxZg11bMBHM
	 AL3spEuUGSK3r2wvnaYmQmkg2GO8VH/79BL7L5lbxF7QdmJuhOxodGFC3FKWidIZVN
	 ap8V3GwA+Gn1XhYEfybwnuhkEA1kwL8hsmYLvu1Q=
Message-ID: <1bbe10ea-90f2-45f2-915e-5895bd0039cf@harmstone.com>
Date: Mon, 9 Mar 2026 18:00:30 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
To: Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, boris@bur.io, Chris Mason <clm@fb.com>
References: <20260225103535.18430-1-mark@harmstone.com>
 <20260225150835.GF26902@twin.jikos.cz>
 <CAL3q7H4dT5aXaw7UsNfWNLccme=HcvbsrgCMuXzNZQRxV1mxjQ@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAL3q7H4dT5aXaw7UsNfWNLccme=HcvbsrgCMuXzNZQRxV1mxjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE5A423E413
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22291-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Rspamd-Action: no action

On 25/02/2026 3.17 pm, Filipe Manana wrote:
> On Wed, Feb 25, 2026 at 3:10 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Wed, Feb 25, 2026 at 10:35:31AM +0000, Mark Harmstone wrote:
>>> Fix a potential segfault in balance_remap_chunks(): if we quit early
>>> because btrfs_inc_block_group_ro() fails, all the remaining items in the
>>> chunks list will still have their bg value set to NULL. It's thus not
>>> safe to dereference this pointer without checking first.
>>>
>>> Link: https://lore.kernel.org/linux-btrfs/20260125120717.1578828-1-clm@meta.com/
>>> Reported-by: Chris Mason <clm@fb.com>
>>> Fixes: 81e5a4551c32 ("btrfs: allow balancing remap tree")
>>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>>> ---
>>>   fs/btrfs/volumes.c | 18 ++++++++++--------
>>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index e15e138c515b..18911cdd2895 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -4288,17 +4288,19 @@ static int balance_remap_chunks(struct btrfs_fs_info *fs_info, struct btrfs_path
>>>
>>>                rci = list_first_entry(chunks, struct remap_chunk_info, list);
>>>
>>> -             spin_lock(&rci->bg->lock);
>>> -             is_unused = !btrfs_is_block_group_used(rci->bg);
>>> -             spin_unlock(&rci->bg->lock);
>>> +             if (rci->bg) {
>>> +                     spin_lock(&rci->bg->lock);
>>> +                     is_unused = !btrfs_is_block_group_used(rci->bg);
>>> +                     spin_unlock(&rci->bg->lock);
>>>
>>> -             if (is_unused)
>>> -                     btrfs_mark_bg_unused(rci->bg);
>>
>> Not related to the patch but isn't this pattern inherently racy?
>>
>> The "used" is read under lock but then btrfs_mark_bg_unused() is outside
>> of the lock so the status can change. This can be seen it more places,
>> but they seem to be related to the remap tree feature.
> 
> It's not a problem since when attempting to delete unused bgs we skip
> any if they are actually used.
> It's done not just for this type of race but also for the case where
> after added to the unused list, it becomes used before the cleaner
> kthread runs to delete unused bgs.

Yes, the unused list means less "these BGs are definitely unused", more 
"these BGs are worth considering as maybe unused".

Johannes, your suggestion that we add a bg variable is a good one - I'll 
send another patch doing that.


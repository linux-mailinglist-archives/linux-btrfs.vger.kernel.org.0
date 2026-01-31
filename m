Return-Path: <linux-btrfs+bounces-21266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOpoKwyRfmkEawIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21266-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 00:32:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F7C4564
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Feb 2026 00:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588E5301E20C
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FF2FF144;
	Sat, 31 Jan 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxKnKmwc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA55733E
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769902333; cv=none; b=RWeqeKNAyDzPiZVwSTD7nEg8uSIjYiCaNzjcy55a1Aq7IjDMdjoabDGJ0aen7usghzMj7AtpgQwVLzUP6ynvKzc+D7hUhQtLXU2HSXNY1UEwDuTcnnKLWX8c4NijliCPB1vGFQS/QfIVhoGA9qDSYcit5w+VpSzWQta70BrYkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769902333; c=relaxed/simple;
	bh=LSpQdEyj7+wqociODTfTui6CMQaeKW5xXBDeNGSAzqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkccDQrBQpNgaUxIQXcv9zkuGC5RHvIIIDnKncJUAEyl2GFFI5v6o7XSeKwVYCMBuJ0ZNlJ0RejqgxsOY+VfXGw1k6HOgwM604myvjENo9v5aVzVFHab37f1C7eIOZz0xl4uD573ruYp8rWILtwcKsJyZHuJJfUYqc8LRtnIbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxKnKmwc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so35059485e9.2
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 15:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769902330; x=1770507130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5KOcYgh3TwjZOo3y1JLTR+xDDzOK1+fIpD6nfp3PV7g=;
        b=cxKnKmwcYU7pNIVPIXQzVlj9LXNEtPuvqPlo4C5a/zhV39aUOvUePHshoB2+u8gUKg
         +e/2kg29ABnnf7cjuoc3qlmGBhbwr4s/iRz8erEsbeuQRmJpbHKSOXxr/ozN0CF2IRlB
         mc95CJIcfD2REROp/3c/7y9pGrdnzwkUHOhQ4/HeqJ7f2dajNkoRoBOgh7JtOF8FOHU7
         IQNuV8OU4XwzJ8rnwMacRjCgt+ytuyS3wQ/K+04VukNBoLJEduYItLbOajrtBFF/r9XJ
         D/JLgimiR0T9uUiTrrQpZbNWAsUlWasDjKPKJuVJFiQzyADLLo7YFr5y440nG80d0XNz
         nMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769902330; x=1770507130;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KOcYgh3TwjZOo3y1JLTR+xDDzOK1+fIpD6nfp3PV7g=;
        b=J3arPVZVxK01dupdosSCGrHOzkMSq0ee6gm2Nj9sk/eeyVtjXrKcIjmHnhR2WQpnRq
         37AAEeTTxdCGzSE+GvnfeufsKRDtIgQgJAWu7Ip+M+B6jrtxbEAs4A+PUpLkyh1uVh3M
         70UP2sUfcOBzi4ciefGMy/o25tVIih9Z1RLJ9DUEJ7d/wl1AI3PnL2MpgsTDJprJeE5T
         EUGplmayFwTm1n9gnSlEsrylMoXlNLn4fivqZwQoVJeBflHxalPqbSs0GMx7tc4m1NbC
         KmEA+2bN927UxPcSWdf7FHsIrwGFhVNjK5HcKfxaXw4k8xNhawvbGDZk7FfunZ0puPpz
         qacA==
X-Gm-Message-State: AOJu0YxqSJwwi0wNFNTXWPTsOkvkBmwIM5rv8pEar3767DTHTgzBYyNb
	lVLTAzsCw1rl6RATg5rYMhSvqmPwDxA1qZSzDcgOc70ls7RyqMYHF/hsDY2MxRB+Lhs=
X-Gm-Gg: AZuq6aJlTPXE6+KX7lg9YgUkPn8qz1+5BY3fSBI5VMyNu6+pqIDvKmbYESglRuwjaBv
	YQ1tN9KBC7b+aDGqR783zO2o2P3P/V8ZZilglItOpN4XyyzZR7lPwSjvJQyanOmaI2fwYjOqkYA
	kAEWfA8m7ubCQCPQ4QaRLQmEyhErVz/A0zNPKG4IA6bsRo+B3KSBiJjD67P/NJdT4xghLO2MMwA
	qpIlBl6a6RyFXHBmRy64cDWDYMXIYntb0Bx8s64Iop93/h4p3cJOSDV3bqqo+r5Swa2xyPhqoNf
	hy7IgqMCrgYp9LTMSBko9Gz6k2PujuLbDiJ13+PRCvzFqigtlDFA+WBFlk8tEnKWqLmkv4nFxJu
	S9/T0tbmwR5FKynuqbz1gbru07IbMuepb0wae33VqQeTHFQqDXzF40CsF8ekzZ4mhqBTjSmMtIA
	H5KwwRlc/sak9eF9wPhNFZnzMvuPSj4Ha67itmWlo=
X-Received: by 2002:a05:600c:4e89:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-482db213a37mr90293935e9.0.1769902330035;
        Sat, 31 Jan 2026 15:32:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1efa6sm11254064b3a.6.2026.01.31.15.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 15:32:09 -0800 (PST)
Message-ID: <0932845c-0ece-4d48-a0d5-4b8de7c301a6@suse.com>
Date: Sun, 1 Feb 2026 10:02:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] btrfs: prevent use-after-free
 prealloc_file_extent_cluster()
To: JP Kobryn <inwardvessel@gmail.com>, boris@bur.io, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260131185335.72204-1-inwardvessel@gmail.com>
 <4c37d4e1-e656-48e3-ac80-83c09fe92625@suse.com>
 <fe31cf8b-ac19-4bb4-9cce-d6f2b2996246@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <fe31cf8b-ac19-4bb4-9cce-d6f2b2996246@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21266-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bur.io,fb.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D2F7C4564
X-Rspamd-Action: no action



在 2026/2/1 09:53, JP Kobryn 写道:
> On 1/31/26 1:08 PM, Qu Wenruo wrote:
>>
>>
>> 在 2026/2/1 05:23, JP Kobryn 写道:
>>> Users of filemap_lock_folio() need to guard against the situation where
>>> release_folio() has been invoked during reclaim but the folio was
>>> ultimately not removed from the page cache. This patch covers one 
>>> location
>>> that was overlooked. Affected code has changed as of 6.17, so this 
>>> patch is
>>> only targeting stable trees prior.
>>>
>>> After acquiring the folio, use set_folio_extent_mapped() to ensure the
>>> folio private state is valid. This is especially important in the 
>>> subpage
>>> case, where the private field is an allocated struct containing 
>>> bitmap and
>>> lock data.
>>>
>>> Without this protection, the race below is possible:
>>>
>>> [mm] page cache reclaim path        [fs] relocation in subpage mode
>>> shrink_folio_list()
>>>    folio_trylock() /* lock acquired */
>>>    filemap_release_folio()
>>>      mapping->a_ops->release_folio()
>>>        btrfs_release_folio()
>>>          __btrfs_release_folio()
>>>            clear_folio_extent_mapped()
>>>              btrfs_detach_folio_state()
>>>                bfs = folio_detach_private(folio)
>>>                btrfs_free_folio_state(folio)
>>>                  kfree(bfs) /* point A */
>>>
>>>                                     prealloc_file_extent_cluster()
>>>                                       filemap_lock_folio()
>>>                                         folio_try_get() /* inc 
>>> refcount */
>>>                                         folio_lock() /* wait for lock */
>>>
>>>    if (...)
>>>      ...
>>>    else if (!mapping || !__remove_mapping(..))
>>>      /*
>>>       * __remove_mapping() returns zero when
>>>       * folio_ref_freeze(folio, refcount) fails /* point B */
>>>       */
>>>      goto keep_locked /* folio remains in cache */
>>>
>>> keep_locked:
>>>    folio_unlock(folio) /* lock released */
>>>
>>>                                     /* lock acquired */
>>>                                     btrfs_subpage_clear_updodate()
>>>                                       bfs = folio->priv /* use-after- 
>>> free */
>>
>> This patch itself and the root cause look good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
> 
> Much appreciated :)
> 
>>>
>>> This patch is intended as a minimal fix for backporting to affected
>>> kernels. As of 6.17, a commit [0] replaced the vulnerable
>>> filemap_lock_folio() + btrfs_subpage_clear_uptodate() sequence with
>>> filemap_invalidate_inode() avoiding the race entirely. That commit 
>>> was part
>>> of a series with a different goal of preparing for large folio 
>>> support so
>>> backporting may not be straight forward.
>>
>> However I'm not sure if stable tree even accepts non-upstreamed patches.
>>
>> Thus the stable maintainer may ask you the same question as I did 
>> before, why not backport the upstream commit 4e346baee95f?
> 
> That commit relies on filemap_invalidate_folio() which was introduced in
> 6.10 so it would not apply to earlier stable branches.
> 
> We need to fix as far back as 5.15 so I can send one additional patch to
> cover stable trees 5.15 to 6.6. The patch would be almost identical,
> with the only change being using the page API instead of the folio API
> (set_folio_extent_mapped() -> set_page_extent_mapped()). Let me know if
> you're in agreement and I can send the extra patch.

If stable chooses to go this path, I'm totally fine with similar backports.

Thanks,
Qu

> 
>>
>> If it's lacking the reason why it's a bug fix, I believe you can 
>> modify the commit message to include the analyze and the fixes tag.
>>
>>
>> I'm also curious to learn the proper way for such situation.
> 
> It's new to me as well. For reference, there are some commits on the
> list that have language like this: "This is a stable-only fix".



Return-Path: <linux-btrfs+bounces-21335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NdjNoRjgmkATgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21335-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:07:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CEDEBA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 22:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D55302FAB2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56663242AC;
	Tue,  3 Feb 2026 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fpZ420Pg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9D2D8792
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152818; cv=none; b=ZbKa4J6QhViDSaRjTe/le26VnT+KrJc/95Exyw+POif4TU2DIOlfs8B2KVG+WWoniOwACfxzJ06/dUhCg2gvHcYPNsR5FnS3vngp5zmmtMOkBsPYzL+VMucGoZglqTd1sii0avFmPhd0nl2JhqZ838hvRDuVPOtLc+uYMjRRXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152818; c=relaxed/simple;
	bh=/QLV/2TGvpj2CuVWGRMrdphn2x0zlCzuAyPiwwH8wGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDOH36f0KA9I18FuJPjribm8lhPFryO/7ILuzzZAm+NOkvsIhKpNTe4JpRMQ3YFWZQ1kHu1b+Ue+Xz8AgTVMNLN2dloUl00N8Na5SqHMFVypRHM5Fg7Y7BmAH8H6NuYILLfIyf+eYZo413rmGqXosPLniscvur8uQWrUNAZiurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fpZ420Pg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so44462605e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770152815; x=1770757615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J/OP+Stit8mZiL4SsfstG3wC1oTgEl0vU0ibIp4okRM=;
        b=fpZ420Pg8iHU64h01f15irtEyx7kILNLBaUK8vgQpt0qrF2E5oLMLUhRdIpvx5cWWw
         0MnJiZMNO6wGj52LB+TYM7iVpRBo6R5DNe+9TJg3uGn0lV2eL3h0wWUf3HOSRAuP3D1+
         rd+vNEHnJnUsPZ8m9+jzCxe3lmRr8/sZbd8AUTVFIjFKUhm5tpm1SozwEgcthw+XwbtU
         D8pRJNOhpDnmJU2GEKG3JCBZ6k/lY5aT2nhTaE1eQxYSd7taS/iEMxJ0FtJKrbXMN3mY
         Rrnb8RUrHkXtSavztcbzOVEyKQJp9DszjggzeA1240yloDJU/1G55BOHgpJRvV/3lAfH
         RFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770152815; x=1770757615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/OP+Stit8mZiL4SsfstG3wC1oTgEl0vU0ibIp4okRM=;
        b=Pmmg20TqIHGjgW92o0rNRfdciog+AUAgjOlnuht+hbV/9Y4rm/nAtWF3XARLb/vKox
         a1FpGoMFCXCVUoh6x81Ix81kOX9pbSforYNeNaBmwhEyDlIT4VMIxq6IEK/ODLijWVZh
         9bZtUoa0mlastlV2ljeUQ9e6SqJK3d2yEV4/9WtyhUwKU+xmF0nO0t9eqWF10w419grr
         zdFO5R3thfp3UVmYwFQFoQLxsddmv9qL5iM4mi9Al/46p2WhGU63ZjD5KOW1nOIulmFI
         iHmnJcqKri7TEqMcCVtaE4tvFjOjimKJUwmScirK3xJon/OXiD6DOvq7Ih8YF6/kbrPa
         RbeQ==
X-Gm-Message-State: AOJu0Yy84pqO/OsstSm3HF3ZkNGn1USaN0zE62HjkJIcH37P97teTaC0
	emj5JYDoQlomhfz6jET2XrIxBGDHVnAlcbDkuOHePSb8/fBHR0GhGzrYbPCh+og6Mxw=
X-Gm-Gg: AZuq6aKDr3s4hNEGdQcQ0SAFe/gXMxIYmlnj6yHw2v3el1CiKRnyNoWIHwIMI92leID
	a4VdVlSlCyDBBP+p9gYRRF6KTqY+gzuvI+Z1ibO2mw5TPEhoQAR6gjAJkGOniYyFmKbS17dfRDo
	V9mSkBYr5amVXtGxE6VplrIVte9d/Gwdd6wE5BoMu8xz+/2vbPMeZezPahvMsEeS3V1toY1CAkR
	6aInB39vVd1ZcFKIenkjysF9o5TtNzXxvhUEdfTTqyIHAmABIwJil/qoNGPu+YxPkMZnTWLTf3w
	KZwIyuBVOA6dB84Jct32vIfzbUtvDTSezNbHRdHISEvZZgiIj6wYQ23RZjiz4EgghUcXl1q+Y1/
	BdZeqSMkjk/MaEeksxMiOmI+3qzxe4KfY4peeUYpnwgevYiKISmasC6ujsaVwJtp5dL+0+BcnLb
	Tm6Ab33LNTpwsWrKDN5b44OpGk5Hhx1/HuHw0ohBw=
X-Received: by 2002:a05:600c:3106:b0:477:9976:9e1a with SMTP id 5b1f17b1804b1-4830e92caf4mr14516035e9.6.1770152815293;
        Tue, 03 Feb 2026 13:06:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354894c2c0dsm31658a91.12.2026.02.03.13.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 13:06:54 -0800 (PST)
Message-ID: <e2783fa0-b511-442a-baa3-145419af034a@suse.com>
Date: Wed, 4 Feb 2026 07:36:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: clean up two FIXMEs related to
 btrfs_search_slot output handling
To: Adarsh Das <adarshdas950@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260203172357.65383-1-adarshdas950@gmail.com>
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
In-Reply-To: <20260203172357.65383-1-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21335-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 3E1CEDEBA3
X-Rspamd-Action: no action



在 2026/2/4 03:53, Adarsh Das 写道:
> Both patches fix cases where a search with offset (u64)-1 gets an
> unexpected exact match. The first silently returned success, and the
> second crashed the kernel. Both now both log an error and return -EUCLEAN.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Adarsh Das (2):
>    btrfs: handle unexpected exact match in btrfs_set_inode_index_count()
>    btrfs: replace BUG() with error handling in __btrfs_balance()
> 
>   fs/btrfs/inode.c   | 15 ++++++++++++---
>   fs/btrfs/volumes.c | 10 ++++++++--
>   2 files changed, 20 insertions(+), 5 deletions(-)
> 



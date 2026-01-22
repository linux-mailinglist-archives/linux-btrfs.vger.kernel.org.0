Return-Path: <linux-btrfs+bounces-20918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AZNCeyLcmlJmAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20918-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 21:43:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5586D7E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 21:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64683303E307
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC33A7028;
	Thu, 22 Jan 2026 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JF/28zkk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED731986E
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114499; cv=none; b=dshCC1hSJTZb1nKnnocmM2TEiXkrvcScG0CmcQWFE3nC/6d1XpLh9gqG1a5y4TCDM+4SA06SUirNJp5BlAUKTimAmxafheoKkS6SwKpmL0B1bPrUOraJbHaLVtw1H+WVtLPcVeZQs5EeK+0prsq2VeoWg4mEoBLzC1UAgNePRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114499; c=relaxed/simple;
	bh=ToP2wZi8J8lq8iZAElDrWtKd7iwAuCoCTLq9h5VhZk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc0w34rfgYznGjPbflpMwD3uQ+qNO5OiJh0tY02L+mJ/qM+zDTAakOGuO/N4tUlctpSodtKKzffADaGFhOHQEFwtEQ+FfH0EiVnzgEFFd1UUl+loMCTp7SbMUVND2/HgBhueQUCCjT1hq0Ec1cdubi3l1nR4eBiaCQZahSfvcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JF/28zkk; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so11286265e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769114491; x=1769719291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=30RcJPudQvo2MeI32/f0AT1tgEbvd+bGjfYhCieZLYY=;
        b=JF/28zkkEZGT7TJcTakYK7mU2UsH0Nro4G06FwZ/Vvr0W4l8bqJEiI93WGSWkgQbs+
         CuBmS8aRNB9xxcPQCy7n7eZgba775Pfmi0WZl7KnCAfSoHaZyQd1mIlaQJJCWM2zmQ8Q
         71HoUS9MzTrUQm8ODpfxXR+PrEUEHKSs2syA9hgvQi6Yqv0ysIq0F20jY8frN82nFBc5
         QPXqP4wDS66HlV23yoX3Gi32G2AMyuDYXFYNt74cmA9JNWi5yCUKKtp5kcVtp5zg+mG0
         zHCeuoacOd+sSGym0WDaNRAQc2n+scWBpGH9jwJv5NwewSEBIqD2Ompo3+zPhU0Yngxo
         kePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769114491; x=1769719291;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30RcJPudQvo2MeI32/f0AT1tgEbvd+bGjfYhCieZLYY=;
        b=UpU9Yd820WaffCiLqqsR71cm5eEs3lHKHu8H+QaxzKp3oSaDs3a5fkW+P96xBO+F6k
         ZAm+CGYltCdz2a4FaXS6KV+7h0y0abX8YZDmpvwNMIdJKADniMcHUE3cqb3MnoMvQWC0
         Oq97Z/NwqiGvg/RwrMu3TKqM4mz4aCsCt29zPOS95ta+F2eEu5QyUMxTcAcmvefS3W/N
         ieKoKxc9mma45GFFUfbZVTRpiVCy2C++rea7tuGkAdndVnaO9plVsfeQeTHCq9elWLKG
         dfV5fT/40GUnCli4W1wcUhTzJ011Y9aK7PYNhjvGhSXa0JPIzrefEMmsy6V4cvBDRl5a
         FZzQ==
X-Gm-Message-State: AOJu0YxneM+3jgC0pM1pt6mH+BZPp2xNOeYi6bRCrjKzOcicYr6CEP+h
	7tMjTyS1r3gWzdad80m548s0425BkOaUjOR0By3oOY479DjsDS7arMVDLH24PHQjgUo=
X-Gm-Gg: AZuq6aLeDEWwh3hcSRQOz6d3K+F0UwYmUlqR8PQ4jE7Dpehr5eW4IB4DYIhPsEKrz36
	5TLgG0DhNJAwne/B+LMXCU3yQXAJyEiwH6/v6rH13UX8bYqlewOCut6cjLx2KFLbsqCjj3hLx3q
	7rfy341zpJWJWDMYhz68EcGRBlSuSHQ0J+Zwm1mk4o4JbczAYivWHrLJ7sDjcJUukEqF877G0eN
	q8bOpPiWEBubH0Q520ZAuENMGNiyYliY/NAYngL/5Rg1z+TU0Qj8v0gSTagC5YZPKOELyAB1Fc5
	U6nyHXjylnRQScDVLjIX1zrJowBdaMc45nc/0ymU+gjvonjP3WMsq0gxHq9FgudSZ2E5SRvfhmE
	zuzPJ2g1w33JBECiU3oPAqUCQrXKNwbJO7mE2qKr2blC1AYZAkQMb+lCMbJbE0HemW688AXF2+O
	/Fud0NNqaMm3s1KCTMwtoaxutEswaS0bA5lMhINHY=
X-Received: by 2002:a05:600c:8b65:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-4804c95c541mr15156945e9.9.1769114491406;
        Thu, 22 Jan 2026 12:41:31 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa65fsm1065975ad.12.2026.01.22.12.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:41:30 -0800 (PST)
Message-ID: <3de1ff71-2c74-4dd8-a69f-25c80a313425@suse.com>
Date: Fri, 23 Jan 2026 07:11:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove unused return value assignment in
 btrfs_finish_extent_commit()
To: Jingkai Tan <contact@jingk.ai>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20260122175325.7148-1-contact@jingk.ai>
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
In-Reply-To: <20260122175325.7148-1-contact@jingk.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20918-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8E5586D7E4
X-Rspamd-Action: no action



在 2026/1/23 04:23, Jingkai Tan 写道:
> Coverity (ID: 1226842) reported that the return value of
> btrfs_discard_extent() is assigned to ret but is immediately
> overwritten by unpin_extent_range() without being checked.
> 
> Signed-off-by: Jingkai Tan <contact@jingk.ai>
> ---
>   fs/btrfs/extent-tree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index e4cae34620d1..0d69c3067ed8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2838,8 +2838,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>   		struct extent_state *next_state;
>   
>   		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> -			ret = btrfs_discard_extent(fs_info, start,
> -						   end + 1 - start, NULL);
> +			btrfs_discard_extent(fs_info, start,
> +					     end + 1 - start, NULL);

If you really want to silent coverity, do a proper error handling other 
than blindly removing the return value.

Especially there is already a proper error handling of 
btrfs_discard_extent() later in the function.

>   
>   		next_state = btrfs_next_extent_state(unpin, cached_state);
>   		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);



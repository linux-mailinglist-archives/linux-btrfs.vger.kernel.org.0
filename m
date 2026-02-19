Return-Path: <linux-btrfs+bounces-21793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHhVOlKGl2n3zgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21793-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 22:53:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753C162F70
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F12303A278
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FBD30EF6C;
	Thu, 19 Feb 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Si/5p2a4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB93064A0
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537977; cv=none; b=teaR4i/Do5J9mHU4MtYRVGKG7bc+Ll/XB36FG5hWzW+WrgxtW0SpM73BHB4sHbK41I6Qy3eefG8zRDWSQGI0vXTqGMEqjDC5LdgBYFT6sKGP6M+YL75h1moloW3XTlaD/C96at8xtFKCFCwf+psoHKOU3x1mgRdPpAoZq+B50Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537977; c=relaxed/simple;
	bh=DT705ymLaHAH8HZ0zWPPBw17EcGcVHvT9qaEC5g4xpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d3Sb+hqyss0Gwp4I+YHvPeYon7oKqYrZlKbyYV44i3lT8pOPkn+Xk411Q2xZ5WdojAbQrEwPf3n59tbnJOb7pgcEd3gUqGdF+AeaeLy2+/pXO/GsmIJpaZQt36dDYoRyZxNCuHtzu7zqAHXTsR8BitkDV4+KZh9+idUW52tUKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Si/5p2a4; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48372efa020so11396785e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 13:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771537974; x=1772142774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sAGEtiBmmziC4Z2RBcT7CqFQsY4cImMQMdWUedATWBs=;
        b=Si/5p2a4hHuU7DNEKUkuoz3O6suCcl1sl57tdYnkIL1sm31/pQmyvubdhDHFD8sXmp
         MIauGeRiKFeTlxxM87jlw4Sa/O9SNGWw0xRxvmH6X1Z8BaESxELNgbgz9WnSREYFPZAH
         Kb+6bONMdyr2UsseSSAZixgKjK7HNeUGE6UbjSlO/OLDQLGmnL+FwXOfpMInoYEHNiH1
         WwO12jkrGnk5Ivn4EBmKygrpkCmL900w/uo/sKXfDcupaqRMPfz7BmkkRP3g6EJ4VHpi
         +jRzH5STsmocVFl8zdlV4lCS6fLrpd20q3Z+TE79lsn1fIx5730cOhgfJdmdU4kUhrKk
         SiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771537974; x=1772142774;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAGEtiBmmziC4Z2RBcT7CqFQsY4cImMQMdWUedATWBs=;
        b=d8AArW38uMhCdS7OR5LYFRVtDj0TLXotRZ+P5xkVbQVcnC8Lb5TkUqr0W+/9Ijfqjj
         RA6VX4SJbRxN9WOcIAcxeQSdnQF3a6A29fdhCkjuoVQBMVZa10543YXYzaOGthzc1NZg
         7bPXoNf+/YzoKAXkTO4LPjSt4qifAEfGcl/DiXsuAH26WSnnMxl6RZJmhBoJxqlSS02W
         KdDNDISGMq1ni7U0ejfnjM7PeaE5kKGl22lPHKx/4ry+DtTyeb3xO+pkz7aJzEFKvTpL
         y+rStKAq9szcxUpYq/rVkbhgvMyMt3XmLfgCZP0SFCz/NqP5TeKN+rldmL5e5GBOJ1ay
         RQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2dvMwnhq9s0kkdd2GuIDaCg6/lonNaOdV+wRL6AtuwCSVeh4jwkHM7e2i/cM5Bh7DNwYm1ZFFcLtrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8vT7HCatRo52k74vFisZpuye6XgUkoP6GUkNqCEUF4jQryIm
	8K4VGVwnjHcdPVQD7AWXfsRiSFldlM06s53TnQXrtA7jcQyXchA45NUBXuuxvfokLEc=
X-Gm-Gg: AZuq6aLgsj0AY6mzioOy2/GVNTFs8ck751SissyP1CODKxVp1lbiowsW5mL+RYOcjCN
	d2+BdgSUX0OWziBHOhXFgrSdtMb1P2rBlI+ezxLMLziMVF+vdnwf3BpROopKGRfL/QjwdNlcBPF
	i9/H0EuB5kyzaXJnNdm0W6CrCCQVInDULpH931VraSfpMAHPR08gRlT4L0M9SEPOYIIVsw7hQs4
	t+GBz2n9QL1Ux3z9Nk9AufVxNF557k34bXv1TQsEphkByHj9nyxT519Xjp6tT0+ANpUMviJlswh
	szcdmP7nO23AyLt9VfpU+iJ9Z7AXKwlTAZITRFKVlt8UqwuXkiCBgxjBcWpccg6G6RwPcimx3rZ
	BS+gR8oz/VrHI3vzMGhnmyTdfSa+B0itWH8pI0twFDXud+YV+wURangAZMBpkkAyp8H9BBin/oJ
	hcn5LFo5WlxlMPDFh7FJIJvU0njDeq7T0Lbp92k3sdiN6A/5soRhU=
X-Received: by 2002:a05:600c:1c07:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48379bac86bmr382017695e9.5.1771537974243;
        Thu, 19 Feb 2026 13:52:54 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa4a0sm175848905ad.14.2026.02.19.13.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:52:53 -0800 (PST)
Message-ID: <f8ce2fde-77e9-49ce-b9ca-ae4e43149049@suse.com>
Date: Fri, 20 Feb 2026 08:22:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: stop printing condition result in assertion
 failure messages
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
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
In-Reply-To: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21793-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4753C162F70
X-Rspamd-Action: no action



在 2026/2/20 02:15, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's useless to print the result of the condition, it's always 0 if the
> assertion is triggered, so it doesn't provide any useful information.
> Examples:
> 
>     assertion failed: cb->bbio.bio.bi_iter.bi_size == disk_num_bytes :: 0, in inode.c:9991
>     assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476
> 
> So stop printing that, it's always ":: 0" for any assertion triggered.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/messages.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 81f59afe4a99..17cdc14dc89d 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -141,11 +141,11 @@ do {										\
>   	verify_assert_printk_format("check the format string" args);		\
>   	if (!likely(cond)) {							\
>   		if (("" __FIRST_ARG(args) [0]) == 0) {				\
> -			pr_err("assertion failed: %s :: %ld, in %s:%d\n",	\
> -				#cond, (long)(cond), __FILE__, __LINE__);	\
> +			pr_err("assertion failed: %s, in %s:%d\n",		\
> +				#cond, __FILE__, __LINE__);			\
>   		} else {							\
> -			pr_err("assertion failed: %s :: %ld, in %s:%d (" __FIRST_ARG(args) ")\n", \
> -				#cond, (long)(cond), __FILE__, __LINE__ __REST_ARGS(args)); \
> +			pr_err("assertion failed: %s, in %s:%d (" __FIRST_ARG(args) ")\n", \
> +				#cond, __FILE__, __LINE__ __REST_ARGS(args));	\
>   		}								\
>   		BUG();								\
>   	}									\



Return-Path: <linux-btrfs+bounces-22057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGeoNddNoWkfsAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22057-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:55:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3301B4269
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE51A30398A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3644F366DDA;
	Fri, 27 Feb 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bhJV6ysm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD66355F3F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178896; cv=none; b=kjpmWv+8oisWbsVxjROIUd4CP4TgP8FEL1GBOKrFmVtuKznCwQJpBfYaa46Jfh9Z5hN5zVjwxI4PMdJeXn+pQtEXilcry/ksckZ6IYrkVGek9WISSFc4zLFhBknvklLEDkBg6NmKI6ucjQ6CbRlHCnW8SyZe380CtBHUuwQAes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178896; c=relaxed/simple;
	bh=4ZTr7FQxKDz4LmkWgj7zCVzzum0lSbRawBmzB0U8wjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcVmo9CN0uDhviHQ21T2XzvJz2+Sl8GFuYZTgijuWLNRMY78vKeibwQScR/iSeD9v7pF866Jiz9Gm703yroK33gvPU2VvzZOTmenePBG2hQvqpY1gTtEsoQV26hzlTTTCYBw2lh1wLbsa0/J/GWXx2r34FtXCgTsrqXyjex8HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bhJV6ysm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48336a6e932so10373305e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 23:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772178893; x=1772783693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w/xMRxnL2BX2Rnk4naDgtwltFfBDf8nsYh6ytOouWC4=;
        b=bhJV6ysmwrKV3NJBc6IlJj2jklggrKpjqfRFNpNrR/1dq1PG7zfrQqwfNjoMeeX+eq
         rJXIxAcV6OmkFz8rx791ycU5oCpzdINJYZUzHU1yIjRX2PIZK1xfaQqNzGXsjyCKxN4k
         vkSDin+ypiRFvYfVJgMDKPzqyt2akymMOYK6W5+1Nr5LSTszl2IibMgbLGVMwUE2blta
         Q+ezlgj9KqGUpgdZUm+pohqhWj/WicvyTGVmC2YdKFIG8/m5Z6QzflSahqACuN3cSrrq
         OGeI7pBcdjEa67Gzg9uxPit/FpicI33f3tFsFEvvBMJh0AUXdVeUK91rP2nhlHF4V4uB
         bR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178893; x=1772783693;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/xMRxnL2BX2Rnk4naDgtwltFfBDf8nsYh6ytOouWC4=;
        b=oLX/V98CmYQPZm41ZQzZ/zg0xIsvqTvugcRNctsGCLirv+l4gFXZNq9q+opqh10FGP
         mn9A2/S5lmTqDPK16OM1CfEvDu5A5T8eHf2FQGzF05s7ru8Y0eLsRK3YKztJrWVSyYnI
         N1kZ2N+u1c4JgRyCf0gbTFQjOZYaAD+VJZI/WuO+cj+WNfzOeefZnXmNlssrbW20X2G3
         rGqABO7bAjksSCcS4ZGpSoKEPhfMh65PRwTK2TO6GouT8JpDtB3Y7pOlxqGxlogSP4Ms
         taAM0u5fWt4aWxqjEp3DwK263IDAWn24BPUUr2rOPijUpWQzaC3H7jMypXia0TcVBJuT
         9w5A==
X-Forwarded-Encrypted: i=1; AJvYcCWOcy9R9hq22D1IcddK4BjPgftw9oNDZ2XYhBZ7LLT+bVMVRGtz2qbDnPi0NjN27397/eAePyjaqoDpGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78KPs5dkQ0dVmPPTZhEEjdRHpi1p0dm3BQdo4ndvWkVgNGAQF
	rfcwVL8xmHDXCaaA74pTQNrfchvTInl/vG1+DogDfNhZp4NxYC0GaN/wHuyLonTfsTQ=
X-Gm-Gg: ATEYQzwWwINlvfm+D2i24sYiEzW7DqIGcpLGlQPZEgC2FiKypr0YGh813Y2RuCIzqY6
	DeLkKsGDEatf+UDtY3UV6uhvEc8Z7prPJMputD044OhhMGBfghEaSoUV1O7XLwmHucYJXltINKc
	TPxZSeqpVWbnz9tTGC01L2m+xvrPG5hJa0kI3KxDboc/9DBwzfJEyGw1t1s8n+dsu4IRcVTpWFW
	F623r2K6aPpQgnORzsDHIp2CxzSnuZBRi7qhX3G6qIZYpA1iliDXQDh2mUigccnBptFDmPdNgDV
	8Ng49VpiGLngH8OhCXclRPPRGEl/db9RQuc+B5hl19Y2Qf10aL3o0DVw75pJj9A3MCeqcvh2mFS
	jPTK/rK35cNCHktK7ogNxGv33RRWjmrDycUBMgF5444LvTtQ4NklTrCHkGTjnsxg2DdjMrrIUcF
	imms9do/fARi/PnS6S+V4F10ba+Ex1Gm8QgpDqIeE4vVGhyaoLKHQ=
X-Received: by 2002:a05:600c:46cf:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-483c9bbbe67mr25127485e9.17.1772178893155;
        Thu, 26 Feb 2026 23:54:53 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fff3sm50935475ad.48.2026.02.26.23.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 23:54:52 -0800 (PST)
Message-ID: <d2e3fb3e-d085-489f-bbf4-00e293ba4e75@suse.com>
Date: Fri, 27 Feb 2026 18:24:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 v2] btrfs: free path if inline extents in
 range_is_hole_in_parent()
To: Hongbo Li <lihongbo22@huawei.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com
Cc: fdmanana@suse.com, linux-btrfs@vger.kernel.org, sashal@kernel.org
References: <20260227064414.2314529-1-lihongbo22@huawei.com>
 <20260227075219.2594937-1-lihongbo22@huawei.com>
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
In-Reply-To: <20260227075219.2594937-1-lihongbo22@huawei.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22057-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 3E3301B4269
X-Rspamd-Action: no action



在 2026/2/27 18:22, Hongbo Li 写道:
> Commit f2dc6ab3a14c ("btrfs: send: check for inline extents in
> range_is_hole_in_parent()") is a patch backported directly from
> mainline to 6.6, it does not free the path in the inline extents case.
> 
> The original patch in mainline does not have this problem because
> the former commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE
> conversions") in 6.18-rc1 introduced scope-based auto-cleanup which
> avoids this issue. Since some dependencies are missing and cannot
> be directly backported, we choose to use a goto statement to avoid
> the memory leak in inline extents case.
> 
> Fixes: f2dc6ab3a14c ("btrfs: send: check for inline extents in range_is_hole_in_parent()")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Changes since v1:
>    - Update commit message as Wenruo pointed out.
>    - Link to v1: https://lore.kernel.org/all/20260227064414.2314529-1-lihongbo22@huawei.com/
> ---
>   fs/btrfs/send.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 6768e2231d61..b107a33dfd4d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6545,8 +6545,10 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
>   		extent_end = btrfs_file_extent_end(path);
>   		if (extent_end <= start)
>   			goto next;
> -		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
> -			return 0;
> +		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
> +			ret = 0;
> +			goto out;
> +		}
>   		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
>   			search_start = extent_end;
>   			goto next;



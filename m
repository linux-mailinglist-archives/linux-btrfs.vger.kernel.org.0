Return-Path: <linux-btrfs+bounces-22051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDTFF4U+oWnsrQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22051-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:49:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21F1B37C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4D830F95CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 06:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7E364941;
	Fri, 27 Feb 2026 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZtBYQxXf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783EC32ED45
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174923; cv=none; b=aau6OgPEzuZfrq6Nk+c6ga0DbBx/SZ5+Rl8uDZ5stv0EdJ69+2IZowkGEjO8qxFrRUlTIPHl++EZOoGou7BtPGab7ZOpdyPn8knmBux0d6TzdLtX4bZTFu+i8SerHrhlpZecZl1zJsJZ/CLR8eW9KVjLmdo/S8/6uQBWJ8MXhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174923; c=relaxed/simple;
	bh=L7z85Kal5WczVnmvOjZ2k+DQsRvYDEjFRPBOxL1rViw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKbTd2bi57mlmURORSL1QtDSozlR4s0U/O+JJoZmHDeyi+6QSJ0I53svJLpg8sZp9uXw4onkEC7H9RRALi57eC/UtABKBfMTqxNTkSVMVj4Jp5Hoxtfy5mMTkypHjWvFRGovsi7alu3Zalc4kBQJVdhFKlB8/RhQofrs40WuUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZtBYQxXf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48378136adcso9706745e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 22:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772174920; x=1772779720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FipIjf6cKCNw8f6kM26ZuE9Nbv7VWhPszk497nnzT1Q=;
        b=ZtBYQxXfzwfUhUWQPMtHDA2HreT62ZSLCDcCSqTV87Y8ubH2w9PHZbwYTN9dWMMODi
         7i4kmDFglR+qYJnMaNpwT7Dg5c++1yLd4xWHM1RtU5WaCnuaFTzGl7o6FxzU2P+ac9ZR
         P1K0c/7T9F2IxLI7CGUxpaRGZXH8ePps0IoEgffAbbciy+BVpdRTle4hxJ6IcfRZx2ke
         zFL+H+sdJgC0aD2xjDalOEZUFhQAmwzTto9RA3JX4qXgRozttCJ+wGw9vSSz+ORBOwr1
         KZJzjKdJORcodrsl8hAU9tVGWB3sXNqkBSS3NLEubEc91AOFZsUY7S6dGA6is90Q0Iny
         mD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772174920; x=1772779720;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FipIjf6cKCNw8f6kM26ZuE9Nbv7VWhPszk497nnzT1Q=;
        b=Yjs0AcEe9GJ8snuAKEGB35RPbdsDwh/Q470/HCR+TCarNN+Z5/THZvd95dVzgSrMtl
         70gYaGR9Nx23XpqT/fB+88gYY0AnLmxbSi+vs8DTvdoLJttEsiFAoBg+6fUzla2uUtGX
         JeY4OnSFSHMC1vJxEnRnE5/t/j6a2cQVlNcDUlUZ78dypuc5Lm/gm4N0ECDh3YRaW+95
         mCVE9AapejFc+zmI2emXrxLkEOzAWodKnxmE1QJPbNE/e2o0Fhx+nVFPoBjFJ/HGamUI
         r9dSern20AbuQXtEijQue10tq8NRMENfcdYU8FItLDsDadRismTW+BFydO36M0ly/G5F
         PC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvPAo2bMAK6rtAYGNGbbt8bwKYDdv4F/BVXBPm1/7T+iLS+Q6H657FQ6OVGAYA4dyKl3+IVPY8kv0xxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Da2hAYuvZzRwTGjSNS3BLCqhU9Vw68zAemrfQU/7pL6B6k7/
	/AvzS68nRQSIiLqtecvF5+gnHxiDWENO4qOPuh7wSy+8LS568nrIuvMOu3Wdy25jDIM=
X-Gm-Gg: ATEYQzyPZSf4s3OCiu0QWYb3t85r6Tq+kijJ/KIZKwDOkvEo00cwJzHwL7oyK02+wz3
	D3VQ76BM3dN5ncouaIJ6tTN4CS/j99/CW6DbIT835GuJo4hjqft1SyAPb4nL7XtfIGTyCfbPVn6
	cE8v0APMuhtyW5Xg1AA1PDJs9W3lRApMZAgsE9ejvw8t6ZiWljVVjN+rPmig6cDVs/4TXw0m2D1
	7A4m/1+5GUfNuWopwnmMmWBBT4pACVk7jkPYmcItm9/2s/gKo5AjGxjdBwMRMmfYQdldO9zAc6f
	pSPLQUsyLqK7cQwrvFCNR/Q36XFR1M8W2y0nwUZuBp3gWAoTdI6QERdrpJ90MnAjQXSf2LVYL2J
	qnxhuTFYJPmVfXuuv+7iiHMCdHvPIYIGt1LyLHihmUXcpQ7cl6NnMcqRnGNqlPloYBlIHNatkBC
	hwST5AXcC7svQRfCzwz6f1rS3uLNBWvUL6nadfANcH9ARcaeZBB4U=
X-Received: by 2002:a05:600c:4e89:b0:483:129e:b573 with SMTP id 5b1f17b1804b1-483c9bfb85bmr21625565e9.18.1772174919770;
        Thu, 26 Feb 2026 22:48:39 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2268sm47411985ad.6.2026.02.26.22.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 22:48:38 -0800 (PST)
Message-ID: <2a3587d3-f131-4e19-b7fd-3c14e8d097f6@suse.com>
Date: Fri, 27 Feb 2026 17:18:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] btrfs: free path if inline extents in
 range_is_hole_in_parent()
To: Hongbo Li <lihongbo22@huawei.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: sashal@kernel.org, fdmanana@suse.com, linux-btrfs@vger.kernel.org
References: <20260227064414.2314529-1-lihongbo22@huawei.com>
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
In-Reply-To: <20260227064414.2314529-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22051-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 0D21F1B37C9
X-Rspamd-Action: no action



在 2026/2/27 17:14, Hongbo Li 写道:
> Commit f2dc6ab3a14c ("btrfs: send: check for inline extents in
> range_is_hole_in_parent()") is a patch backported directly from
> mainline to 6.6, it does not free the path in the inline extents case.
> 
> Commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE
> conversions") in 6.18-rc1 fixes this by accident

It's not "by accident", it's the designed behavior, remember the fix is 
after that commit introducing scope-based auto-cleanup.

It's missing the dependency, which can not be directly backported, and 
considering the scope-based auto-cleanup makes is much harder to detect 
just by the patch context, it's indeed a problem.

> by converting to
> BTRFS_PATH_AUTO_FREE, but we cannot backport this to 6.6 due to many
> dependencies. Instead, we choose to use a goto statement to avoid the
> memory leak in inline extents case.
> 
> Fixes: f2dc6ab3a14c ("btrfs: send: check for inline extents in range_is_hole_in_parent()")

With the commit message fixed it looks good to me.

> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
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



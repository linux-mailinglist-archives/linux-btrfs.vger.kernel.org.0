Return-Path: <linux-btrfs+bounces-10267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B09ED717
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B457A283644
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E91FECDB;
	Wed, 11 Dec 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXe0j6OD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD92594BF
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948286; cv=none; b=fdLroZCaNLmEWOJVMX9b4ie2El7ipeNxzLko9yYrPiqUrJZ5LKnod06fsKU0aXuP1rKZ9o8jjO7eBIXw0+TxXLgaLROKJxwLEPsIAvZ9u/iT6l27i0hgtie8QQdPl6cZpURKlFktKYfoYN1By1kYAEOSb9FQcynr423PJMuKFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948286; c=relaxed/simple;
	bh=FrmHAwz9GUBw4I3t1AxY4LGoB8rp+idR3qe1eENatP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lnIik6c0w40s3jamJO/cNp18BtCvuLS9QV/LztQhvfemlMCNIIbXVA2WkpnKBKXWXhsAwsZfNiUu94UTbyxhAxIZSaQQ5lS8uRV5+1/Kxw8VjiEOk+nED2GcFBSSFC9zNO2AnIxVufrJOS82PDZ5XDAEBaIahyVGX/gg3z3JUzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXe0j6OD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d7f19f20so3436349f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 12:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733948283; x=1734553083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uIfqnWhs2jS6fYf8lHUYwoUitmbF8X/HX3YpHTFg30o=;
        b=dXe0j6ODs+jE93YCNJdi87h6OBeoCvuiGE8iiKXpY75e94gHCa3XAFzR/MFVMfVrJK
         RIqoGc6wb9l2BgAcqcWRk80rfVY8NZzxWr10dlOQiZWrmFR0Y3cTsNqa6wU6RRbWqddg
         6/2G7oZ9nMiWXpvqxf3uOeFFGG9eJZSHeWiKxfBN73V6V3ztgvQJOLuOjfmgfBVW/wTO
         wuVmjw6mVG2pD1Ler6QISIPPzsZhvu9U2Jnt28iWDOTAYvcssCmGbSDBFVwTcIyHrmFf
         mlmbW063rB6HqqPxcG9BQ6G1HJd+EA+pPgZP/tSMloWnG7AcZuTRFm3oEvAYGx0nDopa
         gRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948283; x=1734553083;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIfqnWhs2jS6fYf8lHUYwoUitmbF8X/HX3YpHTFg30o=;
        b=rDjECsi+z8HJneUBGwtoxHQbsHTRiEaYmibm2xCAouz6BYw3E9neuuyh6oqGQUTnEJ
         ovjjbssoZ/1ee/kuoMWogwrLQtklv38f35mC7HpI2wouX4X8gRwb523GBSrQnTIRTeIG
         qklG1Y+N7WhKMUGnTNkxVuJrz7zJdCPcj33L//rJmPOvTswCMOIBAgH76QsaYIcJ8Xtc
         IWPr1vHVyH7x0U+u7k4sEyAXOgmdUZL/yvj/ZM1aJKNOWR/YHLz+he8uc4pP+6hBsR9W
         guuuLhafh73O11cWDcfT1B/tjWbtZkzWgfExFFPIA9wxBOyPwpBbyQx/22PfZeR2JV+l
         D4UA==
X-Forwarded-Encrypted: i=1; AJvYcCXJgX+LlCdVua6m3AJlMhaX4PTD9oMXbQMlYaBqWrJmuPizAQV2PirP0jrrM8R27TMllguJeuAxRyxXeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGUOv3fdJ+aTOkuPSx9zfDi5qxPASk6F8Jcg6z5z3ug7FACtG
	Wz1nRgk+69Ur0byfun6gPpUc/0eIpWN4H80WFmbF0yt1Nl2bjJDDoiaHT8pmaLapBPcmVRSxPr+
	G
X-Gm-Gg: ASbGncvLcVLApx3kRcgTapNBOkd3dPP02pkspbV0udtdjmR2F9SMDPfFIE0XLtptnz5
	954rSR3HSfT8Y9OxFCZoQFjyWZYaybOunUYpDbINAIcN8FHQRJy8oy+ruRNyusqE9DrykCB4elq
	viZdnAQd6L1uoVrOdduGB6NS3vDaIHN2J1M4mbd9kFzwlAfn20VVe/7T/gyaI3uCv/LvOVY4ReV
	dxEQFsmuOF5Y5nVUwby+Up+9nUyxStmyIL6qQZHQMw9USAfxpZE4ZyQ6s3Jl2m1mS40lbxU+xG9
	Au0KWg==
X-Google-Smtp-Source: AGHT+IFRj3YbJP+Wbp6WSbI+cWZ+V4mKnU0h1+xNL8XqL6A8QoNlcLqY9iSHrx7RwpYHXqdfaWCo8A==
X-Received: by 2002:a5d:5887:0:b0:382:5010:c8de with SMTP id ffacd0b85a97d-3864cec5ba6mr2773316f8f.46.1733948282335;
        Wed, 11 Dec 2024 12:18:02 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffb6f5sm13812567a91.6.2024.12.11.12.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:18:01 -0800 (PST)
Message-ID: <9d90c662-993b-4a36-80f3-154f81fb06a7@suse.com>
Date: Thu, 12 Dec 2024 06:47:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix use-after-free when COWing tree bock and
 tracing is enabled
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
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
In-Reply-To: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/12 03:11, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a COWing a tree block, at btrfs_cow_block(), and we have the
> tracepoint trace_btrfs_cow_block() enabled and preemption is also enabled
> (CONFIG_PREEMPT=y), we can trigger a use-after-free in the COWed extent
> buffer while inside the tracepoint code. This is because in some paths
> that call btrfs_cow_block(), such as btrfs_search_slot(), we are holding
> the last reference on the extent buffer @buf so btrfs_force_cow_block()
> drops the last reference on the @buf extent buffer when it calls
> free_extent_buffer_stale(buf), which schedules the release of the extent
> buffer with RCU. This means that if we are on a kernel with preemption,
> the current task may be preempted before calling trace_btrfs_cow_block()
> and the extent buffer already released by the time trace_btrfs_cow_block()
> is called, resulting in a use-after-free.
> 
> Fix this by grabbing an extra reference on the extent buffer before
> calling btrfs_force_cow_block() at btrfs_cow_block(), and then dropping
> it after calling the tracepoint.
> 
> Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for pinning down the error.

Although considering there is really only one caller of 
trace_btrfs_cow_block(), can we just move this only caller into 
btrfs_force_cow_block() before freeing @buf?

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 693dc27ffb89..3a28e77b6d72 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -751,10 +751,21 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
>   	 * Also We don't care about the error, as it's handled internally.
>   	 */
>   	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
> +	/*
> +	 * When we are called from btrfs_search_slot() for example, we are
> +	 * not holding an extra reference on @buf so btrfs_force_cow_block()
> +	 * does a free_extent_buffer_stale() on the last reference and schedules
> +	 * the extent buffer release with RCU, so we can trigger a
> +	 * use-after-free in the trace_btrfs_cow_block() call below in case
> +	 * preemption is enabled (CONFIG_PREEMPT=y). So grab an extra reference
> +	 * to prevent that.
> +	 */
> +	atomic_inc(&buf->refs);
>   	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
>   				    cow_ret, search_start, 0, nest);
>   
>   	trace_btrfs_cow_block(root, buf, *cow_ret);
> +	free_extent_buffer_stale(buf);
>   
>   	return ret;
>   }



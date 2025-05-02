Return-Path: <linux-btrfs+bounces-13638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069DAA7C0E
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 May 2025 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E163C7B524B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 22:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED721214229;
	Fri,  2 May 2025 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S794X09o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9F215162
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223993; cv=none; b=OBlCRUVaARntnR2jnMQhCUTGBx8d+TGZO5K4wsLlqmTE2LRJtx2TDmvlbcfkvmITPiGZ3asgajsdm+O4EaIWANRfWT36Qt8ygz3xkMRf2dHXjmD6fKbwxIttHnwWJTy0pXR61EnOnP2ZAPuE1wtg840XeHeGfvPi/KiRrlLNEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223993; c=relaxed/simple;
	bh=fzRDDcDMIi6rAmSXG6BE63NSMwocwiVBkw8+6lykSxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nuB3bmbNMSmMGSsCdVotshA0uQZSouSqk5ay7rAr6os+TE60zoUbql44WuzXGQgrKic/lms1CIdFAZ2mELQ5pqNQvTzBD6bf9/cyCe9cgRrFXrOjb+4YJd2PS+CsMy/0tVZqChKdXyA39jXedOtlN0Wtsiosfc4/6j0BfdmS/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S794X09o; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1461119f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746223989; x=1746828789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hUbxaHaE2YbuQoYg0ZyYqslwRLD4j4gP3DOHddBwRlI=;
        b=S794X09onVE5AjZZQ7/Tl0zPK5H1X+oJlwxMeiX5YbDgJxhGed5blDnB1cmGDfcaBA
         9MYi2rzYiOOJnVTrh2LSM2MeVl31HMEySn3zdN4i1uJncJpuEh7f4UAnPf0Iu7Qp2j3O
         yFwEDlMr7WLIZt5aUV/sPwa63z8Yrv4W+FS3UXqSMiE9AYyMnpP68pFI6xhqbd2sAsyM
         mn9mmOPHK/HQfWUnDE6OipS1y3uYLvqA3xU3tnAYceZC2ZGc4/05LrV+2PCinRlt1XDg
         XNkesICzz4dPqYzsoek3dcKUjyxHiyVswOzmG7QWa4y/SATz/b/PPhsth4z4UJB5btG7
         RhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746223989; x=1746828789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUbxaHaE2YbuQoYg0ZyYqslwRLD4j4gP3DOHddBwRlI=;
        b=C19bPhCF+b4MOu7sO3XufZo4bu6vguz6RB368NO3KO+lGmXT/EwFosQMH0ACt6rZVH
         Z4JLaUmQORZ6qTo65pG4sNu9Cuiyv9ryldSUCEwoupK86AgbOYrG5QaxKW/89zB5SLCS
         O87i4fB2984gR6WgNmPn5w1KXf89wj17sWHsn8CK+/HzaEK8zjhc0NcF9wi/jnpeVJGl
         JzY0DXjNOV/kSqNCActuzscSx1LCjaxwYXp9Tj8GxPtfRXgeCVPVEu83y1YlBnG20YAm
         JK3z/8GJHWJ7CERukTU6qEpyJDAxXd6fIC4xpleaWln3Sec2BP/sNHSmp+YuEjrxnoiU
         MRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXLTFKXspgtps1/SgTwLYojMRN2kNWDD3SXXRsVih6oLhKybN7cnwTx3oyRwkGP4gkI1ir0K9HDTQj0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhZXbh9Ops2sIlxXyWRefyvAZ4YGezAlZTrFVgEvw9kbiQVcD
	iquhzyLxkYrsptWGpM6u7vPytIP3gMiLHdblCO1LhaIblfMpFY7isnNoqp5H0mGriirZ+JtI27j
	m
X-Gm-Gg: ASbGncvNdewINrspkDPJDqkV5cGPt2Hi3RF1I55ZiTjRtMtUOXjThifMqzfSYMikbrw
	5tWp3SOH94FPZWp1odFFCdZtOWQ/Tp/jZaQU96ATiWNmoafUEkAAGm0Wtoy2ApaN3Jw8m/j4l8H
	xxUk/oXCA4ljrDbs+7t6HmsoD9D+a6vxFWsm/sOdokAuvPZ1bidQTesO/nEESmwnikH8cIgtX23
	BBhcpYePh/MAFylD8p3RINZTks4mJHn4vGfLpP7VHDaXA7vEuGktEkBHJ5Y5QnzSvg1H8qfy9I5
	V6SdQAVwprIuO8//vUNbzvpDL5cib6xv78vBHUlM2Dq21fSAr/UEINGUTGK1c8britjxygGJEQE
	vC+Y=
X-Google-Smtp-Source: AGHT+IGK0g9RiMVZ8T1P0REJVdYR2kNmhfvdVPgS7PR+g7zQ/1WzZerakCwU8sb2xq8UO6nfzliNVg==
X-Received: by 2002:a05:6000:1786:b0:39c:1efc:b02 with SMTP id ffacd0b85a97d-3a099adcf74mr3631679f8f.28.1746223988956;
        Fri, 02 May 2025 15:13:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e97absm12956075ad.62.2025.05.02.15.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 15:13:08 -0700 (PDT)
Message-ID: <aab7c883-b946-407e-96cd-18cc61e8fd28@suse.com>
Date: Sat, 3 May 2025 07:43:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs: some list extraction and disposal cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1746181528.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/2 20:00, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Simplify some list element extractions and list disposals. More details in
> the changelogs.
> 

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Filipe Manana (8):
>    btrfs: simplify getting and extracting previous transaction during commit
>    btrfs: simplify getting and extracting previous transaction at clean_pinned_extents()
>    btrfs: simplify cow only root list extraction during transaction commit
>    btrfs: raid56: use list_last_entry() at cache_rbio()
>    btrfs: simplify extracting delayed node at btrfs_first_delayed_node()
>    btrfs: simplify extracting delayed node at btrfs_first_prepared_delayed_node()
>    btrfs: simplify csum list release at btrfs_put_ordered_extent()
>    btrfs: defrag: use list_last_entry() at defrag_collect_targets()
> 
>   fs/btrfs/block-group.c   |  5 ++---
>   fs/btrfs/defrag.c        |  8 ++++----
>   fs/btrfs/delayed-inode.c | 31 ++++++++++++-------------------
>   fs/btrfs/ordered-data.c  | 12 ++++--------
>   fs/btrfs/raid56.c        |  6 +++---
>   fs/btrfs/transaction.c   | 16 +++++++---------
>   6 files changed, 32 insertions(+), 46 deletions(-)
> 



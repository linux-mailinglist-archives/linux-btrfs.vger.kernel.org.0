Return-Path: <linux-btrfs+bounces-11025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F5A1788C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A411881C01
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AE1ABED7;
	Tue, 21 Jan 2025 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adVWZxPF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC81D554
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737444163; cv=none; b=beEoFM2NNrdIK+qio3tY60q7W8H7fuMs082qkTzvl4mwZVYF8L7ezYkqh8RAhDho8h15kiVx+0GGnJoKKDQyA/B3imj20YWKWZ+bHvW3ulgFZbGey225oJ75mADgX2U1+QNPiKNkPNH7Ilwq8a94nG1CTsfvluJ7ZKWa6rhwSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737444163; c=relaxed/simple;
	bh=bOi/ZuFJU3ugqIyO1Mtdi8KvVAbT5WL+ql7mH+sJltU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs1JxrUT4UFNT+4WsgO5DoCfWKk9rDlpeV6+dDQDc34mNjnvASNDPMkNZvI8Ppw3uDl8SpfFlnOMPpoLiaqlYYFNVlswvJBs9e0dIMXr527FMvaXy1q2Xhs2S+1hsxrJtA8BIBsuH3CnBSK4nq9/VU6IVDfSCv6Nf51xS0fJPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adVWZxPF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6adb4so10786165a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 23:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737444159; x=1738048959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uffX3f3xP/ICG7mu24cqy/152sz9jqcLmBh+iN4ANnM=;
        b=adVWZxPFd4DFGnTIgHYMJjWglmnAXVkVGb5ccvRNQgvMael55eulxVLi7ieDG50OvL
         sz13gGZoqe6gcgODhR26hMGxS3btfcRdqWFCdQpV6UQBVOQNvCv02MriqJLz4to2g1Xn
         f0T1NCHHZvtjj1JGjq3nItsgzgXAYYCpnetm6IdLumWmtbV0UrvHF/mcfsAUgELB40qS
         Sin5oFSllSL/BC61qcvxjH09/dPKhz5t+ljT00gABGbKY3w5IzBE7TDMy0xNLfyoE7MT
         rPtTQW49VdSg/jU28SiQmG45qOdrW89mNXzrkIR3f1SDUGjglwJUzzbXMORR7IUwlNPe
         B+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737444160; x=1738048960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uffX3f3xP/ICG7mu24cqy/152sz9jqcLmBh+iN4ANnM=;
        b=LnWIjfxjyMAAq8bDte0/AHJaU4QaVlMNyMCFisglm8U7gLmv7cFIU8HPBZTa2miR3J
         EcAT92L7bkcmRj13qWiU13caRx7sM47FSH/HcOiysI+YDSvFIXThCvkmWv0/IdyEp66H
         Jbq95MVB+Hw1yqyYE6vokp0VzSV9s8/Gx4leTt1EsR37Y/kv4kgJzpQfy5lQ5YgefpBz
         eADMDVVm6tCToZ26bDGoWilRbjfR+bZ1FMcUG6FrdeI029Pb+oGRxuo/dWfRfO0w+Rhn
         XV6/Uy+seN9xvGyyi8nyAod2I72r5u4umDqGSXzAfAzog/4XpQMHnfWOvl+Qvjh6KtHx
         nRtQ==
X-Gm-Message-State: AOJu0YyrRBD/OjM2UG24I3WbBpEG6REk/ckqnS0fYMwsmntLdj6ay/M+
	2jcwvViQs8hiLu1+IvBbbvR6S6CbfaM/vYbxPev05g9mXDwp1eZhVnv29V7bejwElE2JolJB6hn
	bVQU=
X-Gm-Gg: ASbGnctGdShjyLvuMX1Sk8h5MJxoJxaWoxN2ZvmZB/EJaFNkZ9apRQymmlQthKA9Yq6
	2Bd9NV9aL7Bn4puKBgATktoXOUcVfXkz9oOiYUPUXsXZ42btFs0o9dJJhndSK9I+SLPbyV0x+Pt
	1C1yaGMXs0TZ+RQgsIEgIOavaho3VrJLl9bHTedcobA01hhMr8tSeLu3nAECxX50xSd6le6DRXk
	vUNcKyqYfarlgHAeXrRfweNPUyJrHqynGkkZRuAbkPWDeoW8EI/Mbitaib18nST6AkbTdAHizLq
	LXYWA6zC5TLkgYqgvL4FHg==
X-Google-Smtp-Source: AGHT+IGyyFGlRY+u9/9NR3HsSThfMvfTcbx2ExdBOaz88jDfv/CFO0uynGVo1pz86T8F0GPX5CqWRg==
X-Received: by 2002:a05:6402:35c2:b0:5d0:c098:69 with SMTP id 4fb4d7f45d1cf-5db7d300552mr14850923a12.16.1737444157814;
        Mon, 20 Jan 2025 23:22:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab815f1bsm8544325b3a.65.2025.01.20.23.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 23:22:37 -0800 (PST)
Message-ID: <d335039b-2203-481c-a618-8c77768c91b9@suse.com>
Date: Tue, 21 Jan 2025 17:52:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: Convert io_ctl_prepare_pages() to work on
 folios
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-3-willy@infradead.org>
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
In-Reply-To: <20250121054054.4008049-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/21 16:10, Matthew Wilcox (Oracle) 写道:
> Retrieve folios instead of pages and work on them throughout.  Removes
> a few calls to compound_head() and a reference to page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/free-space-cache.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d42b6f882f57..93b3b7c23d9b 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -447,7 +447,7 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
>   
>   static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>   {
> -	struct page *page;
> +	struct folio *folio;
>   	struct inode *inode = io_ctl->inode;
>   	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
>   	int i;
> @@ -455,31 +455,32 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>   	for (i = 0; i < io_ctl->num_pages; i++) {
>   		int ret;
>   
> -		page = find_or_create_page(inode->i_mapping, i, mask);
> -		if (!page) {
> +		folio = __filemap_get_folio(inode->i_mapping, i,
> +				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> +		if (IS_ERR(folio)) {
>   			io_ctl_drop_pages(io_ctl);
>   			return -ENOMEM;
>   		}
>   
> -		ret = set_folio_extent_mapped(page_folio(page));
> +		ret = set_folio_extent_mapped(folio);
>   		if (ret < 0) {
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>   			io_ctl_drop_pages(io_ctl);
>   			return ret;
>   		}
>   
> -		io_ctl->pages[i] = page;
> -		if (uptodate && !PageUptodate(page)) {
> -			btrfs_read_folio(NULL, page_folio(page));
> -			lock_page(page);
> -			if (page->mapping != inode->i_mapping) {
> +		io_ctl->pages[i] = &folio->page;
> +		if (uptodate && !folio_test_uptodate(folio)) {
> +			btrfs_read_folio(NULL, folio);
> +			folio_lock(folio);
> +			if (folio->mapping != inode->i_mapping) {
>   				btrfs_err(BTRFS_I(inode)->root->fs_info,
>   					  "free space cache page truncated");
>   				io_ctl_drop_pages(io_ctl);
>   				return -EIO;
>   			}
> -			if (!PageUptodate(page)) {
> +			if (!folio_test_uptodate(folio)) {
>   				btrfs_err(BTRFS_I(inode)->root->fs_info,
>   					   "error reading free space cache");
>   				io_ctl_drop_pages(io_ctl);



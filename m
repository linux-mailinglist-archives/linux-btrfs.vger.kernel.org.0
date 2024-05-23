Return-Path: <linux-btrfs+bounces-5221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F50E8CCA29
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 02:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A01B21BE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65217EF;
	Thu, 23 May 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cFsWnotc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99664A19
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425367; cv=none; b=GZA8oWEgLmqx/qnS8El+nlhI+07sgfPrlAbo6zei6h/oxp+Lk1/Sj/jSWGJrlNlPz1g56NvQCpbinOOXdslefT59kCK0b3/pFHWoKmZE9m5MBPzuIFo3eHJuc3eZFsdGVWva8fEEHm/OfcEirazmgUaSsFXYpfDTtwHLbtzLucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425367; c=relaxed/simple;
	bh=BURBtzYHEgDdb+uYi8Docccj0D1+McwW+VQHs8pnDRw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pBAPnRcg1r6f0CUyMImNDwlJeC0uWSt9XmaGaiaHVS5AjLfzD4nwR2WzmsYkStzAJSg583nhqJeMU6/EvDkAqVVrvEiSJ930w1Di2ofvkGXO1JJD5AWvsPPZuNh0xZ78b0UnMznxJbHzstQEey9XYqEwtPZbQEFT+3MK+98tai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cFsWnotc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so61816241fa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716425362; x=1717030162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoxn1yBv5vtWJnooYVaJvK14MNpRokw5s1d+kEt0ktI=;
        b=cFsWnotc0A1U4NGW4HyixbQJp4pbIwjn6O/i+K9PwLM23SC9A5UA4QrXQeOCyjhoGR
         g/OwsuNGYsbHp1AMufleiabOwiYLS0yMPWbCgcWZ+c9F/DjIULl3ZbyWAfvzW7jQsWuA
         1JL5kikoMD5mNYBgAevLglsO1n5tqPNDqyHzUTqDSgsf3PAk73ia7viptwbR7wf4DRYU
         wkPMkJx8CEvIBrU4oR9XjwOz6/wM3NjCibh8X6tyKDP8S67QMskULAFo036RdTAXrSZs
         tLmAYcCzA0tbnt15WONTtj+J+r98UcH7WUo5forI8WLDvQzhsDy/DQNWp4tEIkdVGMVT
         WwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425362; x=1717030162;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoxn1yBv5vtWJnooYVaJvK14MNpRokw5s1d+kEt0ktI=;
        b=tjhE3ECUQvRuK++Jp0oE2+4NrOASnf2q5XxY8nDWM4H61dkdBz79exLOaPeQUS1a4C
         XyehhS2y3CBTiZgrZW24YWs/pW1MFaxpGAkwWfdvtBA+T12rObNGczBaNKVaCphJ7vYi
         Y+xeIVOmvk/fA2KE51u1TaNQ8eyTCZ2oc48m9hRnOKEZkiqqa8HIzK7w3Vh9d/HM6Yu7
         7oWxPW7hhDSNUtow3NmMJRNAbJBUf8hje8hcpM3Wl1KWVAPAJzNYv5h3q+TP7LQuUlpa
         kwJWIOLadANSeFJeiPbWha15F5YaflhaLDFZL/GqUyVkLmMX562GtrWyOcJBxK/5UNbu
         L1WA==
X-Gm-Message-State: AOJu0YzcNxvD+9bBcufsmjQekTqKwwg9mBvxJrFdYt1xNp7SSHxUlzhy
	8r6my0/KKQ5F9/JXD8W1SzaoMcPkJH8Zsekt3blNE2HXI5KgO1dgPJnv20++yNiBJWYJKrm2RzM
	/
X-Google-Smtp-Source: AGHT+IHhAN0LY8PiY8npUSStlO6uO3420Mqr6kBwYOSIMvuABlCOaN5t48ORDnHCIX7YTv+3LxxmpA==
X-Received: by 2002:a05:651c:106b:b0:2e7:1b8:7b77 with SMTP id 38308e7fff4ca-2e94947dbd3mr20252351fa.22.1716425362491;
        Wed, 22 May 2024 17:49:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449ffbsm23424607a12.2.2024.05.22.17.49.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 17:49:21 -0700 (PDT)
Message-ID: <f64d771c-b47b-4db1-9bba-1790fbf91aa3@suse.com>
Date: Thu, 23 May 2024 10:19:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: make extent_range_clear_dirty_for_io()
 subpage compatible
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1716421534.git.wqu@suse.com>
 <015a4a2c7afb8ed894f4fb734cb886f01b9feb0c.1716421534.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <015a4a2c7afb8ed894f4fb734cb886f01b9feb0c.1716421534.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/23 09:17, Qu Wenruo 写道:
> Although the function is never called for subpage ranges, there is no
> harm to make it subpage compatible for the future sector perfect subpage
> compression support.
> 
> And since we're here, also change it to use folio APIs as the subpage
> helper is already folio based.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This patch is causing hangs for fstests with compression involved.

Please drop the series for now.

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 99be256f4f0e..dda47a273813 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -892,15 +892,20 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
>   
>   static void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
>   {
> +	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> +	const u64 len = end + 1 - start;
>   	unsigned long index = start >> PAGE_SHIFT;
>   	unsigned long end_index = end >> PAGE_SHIFT;
> -	struct page *page;
>   
> +	/* We should not have such large range. */
> +	ASSERT(len < U32_MAX);
>   	while (index <= end_index) {
> -		page = find_get_page(inode->i_mapping, index);
> -		BUG_ON(!page); /* Pages should be in the extent_io_tree */
> -		clear_page_dirty_for_io(page);
> -		put_page(page);
> +		struct folio *folio;
> +
> +		folio = filemap_get_folio(inode->i_mapping, index);
> +		BUG_ON(IS_ERR(folio)); /* Pages should have been locked. */
> +		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
> +		folio_put(folio);
>   		index++;
>   	}
>   }


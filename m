Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0729F457
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2S5l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2S5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:57:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BEC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:57:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k21so4674906ioa.9
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=p2li1fx+iVpWGtbhFkX+A5L8cbRcfiBG4jBMYbMNV20=;
        b=wnCgsQ5PYGPlzKh23NDTti1W5PYU948Dw3rEF2U+MT/NvVEY6VoVgHYHlFBunidoJ6
         RHVCoEErUFOl6cwcLwwdBjvdWcffS+uVJhq1Q+V/1lyLm6MkoC9lpwhupTbHIzWSyM1b
         0BytMPH0Li+XWWqNSAz9Tq4OkcrOVdxZTNQL1eHgwraatSz0dteboCfDDyRjqDcp8pzL
         4UUMnNSMArDHck5U5G4kLP/v6OSIUsqM19Puq12AVe4bf1W5LRuz0IWLPtmAuu1sq8Cd
         1n3aFHgwpTcYtg9kOtbMom49Wshcrraq9x3j192qltgF3Z557s6jJnEkO+NMfEE+csV9
         xY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2li1fx+iVpWGtbhFkX+A5L8cbRcfiBG4jBMYbMNV20=;
        b=fmk6Rdsr35Pue58L29b3mG9x/tYIdoYLnf7cd0rwVvqXnYaNh1dEo1+q9gmf2RunQM
         9peGkAq+gyB+Y5jAAC+iWRG3olJ64TFHgblcTGV9Js4Uq63oBnjPjQM/3VYwsZiI1kGm
         nGis6RFhZbNoeyz1g0nS7xrTpQRkkOztRzGhgmBxhPZwgYGkPGkQcu27TjP4jrCi9qxE
         7CB+cHuglXSiTU72K7BJb70l/ZD3Zt0U67KeiWD8nuG078dj8b3ukcf3pkH7TgymGbVi
         2FWsMx27epE7iEe4fecexWx3ZWaAiiVDdyR5pDrjFYJuCcN+sK3edx7xbnEvBk7Yz5pp
         t56w==
X-Gm-Message-State: AOAM532Dg8nb+foPudXaIT9oQDuUzMKPQ8bbAfHAinbgAT1W4OpOZZ56
        k/gUPCWU0EW5iqC77eWNFJGMCUsXS2BblQ==
X-Google-Smtp-Source: ABdhPJxf2bDl8gdalV0o267jrHfATM85ElmfH/9S8i1H2rYjtQqI1aTeuIBVYEgmNjspUe+E97EqtA==
X-Received: by 2002:a02:b786:: with SMTP id f6mr4920831jam.75.1603997858211;
        Thu, 29 Oct 2020 11:57:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1376? ([2620:10d:c091:480::1:18c8])
        by smtp.gmail.com with ESMTPSA id e12sm2821641ilq.65.2020.10.29.11.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:57:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] btrfs: file-item: use nodesize to determine
 whether we need readhead for btrfs_lookup_bio_sums()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <946ec8c3-9480-e3c3-aad7-9b97e8aedf12@toxicpanda.com>
Date:   Thu, 29 Oct 2020 14:57:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029071218.49860-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 3:12 AM, Qu Wenruo wrote:
> In btrfs_lookup_bio_sums() if the bio is pretty large, we want to
> readahead the csum tree.
> 
> However the threshold is an immediate number, (PAGE_SIZE * 8), from the
> initial btrfs merge.
> 
> The value itself is pretty hard to guess the meaning, especially when
> the immediate number is from the age where 4K sectorsize is the default
> and only CRC32 is supported.
> 
> For the most common btrfs setup, CRC32 csum algorithme 4K sectorsize,
> it means just 32K read would kick readahead, while the csum itself is
> only 32 bytes in size.
> 
> Now let's be more reasonable by taking both csum size and node size into
> consideration.
> 
> If the csum size for the bio is larger than one node, then we kick the
> readahead.
> This means for current default btrfs, the threshold will be 16M.
> 
> This change should not change performance observably, thus this is mostly
> a readability enhancement.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/file-item.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 7d5ec71615b8..fbc60948b2c4 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -295,7 +295,11 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>   		csum = dst;
>   	}
>   
> -	if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
> +	/*
> +	 * If needed csum size is larger than a node, kick the readahead for
> +	 * csum tree would be a good idea.
> +	 */
> +	if (nblocks * csum_size > fs_info->nodesize)
>   		path->reada = READA_FORWARD;

Except if we have contiguous reads we could very well have all of our csums in a 
single item.  It makes more sense to do something like

if (nblocks * csum_size > MAX_CSUM_ITEMS() * csum_size)

so that we're only readahead'ing when we're likely to need to look up multiple 
items.  Thanks,

Josef

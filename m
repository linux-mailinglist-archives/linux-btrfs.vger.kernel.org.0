Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092DC3623A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbhDPPQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbhDPPOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:14:41 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:13:15 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y12so21003133qtx.11
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WMx/O0nKxxMWW3Kksh1u5mDdbOj9+ehFofX3a1OcU0Q=;
        b=Cv7dSuEM+7fvlYpTrbDMRivHhFqgHttGwYvPDB04uCpu/SpP4BT/tjxrc/ao8l3ul5
         qa+1uhZSrMJxhVAlzK6zmr8nltJzcMnUe7WjVOwmnvpi17UNZQbsGQXVT4sOJMqajRS7
         gTGDWqoMISN/vJzjd2THBXK3HH43eejMtqodNlSd+B11D2YloRaSPixHqdGn3IbS3D58
         TRvtExtrtKaRnel5BNWDzB3gqxv63ooQYPSPj9LyjzuR+a3S43rFFo58/dRljvOzBt+7
         ZtGZ8CFrt7BdVmFH/OjyTrTfJYjs7qNFh5Pl+q1/Hls47iZkiFC409nBTUY40Xyxolqw
         ClnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMx/O0nKxxMWW3Kksh1u5mDdbOj9+ehFofX3a1OcU0Q=;
        b=AigWs0iIfP1KsoCFerUmOkLcyRjEMWSqzQvFoUMWWI9fLZ/4duyBePC2jOg9PlQFhi
         wvrocF0lMYaa27694v86wmqYsic4BETz4/h3pntc54xnVe4kJmzxZZBdJgEUshJ1uWKU
         PtY/KYviXEpl5tbp/TIvju/ShZRokzsp654BzGJPVXNMocAhsIFCnDxalkuPkcaS81dk
         TcuopTFKt+JhE0naWUhr8aIIyshIx8y0wSsVDQMk7zBM1NrkRCwtSGzIAFfLxGMmM6gm
         vIUIRms1NeSovLpBIZScCG0Vf7zv3n3ZFcItCHu50ZvYE1cBGGs8Z9+TV8zVK9suE+N9
         3qXg==
X-Gm-Message-State: AOAM530ng6aaWgPGd9iEFNp6Ur420DokudPu/lEJn9jkYlSVjtswDuS+
        XthT9EBR3ROm+v7iR8ujDaEJvjS3b9Ajcw==
X-Google-Smtp-Source: ABdhPJzPvNMyJ1jyfjKxF0O97NNq8Qah5ijjkoX6mGxY93jJSSTKSThZXJ0rlC2+3KCQhtMbotfQug==
X-Received: by 2002:ac8:5c92:: with SMTP id r18mr8196423qta.66.1618585994274;
        Fri, 16 Apr 2021 08:13:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x22sm3919079qtq.93.2021.04.16.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:13:13 -0700 (PDT)
Subject: Re: [PATCH 17/42] btrfs: only require sector size alignment for
 end_bio_extent_writepage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-18-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <53cea2cc-3ff8-a005-650a-c5b188e96659@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:13:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-18-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Just like read page, for subpage support we only require sector size
> alignment.
> 
> So change the error message condition to only require sector alignment.
> 
> This should not affect existing code, as for regular sectorsize ==
> PAGE_SIZE case, we are still requiring page alignment.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 29 ++++++++++++-----------------
>   1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 53ac22e3560f..94f8b3ffe6a7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2779,25 +2779,20 @@ static void end_bio_extent_writepage(struct bio *bio)
>   		struct page *page = bvec->bv_page;
>   		struct inode *inode = page->mapping->host;
>   		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +		const u32 sectorsize = fs_info->sectorsize;
>   
> -		/* We always issue full-page reads, but if some block
> -		 * in a page fails to read, blk_update_request() will
> -		 * advance bv_offset and adjust bv_len to compensate.
> -		 * Print a warning for nonzero offsets, and an error
> -		 * if they don't add up to a full page.  */
> -		if (bvec->bv_offset || bvec->bv_len != PAGE_SIZE) {
> -			if (bvec->bv_offset + bvec->bv_len != PAGE_SIZE)
> -				btrfs_err(fs_info,
> -				   "partial page write in btrfs with offset %u and length %u",
> -					bvec->bv_offset, bvec->bv_len);
> -			else
> -				btrfs_info(fs_info,
> -				   "incomplete page write in btrfs with offset %u and length %u",
> -					bvec->bv_offset, bvec->bv_len);
> -		}
> +		/* Btrfs read write should always be sector aligned. */
> +		if (!IS_ALIGNED(bvec->bv_offset, sectorsize))
> +			btrfs_err(fs_info,
> +		"partial page write in btrfs with offset %u and length %u",
> +				  bvec->bv_offset, bvec->bv_len);
> +		else if (!IS_ALIGNED(bvec->bv_len, sectorsize))
> +			btrfs_info(fs_info,
> +		"incomplete page write with offset %u and length %u",
> +				   bvec->bv_offset, bvec->bv_len);
>   
> -		start = page_offset(page);
> -		end = start + bvec->bv_offset + bvec->bv_len - 1;
> +		start = page_offset(page) + bvec->bv_offset;
> +		end = start + bvec->bv_len - 1;

Does this bit work out for you now?  Because before start was just the page 
offset.  Clearly the way it was before is a bug (I think?), because it gets used 
in btrfs_writepage_endio_finish_ordered() with the start+len, so you really do 
want start = page_offset(page) + bv_offset.  But this is a behavior change that 
warrants a patch of its own as it's unrelated to the sectorsize change.  (Yes I 
realize I'm asking for more patches in an already huge series, yes I'm insane.) 
Thanks,

Josef

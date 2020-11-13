Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3328C2B2451
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKMTNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 14:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 14:13:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F5C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:13:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id v11so7427129qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FF75kOviqh4E24g3uBCZaBY92lyu1MBCGuWolMRxlas=;
        b=BRbi8nkn1q2KDU1OUKPx4VThsvgNOCz2htH90W3vXHawM7x2ieHOF4z13bhnFbR8XQ
         fvJiiGrcscRTqbMjH0rcSv1i4RDgOeeg+HxWaD839a/vy1QdKW5KqQOcz2powGH+YG99
         OMd0HTKpJR6e4hsRa0CgjZ4Sbb35u2zkInK92b0p+jQR3Oi8iUmtJq0kbVd69cJ++eMs
         S9z9EbnP4KqeglzeQYq5ooD6ldSZ7Y+TCudGS7abOjoDbyjJOBRfDOgyB/7e/lOWPqdp
         3dLc71bgLmy8864rXPFx2jjIsCZ7ZxvuQtAkpAtZCjtdLJcunHfo4a9F2aP/8CjQSDnV
         226Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FF75kOviqh4E24g3uBCZaBY92lyu1MBCGuWolMRxlas=;
        b=hR/aeECQ3btcMCew7l/Arg2mpB7zKAs1tvFX2MyZ/Eck3jQhXAWmglpRloeNHMmF+f
         i1N+0i1LqHndeF+BToofhaySzFCt6P5ECvpqs994UEQ67S4Tg388R+6YXlTX9rR5vd32
         fizSRmRWYpbXjtSNeJsvC4+K2fRwvqglDEHnQn4BYz5MLGx0oc8WShmv0a5yl0kI3mvZ
         /jPD6cfkSq9EDEVtZVFFfrB0zm9Ign2cq/fua80AOE9QjGnxB+nzJ02qByJEMIIo/u9P
         ESoGaDuo7ykk3dZ2iUwII86YHG1dcw1rOrNmK2Gi43O2tRCMfe3HMuzTcP3tTJ6vMv8P
         pRlQ==
X-Gm-Message-State: AOAM533MSPqxVF6odKndJgKNpamci5J4PFMZaEFvfH2B8cBYXCXnFt/i
        ucSIQ1NTfDtnxkPTfuW/tohuaqY9CQp+8Q==
X-Google-Smtp-Source: ABdhPJyZG5uFewB6Glwq6neWY6QPPxypdqiWWHyuioZSYsxQLMbGpHHXOPPsYX9oOe6cPc9RJC0JiA==
X-Received: by 2002:ac8:8c7:: with SMTP id y7mr3374829qth.278.1605294782876;
        Fri, 13 Nov 2020 11:13:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm6735198qty.30.2020.11.13.11.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:13:02 -0800 (PST)
Subject: Re: [PATCH v2 03/24] btrfs: extent_io: replace
 extent_start/extent_len with better structure for end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3027eb0b-3e97-fef4-8375-5f8ddaaf908b@toxicpanda.com>
Date:   Fri, 13 Nov 2020 14:13:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> In end_bio_extent_readpage() we had a strange dance around
> extent_start/extent_len.
> 
> Hides behind the strange dance is, it's just calling
> endio_readpage_release_extent() on each bvec range.
> 
> Here is an example to explain the original work flow:
>    Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)
> 
>    end_bio_extent_extent_readpage() entered
>    |- extent_start = 0;
>    |- extent_end = 0;
>    |- bio_for_each_segment_all() {
>    |  |- /* Got the 1st bvec */
>    |  |- start = SZ_1M;
>    |  |- end = SZ_1M + SZ_4K - 1;
>    |  |- update = 1;
>    |  |- if (extent_len == 0) {
>    |  |  |- extent_start = start; /* SZ_1M */
>    |  |  |- extent_len = end + 1 - start; /* SZ_1M */
>    |  |  }
>    |  |
>    |  |- /* Got the 2nd bvec */
>    |  |- start = SZ_1M + 4K;
>    |  |- end = SZ_1M + 4K - 1;
>    |  |- update = 1;
>    |  |- if (extent_start + extent_len == start) {
>    |  |  |- extent_len += end + 1 - start; /* SZ_8K */
>    |  |  }
>    |  } /* All bio vec iterated */
>    |
>    |- if (extent_len) {
>       |- endio_readpage_release_extent(tree, extent_start, extent_len,
> 				      update);
> 	/* extent_start == SZ_1M, extent_len == SZ_8K, uptodate = 1 */
> 
> As the above flow shows, the existing code in end_bio_extent_readpage()
> is just accumulate extent_start/extent_len, and when the contiguous range
> breaks, call endio_readpage_release_extent() for the range.
> 
> However current behavior has something not really considered:
> - The inode can change
>    For bio, their pages don't need to have contig page_offset.
>    This means, even pages from different inode can be packed into one
>    bio.
> 
> - Bvec cross page boundary
>    There is a feature called multi-page bvec, where bvec->bv_len can go
>    beyond bvec->bv_page boundary.
> 
> - Poor readability
> 
> This patch will address the problem by:
> - Introduce a proper structure, processed_extent, to record processed
>    extent range
> - Integrate inode/start/end/uptodate check into
>    endio_readpage_release_extent()
> - Add more comment on each step.
>    This should greatly improve the readability, now in
>    end_bio_extent_readpage() there are only two
>    endio_readpage_release_extent() calls.
> 
> - Add inode contig check
>    Now we also ensure the inode is the same before checking the range
>    contig.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I like this much better,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

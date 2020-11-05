Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A492A8779
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 20:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgKETkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 14:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 14:40:32 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31506C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 11:40:31 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m14so1955069qtc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 11:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hNIV18bMUgD527Cm6blvDQgcfup0MgPuR/cmLBuQJds=;
        b=ACKHNs0OyXrPPx9swcqKt6OiBv/eLs8fKPB8vlUc4eI4mtUYvCbQuKGcU2s+V3OFkw
         Wnw6EFUBgefcwuemwwSBPXIXMD/qtU9JbGqUYKhVH/l/pGPCq80Dav3XSoilD2Jvd/dJ
         lGUBSRbrtUxNKpIzChZaJr2nzP17ba7doPZaTQ9s3n2o0iTiRxe1kLZCuHdIBdIm2rmg
         HT6njXDB2txDYWLCJSWnA88bcUrY0bgE8aK9MAZ8PdDtn5Z1UAqHGBoFukysEbmURl4e
         38mYfzn4N1/my/WO5NGamlRPvYOqyylZp1oi9VBklAPXrL/cDvsxiQIHkyDNKK7Z5pDn
         BF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNIV18bMUgD527Cm6blvDQgcfup0MgPuR/cmLBuQJds=;
        b=UxGmulgAkU0T4dhdOZfMSowI2Ut13vQy0pPJE8ErGnNdNpNbGISIdifwTpg/oWpBcm
         VlJTil0v0mRS2kRDuEtinLtG2MVoUuJb9JLGG4fR3LodLmHOKyrv61kLG8WfYBMEsoBw
         mqpOoGhrAQ53iviEjEYM1CEzLBU4mDcngQYEwZyW2jck0n4j+W7rhwVb9V+R8ti/9i+J
         2ICZrAPgWi0MwG+XlK0BAVDFtREafwZZcCUF+3MSFXr7CgJdcPdzGp8RY8feijBdc0mq
         7/eTVcxfuvXqakGNcctLje99zKtABMRP/tNwfwhKZdKdZ5aITj6Te0HCBG8zbse8PMQ7
         GZKA==
X-Gm-Message-State: AOAM532P375dTTTt1oeCbQC+OCSbw8Gv5W9oyREMuTC/niwlM5nryCAT
        FATFai/2EGW7vcHmp5SXU6ka5Q==
X-Google-Smtp-Source: ABdhPJwOy6modLeJ1cLRoeRRp0Pe4iLuWoZ63Bs9elyMFZxqO7h40wl/2DYJxINNkA6D5A8lyESvHw==
X-Received: by 2002:aed:3b5d:: with SMTP id q29mr3397948qte.91.1604605230284;
        Thu, 05 Nov 2020 11:40:30 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x5sm1689854qkf.44.2020.11.05.11.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:40:28 -0800 (PST)
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <08947273-050d-8f44-5cf3-9c980f0906a6@toxicpanda.com>
Date:   Thu, 5 Nov 2020 14:40:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/20 8:30 AM, Qu Wenruo wrote:
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
> The contiguous range breaks at two locations:
> - The total else {} branch
>    This means we had a page in a bio where it's not contiguous.
>    Currently this branch will never be triggered. As all our bio is
>    submitted as contiguous pages.
> 
> - After the bio_for_each_segment_all() loop ends
>    This is the normal call sites where we iterated all bvecs of a bio,
>    and all pages should be contiguous, thus we can call
>    endio_readpage_release_extent() on the full range.
> 
> The original code has also considered cases like (!uptodate), so it will
> mark the uptodate range with EXTENT_UPTODATE.
> 
> So this patch will remove the extent_start/extent_len dancing, replace
> it with regular endio_readpage_release_extent() call on each bvec.
> 
> This brings one behavior change:
> - Temporary memory usage increase
>    Unlike the old call which only modify the extent tree once, now we
>    update the extent tree for each bvec.
> 
>    Although the end result is the same, since we may need more extent
>    state split/allocation, we need more temporary memory during that
>    bvec iteration.
> 
> But considering how streamline the new code is, the temporary memory
> usage increase should be acceptable.

It's not just temporary memory usage, it's a point of latency for every memory 
operation.  We have a lot of memory usage on our servers, every trip into the 
slab allocator is going to be a new chance to induce latency because we get 
caught by some cgroup limit and force reclaim.  The fact that these could be 
GFP_ATOMIC makes it even worse, because now we'll have this random knock-on 
affect for heavy read workloads.

Then to top it all off we could have several megs worth of IO per bio, which 
means we're doing this allocation 100's of times per bio!  This is a hard no for 
me.  Thanks,

Josef

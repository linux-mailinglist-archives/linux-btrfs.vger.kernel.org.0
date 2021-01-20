Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC0A2FD337
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbhATOwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbhATOpc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 09:45:32 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D22C061575
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:44:52 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so9323810qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uhrnNchGJ7+I0/Ezm1LC0EbZLyLG9QBoDD4VQF/J5wc=;
        b=VGAFGl79WYWqDCmXUcnLRWmwAeMJ8Hxh8ZvMAuZdXjl0EWeP20OINPLHp9PZE7f6xs
         rc3K624vLshpL1NoUYzm9j2k4KUuAicx54NZn6Rj+BP2fi+cWIvIkBPJzzoY0P2eR2QU
         2Ba41x0N5huAL4mlfwIsu8xS32t5uRSFRX+uJhuZJ0QBMJAfjjHDe+8J5C2f+h2ub64a
         1DDGlYmktfqDmMQv8t8hYyXF7DngRvXvUCy1vRgzRJh2BJhoKFqgUdEI4vh7aRk7gbEa
         X7Fa/AfaGeU06DnG+G+oD+cL5DU/hQHo4iED8lZIqWX3scumtkX1oHBpEBicg/7owtVN
         BH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhrnNchGJ7+I0/Ezm1LC0EbZLyLG9QBoDD4VQF/J5wc=;
        b=IYBYSEEY1cSQZl1715QuIVn2w8PzqiAp9k/Nt32VCXytTRKROAV1vvNdHVX5cZG/Ww
         94w1XY6DRYjHCPlrFTcPdCLfhXzB4ATLfuD7nLbDR8iJiLdml6sBiZGrBX+tEg+u/0sn
         Aa4XnV+V6YQUAe8lS33p+PTpngIlo9iCDFGVEZzFddqeptmQ+IcseRXfDAQXQPAzmZh4
         b2F/D2jc7ajzmKNZhMDfs4oOTrlD7oVLBEuvUJoEwbbUBwuqdoZXcm0MBpWrLva19dd4
         p0kjxB5+o5TDhhxPpUiyhsHV9KyAEF5WrqNb6ykr6afwOOI2jwpw1TdtaqCkpVBI0GLC
         7MlQ==
X-Gm-Message-State: AOAM531hy450ZQ376clZENhaOnyzoifKPF8lkHVZpch3lfAPqSB8M0G0
        biZeBKfItCyZI79zKG5m4imJ89A5/PGKdRfpJ80=
X-Google-Smtp-Source: ABdhPJxUGbppnBV2fxOyFe+aLS4NysVtY6/S3HkDjtrlslvbWTGIlvrnTv3QG7xJjtrCx0DkIqpS3g==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr8964354qtw.11.1611153891296;
        Wed, 20 Jan 2021 06:44:51 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 136sm1432745qkn.79.2021.01.20.06.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:44:50 -0800 (PST)
Subject: Re: [PATCH v4 06/18] btrfs: support subpage for extent buffer page
 release
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-7-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <deac0208-7c23-f51b-7ff0-c661feba9806@toxicpanda.com>
Date:   Wed, 20 Jan 2021 09:44:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> In btrfs_release_extent_buffer_pages(), we need to add extra handling
> for subpage.
> 
> To do so, introduce a new helper, detach_extent_buffer_page(), to do
> different handling for regular and subpage cases.
> 
> For subpage case, the new trick is about when to detach the page
> private.
> 
> For unammped (dummy or cloned) ebs, we can detach the page private
> immediately as the page can only be attached to one unmapped eb.
> 
> For mapped ebs, we have to ensure there are no eb in the page range
> before we delete it, as page->private is shared between all ebs in the
> same page.
> 
> But there is a subpage specific race, where we can race with extent
> buffer allocation, and clear the page private while new eb is still
> being utilized, like this:
> 
>    Extent buffer A is the new extent buffer which will be allocated,
>    while extent buffer B is the last existing extent buffer of the page.
> 
>    		T1 (eb A) 	 |		T2 (eb B)
>    -------------------------------+------------------------------
>    alloc_extent_buffer()		 | btrfs_release_extent_buffer_pages()
>    |- p = find_or_create_page()   | |
>    |- attach_extent_buffer_page() | |
>    |				 | |- detach_extent_buffer_page()
>    |				 |    |- if (!page_range_has_eb())
>    |				 |    |  No new eb in the page range yet
>    |				 |    |  As new eb A hasn't yet been
>    |				 |    |  inserted into radix tree.
>    |				 |    |- btrfs_detach_subpage()
>    |				 |       |- detach_page_private();
>    |- radix_tree_insert()	 |
> 
>    Then we have a metadata eb whose page has no private bit.
> 
> To avoid such race, we introduce a subpage metadata specific member,
> btrfs_subpage::under_alloc.
> 
> In alloc_extent_buffer() we set that bit with the critical section of
> private_lock.
> So that page_range_has_eb() will return true for
> detach_extent_buffer_page(), and not to detach page private.
> 
> New helpers are introduced to do the start/end work:
> - btrfs_page_start_meta_alloc()
> - btrfs_page_end_meta_alloc()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is overly complicated, why not just have subpage->refs or ->attached as 
eb's are attached to the subpage?  Then we only detach the subpage on the last 
eb that's referencing that page.  This is much more straightforward and avoids a 
whole other radix tree lookup on release.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AABF242006
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKS7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKS7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:59:39 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9686DC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:59:39 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so6509153qvb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNJqEqZwMf8iljT+lnl6RZetwqRklqZTHO5csg5hW6E=;
        b=UKyG06qwloK9Vkn2R9hwiKTqPIiCAseh/odZceAsjaV9CrcK1Aixi/WU3y+B9qMT2O
         hlQV0CydnIj3CRIP3LMNqOaGF9gDaKBEOixQ8rFKxDExOsLpJnOzICtd6gE2My+oau+c
         xlkj+8gyX6fAny+AXt5Xj9K08bRd1G29HZEY9H5T32zcfbYFe/lv91Y4yQ1S4SbKPUGu
         qqN1FHJEBeEDW6s27khEWuAtbYlEB3NagKAw4WM1uT9XqD8/FNvBW/JLhdTJ3tNPXqn/
         HaFaVFaVCCy0YMmMc/XjztFIfPZcHZk9ZVJt/pVwEPDvgcFlA8pcgdHCPKZYMUe2p5CZ
         0uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNJqEqZwMf8iljT+lnl6RZetwqRklqZTHO5csg5hW6E=;
        b=JQBP+uBiN4DG5UkLNPqcECuNcJwatWksmmyvZf+AOcAfV/6YSh7AmSx6fEhqBHZfFp
         AJzcLjilR45hlOrk7wkoBUNCq+TAA24jpNqVnxicMnpqGQhRpiog/Vrq1u21iFbSqZxy
         zjE6TdFBNSxqTa/A12kmelE44d+CzLgAPjIPjJlE/QVippGfArU/aL6iEehvlb5BdLor
         Dq3i63PbeliLP+zhbCi4e+PRRhrHRCkIEn9hg1VN5Jr7C+dMqMgyZd46qCnGY5nOohl6
         X8AcYSbHQ+MtA23qYEUjoPZtqby53uSUKxI/ISQCRUpyPkGnHICQELSwX7zWeWfoJVaj
         tVqw==
X-Gm-Message-State: AOAM530lbl6JUUFHW4zvR1xarXtO0cFr3RyPkyP4ujsyhizQ6tbU2HbC
        0kK3nvdmJhcVuXXfdyYu1sN/PwiRq/TvfQ==
X-Google-Smtp-Source: ABdhPJycKehMRwdfvMqkJhwpWLf0MjjR0ClDkMKyvlixe6WR/veK2tNS6dLJVcLuntLlEj4EBShxeg==
X-Received: by 2002:a05:6214:184b:: with SMTP id d11mr2854813qvy.21.1597172378826;
        Tue, 11 Aug 2020 11:59:38 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm18052804qkm.78.2020.08.11.11.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:59:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] btrfs: inode: don't re-evaluate
 inode_need_compress() in compress_file_extent()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200804072548.34001-1-wqu@suse.com>
 <20200804072548.34001-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5f0c29db-20a8-006d-d761-f1018a2e9f7b@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:59:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804072548.34001-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/20 3:25 AM, Qu Wenruo wrote:
> The extra inode_need_compress() has already caused problems for pages
> releasing.
> We had hot fix to solve that problem, now it's time to fix it from the
> root.
> 
> This patch will remove the extra inode_need_compress() to address the
> problem.
> 
> This would lead to the following behavior change:
> - Worse bad compression ratio detection
>    Now if we had one async_chunk hitting bad compression ratio, other
>    async_chunk will still try to compress.
> 
>    Only newer delalloc range will follow the new INODE_NO_COMPRESS flag
>    then.
>    Although one could argue that, if only part of the file content has
>    bad compression, we should still try on other ranges.
> 
> Despite the behavior change, the code cleanup isn't that elegant either,
> as kcalloc() can still fail for @pages, thus from cont: tag, we still
> need to check @pages manually, thus the cleanup doesn't bring much
> benefit, just one indent removal and comments reformatting.
> 
> Suggested-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

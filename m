Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E742A8642
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKESoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 13:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKESoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 13:44:05 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A2C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 10:44:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 11so2158487qkd.5
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JYCnkxmkoWjjbqukx6r83j/6rELiZZpIITC4JhFhQI8=;
        b=ZIAHkDQkrbvse0NCrjv/IsD3I7oCXBnZmv0/QahzJSHYg2/d6LSHGRgfmcUIyUnNKu
         NaU7I5khtnN6jk6kNkLdjsXnGvrpJ1ivEUtfSp4Ajv3grMDApsWedkFj+5h9li8uyNN9
         5pYp8lqaJuYuyYvYkXBmURmBmreXnsDI8LcAwPJIHFy2mCkapc3ucKG13r2+m2wkvgnK
         k6iPge2EOnP4JPtogBjKMxzGQ7L3rZieujJs2Jm8GmgHEMXqV9FiarGD94kYiKqBs9YZ
         bvLSZ7cce5+QGX/c/ZdIjeIQ72DMiTHj1SbgRVN6ui+Lp1GJLqlZ5Hnk4KX1ZRIbZvAc
         icuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYCnkxmkoWjjbqukx6r83j/6rELiZZpIITC4JhFhQI8=;
        b=nb7pelFG4BMOdbAln1HNDAUwpYf9nCT/6SD3apuV5wYx/hTkpRN7meyfmMMK6n26eC
         wGGploBVP2pSRTaVU8ZG/MKayaxXzbPbBG9bQrsT3GP5bwTXg0Ra2W6zi3muKot/87PN
         PkOLpFmF9ryOs+RGSFWOKMYreBi2ELzG3CyX+E9j20/I9ViCVhPy5T53flyg9xY4+IR3
         DO1TGfnKphdVJsnJkb6wub9ZUpDIAG+1wc0mGH+OuQDjvKR+2FsTKPcs5WdB9y+Lctd5
         w7wdS0cWsS7icRkw6Kp+dsWOH1t6JGTiYBidRuZNpDTnEJbdD+pOuw+pKH7gRU+0zdgs
         yP9w==
X-Gm-Message-State: AOAM532x5AYMtl6ztIgCT1nb/+9bDwF8Yx2QsWSLJqrE/wIKYu3+QF1Z
        Wau46x9sm0PIE6KeDz5nNED0OLPdhNDFyXLA
X-Google-Smtp-Source: ABdhPJzIRj1M68Qizvf4yjuWgidba4MqircnTERSxTFsiWdAWa06/EOWZEVLzp7BOcmdbRaSIlYXXQ==
X-Received: by 2002:a37:8005:: with SMTP id b5mr3313860qkd.419.1604601842585;
        Thu, 05 Nov 2020 10:44:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c129sm1535366qkg.77.2020.11.05.10.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:44:01 -0800 (PST)
Subject: Re: [PATCH 3/4] btrfs: fix race when defragging that leads to
 unnecessary IO
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1604486892.git.fdmanana@suse.com>
 <a812a90e50fd792ee8a2e7adff2f588bf8f9b047.1604486892.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5418c3ec-0283-853c-90aa-1f8d2ec61366@toxicpanda.com>
Date:   Thu, 5 Nov 2020 13:44:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a812a90e50fd792ee8a2e7adff2f588bf8f9b047.1604486892.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:07 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When defragging we skip ranges that have holes or inline extents, so that
> we don't do unnecessary IO and waste space. We do this check when calling
> should_defrag_range() at btrfs_defrag_file(). However we do it without
> holding the inode's lock. The reason we do it like this is to avoid
> blocking other tasks for too long, that possibly want to operate on other
> file ranges, since after the call to should_defrag_range() and before
> locking the inode, we trigger a synchronous page cache readahead. However
> before we were able to lock the inode, some other task might have punched
> a hole in our range, or we may now have an inline extent there, in which
> case we should not set the range for defrag anymore since that would cause
> unnecessary IO and make us waste space (i.e. allocating extents to contain
> zeros for a hole).
> 
> So after we locked the inode and the range in the iotree, check again if
> we have holes or an inline extent, and if we do, just skip the range.
> 
> I hit this while testing my next patch that fixes races when updating an
> inode's number of bytes (subject "btrfs: update the number of bytes used
> by an inode atomically"), and it depends on this change in order to work
> correctly. Alternatively I could rework that other patch to detect holes
> and flag their range with the 'new delalloc' bit, but this itself fixes
> an efficiency problem due a race that from a functional point of view is
> not harmful (it could be triggered with btrfs/062 from fstests).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

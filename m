Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D421362312
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbhDPOo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245406AbhDPOoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:44:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:43:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h13so10384391qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QqFmY2jiVmrGdEup+gIL/amJx1MjsCSoh48dksWU9S0=;
        b=AvFk7/t9kd0Mr0uBv4/jRT7BWdMr2F3bdn1jFRuaa+fK0y9hDDhae2/W2/nBgx+XLk
         fFMyXMmbeq2O6a6v4ivr6Uk49BIduRMzKSuTw18+TYJ5LFecQmxZ7Smc2rtDNFTwrQpE
         yP3mJkUGDstL4bm+JtDya70EZHH4FHNkA/kkeOAMDvx3iy9pAy+zOJlgLPf9+kZ8RnLa
         END1EnqftwyRoDvsVylUfm001ENXB41KlMXWma3SkWYbpkPsTz8BcoMVId4ACx97HRb7
         H9TjfdteYSeSrqmnulONq+PFeeaFQbjdeHcdFIKMZ5ZI1hG2X5xmuuf11cFESoIDytIp
         P/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqFmY2jiVmrGdEup+gIL/amJx1MjsCSoh48dksWU9S0=;
        b=ZVL4jKSWDtni4YONiDHV3k+78ltWof17OBvMcOwHqVbKO4hJkML5MZ9Lj4naNch8Bc
         mHVmLkkj0In2//GRUXXSKofEhvOFkGECht5p+oc/Mrfr20o7W54xn8VMzmzKmJD682Nl
         0xfF1WivAUnjyu4FHaPAtM/8dbHaZ5Dz3LXWtkwHXHVw1YkqWTHqiLp76nbvIzQrcDBL
         mUBOZvHrxwlpH/b+igQ00oa2bnK/AILfriZILur0ObTLPHEANJ4YdgDTKLH084vGb0NS
         jqR037dhjmx1cdP0ILNbqBLA3YDHC3RsFn2CDsVSs2k17B44kLyY1ziX/fjdPLCd0BXL
         h0Rw==
X-Gm-Message-State: AOAM532PAsbM+MpwxC5+ZsHm3bzLEvR9HK6Qt+mZ4QsXP1DfzzU3YvBL
        NcWDYxalGPEloAfpSEL8UROqiuMNbv/Ukg==
X-Google-Smtp-Source: ABdhPJwqFNpv7o9rkSokmz4sMTRanY7Ic0q4z7vVhqDMfn//19s0DV8pezh7l6/J2slZmfaUSD0kOA==
X-Received: by 2002:a05:620a:118f:: with SMTP id b15mr9291932qkk.38.1618584232865;
        Fri, 16 Apr 2021 07:43:52 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p66sm4305383qka.108.2021.04.16.07.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:43:52 -0700 (PDT)
Subject: Re: [PATCH 12/42] btrfs: make Private2 lifespan more consistent
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-13-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a6e2d997-4f04-0220-2951-ee2ac72f075e@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:43:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-13-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Currently btrfs uses page Private2 bit to incidate if we have ordered
> extent for the page range.
> 
> But the lifespan of it is not consistent, during regular writeback path,
> there are two locations to clear the same PagePrivate2:
> 
>      T ----- Page marked Dirty
>      |
>      + ----- Page marked Private2, through btrfs_run_dealloc_range()
>      |
>      + ----- Page cleared Private2, through btrfs_writepage_cow_fixup()
>      |       in __extent_writepage_io()
>      |       ^^^ Private2 cleared for the first time
>      |
>      + ----- Page marked Writeback, through btrfs_set_range_writeback()
>      |       in __extent_writepage_io().
>      |
>      + ----- Page cleared Private2, through
>      |       btrfs_writepage_endio_finish_ordered()
>      |       ^^^ Private2 cleared for the second time.
>      |
>      + ----- Page cleared Writeback, through
>              btrfs_writepage_endio_finish_ordered()
> 
> Currently PagePrivate2 is mostly to prevent ordered extent accounting
> being executed for both endio and invalidatepage.
> Thus only the one who cleared page Private2 is responsible for ordered
> extent accounting.
> 
> But the fact is, in btrfs_writepage_endio_finish_ordered(), page
> Private2 is cleared and ordered extent accounting is executed
> unconditionally.
> 
> The race prevention only happens through btrfs_invalidatepage(), where
> we wait the page writeback first, before checking the Private2 bit.
> 
> This means, Private2 is also protected by Writeback bit, and there is no
> need for btrfs_writepage_cow_fixup() to clear Priavte2.
> 
> This patch will change btrfs_writepage_cow_fixup() to just
> check PagePrivate2, not to clear it.
> The clear will happen either in btrfs_invalidatepage() or
> btrfs_writepage_endio_finish_ordered().
> 
> This makes the Private2 bit easier to understand, just meaning the page
> has unfinished ordered extent attached to it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


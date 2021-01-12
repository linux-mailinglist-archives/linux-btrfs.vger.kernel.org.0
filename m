Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88F2F3485
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405460AbhALPqX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405459AbhALPqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:46:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF1C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:45:42 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id s6so1066440qvn.6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9l50jqPNoBOOTLDEtZWZwTrEvZOlOYAJ9ghVHd0rtA=;
        b=NYuTYxayVqXR2Jibpi6u25k0LlmKLobt6Xe/hc7/dvwWzLQWOiz+NpPNVP8XRJ2xO9
         8ukghIv7J4SStY3QE9h2pLce7WlLIwKoSN4TnZ/kw/uLmLKrnyL0z8vJ10LqYPDCzqtd
         wEPgltwCf34oaaY1ozeR8/1jQ6rkv0HS3AAfcuQ5TLY9MFlaBw2L/KAMQRVcQHsMRvcU
         U6hPLI/vz8zahWefpld4WdiJNEGhTHMX/OOVAyG79YuvaIpMlKZC2jv1e/RIYrBNAllY
         OIOYBZFbQ5Mowy3M9IXPlST0H9l+aK9LtrJmdXjcNByKdJNWWFLcUOO2L3SWMcJSbPRW
         QfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9l50jqPNoBOOTLDEtZWZwTrEvZOlOYAJ9ghVHd0rtA=;
        b=luS4vxuWL4JFXOQhcGUJIlVh0V87mlQ9kbb+AUfXQQPuuhluXxPQlQtRIWUyIIL3Ac
         OaXYRbFM22z68TE001vFATt+koBUN8o35394SVLReIs2NQ/6GdOG7QcXy2bwUbXaRccC
         QuU5zRPtjom4pOkTb38l76eoxaP6naIIod5hy0CILHVM+m9s5KcrhW9ofwto456Af2NN
         +x+qq0sUWnxED5M7akqmxE+hwoyUzeJcRQz+bDRX8ShTl63g1/VJOEqcIlbExtPwtLsQ
         bwMARWASAQNgqgiuRcGfDVgweZMtP3/o/h5uy9bRj/pxR1sX0Oru4U9K0VnaFa/p/kmX
         S9jw==
X-Gm-Message-State: AOAM531r08Lrj+xMh/VPeVcXfLHdONh1Mjt4ENIpdVyDxZfWrD501fUH
        bqtRiGe4G8qenWP1eucgOVogJISRaC32HLmF
X-Google-Smtp-Source: ABdhPJwzKrdj+cTDTebTSm7DMvdCXKI/ezX47wSqc55xpADwHqgifQ0BBlSMoJ3q2G90L91+7SxSFw==
X-Received: by 2002:ad4:5a50:: with SMTP id ej16mr5406933qvb.25.1610466341165;
        Tue, 12 Jan 2021 07:45:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b65sm1404390qkg.75.2021.01.12.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:45:40 -0800 (PST)
Subject: Re: [PATCH v11 13/40] btrfs: track unusable bytes for zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <43075f585c6866abcf2b4e000f4481159b39d78a.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b7a41c8d-3c4c-e6c1-c8d1-0d6fc7f7cdf5@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:45:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <43075f585c6866abcf2b4e000f4481159b39d78a.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> In zoned btrfs a region that was once written then freed is not usable
> until we reset the underlying zone. So we need to distinguish such
> unusable space from usable free space.
> 
> Therefore we need to introduce the "zone_unusable" field  to the block
> group structure, and "bytes_zone_unusable" to the space_info structure to
> track the unusable space.
> 
> Pinned bytes are always reclaimed to the unusable space. But, when an
> allocated region is returned before using e.g., the block group becomes
> read-only between allocation time and reservation time, we can safely
> return the region to the block group. For the situation, this commit
> introduces "btrfs_add_free_space_unused". This behaves the same as
> btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
> allocation offset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

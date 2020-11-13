Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCA2B246C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMTXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 14:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgKMTXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 14:23:02 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03121C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:23:02 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q7so5123374qvt.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eMaQLOPRWfhZVDsBfZBzzVsbLrAGfT+ijesKbtQl+kI=;
        b=anrO0sPXljrYhVmUQHmDv3erZ9ojx4bS9y3i0UA/aad42+5YGY0CelQJXx+R685kVN
         bwUoO1picZ5EGfL+3JCqYINpsuY7BbgWJxLZOIh5daj3rjN9qK3n7Vu/FZeLAmoUAXRk
         FwAT0zSz+NPtYwBcPTa3lgZwLKzFNNcAODZuGBZO4M9hUCdUzUfLJ8VKKu5ACOSshCSX
         zhk27uOmdyUP9zQXMrmoU8TsP6/4Yv1WnXJ9RzIMqfhAoLOG9oWDe+dUKTDccL+niHo6
         uyr2g9VwSEKyuo/NSdXVWlfesmIyyyDS6NIIYR1Jt9/TBqkqpNkYR9nnpFJBJG+nlqzh
         pe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eMaQLOPRWfhZVDsBfZBzzVsbLrAGfT+ijesKbtQl+kI=;
        b=nJpR2HDTkfphEmMclxgkOOq84PitTw0jWa3DtRAucKmiqWH4QlAVbDXaPSV5uNow7v
         /GJtFGF9liENQ36bb1nPBJck54XjLzKD/HhShU3p0ZiiY36O8/+aUjSq2K4XrvluAAIN
         pjk2XTViyHJRQHO7FN7BX6Ogn05JaQmOzcLTMDUOGzVhy9ZUHiDsf0W3VawAp6GdlL1k
         V49qgC2KHYzB/BZ+TGEM/CbMUlnCATDVGdiRMK60JlQ10xC1heAA1RsRQUgdyvGs5t9x
         DI1Da07WHew38tsa4N7URXfoePWTVWETKnUROADTVdxidkjQHJRVUDtSHoFxLNKq+eac
         9BjQ==
X-Gm-Message-State: AOAM530zP3fEtnP063hEJrQY9IhVCYH12OJj0wXyRsH3PdtLiQvwjkZV
        sHQCMxeE/Y0Nfvgc3tovbYCo1Q==
X-Google-Smtp-Source: ABdhPJyRgbfA9speFFHHVIXMu4klmmbsk4dBQqQbaGVpY2B9+j3x3zh7EgPOy+FHuQQtdas0MOp56w==
X-Received: by 2002:ad4:46cb:: with SMTP id g11mr4022832qvw.37.1605295381211;
        Fri, 13 Nov 2020 11:23:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h129sm7297667qkd.35.2020.11.13.11.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:23:00 -0800 (PST)
Subject: Re: [PATCH v2 05/24] btrfs: extent_io: extract the btree page
 submission code into its own helper function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ebe4907c-ccf9-9ae2-b3a0-69d49add0170@toxicpanda.com>
Date:   Fri, 13 Nov 2020 14:22:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> In btree_write_cache_pages() we have a btree page submission routine
> buried deeply into a nested loop.
> 
> This patch will extract that part of code into a helper function,
> submit_eb_page(), to do the same work.
> 
> Also, since submit_eb_page() now can return >0 for successful extent
> buffer submission, remove the "ASSERT(ret <= 0);" line.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87597388F45
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbhESNku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbhESNku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 09:40:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5AC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 06:39:29 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u33so6750150qvf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Q+u9GysAszkRLIPvqvuCJQgL7/HgSBMoYQTdkmILmc=;
        b=ij4iMtQpqfsZCW+gGt7Lk2BDr1mjVXAny/j4TnmO1X0peXl/coo9DyGrkmahVKdBgB
         hCl+Y88rGalA40fKV6j1xjIXB0fMdFJ53vrzV/xM4WW1ceJTfA4ShAdHJ1s7vVz37dWQ
         fKU14v+FKuJXX1B8x2i45NEWL4BydYzl6/yJASOeSU45pImstdG3p0qRwXSPabMac4U9
         8A3TaTnIG3xdgSg7iaqtyl5aWfWx/OlDfhNeyoS1BmGebJluujh3F50IF1ulpRbT9VYI
         CTTCE91Mb0CqpQlcV8HoWo01fjSZqbQNpDyEP4oekG/4kyFsgJYqAi2mJQYbo02UNRlx
         gCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Q+u9GysAszkRLIPvqvuCJQgL7/HgSBMoYQTdkmILmc=;
        b=sqbMEGyuw1mg9YGdaEvMIT3Om9glek1gUFdBGBf3GFpu5/qrlFdVrJFCWaOCp57xan
         JmiCy15DXvc20WcwobONkO9+YxJU/PmD+BHgxcvZDU7wX4dB38zDHTBPT1QDV7Np3jqT
         WRWnJcNZwPoVuf15HBCyIfSjwSpvPxCnrKYqdjFRhLVwi5NTtdrkHXtBR8jZMZh1MYAV
         +MXqcA2WnPIx2jQWPrkkIEflsZ8btGnk8C2Ad+biTMGxUcJRe+e8nVPm7vO+kBXyyeyi
         Yx2/UfcVrVhmFhncc7V8lYyckiMn2HipMpIZGypuxGgh7mwLKnX8EsuaBmEvteq+XDw9
         aaEg==
X-Gm-Message-State: AOAM533Ka6tkhE9M69W/j9exzUKOtUtmUqK4qVPB4iAxZUrvnIFfPuQ0
        mm63yFBOfcSX9dRdRw+0i5Du1A==
X-Google-Smtp-Source: ABdhPJxuDQsdN8EnRqLUkGv3AUbkp/uZdScVPxtqh4LOUBe3tr2IBnVewaPvzGKcZ12pAawFf1HW1w==
X-Received: by 2002:a0c:f005:: with SMTP id z5mr13068459qvk.33.1621431568922;
        Wed, 19 May 2021 06:39:28 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::116c? ([2620:10d:c091:480::1:f365])
        by smtp.gmail.com with ESMTPSA id 145sm1033180qko.89.2021.05.19.06.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:39:28 -0700 (PDT)
Subject: Re: [PATCH] btrfs: mark ordered extent and inode with error if we
 fail to finish
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <72c99ae5a88109487565b0ce156cb323e94aa371.1621265174.git.josef@toxicpanda.com>
 <20210519210122.B480.409509F4@e16-tech.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6aa79409-61d0-0c55-8f2c-946b6073d046@toxicpanda.com>
Date:   Wed, 19 May 2021 09:39:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519210122.B480.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/21 9:01 AM, Wang Yugui wrote:
> Hi,
> 
> Without this patch, xfstests btrfs/146 passed.
> With this patch,  xfstests btrfs/146 failed.
> 
> xfstests 146.out.bad:
> QA output created by 146
> Format and mount
> Third fsync on fd[0] failed: Input/output error
> 
> xfstests btrfs/146 or something in this patch need to be updated?

Yeah the patch needed to be fixed, I missed where we can call with IOERR already 
set and the mapping will have the error, so just need to set the mapping error 
if we're the ones to set IOERR.  Thanks,

Josef

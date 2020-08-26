Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47625313E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHZO1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgHZO07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:26:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DCC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:26:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so1504055qtd.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=o1qRlgALyn9tGDXhbImiRaNeVw7+8pIIO2h9hVYWg8M=;
        b=k4RPuDyhwRZvhrS7M0aNNkq2kkL7Ont5aNrRi/uhdqDIKrPfw+dkkSKsRTq/1n+hWW
         aYP51Ji7OkfxwohSzxeZC8AnT+djMhHrsYEAy+10Wy5QbfhVMZbvztn7gSsQvthDio7D
         J1eTwnBW3u6YnffhWXRvc9qU99psEWFgJSXs3Tmz/CeFsrPpx9leKGFK9rVtFEpwwMcL
         eznYaqf76inzViHBKcXG0wRJwezIoCvdYzoZ3YYoIIKRwMFJiTnO6UxUTOjR6K9/7ioY
         /NmE4MSSlWhl11oFGo0gATw+nkLHA0Uy3YiQwf8R+2A2y3Eh7wFqYLRZRYDoaVVc9MLZ
         o3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1qRlgALyn9tGDXhbImiRaNeVw7+8pIIO2h9hVYWg8M=;
        b=ibcm/NPT649mkEen+j9cehp/FG7nNa/c7hiQU88G0dtFwqx+7svnCEFqb4/u66rVbF
         tHXRhx793yWomfTUOVzx6DRwOwoyvs1UVzYzNjxk/rTMKYB/WB1MZSgsNs9fqa1Zn56b
         E3nOzlrjBqdHD1ir5F5BHPHuxjJ8zoJllD8VY4xT3Wkcv/XmL34l4NpnzFoDTi1eLsCb
         cLJqoPqj6fLlFT/FJuOv5purYsbazdexYYEr5PqKxT6rI1CcaTT7G/YX0/1lnxyqmym8
         O2HsChvgjui8eKz3fjLGstsCCuBSX1h9p2NrYJgtgb+qVZS13QyA0nazyF0ekLDJPHcX
         vR0A==
X-Gm-Message-State: AOAM531wqcfiegBCvCVjqbkwtjxfejWuUTeQOcrRAu47HmjXW7KpM7p5
        +K/Zcgqh3pKIev/jZ/EDP4DwD0v31UvJFprz
X-Google-Smtp-Source: ABdhPJxj8CEg+/d1RvLrBwNQN1+rKOeNcv8ZcCIAjPpsWrzLYEnMpK874mJP/vYnhkurVIXZtRiGww==
X-Received: by 2002:ac8:4815:: with SMTP id g21mr14629034qtq.148.1598452017953;
        Wed, 26 Aug 2020 07:26:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id w17sm1857628qki.65.2020.08.26.07.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:26:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs-progs: fix compile warning due to global
 fs_info cleanup
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826004734.89905-1-wqu@suse.com>
 <20200826004734.89905-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c459e385-c125-ff68-aaad-ec159a8647cb@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:26:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826004734.89905-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 8:47 PM, Qu Wenruo wrote:
> [BUG]
> Compiler gives the following warning:
> 
>    check/main.c: In function 'check_chunks_and_extents':
>    check/main.c:8712:30: warning: assignment to 'int (*)(struct btrfs_fs_info *, u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(struct btrfs_fs_info *, long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} from incompatible pointer type 'int (*)(u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} [-Wincompatible-pointer-types]
>     8712 |   gfs_info->free_extent_hook = free_extent_hook;
> 
> And obviously, this would screwup original mode repair.
> 
> [CAUSE]
> Commit b91222b3 ("btrfs-progs: check: drop unused fs_info") removes the
> fs_info parameter for free_extent_hook(), but didn't remove the
> parameter for the definition.
> 
> [FIX]
> Also remove the fs_info parameter for the hook definition.
> 
> Fixes: b91222b3 ("btrfs-progs: check: drop unused fs_info")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

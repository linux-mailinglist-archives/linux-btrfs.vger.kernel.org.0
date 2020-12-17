Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8E2DD4CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgLQQDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQQDn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:03:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09CC061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:03:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b64so22786606qkc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=G/nkLldGvsEpokH5RoOfCsaDXKVHg00jNjjDeVmtaa8=;
        b=SIWuViRB9+djzxMf0cXkCS9aiO5jLBsiRhbKoD9xWjovI0apAoKf+maz9/IgV5vJNi
         Nj8i9mTc1BQeXhyWLcxWgdQfiC30GUt1QfoQFo4PqlmF3b1D75cdY1OkMOrkWHfqzoEC
         sGqvOWlon8fCDUoCTLH68rRVl0nljqIiYpi2uyTtORXLNsR+OMJlZ8OcclBB9pd0rora
         lC5JKy48zWT2sfFjB+riQrliC557vjvjII1/gcG+6TgpcANAoltHnpl0AFZk0E1yGrbY
         4sIxe/RautE6XEaB4INiX+iVTTJvaxy7grjfv1xG8aoV6LnNWqFvLJxBhZP8kIpc2Gsm
         Fn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/nkLldGvsEpokH5RoOfCsaDXKVHg00jNjjDeVmtaa8=;
        b=lsorCTJvYf0C+f4ZdwsM0BzX0ZcyGBGy0ukDh3Msm8FepnRBp5YFB9nF7hgzZ6myhK
         o9HO4+AkggWwmft7Y2J2QzeCj7mt+e2AzgjPAEYordwDzkRwG3rgQ21SSQFWZyIYXtEM
         LKkrKdP9abBTpqSQ2NKrRF1gzbQeRLTwhd9GZH9VGd5nHWMzNuQMDgwvSTpRMtCMf78h
         +0X6RjAt1wEftEAh7K98ZsEE2sNAS0zsWgc2VUlp7SqmNMr9lm3mpuZlAZ+GFg3L+K1Y
         O0Eqvh4tNpG8FgtZLS8O7I15TZgG2CjhnCtEf4q5Kn17ocYggG3Ia2dJ7eS56IlcF0HG
         3zJg==
X-Gm-Message-State: AOAM532ZbY1iTreUJEv+/EGxXxxv3nC2fiKPZNWQHLOqY8KAJ1Yyuf9/
        3ld+19aGbM0cZhC6EfvICveTKShiAxJWx3Fv
X-Google-Smtp-Source: ABdhPJy/rCv1OJPPkL18Jng66FYRXdPdmF5ooppTD94WTm0x18D3Jz33KK+ZVGhP0QwvUdRU0y1eng==
X-Received: by 2002:a37:a80f:: with SMTP id r15mr49394201qke.289.1608220982092;
        Thu, 17 Dec 2020 08:03:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k4sm3240338qkd.48.2020.12.17.08.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:03:01 -0800 (PST)
Subject: Re: [PATCH v2 07/18] btrfs: extent_io: make
 grab_extent_buffer_from_page() to handle subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1c8ed0da-be1f-740c-ee91-232a6640dc2e@toxicpanda.com>
Date:   Thu, 17 Dec 2020 11:02:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> For subpage case, grab_extent_buffer_from_page() can't really get an
> extent buffer just from btrfs_subpage.
> 
> Although we have btrfs_subpage::tree_block_bitmap, which can be used to
> grab the bytenr of an existing extent buffer, and can then go radix tree
> search to grab that existing eb.
> 
> However we are still doing radix tree insert check in
> alloc_extent_buffer(), thus we don't really need to do the extra hassle,
> just let alloc_extent_buffer() to handle existing eb in radix tree.
> 
> So for grab_extent_buffer_from_page(), just always return NULL for
> subpage case.

This is fundamentally flawed.  The extent buffer radix tree look up is done 
_after_ the pages are init'ed.  This is why there's that complicated dance of 
checking for existing extent buffers attached to to a page, because we can race 
at the initialization stage and attach an EB to a page before it's in the radix 
tree.  What you'll end up doing here is overwriting your existing subpage stuff 
anytime there's a race, and it'll end very badly.  Thanks,

Josef

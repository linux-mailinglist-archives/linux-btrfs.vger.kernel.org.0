Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027352DD34B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgLQOwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQOwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:52:23 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85681C0617B0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:51:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id y15so20210576qtv.5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vU2cyUCNMRI+G4P11ojwfo3tYBYYSGM/ovk3/H+nOVk=;
        b=oov6oIbBN+NjU3PzKBPEbAjgoaxuAawIPRSutZrfLDiYbM+gFIO/i7MnIVAB94uOkj
         1fHaZYZL1XiaqYmYxbbSDOrCwOI3wV42hCg340QqdsbcAvnm5FEZooY/AYwaWOtFuEMT
         sxpocnBfrTD3rrR0FTp0pLobLd1k3aLqFZ3JwjhiCSVKWXQazt0XWDt/9orTQ6Quwf71
         TVKqMzXT4HxVxIEJoPkxnGrzoHmvIP2EOEhvNtwKjiyK9RUuTbESsc87TVlsaiybE0s0
         Ku7GVKfNZn3nAqsXxtXAS5w8rLXwMW0AyQuxhKbbM+lM76MOTF/KbWwmzCJUjkBmFBve
         yK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vU2cyUCNMRI+G4P11ojwfo3tYBYYSGM/ovk3/H+nOVk=;
        b=F0CGxSWC9NLhiP7XfKsAFkIffi00STL1i5SEkoIhTM6ZXBsV430orurTfbmtJp7Qh2
         GI7uNvp09dhp2Rn6qosb4iqbG/0119WBpvqJsRwcqhJT2cmHUkqGXPo+gGcf3kphv3TT
         Dzafi58T2ljF/i2bIIVUS3pJ/l5MBXAbe1BAak4nbODh/jK1Ifz6w4Op8EAxFwlf0w2d
         CVCyUw8PjxiJ3S6iDYIfuTGmphOf/9Vp6lzqrE0LiKzLlzaEYYHtXXBTtY9GJwwAtcn3
         X7jZRnWXFE7INjusLp6OrlGjc4U3t9cxfdncZmmKLDCZOwxS1h8k1USRsKhnC/dRsRR7
         Cg+w==
X-Gm-Message-State: AOAM531FerrbFOy+nwFCCi9aQF8Ez7gHdVEw64VHbFmyhDIVNWHDMB1e
        /evFLt+M6qEQJ9ZUWn89hOGfXpE+OSZ/kqLk
X-Google-Smtp-Source: ABdhPJwQb1UuLBOcy8NQkgCEZaQfgArkmOugKm8VQmIAJ9ceX/0M9bR7PKTR0PIqCR4bl8uw2ZzKRQ==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr16846897qtq.267.1608216694959;
        Thu, 17 Dec 2020 06:51:34 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u65sm3655421qkb.58.2020.12.17.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:51:34 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] btrfs: inode: make btrfs_invalidatepage() to be
 subpage compatible
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201217045737.48100-1-wqu@suse.com>
 <20201217045737.48100-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <778948b8-ec8c-fcbe-310f-eccb37d424f8@toxicpanda.com>
Date:   Thu, 17 Dec 2020 09:51:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217045737.48100-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/16/20 11:57 PM, Qu Wenruo wrote:
> [BUG]
> With current subpage RW patchset, the following script can lead to
> filesystem hang:
>    # mkfs.btrfs -f -s 4k $dev
>    # mount $dev -o nospace_cache $mnt
>    # fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt
> 
> The file system will hang at wait_event() of
> btrfs_start_ordered_extent().
> 
> [CAUSE]
> The root cause is, btrfs_invalidatepage() is freeing page::private which
> still has subpage dirty bit set.
> 
> The offending situation happens like this:
> btrfs_fllocate()
> |- btrfs_zero_range()
>     |- btrfs_punch_hole_lock_range()
>        |- truncate_pagecache_range()
>           |- btrfs_invalidatepage()
> 
> The involved range looks like:
> 
> 0	32K	64K	96K	128K
> 	|///////||//////|
> 	| Range to drop |
> 
> For the [32K, 64K) range, since the offset is 32K, the page won't be
> invalidated.
> 
> But for the [64K, 96K) range, the offset is 0, current
> btrfs_invalidatepage() will call clear_page_extent_mapped() which will
> detach page::private, making the subpage dirty bitmap being cleared.
> 
> This prevents later __extent_writepage_io() to locate any range to
> write, thus no way to wake up the ordered extents.
> 
> [FIX]
> To fix the problem this patch will:
> - Only clear page status and detach page private when the full page
>    is invalidated
> 
> - Change how we handle unfinished ordered extent
>    If there is any ordered extent unfinished in the page range, we can't
>    call clear_extent_bit() with delete == true.
> 
> [REASON FOR RFC]
> There is still uncertainty around the btrfs_releasepage() call.
> 
> 1. Why we need btrfs_releasepage() call for non-full-page condition?
>     Other fs (aka. xfs) just exit without doing special handling if
>     invalidatepage() is called with part of the page.
> 
>     Thus I didn't completely understand why btrfs_releasepage() here is
>     needed for non-full page call.
> 
> 2. Why "if (offset)" is not causing problem for current code?
>     This existing if (offset) call can be skipped for cases like
>     offset == 0 length == 2K.
>     As MM layer can call invalidatepage() with unaligned offset/length,
>     for cases like truncate_inode_pages_range().
>     This will make btrfs_invalidatepage() to truncate the whole page when
>     we only need to zero part of the page.
> 

Are we ever calling with a different length when pagesize == sectorsize?  That's 
probably why it works fine now.

But I think we should follow what all the other file systems do, if len != 
PAGE_SIZE || offset != 0 then just skip it, that would probably be easier and 
work for you as well?  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF49306083
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhA0QFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhA0QCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:02:16 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E0C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:01:36 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o18so1703903qtp.10
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5lxME1/+nPQQSvoAiBpI3bjFzAox/SESaa3XkyHk0s=;
        b=nV+ChGHt+CTaa9MlqWX3IInBwSQ4F98prOkgrO1ralkUka5oif18qGsRtK0XctdCSc
         lDGy1ZJDge3Jaspw+tZbuNfoJnLBJ/RWPlugpFF8pDzKjMboB9yOl66xIQyHDCFo+BAq
         LuuoBDgv2wQtXXzqH+jw9dNhXfcLHWi9kpu0Pns0sSfCysVD35B8zFUhJJIgdqpr/g2U
         vbkGJVu0H6zEaE49TlR1EeSMHedOnMRQv25W7hwqiWCRwVj6+sJF/EKEsCA8YTHlN3ix
         n9zJkIV4xM9G9HgBseD/vy0ltAV7HbmM0rEaI58Ueb+3gC5BBHThJRo3AW6vc+Fo8qK6
         RXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5lxME1/+nPQQSvoAiBpI3bjFzAox/SESaa3XkyHk0s=;
        b=pm20c/Q12O9w/yAbcVXn/3COmkLp8WKLHT3XrOTRfn7SQBEk5Tbsl7B178CQm8vguq
         RLsE06U1eHCL7uP5c7lyqbkIn4qILp4EV7nwxPBffWNp/Czyd8ek3WwJIFsF/aD8MNkY
         TkZK0ESuCC/Y+n5zwS4+Xksp/My+DUCWHqdrydKNJQUKhKxRPR/TKjKlf4t3IYMFI1Ts
         Z9sQKKop0IR2d1YUaDSmcT2GF2M5/YsRqNLrLw/lniBexwCEdaJDckQqRAykt9cqL7/q
         vJrvpXnfgWt/g+HjyrnUVN1J5lBx5/B20R0rLWNhynceR58MEM6lrc8ilm0p/A/FrhfN
         eMRg==
X-Gm-Message-State: AOAM5312Dk5wELg9TEngzKTd95Pu64B2nCko4+BmhPaxbQWhDlak3EVc
        02Mu93Jthjru/IrsCmlU7iZyRg==
X-Google-Smtp-Source: ABdhPJxseS5XXLzX1Ou7FTjaWxLls30jkD5XfU1q6yU8LX4z0puFWwnye6C6VMzRA2g5DblYqiLZdw==
X-Received: by 2002:ac8:39e6:: with SMTP id v93mr10334667qte.139.1611763295362;
        Wed, 27 Jan 2021 08:01:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d192sm1444596qkc.65.2021.01.27.08.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:01:34 -0800 (PST)
Subject: Re: [PATCH v5 04/18] btrfs: make attach_extent_buffer_page() handle
 subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bd88ae39-f5f3-3bfe-c3e1-27fec066a784@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:01:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> For subpage case, we need to allocate additional memory for each
> metadata page.
> 
> So we need to:
> 
> - Allow attach_extent_buffer_page() to return int to indicate allocation
>    failure
> 
> - Allow manually pre-allocate subpage memory for alloc_extent_buffer()
>    As we don't want to use GFP_ATOMIC under spinlock, we introduce
>    btrfs_alloc_subpage() and btrfs_free_subpage() functions for this
>    purpose.
>    (The simple wrap for btrfs_free_subpage() is for later convert to
>     kmem_cache. Already internally tested without problem)
> 
> - Preallocate btrfs_subpage structure for alloc_extent_buffer()
>    We don't want to call memory allocation with spinlock held, so
>    do preallocation before we acquire mapping->private_lock.
> 
> - Handle subpage and regular case differently in
>    attach_extent_buffer_page()
>    For regular case, no change, just do the usual thing.
>    For subpage case, allocate new memory or use the preallocated memory.
> 
> For future subpage metadata, we will make use of radix tree to grab
> extent buffer.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

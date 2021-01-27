Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004C03060E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhA0QVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbhA0QVA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:21:00 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73044C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:20:20 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h16so682446qth.11
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0C/0oNQB/TOBo39CyVe6BKGwbHkjbjTGpSOY3ZgJdM=;
        b=n3y8bsfUbWZY6/Libv+4peFpkPZ/fz667iiMWEGIUCI37hFddgGxRrJubJLo5DhK1r
         bfO9pbDXb7amlrV1Qz87mvCF+gOOyn/fDm3qh8ijd0x3a6ConeDgNhS5OitVWwKVKnHR
         A/jYYzoDe6kvE6Sol8JEOPR3Iguc8++ths/2ia/q1fDzsl9DPtE5uHwLk7tNpJy/h/oo
         Lo/B/M/hcmMxxj7ml7q/xLI91RpthkO83Gib3Ok1QzDPYt1ae1auZH02ugC9hGzDWqDM
         N4Kmt18+sJgpTP5lqB+ZYvwA3dpz+cJNhvOf+l9x5FibcfM5HdCR6zUsUlH84qn1ACi9
         l34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0C/0oNQB/TOBo39CyVe6BKGwbHkjbjTGpSOY3ZgJdM=;
        b=ILaaPfCswyiNZe5TR2jyo4qKtGhPU4mV1YqVkjrlgqwMJ3JZGfzeVMRMwUjUjD3+bM
         s4vo/Gx1XD3vsTyaFkyhVFTy6xBpfxRhvpNzre/us1G7N/+DU+6kl2B7hRIM/TxxgJBv
         LErhVVEpjVtnHnXAqeiWPfsYtll547sdjqQXvyFxiZHXKb1LXJFdoibskkN6w0CrmBCr
         SRa6Y3/PuyCgS6kvuaTRf8iWQkQrmZOel5z2MMs+VMlWnKMzdQJ4aiKatvo6W0FREPOD
         71dt8lGp95SDr9S7ZdJAVc4iGFG6z3EaXYC7HpWZtjPYIVIV/XnH0syAi92uaBe03DzS
         PyzQ==
X-Gm-Message-State: AOAM53388W2BXMumJ4M42VxGf/xJ2NHQmgAv2zCzRJnK8yryVTRctKyB
        vsd8P7QNYAHufGkdbFzFEiCaPw==
X-Google-Smtp-Source: ABdhPJyco/ogzvqQ+E+7hErl5mmGHVB38WoY6W9ydew0trsxBBZ9Jr/wBmsRdXxFNatxCz0f4JYxcA==
X-Received: by 2002:aed:3b9b:: with SMTP id r27mr10444951qte.30.1611764418957;
        Wed, 27 Jan 2021 08:20:18 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v67sm1520346qkd.94.2021.01.27.08.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:20:18 -0800 (PST)
Subject: Re: [PATCH v5 05/18] btrfs: make grab_extent_buffer_from_page()
 handle subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <00339001-c7d8-5b5e-6407-aac386a21eee@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:20:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> For subpage case, grab_extent_buffer() can't really get an extent buffer
> just from btrfs_subpage.
> 
> We have radix tree lock protecting us from inserting the same eb into
> the tree.  Thus we don't really need to do the extra hassle, just let
> alloc_extent_buffer() handle the existing eb in radix tree.
> 
> Now if two ebs are being allocated as the same time, one will fail with
> -EEIXST when inserting into the radix tree.
> 
> So for grab_extent_buffer(), just always return NULL for subpage case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

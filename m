Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087B1257DD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgHaPni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgHaPnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 11:43:37 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A13C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 08:43:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s15so2860579qvv.7
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c2CnYolg5/FhWVQ5Gy2u7c8wW2ql5soAvzMPPk16xuA=;
        b=ATTVVlgiFiSSy44AW4sc9RmRAxl8xnyqGoppbH3Q1RlKXLRs7Ylucon8tLWuqlnUKI
         coHcP1o7tZt7JATxO1RM0UT8bL5A1XNyUoDgcujeefcJkICz0y4o0/AnfDPlXzSacoRS
         3OZmR+zLD8lNF++AS+hPL5ON8dbaBSc5L2sDgRAa37H1qVB44JNS1MZQYODH/mFYG0tl
         o1K421SLoTwY2YAFESt0ZuoTvlE7oeyzSr8jt4GvWYLjSwD3D4wIDMWeaBmxEsIWAKBQ
         6UmlofTvzNS94ttdkftcydzkUqHwlxeGLakEbUqzvM2VVkUSjsjMHmKBrry2aG3CI69b
         +rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2CnYolg5/FhWVQ5Gy2u7c8wW2ql5soAvzMPPk16xuA=;
        b=eIaCZSy5NE26Q9yKY5JRx8AP0nVn93lePzvDFTkGK4PKrY+rb9TZI/gYDamWSl0RM6
         mz+vbzx+vlgT9d4ZWh5XwW8Y3VDiD70haFnqOJzUKJ3ZUlwfXz4xA6VnE7YJvtu9/aq5
         L8oZL3L5vEgo//xRY3PWgPovbtAuYa+fZ6WYw9xqkCxa12R1j1BvSKEO0/VZ62acriNN
         /clkhRMMUB1Re9scLBA1XFoSPw2RTz6k4JMj8Ikq/YzhWaq24JqLMTxI0fJcie2fh5/T
         tHDZg8fDukTJ0Z1fa7vAe6vIeJVXW1icVQwV9XNOyoJT1Tn9rU4sCtKsVErxAxvtGqU9
         TAVA==
X-Gm-Message-State: AOAM531hjBtey85AZn0IABAsnnRqi0cqgWSBQSRW5Owqh4a03XO24Qpv
        e95YWLGHpK7QDQZbnFmNUnbRMO8dHd/5CEOA
X-Google-Smtp-Source: ABdhPJwIdjNt+LU2QZAxlOZXRwPaXcvlLJDTRZEadp89z8bNvOYdAO9Ed26asVBjxfnjQOf39MiX9A==
X-Received: by 2002:a0c:c304:: with SMTP id f4mr1618949qvi.8.1598888616065;
        Mon, 31 Aug 2020 08:43:36 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm10181184qtu.69.2020.08.31.08.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:43:35 -0700 (PDT)
Subject: Re: [PATCH 00/12] Another batch of inode vs btrfs_inode cleanups
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200831114249.8360-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <02f72a45-8f6b-ca9b-d47c-daadb6153da8@toxicpanda.com>
Date:   Mon, 31 Aug 2020 11:43:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/31/20 7:42 AM, Nikolay Borisov wrote:
> Here is the latest batch of inode vs btrfs_inode of interface cleanups for
> internal btrfs functions.
> 
> Nikolay Borisov (12):
>    btrfs: Make inode_tree_del take btrfs_inode
>    btrfs: Make btrfs_lookup_first_ordered_extent take btrfs_inode
>    btrfs: Make ordered extent tracepoint take btrfs_inode
>    btrfs: Make btrfs_dec_test_ordered_pending take btrfs_inode
>    btrfs: Convert btrfs_inode_sectorsize to take btrfs_inode
>    btrfs: Make btrfs_invalidatepage work on btrfs_inode
>    btrfs: Make btrfs_writepage_endio_finish_ordered btrfs_inode-centric
>    btrfs: Make get_extent_skip_holes take btrfs_inode
>    btrfs: Make btrfs_find_ordered_sum take btrfs_inode
>    btrfs: Make copy_inline_to_page take btrfs_inode
>    btrfs: Make btrfs_zero_range_check_range_boundary take btrfs_inode
>    btrfs: Make extent_fiemap take btrfs_iode
> 

Applied and built against misc-next, spot checked everything, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series, thanks,

Josef

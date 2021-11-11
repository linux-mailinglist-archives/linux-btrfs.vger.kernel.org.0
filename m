Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E007B44D4EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 11:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKKKVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 05:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKKVD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 05:21:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931BC061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 02:18:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n29so8889996wra.11
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hMKkCAOogUAP6Yp/j0rU04+UdJr/E0fdqc1Ew1lHJ1A=;
        b=XQfr+fF36bchUYq5floAzku6SVvCUniyN8L9BP9DLndet4qAiKf7lbQiXkW61/E+yM
         lfdmLcxFTEztDUlM1cixttG97iGgyG+ETSj3WlQYaixhcjjxNTwpSZNVnO1KuCt82Am4
         t3+aGMvg7WiN3Hest8uRN8EQO1ADCMJCYayu76I0757+U6sVIeDnHETWWg7yVOnbZiJD
         abiYCTVnVusyBrfbCxMTuOqS1RiMrF5cZK8kku00U955l+2h+UoknecqUSYE4n37ZKvS
         btBVjJhHfzTNTtTKJisUqI8qu17PgCs80QUQs2UQ7S9saFQM/YMeCayjyxE4KwOHUR78
         dTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMKkCAOogUAP6Yp/j0rU04+UdJr/E0fdqc1Ew1lHJ1A=;
        b=ygeUTo0eY2ZNJ3eoO4pazO8+jN5kuvm4PSuIO7mbQ6oMzSpgoQCElunOliHQx3sehu
         m78gl8SOl/vRLqHnAnO8ZoTRoswg7cWVamuNpNptJqDjuvoatmd2dke4M+/FbNKzJVv0
         PispMwFb22liae+23M5nRlz69EijR/KYmAEGkq/7qhx4pLN7+1FNs2txjrVL4RamHW/M
         cH7F+N2DIIhJ2ELFOYLZvq90Z7410PHoiQOWSjYnLtXLLYa9oDhS7XujZ0esorhud01+
         e+8U+TQhhbZnBrGI9bhXn/BbnEcD5xcBKniW/ots6lIPXaqCVa7Wv3KxRdy4wxfEsJWc
         zSjQ==
X-Gm-Message-State: AOAM532vaY3R674oXymVXad8VyJtXZNOAKZ7em1SMybiCJk7l1wIEnEc
        HgZz4Ex/23b3tQYe51lMR0UDMOpZ6x4=
X-Google-Smtp-Source: ABdhPJxRmFRYGY4b5HAyB0+iOWymA1VUdRR50J7bfadMBuC1eAX2bm+zXmCHCeVzM91FjUkvGM4FVQ==
X-Received: by 2002:adf:8165:: with SMTP id 92mr7716596wrm.199.1636625892541;
        Thu, 11 Nov 2021 02:18:12 -0800 (PST)
Received: from [10.20.1.172] ([185.138.176.94])
        by smtp.gmail.com with ESMTPSA id g4sm2404987wro.12.2021.11.11.02.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:18:12 -0800 (PST)
Subject: Re: [PATCH v3] btrfs: index free space entries on size
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
References: <d69c29c8428a923d526aa2fe068d421d14667b47.1636408067.git.josef@toxicpanda.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <93c4c316-1bc1-5144-18f0-f85233060102@gmail.com>
Date:   Thu, 11 Nov 2021 12:18:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d69c29c8428a923d526aa2fe068d421d14667b47.1636408067.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.11.21 г. 23:49, Josef Bacik wrote:
> Currently we index free space on offset only, because usually we have a
> hint from the allocator that we want to honor for locality reasons.
> However if we fail to use this hint we have to go back to a brute force
> search through the free space entries to find a large enough extent.
> 
> With sufficiently fragmented free space this becomes quite expensive, as
> we have to linearly search all of the free space entries to find if we
> have a part that's long enough.
> 
> To fix this add a cached rb tree to index based on free space entry
> bytes.  This will allow us to quickly look up the largest chunk in the
> free space tree for this block group, and stop searching once we've
> found an entry that is too small to satisfy our allocation.  We simply
> choose to use this tree if we're searching from the beginning of the
> block group, as we know we do not care about locality at that point.
> 
> I wrote an allocator test that creates a 10TiB ram backed null block
> device and then fallocates random files until the file system is full.
> I think go through and delete all of the odd files.  Then I spawn 8
> threads that fallocate 64mib files (1/2 our extent size cap) until the
> file system is full again.  I use bcc's funclatency to measure the
> latency of find_free_extent.  The baseline results are
> 
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 10356    |****                                    |
>        512 -> 1023       : 58242    |*************************               |
>       1024 -> 2047       : 74418    |********************************        |
>       2048 -> 4095       : 90393    |****************************************|
>       4096 -> 8191       : 79119    |***********************************     |
>       8192 -> 16383      : 35614    |***************                         |
>      16384 -> 32767      : 13418    |*****                                   |
>      32768 -> 65535      : 12811    |*****                                   |
>      65536 -> 131071     : 17090    |*******                                 |
>     131072 -> 262143     : 26465    |***********                             |
>     262144 -> 524287     : 40179    |*****************                       |
>     524288 -> 1048575    : 55469    |************************                |
>    1048576 -> 2097151    : 48807    |*********************                   |
>    2097152 -> 4194303    : 26744    |***********                             |
>    4194304 -> 8388607    : 35351    |***************                         |
>    8388608 -> 16777215   : 13918    |******                                  |
>   16777216 -> 33554431   : 21       |                                        |
> 
> avg = 908079 nsecs, total: 580889071441 nsecs, count: 639690
> 
> And the patch results are
> 
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 6883     |**                                      |
>        512 -> 1023       : 54346    |*********************                   |
>       1024 -> 2047       : 79170    |********************************        |
>       2048 -> 4095       : 98890    |****************************************|
>       4096 -> 8191       : 81911    |*********************************       |
>       8192 -> 16383      : 27075    |**********                              |
>      16384 -> 32767      : 14668    |*****                                   |
>      32768 -> 65535      : 13251    |*****                                   |
>      65536 -> 131071     : 15340    |******                                  |
>     131072 -> 262143     : 26715    |**********                              |
>     262144 -> 524287     : 43274    |*****************                       |
>     524288 -> 1048575    : 53870    |*********************                   |
>    1048576 -> 2097151    : 55368    |**********************                  |
>    2097152 -> 4194303    : 41036    |****************                        |
>    4194304 -> 8388607    : 24927    |**********                              |
>    8388608 -> 16777215   : 33       |                                        |
>   16777216 -> 33554431   : 9        |                                        |
> 
> avg = 623599 nsecs, total: 397259314759 nsecs, count: 637042
> 
> There's a little variation in the amount of calls done because of timing
> of the threads with metadata requirements, but the avg, total, and
> count's are relatively consistent between runs (usually within 2-5% of
> each other).  As you can see here we have around a 30% decrease in
> average latency with a 30% decrease in overall time spent in
> find_free_extent.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

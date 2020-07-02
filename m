Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB61212504
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgGBNn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgGBNn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:43:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A7C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:43:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so21214953qtd.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JB6WjPiYXYKNJKUs+LmmojDdK6EFbNavrAlfbyKdZFs=;
        b=skYgtL1DY/aZ7aozVGscWEu1QZ3ZAPREW2HJXDchwqdNsvp7hk6UNU03V/Seejglg/
         0W/dU8P12P14ZKMvdVsNQaxJJ2WM4XfTl0GZqBgLAXmmPZ/zQm5gBMYVhHD0tFSh/7+Y
         gdaUECh1awF5Br5l9nb8HQL+gqiru3ww7ZRz4J6D9DKxes8F3amzXMWg2dFvLwKHhkiB
         BwWuT1VKtNdVaj2ekA+eLxSCXoG+TkIgDk2k0cerJS5Z/nqweHCipaUKUpqx2vdZ1J85
         18EgtHCCNgIoQFpxWk03l6e/3Jl6LEklDhXdXOP+KQ0e9er7abSOf9ApXbqFC8xZ6mdE
         WH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JB6WjPiYXYKNJKUs+LmmojDdK6EFbNavrAlfbyKdZFs=;
        b=k3qMOl0snBx7KCq41jr9RSo0OWVPpJyZjVetFXInt4X1F9VQhzZyDbKAhyvvgQBHtJ
         YvIUTVV4BJkCMqIUwIsUq1u/rGmWaRNdLI6ViGJnuh52tGlfvqLmKvqBt4bpCVGp1qTI
         TcxAgS/wXREk2aD/HbcHbbu9Xf8CE/yb1KOV1KyCv8jDLNB1CSua9xe0DoYjqmQzTNfl
         YP4040mCP/roZxmNbuoLagWInvxQNvVXToHeqHYEetHEWJmuDOUH1U8gmWLetw/gmkHb
         NktbbYYRT9l3yn7h/r0FUX1MqdbchfgYL+9Y1PH1QlZqAgzYgFsyS+NpwsT6TVXOTjEv
         F3lw==
X-Gm-Message-State: AOAM531bnGbLSCj521JywYkKO+AQVcVAebWO08hIV+IajI6LD5X+7u4u
        fFWQ2WyBjMw+pqrr6FfKV3geKxKXqA4cbQ==
X-Google-Smtp-Source: ABdhPJzf7oXju6ZM5z0bEnjUEr2/Sfo6dYTqBSY5x1w8/UoEozsh73MOXtroMXawspN5D/Kj7i0MBg==
X-Received: by 2002:ac8:1907:: with SMTP id t7mr30869904qtj.160.1593697404545;
        Thu, 02 Jul 2020 06:43:24 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r35sm6571756qtb.11.2020.07.02.06.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:43:23 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs: qgroup: Try to flush qgroup space when we get
 -EDQUOT
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3ed599a3-3712-81ad-6d04-0889523cfa44@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:43:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702001434.7745-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 8:14 PM, Qu Wenruo wrote:
> [PROBLEM]
> There are known problem related to how btrfs handles qgroup reserved
> space.
> One of the most obvious case is the the test case btrfs/153, which do
> fallocate, then write into the preallocated range.
> 
>    btrfs/153 1s ... - output mismatch (see xfstests-dev/results//btrfs/153.out.bad)
>        --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
>        +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01 20:24:40.730000089 +0800
>        @@ -1,2 +1,5 @@
>         QA output created by 153
>        +pwrite: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>        +/mnt/scratch/testfile2: Disk quota exceeded
>         Silence is golden
>        ...
>        (Run 'diff -u xfstests-dev/tests/btrfs/153.out xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
> we always reserve space no matter if it's COW or not.
> 
> Such behavior change is mostly for performance, and reverting it is not
> a good idea anyway.
> 
> For preallcoated extent, we reserve qgroup data space for it already,
> and since we also reserve data space for qgroup at buffered write time,
> it needs twice the space for us to write into preallocated space.
> 
> This leads to the -EDQUOT in buffered write routine.
> 
> And we can't follow the same solution, unlike data/meta space check,
> qgroup reserved space is shared between data/meta.
> The EDQUOT can happen at the metadata reservation, so doing NODATACOW
> check after qgroup reservation failure is not a solution.

Why not?  I get that we don't know for sure how we failed, but in the case of a 
write we're way more likely to have failed for data reasons right?  So why not 
just fall back to the NODATACOW check and then do the metadata reservation. 
Then if it fails again you know its a real EDQUOT and your done.

Or if you want to get super fancy you could even break up the metadata and data 
reservations here so that we only fall through to the NODATACOW check if we fail 
the data reservation.  Thanks,

Josef

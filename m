Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B2C21240A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgGBNCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBNCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:02:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2DC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:02:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w34so1045683qte.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VCt46EqA7GjcAKAUOkH4pTF4Tj/KSzFQt8IL1cJ3qEc=;
        b=WlRfookABPLGK6zbqHR7sDOb89k7Riyg7SbWGI3gWLjQMiTx11sNGwxSyEhNc81imB
         hFnkWXX/1AMGYQHWgTKwcHhWxsauD/RwJhl543pWGksPYIzCXOscxdLRmDGEC2V1Nz9h
         DQwX+sUWvcj3qguHIXnfwqurLrp74/AVifym0V+X4j/dzE/4o2m5oh8/Ak5kA25mA3vd
         xhfCzHvxTYAra7RDABbhHld0SJWnUkIzzwGghG/2R3OpbaI1Kq1MZk6+U2Y+Nscftn88
         +ZjvoKc1kgxy89rUCXV2qHOXyT9qwF+WIJiFT1fQvWIt6nEFghdLZ4m3uqcMQXBkJ7bY
         TTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCt46EqA7GjcAKAUOkH4pTF4Tj/KSzFQt8IL1cJ3qEc=;
        b=pva1JTSfR0ew+iwWGkqPC3d0DgZenn7lzk6NVaRwnxPIRyQDR+p0gSmzlxgRIxr1QK
         84aqJSjXsgyevB9GP7ONy/F8QrEUKWcQQVvvs5I9LGU74JwhgEFL1b4aNAsx2O73ZaGN
         6rof+ZVDkwjP/O4HsbA7Qb+8nHHKLbbf4DSk0G9bNU6RC36p+GYLMG+xbYFuXLzUSJuH
         TZJlFVyROEXVbckeEDrAGYE9MQfktz9uysKXb8HnlXXrE2FfDMgRFqY3q1mjnwlXKjY+
         7DqYopZ6UC6hjX7/gNReMKOOM2XPLpDkxmshTuvP/CSp13NvVyiCcBLl48Uj2yJWNzFp
         qATw==
X-Gm-Message-State: AOAM531qfjtsx/SyuFe1H+GdfaxQlH8ri1Gy6x0AkbfwRDhoRNE4cpYc
        fILJGIybJmZwn3+wqQf6BcHvlGm3OW15Hw==
X-Google-Smtp-Source: ABdhPJyxBC4aVizzksFZfNgixvt3JlMxNIqFM/KUv+asK9PQO9D0iklkpYHe717EQqXRiOVpa9ZBxw==
X-Received: by 2002:aed:2aa5:: with SMTP id t34mr32390043qtd.363.1593694951475;
        Thu, 02 Jul 2020 06:02:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t57sm8381887qtc.91.2020.07.02.06.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:02:30 -0700 (PDT)
Subject: Re: [PATCH 3/4] btrfs: stop incremening log_batch for the log root
 tree when syncing log
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200702113231.168052-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b2eca20a-ed0f-b45f-b998-8076ac81162e@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:02:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702113231.168052-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 7:32 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are incrementing the log_batch atomic counter of the root log tree but
> we never use that counter, it's used only for the log trees of subvolume
> roots. We started doing it when we moved the log_batch and log_write
> counters from the global, per fs, btrfs_fs_info structure, into the
> btrfs_root structure in commit 7237f1833601dc ("Btrfs: fix tree logs
> parallel sync").
> 
> So just stop doing it for the log root tree and add a comment over the
> field declaration so inform it's used only for log trees of subvolume
> roots.
> 
> This patch is part of a series that has the following patches:
> 
> 1/4 btrfs: only commit the delayed inode when doing a full fsync
> 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> 
> After the entire patchset applied I saw about 12% decrease on max latency
> reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
> ram, using kvm and using a raw NVMe device directly (no intermediary fs on
> the host). The test was invoked like the following:
> 
>    mkfs.btrfs -f /dev/sdk
>    mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
>    dbench -D /mnt/sdk -t 300 8
>    umount /mnt/dsk
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

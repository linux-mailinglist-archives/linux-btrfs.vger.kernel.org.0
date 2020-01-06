Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA81313F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFOof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 09:44:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42084 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 09:44:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so42589763qtq.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AQBju9FTjJK8/p2OLR4cztilktlJGD7Rj9dIbPu7f/o=;
        b=v7uoHCmt788F7g7VPPAJTWciCHnZ22BrYu9q1X4c8GTIXuDcx05vrd9ZSIcwds37tv
         orkrFDz/bWlUG/S/VNhYBPlY16A0rj8ztRR/N7rm2t0MPCkaCXW0x+YooEHXzTs6ALOA
         NMvGV1SnVsdTll4DuJnVVI31wxFgvF3vM/+8rodkJL/sRirQ2uldPgzWNlJ2RwzQFlgQ
         B5mErR7deagu12n6ZwZlFPJjlKHHQ+YmN9IRhvpm7BGxCAfEHbpyIXC1tIm/i2/r5IYa
         lV2PRo+7U15wbhU0gfl5GhdZwx8NrARo1WkJ/o3zIZTgSCW1bdWjgwQQEKLmc1MCYO8U
         gvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQBju9FTjJK8/p2OLR4cztilktlJGD7Rj9dIbPu7f/o=;
        b=RKzzikpx8Tvyc9SC0Iys1Zdwe3LlLlvBGhOFhVjU95X/TQqMqLoCXopj0x/tRRRlQV
         yng3wd8UBBzl/8QDTCFhOrwzyyXTZ1co8uDZ4xYT1KIiC0Y/xv7tpFKflDkcLaQe1Qly
         tFvmYCVOjgCSVrcgaGHHwV0qQsGxzoJ/PVRaFkfJGfi/g4hV5yGxxKa6+Pn0NmT40QdF
         +NDnuv8nu3M+GvoRPXWXSSPT4DB3L8WeAkcqxeBrf57mbkzYAkXYc4EiAp4Ek0LIKoOW
         Yv6lnb5nxM6JIH1PrEF76isoj8meZKPFbW8lcqVaZIkyomMYwJo5oOqlImuYB56V5Pu4
         q2Pw==
X-Gm-Message-State: APjAAAUDK3EWKFLFdFHNCoF3TUxu3cCHpZ34dsAx3F0gbMpdxeizy5Wz
        /3yxaFlVMN9dEj0qCZr2PZA3NvFIrIwIFw==
X-Google-Smtp-Source: APXvYqzOIOWw0kzVrbeRG43VXpKIHEvcI1vWoC804IQHEo87cpnvAw0fXztuQcHm21/o3caW9/HFqg==
X-Received: by 2002:ac8:1e05:: with SMTP id n5mr75661736qtl.227.1578321873711;
        Mon, 06 Jan 2020 06:44:33 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id y26sm23786787qtc.94.2020.01.06.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 06:44:32 -0800 (PST)
Subject: Re: [PATCH v3 3/3] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1c9b3644-4b77-a7c8-c47d-19743cad7f06@toxicpanda.com>
Date:   Mon, 6 Jan 2020 09:44:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106061343.18772-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/6/20 1:13 AM, Qu Wenruo wrote:
> Although btrfs_calc_avail_data_space() is trying to do an estimation
> on how many data chunks it can allocate, the estimation is far from
> perfect:
> 
> - Metadata over-commit is not considered at all
> - Chunk allocation doesn't take RAID5/6 into consideration
> 
> Although current per-profile available space itself is not able to
> handle metadata over-commit itself, the virtual chunk infrastructure can
> be re-used to address above problems.
> 
> This patch will change btrfs_calc_avail_data_space() to do the following
> things:
> - Do metadata virtual chunk allocation first
>    This is to address the over-commit behavior.
>    If current metadata chunks have enough free space, we can completely
>    skip this step.
> 
> - Allocate data virtual chunks as many as possible
>    Just like what we did in per-profile available space estimation.
>    Here we only need to calculate one profile, since statfs() call is
>    a relative cold path.
> 
> Now statfs() should be able to report near perfect estimation on
> available data space, and can handle RAID5/6 better.
> 
> [BENCHMARK]
> For the performance difference, here is the benchmark:
>   Disk layout:
>   - devid 1:	1G
>   - devid 2:	2G
>   - devid 3:	3G
>   - devid 4:	4G
>   - devid 5:	5G
>   metadata:	RAID1
>   data:		RAID5
> 
>   This layout should be the worst case for RAID5, as it can
>   from 5 disks raid5 to 2 disks raid 5 with unusable space.
> 
>   Then use ftrace to trace the execution time of btrfs_statfs() after
>   allocating 1G data chunk. Both have 12 samples.
> 				avg		std
>   Patched:			17.59 us	7.04
>   WIthout patch (v5.5-rc2):	14.98 us	6.16
> 
> When the fs is cold, there is a small performance for this particular
> case, as we need to do several more iterations to calculate correct
> RAID5 data space.
> But it's still pretty good, and won't block chunk allocator for any
> observable time.
> 
> When the fs is hot, the performance bottleneck is the chunk_mutex, where
> the most common and longest holder would be __btrfs_chunk_alloc().
> In that case, we may sleep much longer as __btrfs_chunk_alloc() can
> trigger IO.
> 
> Since the new implementation is not observable slower than the old one,
> and won't cause meaningful delay for chunk allocator, it should be more
> or less OK.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Sorry I should have been more specific.  Taking the chunk_mutex here means all 
the people running statfs at the same time are going to be serialized.  Can we 
just do what overcommit does and take the already calculated free space instead 
of doing the calculation again?  Thanks,

Josef

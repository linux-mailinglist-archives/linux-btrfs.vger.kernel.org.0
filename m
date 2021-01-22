Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2C13006B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbhAVPIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbhAVPD5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:03:57 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD4C061788
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:03:12 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d85so5349687qkg.5
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bEULd0MKBDbTk70H7ub3+A+aQ5E4jMhqsEiMlpco6Vg=;
        b=O1DoMC+g269qFMIVkQeoIBtWmx33AfhajGHIIwd86ouRUNIfMr+ivC4GhY67mbLfu8
         mlsJwVmfml+4Iuheh88L6DaqxfUWxaYCGfbyxgi5Vj8LQPL4sz60reb/Xl60kfM3D0Cn
         1l/h/gtTVlkmt5pcJyF0QhwioFtDk2Ekn+62bwuWJvcT1D/juiPZxvA0s9SSZLJdf1l9
         OSqRR8frdwom59ozvz9w33iQPo9gogJrRj3yC1MTRoUTpLM+v1IlfOs5291IaF7p7DTP
         pOgiTRVvruwWiswCScXuz7BIPZtCn5uEMXrlQ9jilPL3fyEn81FelW1CS+F96xXqCLpP
         SQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bEULd0MKBDbTk70H7ub3+A+aQ5E4jMhqsEiMlpco6Vg=;
        b=FcLs9n7ospTl799wROF4uzuBQbZgOi/yQiQosgS4sxvnmMKBNDRgtVZ1N7QquYeqgq
         YR/hlolNW/HTkuX3LNvWg0uH9+3qWBBaUyETsRImRcjowGgIuvLE9CV4xY1wUeANnGRi
         bwlxgoCH40HU//ZBHkJ8oueoAhHr0k+40HLweOMcKsKDsWEAxw3jUQBzT3nRAn5xBir6
         g5a0MOdy9xlJ7T/0i3I2w720ZgU6gBD0soyJfmsXCpZ1E3IStegn5vHi/ObXy7ACHL8M
         +zA+z4hYaF4tGkieVFC18HxwjrjWmcqCq9EndRezNOYMpu6Vmf1ZL+KrebhusA4Crygb
         E1Gw==
X-Gm-Message-State: AOAM531STAdgVt9aD1hKTsqoUrjp6ItezkwbAEdqGiQ9H25C72BOjFev
        Krsb3fJRPSwgPmkUQEy1e2IETNb1x6mL5Ymx
X-Google-Smtp-Source: ABdhPJwQMlYNnE17WJTVF5u/3z7MGG42e615zzUrkhsxD1gB5ND9BKv6rhj7q9NviUn6LvcR8hGGYQ==
X-Received: by 2002:a05:620a:a19:: with SMTP id i25mr5171535qka.157.1611327791827;
        Fri, 22 Jan 2021 07:03:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h6sm5697085qtx.39.2021.01.22.07.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:03:09 -0800 (PST)
Subject: Re: [PATCH v13 08/42] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <6764c8d232325868e47ded876af398053e674f50.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f22665c-2f29-6437-25fb-2cea9f5ec733@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:03:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6764c8d232325868e47ded876af398053e674f50.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
> up" the block-device into static sized chunks and fake a conventional zone
> on each of them. The emulated zone size is determined from the size of
> device extent.
> 
> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
> chunk allocator, on regular block devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


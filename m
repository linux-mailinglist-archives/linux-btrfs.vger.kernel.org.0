Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB6300756
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbhAVPaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbhAVP3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:29:50 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400EC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:29:09 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n15so767839qkh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JKLb6o26D9id29c1gopTQO3QeooNIY6URdOUGIbhzQk=;
        b=GL8g5Xvq+ISbAf1o0xoFHkbq2PqPrctJC4eAywiFieJlMFtFiaILZUfjRD7izDX33f
         LlXKP3iU5fRa0k7rtQo/BMNeaxQbPRSGDvlAWiy6v8vD7lG2Nv4jUi3nXTOkvBE35Afy
         SIXsPusm8iKPs9KL6qrlgk/2s7aOJ6LQYZBpJE4sSE8zqWl4fXv3Pl3rOqQMGjPHFBK6
         sf34vaSqTwLbHlKVMcUL3Z/4jCTiGbdD93+ZNLsPlAUnpneS4v2J5Zbo7jwGm0JZVBnb
         PmVZfd6FRC4YGYKUYR019WOkA/Gt5ixDP2LGIod7OMtURTyCMeNN7sbX4tFpSF5pDcwV
         DKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JKLb6o26D9id29c1gopTQO3QeooNIY6URdOUGIbhzQk=;
        b=L7Jp+8kuu8gj2NQ3nqDvcH8U+bh7mp/ByNtkTtn868Zct/5E9492PwGc5j7j41ce4Y
         vEcX32+LttbPRaeYf1dvUF6jQd5TyChHlaxw3kmqo+8JD340o2lzdAYwgxIBukg/NUl3
         WDYsBFH2c8Ln0Q+IuZ+jH232LW/on6GLkk0txWwMnNDNjD3q6kv/zET5z1ux0ZTfBI/i
         v5U14rDwd+Sp4q8sXqaEzUNq1TgLbjecej5IBAFJLd65H/hWqjAlJJJ+K4fvpy6eR6Fg
         /w3y99dQd8uLQ4ugC+rNSZXL496vYtXg7WFam0lk6gFN21lUgxtC1t6u6vJxUpCFc08Q
         n4QA==
X-Gm-Message-State: AOAM530iuj59egTJZoc3kTkVByn7sEHZ2ntdN3+TrqAxGX6vO3fYj6gs
        aHCnbTpA7E5iK27DqmzIQQQGEg==
X-Google-Smtp-Source: ABdhPJzHck4iJHxDMUmLShS9orB26IhKrxxUrp7Dcup5cAvEujhggvAK6h7/USfcVz0Ti3IkOgX7aA==
X-Received: by 2002:a37:6f42:: with SMTP id k63mr770668qkc.291.1611329349174;
        Fri, 22 Jan 2021 07:29:09 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o75sm431299qke.77.2021.01.22.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:29:08 -0800 (PST)
Subject: Re: [PATCH v13 27/42] btrfs: use ZONE_APPEND write for ZONED btrfs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <3ce68f36407d9aa3665c5d5b444382650a6e1967.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9de82784-13d5-cfd6-0763-a3f70266914a@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:29:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3ce68f36407d9aa3665c5d5b444382650a6e1967.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> This commit enables zone append writing for zoned btrfs. When using zone
> append, a bio is issued to the start of a target zone and the device
> decides to place it inside the zone. Upon completion the device reports
> the actual written position back to the host.
> 
> Three parts are necessary to enable zone append in btrfs. First, modify
> the bio to use REQ_OP_ZONE_APPEND in btrfs_submit_bio_hook() and adjust
> the bi_sector to point the beginning of the zone.
> 
> Secondly, records the returned physical address (and disk/partno) to the
> ordered extent in end_bio_extent_writepage() after the bio has been
> completed. We cannot resolve the physical address to the logical address
> because we can neither take locks nor allocate a buffer in this end_bio
> context. So, we need to record the physical address to resolve it later in
> btrfs_finish_ordered_io().
> 
> And finally, rewrites the logical addresses of the extent mapping and
> checksum data according to the physical address (using __btrfs_rmap_block).
> If the returned address matches the originally allocated address, we can
> skip this rewriting process.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

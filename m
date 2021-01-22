Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7513E30072D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbhAVP0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbhAVO6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 09:58:38 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA140C061351
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 06:57:42 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t17so4280248qtq.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqjNm/rdJq2xR1KlR6OKdhT6ng5D/w3SPsNp43RCjgk=;
        b=WURC6quZJSmQAVn1OPFjZp+gDu3Jegt/Hvqx2kTw9+ScioBpDcoop/GBGeVWEpgzgc
         /zcdyqji4bVVe3pDiZzKfAjJQPmgffRqJseWLl+aN+60Ie147SJ/qfw7WdEORGB5diwA
         6eGefWYeMXTuBMIkvpgTBgUjhO0G6amOxWB2kGQZGPRfYPqeWZ4jgCKU9vKm5ivAb/tA
         1AMZMo3ZAxYCN+5JpA4xN6N0szd9Yzdr0bquFuvkaI6m8B5/zCt4/qqESb7aClOZOT4M
         wE5f4XD23wLBDSYFLFWGVuwU4C9zEdspTsJ5XV9D8FErq1N6pL8nAJBbsp5ds7kgQqcL
         5e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oqjNm/rdJq2xR1KlR6OKdhT6ng5D/w3SPsNp43RCjgk=;
        b=LpFieGjKh6JNRcyOB/ZJQOq+26hqCYbzdb8EXG3vHx7gUqoBagVTVcRm+wxREEJcSm
         oZY/UGhkK9KEOXl/weSoNV9HK0j/Ny16Yp+7J3QnhYEV9NpPhyDv6or3WefdsFTj07y4
         A9mvoF6XhksZpo99lmINJz1Hyi54W+ifiPpID+32Wx9Y1wnNIjAL81ZaXT+Rh3UuhFiO
         QPOIQ2z9TMWofJuTx+BGWJUl/jAbc4oMjwxZ4VX6l1ouzX3jPy3fqR5g1r7vJajX9lzo
         WbNUW4D8pm0tzBJzMeAQ6y4SMTxTmWu2YMgnKn+ThzP+WdIZnocCabfq0xKzCaMduOPN
         R5gg==
X-Gm-Message-State: AOAM531pYqLC0oRHPlXbSGNMUX7w7TiEhWa8KkslUgnDqWMJa3p2uLCX
        KurPSQ6nodE3R2LQ3bNOmV/BWnlJzpfrSIg9
X-Google-Smtp-Source: ABdhPJxxo7QbUqDv2b5LcamFR6wTsVSa7z5nXhYD1QnoUheW8ot6nzglJ9H9fLfCXwqjAeg6ugq5TA==
X-Received: by 2002:ac8:6799:: with SMTP id b25mr4599692qtp.100.1611327461954;
        Fri, 22 Jan 2021 06:57:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 23sm4002852qks.71.2021.01.22.06.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:57:41 -0800 (PST)
Subject: Re: [PATCH v13 05/42] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <9caf351d3da77e5b9f781226b2c199b570cccb62.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2830452d-5f5c-3c6d-a588-c8b7c5823461@toxicpanda.com>
Date:   Fri, 22 Jan 2021 09:57:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9caf351d3da77e5b9f781226b2c199b570cccb62.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Since we have no write pointer in conventional zones, we cannot determine
> the allocation offset from it. Instead, we set the allocation offset after
> the highest addressed extent. This is done by reading the extent tree in
> btrfs_load_block_group_zone_info().
> 
> However, this function is called from btrfs_read_block_groups(), so the
> read lock for the tree node can recursively taken.
> 
> To avoid this unsafe locking scenario, release the path before reading the
> extent tree to get the allocation offset.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

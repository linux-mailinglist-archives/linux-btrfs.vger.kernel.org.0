Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29F2F34EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 17:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbhALQBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392538AbhALQBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 11:01:03 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9EC061786
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 08:00:22 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id bd6so1084494qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hm+XQ7cN6+nZBQUgTtPLF8CqJXZZATNvEP8naU0e0lM=;
        b=MfrHxoNX2f+Eq5xBiqzUMeFd83lZN+sBOVRSGgaaXU4ZabvFVSKP82/1S4Mf1/UnUN
         +/n72KFCQJWyltfNiBChOvnIjPfYaF6rOS1zdtxtAN7+dfHoBgGNwIE/sPP5mtZAB8z6
         28ONCslJZC2e5/d+PjkaXxu994VAQAJCteaDM0xucGhCXa5EkfivkbDu5ocqTcB1QsV2
         sKEsy/N0AkQXXJ098VXjRNxwJJ+882EhT9kdM2F52UzGCwQLhWwOG7FI0zhku9obIiqn
         am+SlyO8gv9jNkCv5sLk4zCn+PcYgTSbs557z3Y70woTezY0uX2RhJ+2gKSC5zWBtEGj
         8CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hm+XQ7cN6+nZBQUgTtPLF8CqJXZZATNvEP8naU0e0lM=;
        b=hGrS+JfaNkmPi+g1LUObID/SYAvi4sSEAla4awXdeid6DrRGMYdzZr2kUBtTbJ3qjP
         ncc+rKnAx5k+wYF128yzm8HtaEXwBmk9Iu6chBimKVTGtiL9hZ2x/ACSYJjE2hK4rA8k
         riee/GIIIeyQnAMq6H/TQeoThWD243LA7FlnVRL+vicRft5FQTGs912sYQ55j3YbATon
         rG71LtLiAOZZuhKGgk0HYYjXuocYXT8A1P4XkeebkqrwjRiLEtbnqtHoUsXEK6FYbppQ
         gjry/UKOZeM/o36++2DuFgaTZLcglwZKdZIUHvrTvo8+VrsBFI89WImcs5qe94kMWgld
         dXdQ==
X-Gm-Message-State: AOAM533Inhkzj2XYMSi6dMWACLDTf5SfutmJdj6n0Gkr/FslY+sYLY7t
        4ksjh195vZSEaL+ZLZvajp2+Rg==
X-Google-Smtp-Source: ABdhPJwt8IffmZTXuWI69+4qRHELG5sypJHXeb9ddMqTFSRHTfa0wQDA8IeDqQ6ZweXJHYXkCH/kXQ==
X-Received: by 2002:a0c:fd89:: with SMTP id p9mr101238qvr.8.1610467221998;
        Tue, 12 Jan 2021 08:00:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y17sm1466113qki.48.2021.01.12.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 08:00:19 -0800 (PST)
Subject: Re: [PATCH v11 23/40] btrfs: extend btrfs_rmap_block for specifying a
 device
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <62d40762a5bbcc27377d15ac76e5f5f874acbc1a.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e658df92-cbc6-1a17-2d72-6a21d5104423@toxicpanda.com>
Date:   Tue, 12 Jan 2021 11:00:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <62d40762a5bbcc27377d15ac76e5f5f874acbc1a.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> btrfs_rmap_block currently reverse-maps the physical addresses on all
> devices to the corresponding logical addresses.
> 
> This commit extends the function to match to a specified device. The old
> functionality of querying all devices is left intact by specifying NULL as
> target device.
> 
> We pass block_device instead of btrfs_device to __btrfs_rmap_block. This
> function is intended to reverse-map the result of bio, which only have
> block_device.
> 
> This commit also exports the function for later use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

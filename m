Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1939732B298
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbhCCB6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835350AbhCBTCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 14:02:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE85C061221
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Mar 2021 11:01:00 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d11so14865159qtx.9
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Mar 2021 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tg+d/LRAGTG1IKdq5Ummz9Q9xop/B7Brr9jOYccccKA=;
        b=n6pNUm287vSvGSyr7zvGBfEzlAVYTW2evomGesAJj9yVD9S3k26NRxpuGXe3mjAxm+
         Im43Y3/DXYF29dAXQ6ELxWwOGH+xyMn8bHf3X8YqEI7v5XGuXSMWmYSw4VFnrpIKVC8F
         4qmXKMYk1boECNWIMnj3tRDj2cxkeO243F4uD44uEyUEJfOvohmLAajyNRl86unJc4FU
         8zXtwAcYPxbnfDw2kIT9cCWpSB0gWjQzUN1fAGyNjZQRpiS8ZcxPgF1Ep/5i2BR7Gpwm
         IWE5aohKPuWVVTQ0z+LpmXVftNbaltd6Ym4thCJDsC28mc8H0uvrgZfq/54bI1J+RaEw
         QCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tg+d/LRAGTG1IKdq5Ummz9Q9xop/B7Brr9jOYccccKA=;
        b=I81JEvAkvJUuQf+gNyTKKQCafYyS3uMiErGJ1gKSP7hrg619z9GZUBC4Eb+xyShcpS
         PcGffMTVBInDVwTfewzi7r1XnvewQrUneVzgGhMTQdpse6OQAzZP7MGKm0nItrSmJtsW
         p51JK6/thmT84qK3lJOD+JleSvjq2wjJb5YKSbMcUJQT2ar0n7tY1dUgbw+kk3XPd8A0
         tuYU7cWDb+S3pW0Ezs1Kbq4eCpYhWWlI+JVlNdJN+OInN76qqiTbmmHMpKUH3BAoWzj/
         lYwrWmEidx9PNimK56Xaa6yEjGGRZzWJBjVWTyBeijVxLEqdwKEiA6ALwM9CnoNOp1HS
         w0NA==
X-Gm-Message-State: AOAM533nK5DpXEE6BzmbQ+VfVyA/CK5vN/SDQHuJy2iTQ/vKGQkOiGfM
        WoWXncEAAZpr5Y25RtuV6qtLdg==
X-Google-Smtp-Source: ABdhPJybx4b2Gt14q622BA8N8N+z50TDJQ9SNZUk6Te3jjSzIFqsB1fUftwzJfOfp17OcbLFbUWe2w==
X-Received: by 2002:a05:622a:408:: with SMTP id n8mr19875757qtx.64.1614711659117;
        Tue, 02 Mar 2021 11:00:59 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a14sm12150294qkc.47.2021.03.02.11.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 11:00:58 -0800 (PST)
Subject: Re: [PATCH 1/2] fstests: add missing checks of fallocate feature
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
 <20210302091305.27828-2-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fe0829c9-b719-a155-2404-a43640d8df70@toxicpanda.com>
Date:   Tue, 2 Mar 2021 14:00:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302091305.27828-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/21 4:13 AM, Johannes Thumshirn wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> Many test cases use xfs_io -c 'falloc' but forgot to add
> _require_xfs_io_command "falloc". This will fail the test case if we run
> the test case on a file system without fallcoate support e.g. F2FS ZZ
> 
> While we believe that normal fallocate(mode = 0) is always supported on
> Linux, it is not true. Fallocate is disabled in several implementations of
> zoned block support for file systems because the pre-allocated region will
> break the sequential writing rule.
> 
> Currently, several test cases unconditionally call fallocate(). Let's add
> _require_xfs_io_command "falloc" to properly check the feature is supported
> by a testing file system.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

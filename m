Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24E730066D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbhAVPBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbhAVO7s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 09:59:48 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB081C0613D6
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 06:59:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id q9so5004285qkn.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iw9C/sQSpNgvl1c+JDB0Gphk0cvRbnvt9wkXLD1/GC4=;
        b=AOU/cXOFz91xJQQ2x2Y8ebY7i2sAe3Rme1TiC/Dn9h29Dp8/34YYq+gNafIixJgC47
         4JoRhqbi3DIyZds4PgbASO9YC37vFV1FYF6ghsIYVTt498hqn57/V32EcDm34HcdW5RA
         I+vruX+rGwsy45Fup2TKfhJ6E/eXFU0MG5Veac9ElFc6lV6BaRMmgxKvk0bcIcYWrtce
         EeYYZchhyopchH1mYKyfOP+QcRrR2Z7ReGovrGJzjH7/D9jytw5rJP9MrigYvB29ktgX
         Mn4nmhT5sp9GM1fuzo5vbcSHb0pn9nKw2mHJxkrkZFgp5CJGE+3YMxj67nvuwGZHUCXL
         5kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iw9C/sQSpNgvl1c+JDB0Gphk0cvRbnvt9wkXLD1/GC4=;
        b=UxmY6xrl7AQWrpn8vN8kCOYGOVRzh+AkzXNqh4835/ucxQr/09JDBIG2/yHiCJ7vzF
         5yunJMhrjZoBHorAagLZiGASgfLgXIC+OaFj26V2DLDWGYfYEeyFMNL4MbFWmU2+Ke2f
         /L4q0U+g0ciOADZaojgZLBZmcq3lH1fnrO0UtF9UgkhQUIp7ktAxsURPVz3HYyLDahN6
         ObWWTDwHokBT9h+7n2jferFirxuhZQGDMJRedjzsmrbxvHHVG6Ok4z9ViF9Q8F1GtuWC
         OIcvIrrukV7n8UmYYF1HGn/qSgURU06dgHiRxYpg8jLQaKG6s4e5Urag9sPfvoG/ZDlk
         BDkQ==
X-Gm-Message-State: AOAM530epiOGOX7FdldI1gmCzZyFSnE97YGlRiMI0WaWNSurkopPR3bA
        H+KaEv9juQHwP+uRK8PF6RXYPg==
X-Google-Smtp-Source: ABdhPJzQe2p5/ZusIjtBZwVurrrNb2Te9DsSXSbKqN/6ap3lM178AIl2F4Xj7idSwpYMXeOUc55wgg==
X-Received: by 2002:a05:620a:1206:: with SMTP id u6mr5045726qkj.209.1611327547081;
        Fri, 22 Jan 2021 06:59:07 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s15sm5876033qtn.35.2021.01.22.06.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:59:06 -0800 (PST)
Subject: Re: [PATCH v13 07/42] btrfs: disallow fitrim in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <51f6f258af8d5de433c3437c26a98936a69eea7e.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a66fa1a-034f-8fcd-c726-1cf944316fba@toxicpanda.com>
Date:   Fri, 22 Jan 2021 09:59:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <51f6f258af8d5de433c3437c26a98936a69eea7e.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> The implementation of fitrim is depending on space cache, which is not used
> and disabled for zoned btrfs' extent allocator. So the current code does
> not work with zoned btrfs. In the future, we can implement fitrim for zoned
> btrfs by enabling space cache (but, only for fitrim) or scanning the extent
> tree at fitrim time. But, for now, disallow fitrim in ZONED mode.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

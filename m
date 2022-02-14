Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7160A4B5424
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiBNPEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 10:04:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiBNPEe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 10:04:34 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9794B84F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 07:04:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id p14so15678710qtx.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 07:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tm4Aw/5pOyO8XOtOBk1bsQfa0OvL9Ka+rHjxXZkROI0=;
        b=8PQ7xId5dLlY4oBCP7LmyFimjnW85jRAdwGy5+Z0vezIaxJZuhv25iNIxfXVXd+4p/
         FsTi35lWQ2kCjZ1YBKrvD1JOBXmkEcSvMvRsMivNCt78Lkew1cWv2/n03mry+bDYvggO
         HhGcdmOG04e/woMuzlKf9pRc+Yh/H7KluftzEHUtgnhHDD8xe+LCG4KZOojRYuYt2VZR
         uJ6ioXn/gDQWq5kPBEf3qK9MCYi1BsfsnX4nWW68RUXXbm7Z72JReEqybt9IdUicM+TK
         vVAh3rKu/LPpLtA6Iy2UKNZy7SzgonwxpbgxS7AOxi5dGhdw7cdBrIrAs2KAnp6H2VVe
         tbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tm4Aw/5pOyO8XOtOBk1bsQfa0OvL9Ka+rHjxXZkROI0=;
        b=ZySsxxuM/itLBgxwtXu/hujgdtsD29879Uno5kjh8oaBq2zGGM35w42VIpMguAsTql
         7x42SVzmZhoVXGf4g7B3YTD/Spv389puzU6Vwqx1KtxD5FiHVOT1EFyuTkg3GskszuYi
         OjZsgyZJcWC75prz7yjmPzZ+vGayug0XPF13PIXNa887wmQvPZruaE8L82w9wzJ20j3I
         gYx04KTcEo+K/7njt99OdaB2QQY0ivc/hDS8g7nq1mhO0poD3rbqR04c8HAOGHJ7FseX
         dS0h615U8KF87WDvbiNNrxfC6FhSBovQLM1qyH6C12OUofVOXJX7jgDrhEz2dlk7U4PP
         awKA==
X-Gm-Message-State: AOAM531cAIansN2aI3hT4dOyF6W1upWbd8Gmk3u97SRdxsEsjghBbjUF
        uIfdevM8M5h2o1wpsQdqtGoKqg==
X-Google-Smtp-Source: ABdhPJxIffhBIPqCvAOdfXTD7PV+ccrIiaVOZSZMTSpHz/Ad1vXzjGcO6mXNu/xUvTtLZSC5flR8BQ==
X-Received: by 2002:a05:622a:1105:: with SMTP id e5mr157122qty.190.1644851064721;
        Mon, 14 Feb 2022 07:04:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x21sm3459525qtp.67.2022.02.14.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:04:24 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:04:22 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Message-ID: <Ygpvdjq7ZUc4izbL@localhost.localdomain>
References: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 05:54:02AM -0800, Johannes Thumshirn wrote:
> The current auto-reclaim algorithm starts reclaiming all block-group's
> with a zone_unusable value above a configured threshold. This is causing a
> lot of reclaim IO even if there would be enough free zones on the device.
> 
> Instead of only accounting a block-group's zone_unusable value, also take
> the number of empty zones into account.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> 
> RFC because I'm a bit unsure about the user interface. Should we use the
> same value / sysfs file for both the number of non-empty zones and the
> number of zone_unusable bytes per block_group or add another knob to fine
> tune?
> 

I want per-space_info thresholds, because for us we want to never relocate
metadata block groups and set a threshold for data.

But I think for this we could have a separate threshold of "don't start
auto-relocate until we are below X threshold for the whole file system" and this
could be the fs wide setting.  Does that make sense?  Thanks,

Josef

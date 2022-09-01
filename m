Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0158F5A9EDA
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiIASS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiIASSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 14:18:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856C7B1D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 11:18:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f24so15069764plr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TwtbOwFF+ZiwJoT/CqZldbVVzIhhOz2njGH/aDVkVkA=;
        b=CN47m2TxTAyOOaGsxnrCEjbauhE3jcM9dEBUsSClfUoo2xhwW3Tl7z9gwpZ7iKt/sA
         MRen624Q9mvIaX+cpkc2dMKe+QOtf2TjZ1QHQwJr97OL/gKIFQxEWgaCKqyhv/NMTtVB
         b7/OYRRIsCNH/N1C/HyMSkRd1VkN+ZmE91ttY154i7S9wbvh02Tex/zucXlU5op+sezx
         lqcDpXLCki8Qwk2Nm/Nai7xpbmZum3qDAJoNsyJjaAOy1CFWAqH44n5/QtWPIcuiWvbU
         2UX8NUMrin9MC78s1LXphLPbykMMxfb9TD3NNu7g5+7GYn0kRiHN57wbD8CrlB3EnWlj
         +9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TwtbOwFF+ZiwJoT/CqZldbVVzIhhOz2njGH/aDVkVkA=;
        b=RlJHWmqtZdojxpC8cZ5jMKMCc1gMwKcozn/YKm9NR8S79KWyKkAcV7l2D9UHbCTA5F
         WxrdOGpzhvmys0yTG3YNCjlEiOFlvbfYX430LXQMHVs4nOSn6auy7xkHhyTx1MN+B3XA
         gbTiw+MbzegjzpmvMaYb7ftILGv4A1yBz65lDPpmqZxMl1SOOVqblLPFVHV84CJN8zgS
         UN8Pm79+hdMKsEuY6qp/0MWxOq1QJe2rJWA+HPgehE4FmYPinAmns6M/QmRnNesbXvWJ
         HxC1oplbpl7Jf+z726NOVJ3WHc4qR02p7uoVBZyGSjmLAqJAYMo286nFjqkDazom/vye
         1qfQ==
X-Gm-Message-State: ACgBeo0EiAKuNjL8QqOus68XoMKcwMw+VouffN3wUfbFlpBwFWwMWF/C
        BUmLCbykAqZ7PtXtw4ixQGRWgT9YGteUbw==
X-Google-Smtp-Source: AA6agR5UKL72FL9RZGPJjr/P0wU72/eZsMVy1QT/on23nu7/m5YIbKbtTvVG6oBkppDhJYwmINxz7Q==
X-Received: by 2002:a17:902:7481:b0:173:cfae:a7f0 with SMTP id h1-20020a170902748100b00173cfaea7f0mr31349047pll.27.1662056331079;
        Thu, 01 Sep 2022 11:18:51 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::594d])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001754571a093sm3947636plf.122.2022.09.01.11.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:18:50 -0700 (PDT)
Date:   Thu, 1 Sep 2022 11:18:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <YxD3iM29bDpnxeNg@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
 <Yv2A+Du6J7BWWWih@relinquished.localdomain>
 <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
 <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
 <467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org>
 <751cc484a56fc0bbe3838929feae3c214c297001.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751cc484a56fc0bbe3838929feae3c214c297001.camel@scientia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 06:59:05PM +0200, Christoph Anton Mitterer wrote:
> Hey.
> 
> Now that the first stable kernel with the fix is out,... is there going
> to be any more information on how people can asses the impact of this
> issue on their data integrity?
> 
> I had asked some questions below, but I guess for me, personally, it
> would also be okay to just recreate the potentially affected
> filesystems from backups, if it cannot be determined for sure whether
> any corruptions have happened (especially in both data or metadata).
> 
> 
> Also anything expectations on when the announced tool for this might
> become available?
> 
> Thanks,
> Chris.

The tool is here for now:
https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_check_space_cache.c

Please try it out with:

git clone https://github.com/osandov/osandov-linux.git
cd osandov-linux/scripts
make btrfs_check_space_cache
sudo ./btrfs_check_space_cache $MOUNTED_FILESYSTEM_PATH

It'll print out a diagnosis and some advice. Please let me know what
output it gives you and any suggestions you have.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7AC602E5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJROYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJROYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:24:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72D9AFA1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:24:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c23so9705788qtw.8
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RuI8Mw/xM66CqA+E7rElorVWsByEoL+POjcwKDGx9Q=;
        b=0HFK2elLajouR77LD/kXbzgXsl5sejXhjXBVstYAi7ossW/mDmP6hRpPh0nKW3YPxM
         v2QqssICOf+C2jaT3kwSiU4SuDvYsGWsHL+zASYjxEsZWyYcB0VX1YoSkcs8fiRrO1oX
         K3BGRWN46jN9P9ZryoB9S6+JKbdV+wNTgr9M7rPzbZczy8V/WuCv2BuLBemw5jKMAPZt
         Ftkq9V1jZTbtM2h8ku8IAY2Zyx/gaoe1llmFHm8soHFZTeRKJCiy6KRc1LJHRqlCierT
         pvYPwcBjPxYYn4wfl+HDuuXf0zKJNqCvW4WqVzXLoHgKRCY8ydFUD4ETLyXu8COibjxS
         Zj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RuI8Mw/xM66CqA+E7rElorVWsByEoL+POjcwKDGx9Q=;
        b=6P+txGU7mu/ENNFUnlP1DRxjDCfZ8QO57jnc0omdCgr+8wmDOsWgcCAkQR1vtk58wd
         IX1hn0aaTHUasiIv3Rzo16b33hwN+LKyeRp/eu85Xi2HtP8NVkGWT2WTALsiv8z76Om1
         d/Tn1iMxTLB6ra2QPqM3/Mv0Q74FCGnYlbafLX2RC/4KbZPg9hJMU19yPoHoR35VPvLt
         8wuPYnHx+LHKZwWWTc6DiZH7pWE7FYdfRg+GVYxJBz60slCTtx4QsKGQa3uEukoNh6XT
         TC8lyDV9ev+MWgwQ7PTBKHbdj0QI45TUTXmDKNPLn5rLiUEu7Ia/UGZ/Ax+MyjPwUnu+
         q1TA==
X-Gm-Message-State: ACrzQf1spZP+79fbiZ0wawjPEyP7WiB0sJ86SSYb6az95xGtEB8LrKcx
        DnBZvCsIlXnVcd6Z5jWsok1ff2g7FGTSgQ==
X-Google-Smtp-Source: AMsMyM5OgRVGm37V41l9buaDYSfF14XK4qHDTG6ZKkxChQYrFWYlCGI+gvrjkRDKpCLfkxhCYDjfCA==
X-Received: by 2002:ac8:5fc6:0:b0:39c:8993:88f1 with SMTP id k6-20020ac85fc6000000b0039c899388f1mr2357115qta.24.1666103042994;
        Tue, 18 Oct 2022 07:24:02 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ff13-20020a05622a4d8d00b00397e97baa96sm2096452qtb.0.2022.10.18.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:24:02 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:24:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: convert remaining scnprintf to sysfs_emit
Message-ID: <Y063AZr08/1EbDuK@localhost.localdomain>
References: <20221018125349.31879-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018125349.31879-1-dsterba@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 02:53:49PM +0200, David Sterba wrote:
> The sysfs_emit is the safe API for writing to the sysfs files,
> previously converted from scnprintf, there's one left to do in
> btrfs_read_policy_show.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by; Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

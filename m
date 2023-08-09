Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD0776074
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHINSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjHINS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 09:18:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9F1B6
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 06:18:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-586a684e85aso58397407b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Aug 2023 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691587106; x=1692191906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvYWtg7Du58ionaaWICXF2GnJJ0l6//mulpiAyQw8nA=;
        b=expb73sVTlWt18S34f5W9ZKnEBC5GAdH2dwrdVmRsEs1f27m7TMq9Tz6tuTWGBtvwG
         ljVHja0PFA3yg6GuDUTaQa4d0r1wakJ6pT094sIR6Ic5XilILw4egUg2qGDAbJ9l13xS
         76cw3U0I8P5HyJJ8H9+DXjwQHgMgZfZJV/Q1tv+UBHYamaRvOFWitwhcIs/n0Qe45a1m
         KXzBE/yYoUczJpQaEqIEOPZXVF1iHz6gp4Zi1dYmxGm+QoeeMLUjbeWABkvbSvWEonJZ
         d//5ANlyHk7vHzMHssvx2du/sI6IlM6ROC8paeFdDFAchiaJpw45Jz7shGP3Fz9ea4mb
         VI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587106; x=1692191906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvYWtg7Du58ionaaWICXF2GnJJ0l6//mulpiAyQw8nA=;
        b=X7KB+hx6lJ86KRaruUrtk4RJBmR1Y9tN6Uo/SXkatm6ybDcs+PSDPvwbrGEJHvhLaj
         S7on+k3rHgVBntBCTN7SLrnR5fLdIxe9YguhI07pXLWw+9O5Qc1I4QQg8VNFABinQf45
         VDNx+Q1faeX9MKhAXWPrO5xM2Z8zIpA6aEHThCNbYoalyBH6r82Lw3nxrA5Iuycc8RrJ
         x9k38JJAwwprh/nNTAwt5RKBQX7NWH2v4NxbOUBM2/Ib4UnmGGZrTcKKHSmN3eNB8isV
         V/Ykdc/bCdttXcjB8NBzULZZj85kMBwlmI0+cu20msGpsxIteZNiiFiSqDxXXJ0NWpVd
         Cdkg==
X-Gm-Message-State: AOJu0YzIY0OBSk0KUU7u+/978mSnHnbEU+TsRuvqkx/Ip9j+BIEdJA6r
        Sa6yLFcU0q/eMcLKOdfF30UPa6L9EtARGptWw8X/6A==
X-Google-Smtp-Source: AGHT+IFJU3wJoPvsF6pdZ+2gYvbHRQkuo1qgI+2TzWB/0psj0g/CffsnwmwxA+uzr3aJBKnCIswXYg==
X-Received: by 2002:a0d:d88b:0:b0:577:228f:467f with SMTP id a133-20020a0dd88b000000b00577228f467fmr2582813ywe.36.1691587106206;
        Wed, 09 Aug 2023 06:18:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e16-20020a0ce3d0000000b0063642bcc5e4sm4391511qvl.9.2023.08.09.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:18:25 -0700 (PDT)
Date:   Wed, 9 Aug 2023 09:18:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/misc/030: do not require v1 cache for
 the test case
Message-ID: <20230809131825.GD2515439@perftesting>
References: <c56a81542acc3319265ed1041640253d2b4b8276.1691474892.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56a81542acc3319265ed1041640253d2b4b8276.1691474892.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 02:08:42PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> Since we have migrated to default v2 cache, the test case
> misc/030-missing-device-image is no longer executed:
> 
>     [TEST/misc]   030-missing-device-image
>     [NOTRUN] unable to create v1 space cache
> 
> [CAUSE]
> The test case itself is trying its best to cover all paths, including
> the data extent read path.
> 
> Thus the test case is requiring v1 cache, as that's the only way to
> cover the data read path.
> 
> [FIX]
> Just remove the v1 space cache requirement, it's still better to run the
> test even it only exercises the metadata read path.
> 
> The good news is, after commit 3ff9d352576b ("btrfs-progs: use
> read_data_from_disk() to replace read_extent_from_disk() and replace
> read_extent_data()"), all data/metadata read paths are unified.
> They only differ in the verification part.
> 
> Thus even if we didn't fully exercise the data read path, we didn't lose
> much coverage anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

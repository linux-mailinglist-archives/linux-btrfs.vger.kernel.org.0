Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149A63AD33
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiK1QDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiK1QDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:03:11 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03389637B
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:03:11 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g10so7558647qkl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=menkDLFTK0ucehS7YUSqDx7q0Zc1/XhysGCjN3/Cgds=;
        b=vDwdH37/bVP2DKYQVvvp7f0ZEt/89cChNNSrOSioM7LU4HaF9oTUh4qYTWwKBWAxyu
         rn08kOmHR2SDfmCi6jmeUkyANAItF38qyiFqehslm4380CCLLtOFNnTOO4ONLGmwPw3V
         BZEFsL03oVuvZu4omaWouk9sNydlH59XYf7Rbi7kWANmQ6im/Lr72+xRaYs7e3ONVR2T
         Fkvw/Lv6S6f5ehSuViIl30oqgmm/sLJsw4vLLYpYzn+gdxHS+XDM0H5MqKed0U9h1WkQ
         Huoobe1f2WJZSPILcjQXFOxhSbMC6Ox4Q58msydjnCTax96i+9tg+U1fmGZ7necjFgb8
         nhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=menkDLFTK0ucehS7YUSqDx7q0Zc1/XhysGCjN3/Cgds=;
        b=FkZ9IMudegIh7dOKmNdVSD/vaMCpCcxD+8+iNYA7jmTMksQRKctKLPSxq+SebjIrRL
         bourKll0qaxtwK8+5aEXimjY9irQGVY/aFkvREP9iomUH01/wFOIyENhNZVlP7ZxhcjO
         U/UQ0q1j8OkIdyUo2UfZ7XpBAVWI+Y4Md6fDIFOcfZFKbprRGoCkAI8voqrYVJKHHTh6
         ALR9pSl6ThlGPsFfa06Sp9+2lLoh04P/K8VNO2MwuRpSDfze430IKq+2dQ+zftESmbtP
         a4aUERii+VXVF0MCtOjbB4atW5/eoD1wWMhrxR5advF4HB7PBSAX8pMeet8SolA2BIZa
         zvSA==
X-Gm-Message-State: ANoB5pkVLYaXAWIEeWS97E1wnRjs7xcwFYRdN0s20m36j/2C5RZgY/E3
        6uVH9WR/wKV36GFjIo3Xv/gDZQ==
X-Google-Smtp-Source: AA0mqf4dMJmokOLhQEcXE69ImmSdhVnsKgVgdDNuyJDW+oh4VXWIqieB3SxbCCr+boRU8hdUiB0O8g==
X-Received: by 2002:a37:ad0a:0:b0:6fa:2c9a:ae20 with SMTP id f10-20020a37ad0a000000b006fa2c9aae20mr33658449qkm.582.1669651389359;
        Mon, 28 Nov 2022 08:03:09 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05622a228e00b003a51e6b6c95sm7066401qtb.14.2022.11.28.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:03:08 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:03:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: skip btrfs/254 in case MIN_FSSIZE is more than
 1G
Message-ID: <Y4Tbu6YMaiN03Bi6@localhost.localdomain>
References: <20221128125105.52458-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128125105.52458-1-johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 04:51:05AM -0800, Johannes Thumshirn wrote:
> The test-case btrfs/254 creates a 1G device-mapper setup, but this might
> be too small for the filesystem to actually operate (i.e. in case of a
> zoned block device which needs at least 5 zones).
> 
> Skip the test if MIN_FSSIZE is set to a value above 1G.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

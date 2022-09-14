Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134FC5B82E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiINI2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINI2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 04:28:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699376555F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 01:28:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j13so2582271ljh.4
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YvDhMlTShC8ws7tffJOmzuTsobim/Yph/Xv8npXkKII=;
        b=DkdoCre1ANybR/sysnCRY362lrKRv+KQk6OlQnvFt66CDc7KYeevzl1Dgtv1ApbrQP
         7xxzxEJm54f1bVsfZPesjc9XaLPVKWTImcbvWPUaImUZcUrRtut5fbkeoI6HSi7gg9e/
         JlMyZ4LF6n4zp84m0q/n0gH/SdJRX8L8Bt2wIb9H1td/B//rVbMEgnIG6prHsVukD/34
         J7nheOVCVY02lS06elDiw4lo2L2Oj3/p+d2pOfubQgpwp2RfIGis5YnTiUO7ORH8Bz5h
         raTBzsOPaZqVeUxf+o0OjuxchUPJPB5u8cC8XCChNaa/nNTrODPzPU6IlwYVIG5d5jcI
         vAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YvDhMlTShC8ws7tffJOmzuTsobim/Yph/Xv8npXkKII=;
        b=elk3Ic2WkjBTHjzFG7ed5w6wkS8MFjWQRNBIapB0DcLFV8ZA3l/I0ZAmkJ+96POu3f
         evpD4yTpz7b1Tjc2H466BjqhA6pz5TMAYi5zHLSybyXGEdRo1cY/LMkfh9ECkES6Dg8r
         GeAWf7Vjc2lAMFlSf7ShDEUB2MXDe4wosmSJQX6gxElmoTqJNDdwcbBSiOT6c20n9BLG
         Tbxm1CgIFNy9FWc71SpKGNv7MVzZCmNf7ZkNSaWFgJ6pzfyTL0J/hqGvKKhQ3MPGhaYZ
         ds5J8Ojxmms/T/mWzep6NDvjn/+CJsODE+wGgTrPAO8VThQd/Q/+r5bAfUVnRy5zCmod
         15aA==
X-Gm-Message-State: ACgBeo1VbJwOvy2wgBZHdbhyZ7nyPv/3lYURwvtZU+XsHSSA9clMEUxx
        Rb6R5Kz9jhnOlwwdte8wheensIM98jA=
X-Google-Smtp-Source: AA6agR6pPhMjcENcmrTFLkAMMI3lafIm+mVMmGlHeKUFOm4hngMpKPiUG3dZ0AYfM5+AIcKyCkb1EA==
X-Received: by 2002:a05:651c:88b:b0:261:ba8e:717a with SMTP id d11-20020a05651c088b00b00261ba8e717amr10186975ljq.401.1663144123677;
        Wed, 14 Sep 2022 01:28:43 -0700 (PDT)
Received: from localhost (87-49-146-244-mobile.dk.customer.tdc.net. [87.49.146.244])
        by smtp.gmail.com with ESMTPSA id c37-20020a05651223a500b0048b3926351bsm2275169lfv.56.2022.09.14.01.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 01:28:42 -0700 (PDT)
Date:   Wed, 14 Sep 2022 10:28:40 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dsterba@suse.com, johannes.thumshirn@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org, damien.lemoal@wdc.com,
        p.raghav@samsung.com
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: fix error message for minimum
 zoned filesystem size
Message-ID: <20220914082840.ix2x35fdvrlycggw@quentin>
References: <20220909214810.761928-1-mcgrof@kernel.org>
 <20220909214810.761928-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909214810.761928-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> With this now the user sees:
> 
> ERROR: Size 512.00MiB is too small to make a usable filesystem.
> ERROR: The minimum size for a zoned btrfs filesystem requires
> ERROR: 5 dedicated zones. This device's zone size is 128.00MiB so
> ERROR: the minimum size for a btrfs filesystem for this zoned
> ERROR: storage device (/dev/nvme5n1) is 640.00MiB
> 
> The following fstests fail because of this issue, and at first glance
> it was not clear why:
> 
>   * brfs/132
>   * generic/226
>   * generic/416
>   * generic/650
> 
> Now it's clear what the issue is and what needs to get done to
> fix those respective tests. But note, that if working on a sequential
> zone then parallel writes are expected to fail, so tests which require
> that and use parallel writes must also check for sequential zones
> and bail if one is to be used. Each of these tests needs to be adapted
> a bit for zoned devices to work properly.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

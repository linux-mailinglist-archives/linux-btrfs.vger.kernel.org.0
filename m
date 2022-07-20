Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB657B844
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiGTOOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiGTOOA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:14:00 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5E4D16B
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:13:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y9so10036697qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2paShj/WbCID2vVVBGSDwJweFW9y6tZT6y1FyYfDR78=;
        b=pnRZdg0o/aDh+EtWwCpkGiL7AOC/jK+KYRWd1+UcNYrR7mUvNFbCksK3TWzkAVXiZ1
         ZSAS83huODYKeyQw31IIZKB6IH9vk+dM7Vcbczi7QTVFb7lBLJ0I75wjucCfJREMRJcA
         0tWWivQY39JdoEcKDH7ulZxAYpo98iUBm7uxcTlgz6wKCoWho7a9jUXo2iclLpqCcPU4
         0ECRJXQ1nArcHpuiMX7f4KKvla7AhhmdgWVzhmfFOmaYZWSXO3YbbWbNOGinYUALIft1
         Q4+QTCTut8nDIzETy+hxpvl2IFil14U/Ip79i9AJnhIuCLcuxRa7olu3JZ+CXVAOiIUt
         HEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2paShj/WbCID2vVVBGSDwJweFW9y6tZT6y1FyYfDR78=;
        b=VRtNpPwINbmzo7EKbKlk6B5D3LzTXzwJEst5OefFI8LYOd+hj9P4ENvN0MresfWqAZ
         vUySLmA/juQoeQp3x6yf1vi5Cpk+VEShKRGfXdIoKX7ivCliVMX/YG1D2cEh2tCX7+4V
         Mw0bs4Bys2OZbryPKCjRU5J+dGTDob/oLb7sIEkwc8oqvb9UGP7umqQd0XWYh9ZbE3Un
         7Osc4u2L9EcM9pH3Es3bFgl2XLMuV/x9jdzGc/afLfBj+xUHuu2pxe9XykjKPXDxgWC5
         2ODF/93gJXLdIdAPp4lKDUefTy4VWhRaGIRqKgVYH37+6W8NnNhrxQD5/DaKdUaXypNW
         FGvg==
X-Gm-Message-State: AJIora+p/9PFanuPVKnM8LDPW7KhulK3ZD+fL+V5Pv9OI/FwzFQfSOsz
        laE13cCCnX6Nkzabkt91qB1vAw==
X-Google-Smtp-Source: AGRyM1tr7DPMNFgBzMX6CveG8RFSQi0ZOUGnW9e7h+aVWfeZzv5Zphsp0FHq50T8/XQrrFIYvuDh/Q==
X-Received: by 2002:ac8:5b0e:0:b0:31d:3b3d:37cd with SMTP id m14-20020ac85b0e000000b0031d3b3d37cdmr29680008qtw.657.1658326438269;
        Wed, 20 Jul 2022 07:13:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006b5fe4c333fsm4174482qkb.85.2022.07.20.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:13:57 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:13:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 0/5] tests for btrfs fsverity
Message-ID: <YtgNpAa8qu4LOSyP@localhost.localdomain>
References: <cover.1658277755.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658277755.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 05:49:45PM -0700, Boris Burkov wrote:
> This patchset provides tests for fsverity support in btrfs.
> 
> It includes modifications for generic tests to pass with btrfs as well
> as new tests.
>

These ran fine on our overnight CI testing, the patches look good as well, you
can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 

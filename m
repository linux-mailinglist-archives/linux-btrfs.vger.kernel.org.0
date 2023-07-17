Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256A756833
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGQPm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGQPm0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 11:42:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB3103
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 08:42:26 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a1ebb79579so3288313b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689608545; x=1692200545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDt/hVc/W0X2pOY2Tf4gYKPPLK2ayn9fWvhQtq9sAj8=;
        b=y5vjsz7nYXnUVg6gDBkQPzJCIQ6l12I24XawuCjOc3L++iMrIvIC1BVuGXMMLrgwsY
         DDqn0mSC3ih86ULu51oRyQqi+z6BKCFm54ax9qBmdQmVp1KKtFP6FFU/MQ++KUNhelGL
         4otjHF9cscZ8Y/FML/nQWKRg+ph2ZDIR/VswXHguAdVkJK3SD71aY0CzZKfFg841+8mw
         C6KCYid7QosQFhNFwzi50fkJPZFfxaftCq2ddqDvk1ulI4zdr87ub0acqVJzl8CSu61G
         tv7px86J39J+XO5A8AaqUKH8cKFIMs5pE/r4VwStH0D3vm010ed5N1VKo3eRZp2nbWqE
         0W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608545; x=1692200545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDt/hVc/W0X2pOY2Tf4gYKPPLK2ayn9fWvhQtq9sAj8=;
        b=i4tcI2Fxs+Fi+lQXcYv1zVNnB7fsLCLJ2uj5jTpHuCWEydBHI/cS5Z0/UsLz86WiGU
         dN0bTYSU+N1mA3CvHInULjJN79AGU+dRAC6DiwIjY1rPuBaTrk+c0cWTMOnZNE9KYzFY
         ZXdvOmAkezhEl+MYRXfoWorUex1bJNt/nd39CPR88eJ/caz475RLK7vVLFsn9OZkaF6E
         gFb53A+jXUKmx1L41ykTTXW2hRNS/BBrURojbbF4luyBgC/rRAAZ7aDHePLj4wckQTqm
         638wdIUq1slb4hDa4lr8QHj8HAUagOLnrpzNk5Bem0LfuGCdZNIND+4T0u1eY9mTxHaX
         vy/Q==
X-Gm-Message-State: ABy/qLasPuOGDaOgfqt/7EaFpybg/3Pd6nsSlq58R17WanOQvXEktzOZ
        U92z2PAujNAcwSB3Uwy9IOobkA==
X-Google-Smtp-Source: APBJJlGK0B55W4UA0m64TItmvnraAvV6oTYi6dAJM7hALVw0X9V2d13UvBLH1RIOFksmGX/JvOZtxg==
X-Received: by 2002:a05:6808:150a:b0:3a3:6382:b67d with SMTP id u10-20020a056808150a00b003a36382b67dmr12794472oiw.41.1689608545465;
        Mon, 17 Jul 2023 08:42:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cf04a000000b0063c79938606sm2608590qvl.120.2023.07.17.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:42:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:42:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 06/17] btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
Message-ID: <20230717154224.GJ691303@perftesting>
References: <cover.1689564024.git.sweettea-kernel@dorminy.me>
 <ef50913d0c3f9050dc368f99077724243735117a.1689564024.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef50913d0c3f9050dc368f99077724243735117a.1689564024.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 16, 2023 at 11:52:37PM -0400, Sweet Tea Dorminy wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> As encrypted files will be incompatible with older filesystem versions,
> new filesystems should be created with an incompat flag for fscrypt,
> which will gate access to the encryption ioctls.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Make sure to also update the supported features sysfs file.  Thanks,

Josef

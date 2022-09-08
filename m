Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC635B276F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIHUHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIHUHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 16:07:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A038FE48C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 13:07:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id v15so11368658qvi.11
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lsX+edKaCJv0bv9Gi1YPYrrsj1bXz3dus8J7NnC400E=;
        b=yHhwQqFRhIiXrs4AxYnSKjYzcB/kXOnFGVqA+hYupNVVg93BZcZcsNnZLZiH4BU+Z+
         gp4NFq+buhyGCiGR/R38LbIq+rRsAWjZPebORtc7Dqg7hN8bqciBKJT1mxvQM1KxSqsZ
         HIrUICiFtN6EEjVivhLifD/Xko+5onerwgfEyMQ8IOpdXyQP0o2qhkDUHiuQz1PJzMpg
         hIIn5BuMw5eIlKWDQJfRorLsrs/YLXSt3Rm8IHm2JAJrf/MQgMUfZHJA+VdzZ8mLuhHO
         5TuxeVwGkhE1O4125aUBLuYP0+c2Fdgsd6AeEciG3kpm/Y1WLnamUsBhc5ZVLdIX6pf6
         Ngfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lsX+edKaCJv0bv9Gi1YPYrrsj1bXz3dus8J7NnC400E=;
        b=KdCg7aislDqL7KtAvTw2sLWkgoSe6coorvn5vP5GdQIWFfnDF4Rupr/ODUc3dRb/tB
         yemU7KjtJyyQJS5iFJpZYmllwYp8fYYcoTfxNRuwnKobHEH5y2QS/Vd0sb3Ft3Manp5D
         EdgUPxV6iJhYhmSjqw1UwKPhkkFdzBiYT2+aI9+J1wj3thvMjt8Q23mxyyV5Hy/QcbwF
         PXza2e6Z8euhaAwLZ22CxCVv0uKodV8+55noKmsFs62sbJyqCqkDIvpEJD7lEqtEU4+F
         wijybd2TIpdxizvV1mF92UyT2nbjH6Fwww9WboBNmri/blmXciXffA7jHHCjkS8l9omQ
         ScBw==
X-Gm-Message-State: ACgBeo1/Qq/iJkOaiuQfJ2t1L4m7oFszbs62fEta2kzsARYHtratzCrW
        adUw8oBN73HHaoN1VAkwVADCOw==
X-Google-Smtp-Source: AA6agR4ku9Bm1pBKZsLD7ITapxdpfeyk8vfno7PcsAtgJDp1qW1qaxOi4Nb5M+NgifhlR3tLGAjzsA==
X-Received: by 2002:a05:6214:27c3:b0:498:f448:f7fa with SMTP id ge3-20020a05621427c300b00498f448f7famr8927751qvb.18.1662667655095;
        Thu, 08 Sep 2022 13:07:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b006b942f4ffe3sm18693476qkp.18.2022.09.08.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:07:34 -0700 (PDT)
Date:   Thu, 8 Sep 2022 16:07:33 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 14/20] btrfs: translate btrfs encryption flags and
 encrypted inode flag.
Message-ID: <YxpLhXJEosG/+Orq@localhost.localdomain>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
 <d0cc8d176673ffd5d63587ff2340a969ea0c8d72.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0cc8d176673ffd5d63587ff2340a969ea0c8d72.1662420176.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:29PM -0400, Sweet Tea Dorminy wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> In btrfs, a file can be encrypted either if its directory is encrypted
> or its root subvolume is encrypted, so translate both to the standard
> flags.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

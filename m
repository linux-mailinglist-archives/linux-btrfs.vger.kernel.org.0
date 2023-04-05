Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6F6D82E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbjDEQFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjDEQFS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 12:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7C5583
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
        b=WZQDHh+of/UYNZ2stDGY9PzROsTjfchHFxGKS5F1+FlDvGBU9IXS5pBpRk9ozdWxSlwwmX
        TteqVqcNE+f5rCMnquCTtvjXuolTGWtyMInBbiCBByk28kx9bAYWk9WMffQrfKlrz5FJyn
        RKiBK6G2l+U0Sen6jfOFJRi15JdcUs8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-IjCZymf8NziKaYK-uiQMmA-1; Wed, 05 Apr 2023 12:04:20 -0400
X-MC-Unique: IjCZymf8NziKaYK-uiQMmA-1
Received: by mail-qt1-f200.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso12709998qtk.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 09:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezrY1MpbuGn54W85nscQkQabj0tChDh4QyAKrhiN160=;
        b=6pcMpbi4NbWw97u5/rJY+fryDYefwgJVZ3sHgRQBOixef4Wv10qIgQu2oI6UbBWGTN
         zBJl/VqEKVT83o7Z/sHeMo5BIrIYCcoyvwJy6BC4WrbR2vdvcy68oifD+JYdHTfdh4MZ
         Y2qdjTj9ls2YKVD4Of86PowT6t7zKw9QEaeAK9Mb2H0iucrxzBGwBxglVGuShVLDdp+L
         v4gpOBsjcUsfScdcGKN69peJxuFddm6K0g2jJpTV0Z5rIre0GV3/o9KHSWYWOMO4yh0j
         gN68bDRAErO1g1aiDE8mxohYZXNVVpnURQwLN1pqVeBPjFgzTtfj6QIhooTp1EmgaN/C
         NQjA==
X-Gm-Message-State: AAQBX9ds34lBVyWnEd+awh0gb+XWbkR42frErr8Calhc7oYrGlvYl3Ei
        mGqEmHjOIIjQf2q+jyi4hEAU1LlUwt1XdBeISwk8/m2DF+uhhWTmAoQ6+A0+zEqDmsirZ0nbZ6V
        QH/V2XYXERCvEXQK4KVT9Ag==
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7038050qtw.46.1680710659555;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350a5lKksulKGDz1s6x8IlpR6R6JUlCw8aCDbcTRwKrjAxeI/G0vqKKfr43MPgy1YnBz9zPAfFA==
X-Received: by 2002:a05:622a:4b:b0:3d8:8d4b:c7cc with SMTP id y11-20020a05622a004b00b003d88d4bc7ccmr7037982qtw.46.1680710659193;
        Wed, 05 Apr 2023 09:04:19 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b9-20020ac84f09000000b003e398d00fabsm4083588qte.85.2023.04.05.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:04:18 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:04:13 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     djwong@kernel.org, dchinner@redhat.com, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230405160413.7o7tljszm56e73a6@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404233713.GF1893@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404233713.GF1893@sol.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 04:37:13PM -0700, Eric Biggers wrote:
> On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> > The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> > xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> 
> Just to double check, did you verify that the tests in the "verity" group are
> running, and were not skipped?

Yes, the linked xfstests in cover-letter has patch enabling xfs
(xfsprogs also needed).
> 
> - Eric
> 

-- 
- Andrey


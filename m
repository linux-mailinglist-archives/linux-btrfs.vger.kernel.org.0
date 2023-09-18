Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4487A4051
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 07:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjIRFJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 01:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjIRFJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 01:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7611F
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695013724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wE0CywnquWaBq0zaTmTYPgZ24xPdhCEo6wZjfP895Uw=;
        b=aDeSC2tm2REIiSPWzfozjRYFQnFydle0tHN5TYKQp3ZYpyKLOaoc6l8FGKTS6a+xKPizsW
        aoGctFm4QE83LiDYOhaHzmxCaDl02kNMl7QIGQ4dGJJpOWKO+Y1paiWeKNpYv9YyWnRfv9
        3z3E5zfMyFyQUv03qbZymgSwkYcJCg0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-rgxYVT7iN2aFhot8X-Uidg-1; Mon, 18 Sep 2023 01:08:43 -0400
X-MC-Unique: rgxYVT7iN2aFhot8X-Uidg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bf39e73558so43939495ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 22:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013722; x=1695618522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE0CywnquWaBq0zaTmTYPgZ24xPdhCEo6wZjfP895Uw=;
        b=jfgByXqRgWo3kjpwvMxE7viddCoVcLIOKHFhJv62WEIE0RkCtYu4SkC9+WHE2GF2MH
         uQN0pgLrzarES8hcib6KDStcfXswlhkrtCtaDOO0weqfzLRfzM9xSbAUHOgXcUQPObpZ
         UGdZ68RWlDTP3eqAB0fBiK1h2vUwY6gG6QeWw+51HyuXLbxIm9APnBJ9cYtOUX4ozUFF
         Z6edj9aTPYHF7kGryU6mEB0pEPXQH0kOAaxacjt+RI4/CcNi7uEnd9SidXD+uCTkzcOY
         ylx4W0a1ddEUaWiGghWNXXi2BGoh+5sRwMiIhW0WqOsEw3bPDWc8stzWpPYMEMXIKis3
         m/cg==
X-Gm-Message-State: AOJu0YwU23IST0ycLd8+0vW1ycz0FB9nA20G7+spY3iNivvZN/HFkudp
        L+a3W+7Cx0LwKHvK3EqvLr7bmqnYg47f/YtTcBaPiGtnd7BRweKPceFyM0k5pUTOWmmJivdma/9
        b4Q22jqe9oQ7cib5wCMVV5ZE=
X-Received: by 2002:a17:902:e84a:b0:1c2:584:51c8 with SMTP id t10-20020a170902e84a00b001c2058451c8mr10492190plg.12.1695013722239;
        Sun, 17 Sep 2023 22:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQPxmn6qr/2wcLlsf006I+v7+RmF1IOWYxpBApYLYGqyXj3QTwT+0gO1cu4RI5J7TT2lC2A==
X-Received: by 2002:a17:902:e84a:b0:1c2:584:51c8 with SMTP id t10-20020a170902e84a00b001c2058451c8mr10492179plg.12.1695013721955;
        Sun, 17 Sep 2023 22:08:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001bde6fa0a39sm7475949plb.167.2023.09.17.22.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:08:41 -0700 (PDT)
Date:   Mon, 18 Sep 2023 13:08:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     zlang@kernel.org, fstests@vger.kernel.org,
        Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2023.09.03
Message-ID: <20230918050838.k4uwskcplrxaljc4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <2a2f6e34-980b-2c11-bb07-95e0222f3140@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2f6e34-980b-2c11-bb07-95e0222f3140@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 17, 2023 at 10:16:08PM +0800, Anand Jain wrote:
> 
> These four patches are ready to be included in your for-next branch. I've
> consolidated them here for your git pull.
> 
> Thanks, Anand
> 
> 
> ------------------------------------------------------------
> The following changes since commit 2848174358e542de0ad18c42cd79f7208ae93711:
> 
>   xfs/559: adapt to kernels that use large folios for writes (2023-09-02
> 13:54:38 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests.git for-next
> 
> for you to fetch changes up to 964d3327d3954ed589bf4a2f8c86302bbb37acf9:
> 
>   fstests: btrfs/185 update for single device pseudo device-scan (2023-09-17
> 21:20:53 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (4):
>       fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
>       fstests: btrfs add more tests into the scrub group
>       fstests: use btrfs check repair for repairing btrfs filesystems
>       fstests: btrfs/185 update for single device pseudo device-scan

Hi Anand,

Thanks Anand, actually I've merged these patches in my local branch [1]. I
planned to push them last Sunday, but something blocked that. These un-pushed
commits list as [1], feel free to tell me if I missed some btrfs patches. I'll
push them soon.

There're several btrfs related patches are pending as [2], if you'd like, feel
free to review them, especially the btrfs new feature testing, hope to get review
from btrfs side at first :)

Thanks,
Zorro

[1]
5bc43d67 (HEAD -> rh-for-next, redhat/rh-for-next) btrfs: add missing commit ids for a few tests using _fixed_by_kernel_commit
38b7cb72 btrfs/076: use _fixed_by_kernel_commit to tell the fixing kernel commit
6540ed24 btrfs/076: support smaller extent size limit
49abf950 fstests: btrfs add more tests into the scrub group
7ae7bcb1 common/rc: make _get_max_file_size find file size on mount point
0e2055b4 tools/mvtest: ensure testcase is executable (755)
39551b4d fstests: btrfs/185 update for single device pseudo device-scan
253f54c0 overlay: add test for persistent unique fsid
04bbac00 xfs/270: actually test log recovery with unknown rocompat features
75adb8f7 xfs/270: actually test file readability
8abf8a20 fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
2da0d269 fstests: use btrfs check repair for repairing btrfs filesystems

[2]
[PATCH] generic: test new directory entries are returned after rewinding directory
[PATCH 0/5] btrfs: simple quotas fstests
[RFC PATCH v3 0/9] fstests: add btrfs encryption testing

> 
>  common/rc       | 16 ++++++++++++++++
>  tests/btrfs/011 |  2 +-
>  tests/btrfs/027 |  2 +-
>  tests/btrfs/060 |  2 +-
>  tests/btrfs/062 |  2 +-
>  tests/btrfs/063 |  2 +-
>  tests/btrfs/064 |  2 +-
>  tests/btrfs/065 |  2 +-
>  tests/btrfs/067 |  2 +-
>  tests/btrfs/068 |  2 +-
>  tests/btrfs/070 |  2 +-
>  tests/btrfs/071 |  2 +-
>  tests/btrfs/074 |  2 +-
>  tests/btrfs/148 |  2 +-
>  tests/btrfs/185 |  5 +++--
>  tests/btrfs/195 |  2 +-
>  tests/btrfs/261 |  6 ++++--
>  17 files changed, 37 insertions(+), 18 deletions(-)
> 


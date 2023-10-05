Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371E27BA2C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjJEPqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJEPpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 11:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B876EBA
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696518033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3zIQ/1SCg3FfbT6wGlhNivHrXgwo5pS8sAzvvJNfMM=;
        b=NEDk86N0opjfgc5yoofSz7VGdFTLkXY9f4hH+4gA5/nrefjaWg+2hadtoItKU25EIaiF2n
        a78nXvK/58bCu0kogjT/dICnfY/gvEAPaJ/ixirYv2pzCI/7TMAl02eIj35zPERHGS8t/O
        SXkXIuY239AFDdHcYOBDpmPDwaHq/bo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-xUs5PYM5O_epY1gCfhxGNg-1; Thu, 05 Oct 2023 11:00:31 -0400
X-MC-Unique: xUs5PYM5O_epY1gCfhxGNg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2773b534dd2so914366a91.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Oct 2023 08:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696518031; x=1697122831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3zIQ/1SCg3FfbT6wGlhNivHrXgwo5pS8sAzvvJNfMM=;
        b=S5r1bBlc3UTQxR7xyovHTtiz0Ih0X4xq0wdwM7gP4OTmcOAjnVb0haCM3QPLylCRph
         6VLuy9MfddSZVZwbRcJCTUpgftORTIo5TLZs45ZWx0FDfYG3EOHdFRVCtJjOqsVit3Eq
         t/r/TBrMo7NWBdLgRfHtj+RUpAdqmB3IO11uzdXBD4nHQbnBxSSXphlD+i0J68nRdeb3
         zZmNGQMBKmX6ISckECZF8FFVxhz7sa26EJTzH5YKPL1hG+uEB9BaYWAEQOiWnUoPNqN5
         +qR7BQF3OqLrA3ncT1aiQh97jb3m5n4+Yx1YcuFQoSGD8UNog0jKe7qfKL6QGji2ZBVw
         Ssmw==
X-Gm-Message-State: AOJu0YxdncE6x/OrI6FcQINYRiK+HZ5v84iQYO+Af1rfw1++k3mGIk+q
        hGN20/GYNH+AIOVMD1xUF62jlNQ4PKZbbeB80ZaSyp8kcwyI7gG7jqnrbQL5PkUjrIqsUZM1wrG
        pHX7tCow2jVJ49TPKhTRZyEo=
X-Received: by 2002:a17:90a:950e:b0:274:8be8:f767 with SMTP id t14-20020a17090a950e00b002748be8f767mr5094797pjo.15.1696518030799;
        Thu, 05 Oct 2023 08:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETeYL9O1wsJpWTBbvvTlpJLtGxJP4zqFXH5Ea2u+4VLmh2S777TOYUuf+kdatxSTpSflRYgg==
X-Received: by 2002:a17:90a:950e:b0:274:8be8:f767 with SMTP id t14-20020a17090a950e00b002748be8f767mr5094776pjo.15.1696518030474;
        Thu, 05 Oct 2023 08:00:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ev7-20020a17090aeac700b00274922d4b38sm1702506pjb.27.2023.10.05.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:00:29 -0700 (PDT)
Date:   Thu, 5 Oct 2023 23:00:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2023.10.05
Message-ID: <20231005150026.s32nmpkskpzozmzp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <35b9a0c0-1a83-4b63-a494-9b66198f8000@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b9a0c0-1a83-4b63-a494-9b66198f8000@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 05, 2023 at 06:54:46PM +0800, Anand Jain wrote:
> 
> Zorro,
> 
> These patches have undergone testing and are now prepared for merging, based
> on your for-next branch.

Thanks Anand, I've merged these changes onto my for-next branch. Sorry, I'm
just back from a holiday, I'll try to make a new fstests release this weekend.

Thanks,
Zorro

> 
> 
> The following changes since commit 2fddeb5c79ff16bf37e1f1d809bd94b360c27801:
> 
>   btrfs/287: filter snapshot IDs to avoid failures when using some features
> (2023-09-23 22:13:11 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests.git staged-20231005
> 
> for you to fetch changes up to 9750f8d42560a459c89071c6a0bd68bdb467fa49:
> 
>   btrfs/295: skip on zoned device as we cannot corrupt it directly
> (2023-10-05 17:37:39 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (1):
>       btrfs test scan but not register the single device fs
> 
> Boris Burkov (6):
>       common: refactor sysfs_attr functions
>       btrfs: quota mode helpers
>       btrfs/301: new test for simple quotas
>       btrfs: quota rescan helpers
>       btrfs: use new rescan wrapper
>       btrfs: skip squota incompatible tests
> 
> Filipe Manana (2):
>       fstests: redirect fsstress' stdout to $seqres.full instead of
> /dev/null
>       btrfs/192: use append operator to output log replay results to
> $seqres.full
> 
> Naohiro Aota (3):
>       btrfs/283: skip if we cannot write into one extent
>       btrfs/076: fix file_size variable
>       btrfs/295: skip on zoned device as we cannot corrupt it directly
> 
>  common/btrfs        |  64 ++++++++++++++++
>  common/rc           | 127 ++++++++++++++++++++-----------
>  tests/btrfs/017     |   1 +
>  tests/btrfs/022     |   1 +
>  tests/btrfs/028     |   4 +-
>  tests/btrfs/049     |   2 +-
>  tests/btrfs/057     |   1 +
>  tests/btrfs/060     |   2 +-
>  tests/btrfs/061     |   2 +-
>  tests/btrfs/062     |   2 +-
>  tests/btrfs/063     |   2 +-
>  tests/btrfs/064     |   2 +-
>  tests/btrfs/065     |   2 +-
>  tests/btrfs/066     |   2 +-
>  tests/btrfs/067     |   2 +-
>  tests/btrfs/068     |   2 +-
>  tests/btrfs/069     |   2 +-
>  tests/btrfs/070     |   2 +-
>  tests/btrfs/071     |   2 +-
>  tests/btrfs/072     |   2 +-
>  tests/btrfs/073     |   2 +-
>  tests/btrfs/074     |   2 +-
>  tests/btrfs/076     |   2 +-
>  tests/btrfs/091     |   3 +-
>  tests/btrfs/104     |   2 +-
>  tests/btrfs/123     |   2 +-
>  tests/btrfs/126     |   2 +-
>  tests/btrfs/136     |   2 +-
>  tests/btrfs/139     |   2 +-
>  tests/btrfs/153     |   2 +-
>  tests/btrfs/171     |   6 +-
>  tests/btrfs/179     |   2 +-
>  tests/btrfs/180     |   2 +-
>  tests/btrfs/190     |   2 +-
>  tests/btrfs/192     |   4 +-
>  tests/btrfs/193     |   2 +-
>  tests/btrfs/210     |   2 +-
>  tests/btrfs/224     |   6 +-
>  tests/btrfs/230     |   2 +-
>  tests/btrfs/232     |   4 +-
>  tests/btrfs/261     |   2 +-
>  tests/btrfs/283     |   8 ++
>  tests/btrfs/286     |   2 +-
>  tests/btrfs/295     |   2 +
>  tests/btrfs/298     |  53 +++++++++++++
>  tests/btrfs/298.out |   2 +
>  tests/btrfs/301     | 444 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/301.out |  18 +++++
>  tests/ext4/057      |   2 +-
>  tests/ext4/307      |   2 +-
>  tests/generic/068   |   2 +-
>  tests/generic/269   |   2 +-
>  tests/generic/409   |   2 +-
>  tests/generic/410   |   2 +-
>  tests/generic/411   |   2 +-
>  tests/generic/589   |   2 +-
>  tests/xfs/051       |   2 +-
>  tests/xfs/057       |   2 +-
>  tests/xfs/297       |   2 +-
>  tests/xfs/305       |   2 +-
>  tests/xfs/538       |   2 +-
>  61 files changed, 734 insertions(+), 102 deletions(-)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
>  create mode 100755 tests/btrfs/301
>  create mode 100644 tests/btrfs/301.out
> 
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0B5F82AB
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 05:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJHDQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 23:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHDQ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 23:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F277571
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665198986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DhbxeJroSHaKpAvFPoOatTT7B0GoHZwGhdusH6yXbfE=;
        b=JAzRBqNQthTyNS/qUqr5TE9XIsoEX7dvMOmrcy4O3OFYLkV/NsVtt65iKGrwYNzct9N3bq
        Oh9UNc0AMBNX0Z6CXDgPejxsiVyIC4ut0umnsJm03sj2hfEqXSkLW5tIUN/4DbsR4NOIGm
        HlNWS44/sbNBTNTO8PwEJdnHCwZgfss=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-n43n2oDKOlG0cv0UnhHCqA-1; Fri, 07 Oct 2022 23:16:25 -0400
X-MC-Unique: n43n2oDKOlG0cv0UnhHCqA-1
Received: by mail-pl1-f198.google.com with SMTP id c12-20020a170903234c00b0017f695bf8f0so4363678plh.6
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Oct 2022 20:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhbxeJroSHaKpAvFPoOatTT7B0GoHZwGhdusH6yXbfE=;
        b=3S9SHRj20naeTNF9XVdI1YKi5aI4kotAbE1xIrxZcvqas9pEgEVTtZMa+Q2CHKJacE
         peVmKjEyW3Viy8eBNCDxsQGTh3ZiIHXishCNcHNy4zWBCFDmmVWHU8g8Iz06U0gn/QpV
         rvYoEzp4sljLDG2+Bzl7yVzxFLzhRzbqjPDZub1Dhn9408Kw9Ezu23XpYEwzRWgEbhR1
         Bkxz6grBqEmg5Q7MOk1QHHo6JDg7c9k+clQQUhHK7Uei/mkXECd0H2Bwzt8Ix+lvfA8L
         pIGO8+D794vljWf+iEwmRdHECF7n4MxtD2DbYz5NSxiPIX5ueFKT9IiSfFcdzl1n9xVo
         sing==
X-Gm-Message-State: ACrzQf1kLU7A1KwlZzqN+GRWeqSyJ8PwUCjgpSH66RZzzVbTrh8v51D7
        eZk8WwpLc3vg2/zhTZKu54Mw5JHtxSUquxm//2N57IDY3jtwCK7jI2r7YLBkynodLeV7SXBu/2F
        UtTDPscvsmCcaDnB6gmxI8sU=
X-Received: by 2002:a17:90b:1c0d:b0:202:61d0:33c with SMTP id oc13-20020a17090b1c0d00b0020261d0033cmr20026984pjb.90.1665198983976;
        Fri, 07 Oct 2022 20:16:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EAWoXWLQXUj/3mWol3hDyD9uARG19oFUN2WxxpIC4Qtlf3M5VfyBqvKnL8PclqQjQhBLISw==
X-Received: by 2002:a17:90b:1c0d:b0:202:61d0:33c with SMTP id oc13-20020a17090b1c0d00b0020261d0033cmr20026964pjb.90.1665198983651;
        Fri, 07 Oct 2022 20:16:23 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00172f4835f60sm2223977plg.189.2022.10.07.20.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:16:23 -0700 (PDT)
Date:   Sat, 8 Oct 2022 11:16:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/3] fstests: add a btrfs fiemap test and fiemap test
 group
Message-ID: <20221008031619.7zwzzgdgr7q3b4pw@zlang-mailbox>
References: <cover.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665150613.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:33PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a new btrfs test case to exercise fiemap in the presence of a
> snapshot, and then add a fiemap test group, as well as some missing
> '_require_xfs_io_command "fiemap"' calls in a few tests.
> 
> Filipe Manana (3):
>   btrfs: test fiemap on large file with extents shared through a snapshot
>   fstests: add missing require of xfs_io fiemap command to some tests
>   fstests: add fiemap group

Thanks for doing this! The 1st patch looks good to me, the 2nd is fine too.
If you're hurry (Are you?) to have that btrfs test coverage, I can merge the
1st patch at first. Then keep other patch one more week. Due to it changes
many other fs cases (although not big change:), I need time to check one by
one, and I hope to see if there're more review points from others :)

Thanks,
Zorro

> 
>  doc/group-names.txt |   1 +
>  tests/btrfs/004     |   2 +-
>  tests/btrfs/079     |   2 +-
>  tests/btrfs/137     |   2 +-
>  tests/btrfs/140     |   2 +-
>  tests/btrfs/199     |   2 +-
>  tests/btrfs/200     |   2 +-
>  tests/btrfs/211     |   2 +-
>  tests/btrfs/257     |   3 +-
>  tests/btrfs/258     |   3 +-
>  tests/btrfs/259     |   3 +-
>  tests/btrfs/260     |   2 +-
>  tests/btrfs/263     |   2 +-
>  tests/btrfs/276     | 124 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/276.out |  16 ++++++
>  tests/ext4/001      |   2 +-
>  tests/ext4/034      |   2 +-
>  tests/ext4/308      |   2 +-
>  tests/f2fs/002      |   2 +-
>  tests/generic/009   |   2 +-
>  tests/generic/012   |   2 +-
>  tests/generic/016   |   2 +-
>  tests/generic/017   |   2 +-
>  tests/generic/021   |   2 +-
>  tests/generic/022   |   2 +-
>  tests/generic/032   |   2 +-
>  tests/generic/043   |   2 +-
>  tests/generic/044   |   2 +-
>  tests/generic/045   |   2 +-
>  tests/generic/046   |   2 +-
>  tests/generic/047   |   2 +-
>  tests/generic/048   |   2 +-
>  tests/generic/049   |   2 +-
>  tests/generic/058   |   2 +-
>  tests/generic/060   |   2 +-
>  tests/generic/061   |   2 +-
>  tests/generic/063   |   2 +-
>  tests/generic/064   |   2 +-
>  tests/generic/092   |   2 +-
>  tests/generic/094   |   2 +-
>  tests/generic/110   |   2 +-
>  tests/generic/111   |   2 +-
>  tests/generic/115   |   2 +-
>  tests/generic/177   |   2 +-
>  tests/generic/225   |   2 +-
>  tests/generic/255   |   2 +-
>  tests/generic/301   |   2 +-
>  tests/generic/302   |   2 +-
>  tests/generic/305   |   2 +-
>  tests/generic/316   |   2 +-
>  tests/generic/326   |   2 +-
>  tests/generic/327   |   2 +-
>  tests/generic/328   |   2 +-
>  tests/generic/352   |   2 +-
>  tests/generic/353   |   2 +-
>  tests/generic/372   |   2 +-
>  tests/generic/414   |   2 +-
>  tests/generic/425   |   2 +-
>  tests/generic/473   |   2 +-
>  tests/generic/483   |   2 +-
>  tests/generic/516   |   2 +-
>  tests/generic/519   |   2 +-
>  tests/generic/540   |   2 +-
>  tests/generic/541   |   2 +-
>  tests/generic/542   |   2 +-
>  tests/generic/543   |   2 +-
>  tests/generic/578   |   2 +-
>  tests/generic/654   |   2 +-
>  tests/generic/655   |   2 +-
>  tests/generic/677   |   2 +-
>  tests/generic/679   |   2 +-
>  tests/generic/695   |   2 +-
>  tests/overlay/066   |   2 +-
>  tests/shared/298    |   2 +-
>  tests/xfs/180       |   2 +-
>  tests/xfs/182       |   2 +-
>  tests/xfs/184       |   2 +-
>  tests/xfs/192       |   2 +-
>  tests/xfs/193       |   2 +-
>  tests/xfs/198       |   2 +-
>  tests/xfs/200       |   2 +-
>  tests/xfs/204       |   2 +-
>  tests/xfs/207       |   2 +-
>  tests/xfs/208       |   2 +-
>  tests/xfs/209       |   2 +-
>  tests/xfs/210       |   2 +-
>  tests/xfs/211       |   2 +-
>  tests/xfs/212       |   2 +-
>  tests/xfs/213       |   2 +-
>  tests/xfs/214       |   2 +-
>  tests/xfs/231       |   2 +-
>  tests/xfs/232       |   2 +-
>  tests/xfs/252       |   2 +-
>  tests/xfs/344       |   2 +-
>  tests/xfs/345       |   2 +-
>  tests/xfs/346       |   2 +-
>  tests/xfs/347       |   2 +-
>  tests/xfs/443       |   3 +-
>  98 files changed, 240 insertions(+), 95 deletions(-)
>  create mode 100755 tests/btrfs/276
>  create mode 100644 tests/btrfs/276.out
> 
> -- 
> 2.35.1
> 


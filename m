Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DB72A9B0
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jun 2023 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFJHEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jun 2023 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFJHED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jun 2023 03:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A473A9B
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jun 2023 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686380597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thxU3diO4BkJXBxEG+yq1ygYNN68uOVgHR/y83leKdc=;
        b=PrZuJoFUMVW7rYC9WF9O2HR1dzYgRCtEmEBkYwDq8Xp0W7Y1pTPkjDlNg1eLC/nLjahMay
        aqN7OeSWFU2ypf2DvXEhIl6OOC2pOiOF3Nc8pFe/LrsUVCQ1IDvxFbcDh8xzinCglHfj1k
        hwN/O71oXcoItrZAqe619VVawlskkiA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-ti_dLCAQMvGyPVVpzs8keQ-1; Sat, 10 Jun 2023 03:03:14 -0400
X-MC-Unique: ti_dLCAQMvGyPVVpzs8keQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso1018806a12.0
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jun 2023 00:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686380594; x=1688972594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thxU3diO4BkJXBxEG+yq1ygYNN68uOVgHR/y83leKdc=;
        b=LLTQHRSWk2HghiJIA9paDDQNivfDq8YN3WQeEtKZkXXakxjDrMkLvcg8c6nB4auoCV
         bqMdG+40IvfMP8lJv2YL927+UcSOaIOpl3xwG3DP/DTZCbdgEeizDwJWE6Y1cyNeVoC5
         XaxHd5M1eiNrBro1fOFgoqijTR1S6EUeqNR67fCTWMxL2+yH6WOWT9UshJMjTiS30QJ/
         XK/8wSdB1Gyfs8X/Gz1hdYJl91ESy8hTGsx+QHEBkUINCjFOMpOrokOBhvtDiloAqhPH
         ClKvpcF3bWTbv8oXbT6n5o82yBMHqKz4YrN8FJAifoO6CM99D9Q8WxflLEdJrP+6f/6D
         AfTg==
X-Gm-Message-State: AC+VfDyAeFmczED6NPgVUgPxJUKPSRI0yTuAifR8UvCXQbXT7PClWUVe
        GaYmGeRYhyyGe6XcLL50KliuxlCsFGkg1YtbIdEBKvey2GMyus7Wv6GUjkP1wxRE1BwjU8JSDjI
        S//tbwAOJQ8ssUTK5lbvqOcE=
X-Received: by 2002:a05:6a21:6da3:b0:10a:be5c:6e2d with SMTP id wl35-20020a056a216da300b0010abe5c6e2dmr3550411pzb.39.1686380593777;
        Sat, 10 Jun 2023 00:03:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40mYWWGeSfRo+5bDF3kL4JbS0PLuWUFatiZRBvAnhp1iW7pjF4NKP6Rt5qVfGD91zMBgZDWg==
X-Received: by 2002:a05:6a21:6da3:b0:10a:be5c:6e2d with SMTP id wl35-20020a056a216da300b0010abe5c6e2dmr3550397pzb.39.1686380593488;
        Sat, 10 Jun 2023 00:03:13 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t26-20020a65609a000000b0053fed3131e6sm3537520pgu.65.2023.06.10.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 00:03:13 -0700 (PDT)
Date:   Sat, 10 Jun 2023 15:03:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/122: fix nodesize option in mfks.btrfs
Message-ID: <20230610070309.kslef76hvdxi56xd@zlang-mailbox>
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
 <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 02, 2023 at 07:38:54PM +0800, Anand Jain wrote:
> btrf/122 is failing on a system with 64k page size:
> 
>      QA output created by 122
>     +ERROR: illegal nodesize 16384 (smaller than 65536)
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>     +mount /dev/vdb2 /mnt/scratch failed
>     +(see /xfstests-dev/results//btrfs/122.full for details)
> 
> Mkfs.btrfs sets the default node size to 16K when the sector size is less
> than 16K, and it matches the sector size when it's greater than 16K.
> So, there's no need to explicitly set it.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Remove the redundant explicit nodesize option from mkfs.btrfs.
>     Changed: Title from "btrfs/122: adjust nodesize to match pagesize"
>     
> 
>  tests/btrfs/122 | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/122 b/tests/btrfs/122
> index 345317536f40..9d5e9efccec7 100755
> --- a/tests/btrfs/122
> +++ b/tests/btrfs/122
> @@ -18,9 +18,7 @@ _supported_fs btrfs
>  _require_scratch
>  _require_btrfs_qgroup_report
>  
> -# Force a small leaf size to make it easier to blow out our root
> -# subvolume tree
> -_scratch_mkfs "--nodesize 16384" >/dev/null
> +_scratch_mkfs >> $seqres.full || _fail "mkfs failed"

Oh, generally we don't check the return status of default _scratch_mkfs, except
there're specific arguments for _scratch_mkfs. Or we need to add "_fail" to each
mkfs lines. So I'd like to remove that "_fail" when I merge it.

Thanks,
Zorro

>  _scratch_mount
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  
> -- 
> 2.38.1
> 


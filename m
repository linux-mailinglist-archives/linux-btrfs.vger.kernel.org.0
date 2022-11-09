Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32062310E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKIRHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 12:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKIRHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 12:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68BAF75
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668013619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBwQZJIi2BVi9LjnoUI2prY0PEJGEFudVPWJ71X1164=;
        b=aOQ/S1FIja+5vLYXBTu2sJx6TCYlkXsZnVp5LhUwqh/0xGdl2MaFL7de0CxYTnr6rkn8/N
        cMW9n3fBI59/koGNV2IX08+ORxPVIVat+5hruvQ6uhVBEny4gxYFGNAZMlKh2pN7IKJz0c
        QzDIdCoQtPW4VCAc6ySoYYwb1TJ4L1w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-dBaPuVjUOhaCCs2CLEtegA-1; Wed, 09 Nov 2022 12:06:50 -0500
X-MC-Unique: dBaPuVjUOhaCCs2CLEtegA-1
Received: by mail-pg1-f197.google.com with SMTP id l63-20020a639142000000b0046f5bbb7372so9905506pge.23
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Nov 2022 09:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBwQZJIi2BVi9LjnoUI2prY0PEJGEFudVPWJ71X1164=;
        b=zVLLas2C02UoqDpchnyMoC9+ZHXUCh0+q7QgdEZGREycLJpjq3Dy2TfEEHCWh4IpWU
         dtFCQXh/Qt3JNaQmPKfiBvOIUhywdo0NgSrYjWee20PFcu3kxfi34cU375uyrFexPt8O
         X+StusJFanHjQZxIWi3hQEn2Zspvul51hcnF+eElFFcSXe+2e9PcV744mHZN62rF9bj7
         DMIMxgNV0SIcNkPaXfYP3VdDs7b797hkvmt6PVdlPrsQ51TIDRynzcUi64BJXRmYlVau
         PHUD8UFwd4MkSljWQkKQ0sEz9vIqkxH9ee3HQp6QwG0Pts91WzC4/FDLvxIseDLDWIW3
         fRiQ==
X-Gm-Message-State: ACrzQf3SE2CNQVox948QZgczm5Sfhbzqydw97tANMs9pjFMGjTnmTyLA
        ZaDsY7/wEVGIwA4mc9SPWLT3XQEjWNp6n+8KIV45eUcx629oXL5fqAImMNYfPUSKxB5C0CD6ha5
        Gb5vdHhW2hI1m+8rEuCGliro=
X-Received: by 2002:a17:902:9004:b0:187:4889:7dbb with SMTP id a4-20020a170902900400b0018748897dbbmr39833712plp.137.1668013609116;
        Wed, 09 Nov 2022 09:06:49 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4Nz1d2XjHNMfa0GWVbcESlABQGlSzEx+6WG7jMFaMVzomyXr9mD1gEVt0gQT12YE058gNk9g==
X-Received: by 2002:a17:902:9004:b0:187:4889:7dbb with SMTP id a4-20020a170902900400b0018748897dbbmr39833681plp.137.1668013608829;
        Wed, 09 Nov 2022 09:06:48 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u17-20020a634551000000b00439f027789asm7808687pgk.59.2022.11.09.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:06:48 -0800 (PST)
Date:   Thu, 10 Nov 2022 01:06:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/3] btrfs/053: fix test failure when running with
 btrfs-progs v6.0+
Message-ID: <20221109170643.sfxl7nl47ro73pis@zlang-mailbox>
References: <cover.1668011940.git.fdmanana@suse.com>
 <793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 04:44:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In btrfs-progs v6.0 the --leafsize (-l) command line option was removed
> from mkfs.btrfs, so btrfs/053 can fail with v6.0+ in case the scratch
> device does not have a btrfs filesystem created before running the test,
> in which case mounting the scratch device fails.
> 
> The change was introduced by the following btrfs-progs commit:
> 
>   f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")
> 
> Change the test to use --nodesize (-n) instead, since it exists in both
> old and new btrfs-progs versions. Also redirect mkfs output to the test's
> log file and fail explicitly if mkfs failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This version looks good to me, thanks for fixing this.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/053 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/053 b/tests/btrfs/053
> index fbd2e7d9..67239f10 100755
> --- a/tests/btrfs/053
> +++ b/tests/btrfs/053
> @@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
>  rm -fr $send_files_dir
>  mkdir $send_files_dir
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount
>  
>  echo "hello world" > $SCRATCH_MNT/foobar
> @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
>  _scratch_unmount
>  _check_scratch_fs
>  
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount
>  
>  _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> -- 
> 2.35.1
> 


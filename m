Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CC780B95
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376802AbjHRMNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376806AbjHRMM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 08:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724B12B
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692360728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H03qrLDPJ+C4WBVW8rxEz6cByLaUURA0As/7v5LT82o=;
        b=FpIGj+ywon2W08Ag22gI5iPyzgB8Qcri9zdCjHsy9gvqZ8RGYT6VnextzP3H5UmDuW0J6x
        pvyr0q8gsmdB0l+2Hza7JNdTDrJjV2UDvhjWlSyXqmR9gJFFUxWtNR+hLhX+737GvDj1w5
        PQ4dH2JMctQYLgmthmLJex9aGWgCCA0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ExcNdOSwMzq79-sC7em9Qg-1; Fri, 18 Aug 2023 08:12:07 -0400
X-MC-Unique: ExcNdOSwMzq79-sC7em9Qg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bf39e73558so8493785ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 05:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692360726; x=1692965526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H03qrLDPJ+C4WBVW8rxEz6cByLaUURA0As/7v5LT82o=;
        b=kO1oTuMWp8RktTAl8rVl2lb2eKr94KfPCCZcWWM/TMNInDQTkb5IRSIehrKjY3wrUQ
         X5MHyIW1L3HXg+oyCdXPPUqZ5njtp9MVDOllxL0wn+Rocgf3dgqC7TpJVTA0ff/0fdxo
         JiG78gstCqpoy4z83I9LJZnyhxeriBQ47I/3Xe+fDffD+UZrigiLHapCXY1MhmrFq2b2
         HevIPfm2wqmjT50mqvLOtS5EbRiZ4l90zzr5Mlyi3PvlTM7A0lkRzFe9jky6G3hLDxKm
         /TG/ABv2qX3rAY3BF24diSIwRIJncIAHNLKORVf87gTqdzD2HlUQVcPlv60Rv3iXBzQh
         Cqsw==
X-Gm-Message-State: AOJu0YwLgWG+FN0CpnfZsH+K2F98Yw/5VE+7hY4I2y5GcnNIGHzU55qA
        4Ku56EQbE2OBJMkMG1n+lkEZeDDMqd5Jnp9kXg2uVgpReQipS8CCp1VvKFlBcv50pEqNhLp1AhW
        dugODu5hMYyq2p5QEDYUiHolSu20Ui5mhR6Ej
X-Received: by 2002:a17:902:ee4d:b0:1bb:b34b:73a with SMTP id 13-20020a170902ee4d00b001bbb34b073amr2612598plo.25.1692360726068;
        Fri, 18 Aug 2023 05:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxVA8hbHhyEUja5oL3p3+F8ruwUaIWxw+Me+eSMvE2mkiJjVYm7pulWiC3Q6j0nKmefu9mCw==
X-Received: by 2002:a17:902:ee4d:b0:1bb:b34b:73a with SMTP id 13-20020a170902ee4d00b001bbb34b073amr2612575plo.25.1692360725697;
        Fri, 18 Aug 2023 05:12:05 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001b243a20f26sm1591413plz.273.2023.08.18.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 05:12:05 -0700 (PDT)
Date:   Fri, 18 Aug 2023 20:12:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] fstests: Verify dir permissions when creating a stub
 subvolume
Message-ID: <20230818121201.34lvepp5ndhv6fkk@zlang-mailbox>
References: <20230818081156.3306384-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818081156.3306384-1-lee@trager.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 01:11:56AM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
> v5:
> - Fixed typo in subject
> - Added _fixed_by_kernel_commit as this test requires a kernel fix to pass
> - Fixed copyright year

This version is good to me now,

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> v4:
> - Removed extra blank line in common/rc
> - Allowed caller to pass extra options to _require_unshare to check for
>   support. -f -r -m -p -U have been supported by util-linux and busybox
>   for awhile and are typical options.
> - Moved _registry_cleanup to right after _begin_fstest.
> - Added "cd /;rm -rf $tmp.*" from standard cleanup to 300 cleanup.
> - Added rm -rf $test_dir before running test to ensure its in a clean state.
> v3:
> - Fixed whitepsace in 300.out due to find command not using './' before %P
> v2:
> - Migrated _require_unshare from overlay/020 into common_rc. Updated the error
>   message as most Linux systems should have unshare from util-linux.
> - Added note about why the test must be done in one subshell process.
> - chown command now uses $qa_user:$qa_group instead of hard coded values.
>  common/rc           |  5 +++++
>  tests/btrfs/300     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++
>  tests/overlay/020   |  7 +-----
>  4 files changed, 76 insertions(+), 6 deletions(-)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..18ea0f02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5224,6 +5224,11 @@ _soak_loop_running() {
>  	return 0
>  }
>  
> +_require_unshare() {
> +	unshare -f -r -m -p -U $@ true &>/dev/null || \
> +		_notrun "unshare: command not found, should be in util-linux"
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..d3722503
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +
> +_begin_fstest auto quick subvol snapshot
> +_register_cleanup "cleanup"
> +
> +_supported_fs btrfs
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: copy dir permission and time when creating a stub subvolume"
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_require_unshare
> +
> +test_dir="${TEST_DIR}/${seq}"
> +cleanup() {
> +	rm -rf $test_dir
> +	cd /
> +	rm -rf $tmp.*
> +}
> +
> +rm -rf $test_dir
> +mkdir $test_dir
> +chown $qa_user:$qa_group $test_dir
> +
> +# _user_do executes each command as $qa_user in its own subshell. unshare
> +# sets the namespace for the running shell. The test must run in one user
> +# subshell to preserve the namespace over multiple commands.
> +_user_do "
> +cd ${test_dir};
> +unshare --user --keep-caps --map-auto --map-root-user;
> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"
> +
> +find $test_dir/. -printf "%M %u %g ./%P\n"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
> new file mode 100644
> index 00000000..6e94447e
> --- /dev/null
> +++ b/tests/btrfs/300.out
> @@ -0,0 +1,18 @@
> +QA output created by 300
> +Create subvolume './subvol'
> +Create subvolume 'subvol/subsubvol'
> +Create a snapshot of 'subvol' in './snapshot'
> +drwxr-xr-x fsgqa fsgqa ./
> +drwxr-xr-x fsgqa fsgqa ./subvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/1
> +-rw-r--r-- fsgqa fsgqa ./subvol/2
> +-rw-r--r-- fsgqa fsgqa ./subvol/3
> +drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
> +-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
> +drwxr-xr-x fsgqa fsgqa ./snapshot
> +-rw-r--r-- fsgqa fsgqa ./snapshot/1
> +-rw-r--r-- fsgqa fsgqa ./snapshot/2
> +-rw-r--r-- fsgqa fsgqa ./snapshot/3
> +drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
> diff --git a/tests/overlay/020 b/tests/overlay/020
> index 98a33aec..9f82da34 100755
> --- a/tests/overlay/020
> +++ b/tests/overlay/020
> @@ -16,18 +16,13 @@ _begin_fstest auto quick copyup perms
>  
>  # real QA test starts here
>  
> -require_unshare() {
> -	unshare -f -r "$@" true &>/dev/null || \
> -		_notrun "unshare $@: not supported"
> -}
> -
>  # Modify as appropriate.
>  _supported_fs overlay
>  _fixed_by_kernel_commit 3fe6e52f0626 \
>  	"ovl: override creds with the ones from the superblock mounter"
>  
>  _require_scratch
> -require_unshare -m -p -U
> +_require_unshare
>  
>  # Remove all files from previous tests
>  _scratch_mkfs
> -- 
> 2.34.1
> 


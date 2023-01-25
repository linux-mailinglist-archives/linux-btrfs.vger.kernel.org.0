Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD367B286
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjAYMUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 07:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbjAYMUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 07:20:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74230E3;
        Wed, 25 Jan 2023 04:20:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5E11FF49;
        Wed, 25 Jan 2023 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674649211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1TfXmmTzBBg2cGmIf2cpJBYE95cBiM6syHdN7a5CNk=;
        b=0qJv6vQ541lQDmCNDTH8LHqrbQfgzD0Tpl8VwAA4ws3+3+l8elB3Omikhi24Dl0Lhyro3Y
        zsM81yiBxcCZC5Lu9h1COCJgsnXE8d8PX+vKaKIFxJ5cSH/v3T2dv+1YispF4BfO5GCDZ6
        JWsZbD3y7uO/83YgBZvWSALrkjHXsp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674649211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1TfXmmTzBBg2cGmIf2cpJBYE95cBiM6syHdN7a5CNk=;
        b=n3XMJf0q7yVx8vQkYJhqVhNMbXXzVMegw8k2XCMOUijiNCPzvgMMgQAAqyW9bvKlN+BhSH
        g7vO+nfjCEQBWoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08B4B1358F;
        Wed, 25 Jan 2023 12:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FtXSAHse0WOMfgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 25 Jan 2023 12:20:11 +0000
Date:   Wed, 25 Jan 2023 13:21:21 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test send optimal cloning behaviour
Message-ID: <20230125132121.7c7be706@echidna.fritz.box>
In-Reply-To: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
References: <49e01810eff8d5ddd7d3c99796a66b997faaaf84.1674644814.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 25 Jan 2023 11:07:54 +0000, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that send operations do the best cloning decisions when we have
> extents that are shared but some files refer to the full extent while
> others refer to only a section of the extent.
> 
> This exercises an optimization that was added to kernel 6.2, by the
> following commit:
> 
>   c7499a64dcf6 ("btrfs: send: optimize clone detection to increase extent sharing")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/283     | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/283.out | 26 ++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100755 tests/btrfs/283
>  create mode 100644 tests/btrfs/283.out
> 
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..c1f6007d
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Test that send operations do the best cloning decisions when we have extents
> +# that are shared but some files refer to the full extent while others refer to
> +# only a section of the extent.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send clone fiemap
> +
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch # for _filter_fiemap_flags
> +
> +_supported_fs btrfs
> +_require_test
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_io_command "fiemap"
> +_require_fssum
> +
> +_wants_kernel_commit c7499a64dcf6 \
> +	     "btrfs: send: optimize clone detection to increase extent sharing"
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +send_stream=$send_files_dir/snap.stream
> +snap_fssum=$send_files_dir/snap.fssum
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir

I'm not sure what the rules are regarding TEST_DIR residuals, but it
might be worth adding a custom _cleanup() for $send_files_dir .
Anyhow, looks good as-is.
Reviewed-by: David Disseldorp <ddiss@suse.de>

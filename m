Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DC7BE552
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376907AbjJIPsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJIPsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:48:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0599;
        Mon,  9 Oct 2023 08:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA0501F381;
        Mon,  9 Oct 2023 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696866516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLSjUkF9AyRuV3MbSeTN3+eqjFVoIOgtmYM7DWuo3Jk=;
        b=sL8jLQxN3Vt5bT6PjHBlQKreKrGb5WjlwJ5o3i1uWc3g6wyDbKgAaXaW+JeNn+35mokiUD
        cVEAvntYpimF3kuXj3z9+TYt7z/qyLTaSzz9LZuo7RMPY/12QahcJb5R8bS1R4NdOo27GR
        QFI0ttHPT5O1Tr3cbXZxNBFz8vrtGqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696866516;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLSjUkF9AyRuV3MbSeTN3+eqjFVoIOgtmYM7DWuo3Jk=;
        b=qKZ/6jE1niMfo/wP1voQN7T9sP42VSgxPOZQvVi/Ie7HNM8FFDsdmPIjcVq25BtUnKxcSn
        yr4z81OFYZ43LWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D4E13586;
        Mon,  9 Oct 2023 15:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f73CH9QgJGXPOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 15:48:36 +0000
Date:   Mon, 9 Oct 2023 17:41:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/298: add test for showing qgroups include staled
 sorted by path
Message-ID: <20231009154151.GS28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231009143123.9588-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009143123.9588-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 02:31:23PM +0000, Sidong Yang wrote:
> Test for showing qgroups include a staled qgroup list sorted by path.
> It crashed without checking qgroup has empty path. It fixed by the
> following commit in btrfs-progs:
> 
> cd7f1e48 ("btrfs-progs: qgroup: check null in comparing paths")

This is a progs patch and I'd like to have the test case there, while it
does not hurt to have it in the fstests too but IMHO it's not very
useful there.

> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  tests/btrfs/298     | 34 ++++++++++++++++++++++++++++++++++
>  tests/btrfs/298.out |  2 ++
>  2 files changed, 36 insertions(+)
>  create mode 100755 tests/btrfs/298
>  create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 00000000..5457423d
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,34 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +# Test that showing qgourps list includes a staled qgroup without crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> + . ./common/filter
> +
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +# Create stale qgroup with creating and deleting a subvolume.
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/a >> $seqres.full
> +
> +# Show qgroups list with sorting path without crash.
> +$BTRFS_UTIL_PROG qgroup show --sort path $SCRATCH_MNT >> $seqres.full
> +
> +_scratch_unmount

I've created a test case for btrfs-progs with the same commands, only
using the other wrappers to run them.

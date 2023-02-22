Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4569FECA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjBVW4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 17:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBVW4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 17:56:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66F38003;
        Wed, 22 Feb 2023 14:56:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3427B372F2;
        Wed, 22 Feb 2023 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677106606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KF+v5v2AZh3rCzDsmZHCBpKs5LzuSrm1Ct4LRtegoQ=;
        b=bMidcwkzFfZxkuLzfSEpK0h6CYJh5jX28bMAH3BW4nloJRYxTwlYK8A5icZifEHAF9DePN
        qN6Oimrv9i16mpvvqla3XJDexxi/r6Lez9L+V/OeJuOnmVUIjBCcDfSB2tHXYGC7RY7qNO
        9RftUrS4oKL8AACYq6I4XFHzCjTCUCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677106606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KF+v5v2AZh3rCzDsmZHCBpKs5LzuSrm1Ct4LRtegoQ=;
        b=uNaGHqgCJCIP91QisH2OrFdOwm6D114VUQqgLQABb6uHyGAPmPYZwyXu0eDI8vJDOSYxDl
        KvAZRAfsFdKvYOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC23133E0;
        Wed, 22 Feb 2023 22:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JgliAa6d9mOvAQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 22 Feb 2023 22:56:46 +0000
Date:   Wed, 22 Feb 2023 23:58:10 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for direct io partial writes
Message-ID: <20230222235810.474f69f2@echidna.fritz.box>
In-Reply-To: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
References: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>
A few minor nits below...

On Wed, 22 Feb 2023 11:30:20 -0800, Boris Burkov wrote:

...
> +	/* touch the first page of the mapping to bring it into cache */
> +	c = ((char *)buf)[0];
> +	printf("%u\n", c);
> +
> +	do_dio(argv[2], buf, sz);
> +}
> diff --git a/tests/generic/708 b/tests/generic/708
> new file mode 100755
> index 00000000..ff2e162b
> --- /dev/null
> +++ b/tests/generic/708
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test iomap direct_io partial writes.
> +#
> +# Create a reasonably large file, then run a program which mmaps it,
> +# touches the first page, then dio writes it to a second file. This
> +# can result in a page fault reading from the mmapped dio write buffer and
> +# thus the iompap direct_io partial write codepath.

s/iompap/iomap

> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> + 	cd /
> + 	rm -r -f $tmp.*

There's some whitespace damage on the two lines above.

> +	rm -f $TEST_DIR/dio-buf-fault.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program dio-buf-fault
> +src=$TEST_DIR/dio-buf-fault.src
> +dst=$TEST_DIR/dio-buf-fault.dst
> +
> +echo "Silence is golden"
> +
> +$XFS_IO_PROG -fc "pwrite -q 0 $((2 * 1024 * 1024))" $src
> +sync
> +$here/src/dio-buf-fault $src $dst >> $seqres.full || _fail "failed doing the dio copy"

Any reason for redirecting the single character to the 708.full file? It
doesn't appear useful for debugging so can probably go to /dev/null

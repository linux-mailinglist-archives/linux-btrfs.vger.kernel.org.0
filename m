Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFF66240D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjAILTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 06:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjAILT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 06:19:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC805140EF;
        Mon,  9 Jan 2023 03:19:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 911A776AED;
        Mon,  9 Jan 2023 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673263164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiUOfhvPaNRejDnr1DtYL+l9rm61yD3KFIviRGdJ7m0=;
        b=NWfDUDrcmcO/3UEKRlwkujf0lItatH/77wSOE8oaqvgK0kJ3xxq69jj4+1XQb3LpME8wCD
        PXlG+t9XjsZ+BUcvwBfYg3R4meh9MhhD522VadEc3lnzDJeBPFvt/Rc34jrmoMLOXQdqZl
        QC7YgKSE2LxCixUs6ly8jGfrv4Uao+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673263164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiUOfhvPaNRejDnr1DtYL+l9rm61yD3KFIviRGdJ7m0=;
        b=vl8Rc6YyD0HN0yb6R5Ic5703jOMGGsgZPV8eHiXmyZEE9MUTa/GXT3eWD58qCnM/DkSvlb
        MA8aH1A8wOSUh4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DE04134AD;
        Mon,  9 Jan 2023 11:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id osN2FTz4u2MoPQAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 09 Jan 2023 11:19:24 +0000
Date:   Mon, 9 Jan 2023 12:20:27 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test lseek with seek data mode on a one byte
 file
Message-ID: <20230109122027.4ff90c42@echidna.fritz.box>
In-Reply-To: <2ba1050ace4aa65eff3082580b449fe1e97a3c5b.1673260375.git.fdmanana@suse.com>
References: <2ba1050ace4aa65eff3082580b449fe1e97a3c5b.1673260375.git.fdmanana@suse.com>
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

Looks fine:
Reviewed-by: David Disseldorp <ddiss@suse.de>

Minor nit below...

On Mon,  9 Jan 2023 10:34:15 +0000, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that seeking for data on a 1 byte file works correctly, the returned
> offset should be 0 if the start offset is 0.
> 
> This is a regression test motivated by a btrfs bug introduced in kernel
> 6.1, which got recently fixed by the following kernel commit:
> 
>   2f2e84ca6066 ("btrfs: fix off-by-one in delalloc search during lseek")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  src/seek_sanity_test.c | 36 ++++++++++++++++++++++++++++++++++++
>  tests/generic/706      | 36 ++++++++++++++++++++++++++++++++++++
>  tests/generic/706.out  |  2 ++
>  3 files changed, 74 insertions(+)
>  create mode 100755 tests/generic/706
>  create mode 100644 tests/generic/706.out
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 8a586f74..48b3ccc0 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -292,6 +292,41 @@ out:
>  	return ret;
>  }
>  
> +/*
> + * Test seeking for data on a 1 byte file, both when there's delalloc and also
> + * after delalloc is flushed.
> + */
> +static int test22(int fd, int testnum)
> +{
> +	const char buf = 'X';
> +	int ret;
> +
> +	ret = do_pwrite(fd, &buf, 1, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Our file as a size of 1 byte and that byte is in delalloc. Seeking
> +	 * for data, with a start offset of 0, should return file offset 0.
> +	 */
> +	ret = do_lseek(testnum, 1, fd, 1, SEEK_DATA, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush all delalloc. */
> +	ret = fsync(fd);
> +	if (ret) {
> +		fprintf(stderr, "fsync failed: %s (%d)\n", strerror(errno), errno);
> +		return ret;
> +	}
> +
> +	/*
> +	 * We should get the same result we got when we had delalloc, 0 is the
> +	 * offset with data.
> +	 */
> +	return do_lseek(testnum, 2, fd, 1, SEEK_DATA, 0, 0);
> +}
> +
>  /*
>   * Make sure hole size is properly reported when punched in the middle of a file
>   */
> @@ -1131,6 +1166,7 @@ struct testrec seek_tests[] = {
>         { 19, test19, "Test file SEEK_DATA from middle of a large hole" },
>         { 20, test20, "Test file SEEK_DATA from middle of a huge hole" },
>         { 21, test21, "Test file SEEK_HOLE that was created by PUNCH_HOLE" },
> +       { 22, test22, "Test a 1 byte file" },
>  };
>  
>  static int run_test(struct testrec *tr)
> diff --git a/tests/generic/706 b/tests/generic/706
> new file mode 100755
> index 00000000..b3e7aa7c
> --- /dev/null
> +++ b/tests/generic/706
> @@ -0,0 +1,36 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 706
> +#
> +# Test that seeking for data on a 1 byte file works correctly, the returned
> +# offset should be 0 if the start offset is 0.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seek
> +
> +[ $FSTYP == "btrfs" ] &&
> +	_fixed_by_kernel_commit 2f2e84ca6066 \
> +	"btrfs: fix off-by-one in delalloc search during lseek"
> +
> +_supported_fs generic
> +_require_test
> +_require_seek_data_hole
> +_require_test_program "seek_sanity_test"
> +
> +test_file=$TEST_DIR/seek_sanity_testfile.$seq

Nit: test_file set and use below should be quoted. 

> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $test_file
> +}
> +
> +_run_seek_sanity_test -s 22 -e 22 $test_file > $seqres.full 2>&1 ||
> +	_fail "seek sanity check failed!"

Nit: I think it'd be nicer to avoid the redirect and _fail here, instead
filtering the FS magic / alloc size strings. I'm okay with it as-is
though.

Cheers, David

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/706.out b/tests/generic/706.out
> new file mode 100644
> index 00000000..577697c6
> --- /dev/null
> +++ b/tests/generic/706.out
> @@ -0,0 +1,2 @@
> +QA output created by 706
> +Silence is golden


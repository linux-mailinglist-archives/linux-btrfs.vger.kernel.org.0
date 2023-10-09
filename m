Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEC7BE212
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346584AbjJIOFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346443AbjJIOFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 10:05:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA591
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 07:05:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DD9521880;
        Mon,  9 Oct 2023 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696860307;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVGOxhyZiAzUpGbL3Bv9o3WieHWGTGKCuOhV9imqYCQ=;
        b=hZ+rukJhq0wOohFEWPpQvDb87OxGK9tQ0JLkiH/4wzeCE7hdBrUL5ftwFilghNct+8QpLJ
        0ygGrL/ZSakYz2XgXF8aG81CIfnsaJsHyI++O+S/0biPizwTvbWAAJFjMKMAD/oF5CjNT5
        9y/P8CkIM7cSFF9sYli5n2pRDhTchhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696860307;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVGOxhyZiAzUpGbL3Bv9o3WieHWGTGKCuOhV9imqYCQ=;
        b=Hihr+u40/eItwRG6Epu4Nrl/FFVu6O0M3Hn8KQpDEvaBqU6IjLvovO6zNzdsFiHN2quEbB
        J1bPFYAwB3qmgRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4A513586;
        Mon,  9 Oct 2023 14:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Y2zBZMIJGWMAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 14:05:07 +0000
Date:   Mon, 9 Oct 2023 15:58:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests/mkfs: make sure rootdir got its
 xattr copied
Message-ID: <20231009135821.GO28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696822345.git.wqu@suse.com>
 <3daf7ed97305f5482800e28c960e3b5c2ed222b3.1696822345.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3daf7ed97305f5482800e28c960e3b5c2ed222b3.1696822345.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 02:04:09PM +1030, Qu Wenruo wrote:
> The new test case would:
> 
> - Create a dir as source dir for --rootdir
> - Add xattr for that source dir
> - Create a file inside that source dir
> - Add xattr for that file
> - Run "mkfs.btrfs --rootdir" with that source dir
> - Mount the created fs
> - Make sure the following xattr exists:
>   * Xattr for the rootdir
>   * Xattr for that file inside the mount point
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/mkfs-tests/027-rootdir-xattr/test.sh | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100755 tests/mkfs-tests/027-rootdir-xattr/test.sh
> 
> diff --git a/tests/mkfs-tests/027-rootdir-xattr/test.sh b/tests/mkfs-tests/027-rootdir-xattr/test.sh
> new file mode 100755
> index 000000000000..bff9dc71d8e0
> --- /dev/null
> +++ b/tests/mkfs-tests/027-rootdir-xattr/test.sh
> @@ -0,0 +1,40 @@
> +#!/bin/bash
> +# Test if the source dir has xattr, "mkfs.btrfs --rootdir" would properly copy
> +# that xattr to the rootdir inode.
> +
> +source "$TEST_TOP/common" || exit
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +check_global_prereq setfattr
> +check_global_prereq getfattr
> +
> +# Here we don't want to use /tmp, as it's pretty common /tmp is tmpfs, which
> +# doesn't support xattr.
> +# Instead we go $TEST_TOP/btrfs-progs-mkfs-tests-027.XXXXXX/ instead.
> +src_dir=$(mktemp -d --tmpdir=$TEST_TOP btrfs-progs-mkfs-tests-027.XXXXXX)

In case we want to be sure that the underlying filesystem for temporary
files supports the feature we want it's better to create a temporary
btrfs filesystem, either inside the test directory o in /tmp.

Chosing TEST_TOP is IMO wrong because that's where the test related
scritps and logs are, this is not meant for temporary files at all.

Also please use one of the _mktemp helpers.

I'll apply the first patch with fix, please update the test, thanks.

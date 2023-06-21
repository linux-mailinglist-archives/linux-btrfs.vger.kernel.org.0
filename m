Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1341738878
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFUPJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjFUPJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 11:09:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238E49C6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 08:04:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0948D21E54;
        Wed, 21 Jun 2023 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687359802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5smgRe3StBkgZ6trGKF0nfHw96CjkqvFXmAuvXUKlKg=;
        b=Sjs29pnJmQhBP1htGmBpMbwJFl0MEQ4Dz+9+tNoIvhz60JK4jjf8MFlszK++669BvaeOS4
        Oqe8ubX7MBihVYPa/KDL5AA7RHwMO+/5/5UW26O21OJwuI9SiG9pZ9KpikQK7wF0enC3h1
        odYMdA8TuqmRkSEQpNrhUBF2jRK0k08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687359802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5smgRe3StBkgZ6trGKF0nfHw96CjkqvFXmAuvXUKlKg=;
        b=6/olC89tVk4OO7+HjI/KinloduMt/4mkoNH2sM/zCVB0l4kwAws7kWAl4tlP78qNsvRX8v
        ylSLa/enmj/1JLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7D14133E6;
        Wed, 21 Jun 2023 15:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BBvkMzkRk2RjGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Jun 2023 15:03:21 +0000
Date:   Wed, 21 Jun 2023 16:56:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs-progs: tests: add helper check_prereq_btrfsacl
Message-ID: <20230621145658.GQ16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687242517.git.anand.jain@oracle.com>
 <6ace53b5d32b7814cf4770bcb5bb1d2f4287d490.1687242517.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ace53b5d32b7814cf4770bcb5bb1d2f4287d490.1687242517.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 04:49:57PM +0800, Anand Jain wrote:
> Some test cases are failing because acl is not compiled on the system.
> Instead, they should be marked as 'not_run'.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/common | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/common b/tests/common
> index d985ef72a4f1..0c75d5d76c44 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -575,6 +575,19 @@ setup_root_helper()
>  	SUDO_HELPER=root_helper
>  }
>  
> +# Check if btrfs is compiled with CONFIG_BTRFS_FS_POSIX_ACL, requires TEST_DEV.
> +check_prereq_btrfsacl()

The _prereq_ helpers are supposed to check utilities or modules, the
kernel features are named like check_kernel_support_FEATURE.

> +{
> +	run_check_mkfs_test_dev
> +	run_check_mount_test_dev
> +
> +	if grep "$TEST_MNT" /proc/self/mounts | grep -q noacl; then

So this relies on the fact that if ACLs are not compiled in a mounted
filesystem will add noacl to the mount options. This works though
requires a mount. Another option is to grep /proc/config.gz, or
eventually rely on the sysfs export.

That it needs mount can be problematic on kernels with unsupported
features built by default, like eventually block-group-tree. This would
be rare but also would fail the testsuite. The CI environments do not
always have most up-to-date kernels while part of the test suite can
still run.

We can do the mkfs/mount check with some caution, though I don't like it
much.

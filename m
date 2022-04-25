Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB32C50E68E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbiDYRLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbiDYRLW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:11:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC93B020
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:08:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A82F321100;
        Mon, 25 Apr 2022 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650906495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWiuYPAUM9sz1l//t5bHBirbtYYjhhirD3KPB2a9Mng=;
        b=A+EyHdaA5/BP0FrXnjT7wQHUviveRfo0DYP9tB160KLmY3OaOriYMKOlAa2rp49Jgu4P6o
        +5zQk6JXIv5D3CLz1TK6z53wmKSUQHL3CVPYOPvoORqzBPjWmpAyhNS9Z0ZZCbvyYxvaR7
        W48+qkiWDuoGDNbYr7OorDm1DQDnEQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650906495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KWiuYPAUM9sz1l//t5bHBirbtYYjhhirD3KPB2a9Mng=;
        b=d5X14Ikv5P4l+lWS6eu0sHNW+8cpzsHFpxo+g9ADuxNvgbLCMmBOo6oV92p+ttud1vL01X
        cNKEsSStZWZeGBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83E3413AED;
        Mon, 25 Apr 2022 17:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qMM5H3/VZmLxaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 17:08:15 +0000
Date:   Mon, 25 Apr 2022 19:04:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and
 sprouted filesystems
Message-ID: <20220425170408.GR18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 17, 2022 at 03:30:36PM +0800, Qu Wenruo wrote:
> Previously we had a bug that btrfs check would report false warning for
> a sprouted filesystem.
> 
> So this patch will add a new test case to make sure neither seed nor
> and sprouted filesystem will cause such false warning.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  .../fsck-tests/057-seed-false-alerts/test.sh  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100755 tests/fsck-tests/057-seed-false-alerts/test.sh
> 
> diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh b/tests/fsck-tests/057-seed-false-alerts/test.sh
> new file mode 100755
> index 000000000000..3a442c1202d0
> --- /dev/null
> +++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
> @@ -0,0 +1,51 @@
> +#!/bin/bash
> +#
> +# Make sure "btrfs check" won't report false alerts on sprouted filesystems
> +#
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs
> +check_prereq mkfs.btrfs
> +check_prereq btrfstune
> +check_global_prereq losetup
> +
> +setup_loopdevs 2
> +prepare_loopdevs
> +dev1=${loopdevs[1]}
> +dev2=${loopdevs[2]}
> +TEST_DEV=$dev1
> +
> +setup_root_helper
> +
> +run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f $dev1
             ^^^^^^^^^^^^^

It's $SUDO_HELPER, otherwise it does not work, also please quote all
shell variables, everywhere.

> +run_check $SUDO_HELPERS "$TOP/btrfstune" -S1 $dev1
> +run_check_mount_test_dev
> +run_check $SUDO_HELPERS "$TOP/btrfs" device add -f $dev2 $TEST_MNT
> +
> +# Here we can not use umount helper, as it uses the seed device to do the
> +# umount. We need to manually unmout using the mount point
> +run_check $SUDO_HELPERS umount $TEST_MNT
> +
> +seed_output=$(_mktemp --tmpdir btrfs-progs-seed-check-stdout.XXXXXX)

This won't work as intended, there's a helper _mktemp_dir that creates a
temporary directory, otherwise --tmpdir is interpreted as the direcotry
name.

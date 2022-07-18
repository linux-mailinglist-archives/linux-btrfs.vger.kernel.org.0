Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100D9578703
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiGRQJb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiGRQJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:09:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C01CB1F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:09:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9EAC33EAD;
        Mon, 18 Jul 2022 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658160567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEBEBxJ6ptDj1RnVWLNxH92rLOsegOyDXlxdRR5NBZI=;
        b=tMa2uuTkC09qFBOufZ92YRvBu/oODWbZhrRxR2ircb9eJpqsekXYnewRnRU52PaMw0ndga
        zEOZ4hi6Be/zfAHkmsMIayK/ukROgwDyzMpBvU/9UVHpwske092RNI2OPM1AsGrrEbbAFx
        bCSXBoAtgNpiUxSNMW6/hJwIV7SvX08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658160567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEBEBxJ6ptDj1RnVWLNxH92rLOsegOyDXlxdRR5NBZI=;
        b=++1vP+Ao2R/0CzcV0llCoBxHKDKX+TBTlrfLCFIGCGglkWp0v3M/l8RWeWJnPWMmhk02+c
        5CYBYkVXfgDeYCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C46FF13754;
        Mon, 18 Jul 2022 16:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sv8AL7eF1WL/bgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 16:09:27 +0000
Date:   Mon, 18 Jul 2022 18:04:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests: Add test for fi show
Message-ID: <20220718160434.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220329083042.1248264-1-nborisov@suse.com>
 <20220329083042.1248264-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329083042.1248264-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 11:30:42AM +0300, Nikolay Borisov wrote:
> Add a test to ensure that 'btrfs fi show' on a mounted filesyste, which
> has a missing device will explicitly print which device is missing.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

There are some things to fix, even if it's just shell scripting there is
a coding style to follow, and some testsuite specific requirements.

> ---
>  tests/cli-tests/016-fi-show-missing/test.sh | 35 +++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100755 tests/cli-tests/016-fi-show-missing/test.sh
> 
> diff --git a/tests/cli-tests/016-fi-show-missing/test.sh b/tests/cli-tests/016-fi-show-missing/test.sh
> new file mode 100755
> index 000000000000..e24a85d05410
> --- /dev/null
> +++ b/tests/cli-tests/016-fi-show-missing/test.sh
> @@ -0,0 +1,35 @@
> +#!/bin/bash
> +#
> +# Test that if a device is missing for a mounted filesystem, btrfs fi show will
> +# show which device exactly is missing.
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +setup_root_helper
> +setup_loopdevs 2
> +prepare_loopdevs
> +
> +dev1=${loopdevs[1]}
> +dev2=${loopdevs[2]}
> +
> +run_check $SUDO_HELPER "$TOP"/mkfs.btrfs -f -draid1 $dev1 $dev2

I'd rather use "${loopdevs[@]}", also to add quoting around paths.

> +# move the device, changing its path, simulating the device being missing
> +mv $dev2 /dev/loop-non-existent

This fails if not run by root, so
run_check $SUDO_HELPER mv ...

> +
> +run_check $SUDO_HELPER mount -o degraded $dev1 $TEST_MNT

All variables must be quoted

run_check $SUDO_HELPER mount -o degraded "$dev1" "$TEST_MNT"

> +
> +if ! run_check_stdout $SUDO_HELPER "$TOP"/btrfs fi show $TEST_MNT | \

if ! run_check_stdout $SUDO_HELPER "$TOP"/btrfs filesystem show "$TEST_MNT" | \

no command shortcuts

> +	grep -q "$dev2 MISSING"; then
> +
> +	_fail "Didn't find exact missing device"
> +fi
> +
> +mv /dev/loop-non-existent $dev2

Again run_check $SUDO_HELPER

> +
> +run_check $SUDO_HELPER umount $TEST_MNT
> +
> +cleanup_loopdevs
> +
> -- 
> 2.17.1

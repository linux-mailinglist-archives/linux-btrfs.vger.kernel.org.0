Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803B84EB505
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiC2VHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VHk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 17:07:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71EB6D21
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 14:05:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC64B1F37B;
        Tue, 29 Mar 2022 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648587954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuGhfBLcNXZw9Fzid+nbTOnqoMmdAU806sCk89eJXJ0=;
        b=kI9ZlHjePlHWwv+xZ7ALL+wYHlU8lyq8uCYaJu5tMJgJbRtkts1lrVwvLB0/u5utVgexzA
        92yaLxYQljgwiW5z9DFVB+88AU4BNj8tc8kZWaDGc9Tb53wbLZ+aeEitAGEN0B0Q92QF2X
        K9sbKKU5oMUCPZHyD0y4rKrmXaJI1iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648587954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuGhfBLcNXZw9Fzid+nbTOnqoMmdAU806sCk89eJXJ0=;
        b=MSbUURbMn/Wm/pY4mq0HE1KnNFCkiCKmh0+wdf1sdXB1QNiwOWccyxMDoYD6Ot5QtpV0e8
        mxLuJIVEFh8rziCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C2FB5A3B82;
        Tue, 29 Mar 2022 21:05:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46A04DA7F3; Tue, 29 Mar 2022 23:01:57 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:01:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests/fsck: add test case for data csum
 check on raid5
Message-ID: <20220329210157.GB2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648546873.git.wqu@suse.com>
 <ead45d5b0951c20819a5e50369583cbccdd6ea16.1648546873.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead45d5b0951c20819a5e50369583cbccdd6ea16.1648546873.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 05:44:26PM +0800, Qu Wenruo wrote:
> Previously 'btrfs check --check-data-csum' will report tons of false
> alerts for RAID56.
> 
> Add a test case to make sure at least no such false alerts is reported.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  .../056-raid56-false-alerts/test.sh           | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 tests/fsck-tests/056-raid56-false-alerts/test.sh
> 
> diff --git a/tests/fsck-tests/056-raid56-false-alerts/test.sh b/tests/fsck-tests/056-raid56-false-alerts/test.sh
> new file mode 100755
> index 000000000000..b82e999c7740
> --- /dev/null
> +++ b/tests/fsck-tests/056-raid56-false-alerts/test.sh
> @@ -0,0 +1,31 @@
> +#!/bin/bash
> +#
> +# Make sure "btrfs check --check-data-csum" won't report false alerts on RAID56
> +# data.
> +#
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs
> +check_prereq mkfs.btrfs
> +check_global_prereq losetup
> +
> +setup_loopdevs 3
> +prepare_loopdevs
> +dev1=${loopdevs[1]}
> +TEST_DEV=$dev1
> +
> +setup_root_helper
> +
> +run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f -m raid1 -d raid5 ${loopdevs[@]}
              ^^^^^^^^^^^^
              SUDO_HELPER

> +run_check_mount_test_dev
> +
> +run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/file" bs=16K count=1 \
> +	status=noxfer > /dev/null 2>&1

This is not fstests, it's fine to use quieting options (like
status=noxfer) but it's not necessary, and in some cases even harmful
for debugging, to redirect output to /dev/null

> +
> +run_check_umount_test_dev
> +
> +# Check data csum should not report false alerts
> +run_check "$TOP/btrfs" check --check-data-csum "$dev1"
> +
> +cleanup_loopdevs
> -- 
> 2.35.1

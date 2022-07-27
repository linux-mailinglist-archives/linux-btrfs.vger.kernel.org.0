Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D3583356
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiG0TSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiG0TSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:18:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00154AEC
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 12:09:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8DBE34FFD;
        Wed, 27 Jul 2022 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658948980;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QFksX1AAxTDJgP4X5neI0A7H7aavE0+lnjrPVLtN6Y=;
        b=q1uSrs8AEavFmCVWj8aNosW4EIM1DvGb9KGU6bgTUUftuMknpeBiKMwIq9hMsvU0DELjoe
        ozq52zopyZrZmMUW01EO99cjdDJD1CM5CO8DYpbA+i7ZdAbNH+7mMQH4m/We052tuPtd9U
        ThFfijdkonfa9rAr1slZGzP37CnA9sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658948980;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QFksX1AAxTDJgP4X5neI0A7H7aavE0+lnjrPVLtN6Y=;
        b=z3egQlgYug1RnsoKyG8gG7DHUiu8p3V7Xx6uTu/jI6QUHPRf2vlpQuSKZoc5KuPln65J3G
        scwnQQB6zQUpgdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFBC713A8E;
        Wed, 27 Jul 2022 19:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J3jZKXSN4WLsQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 19:09:40 +0000
Date:   Wed, 27 Jul 2022 21:04:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: exit with failure when printing bad
 superblock
Message-ID: <20220727190442.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Mike Fleetwood <mike.fleetwood@googlemail.com>,
        linux-btrfs@vger.kernel.org
References: <1658676734-15294-1-git-send-email-mike.fleetwood@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658676734-15294-1-git-send-email-mike.fleetwood@googlemail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 24, 2022 at 04:32:14PM +0100, Mike Fleetwood wrote:
> Attempting to dump a bad btrfs superblock returns successful exit status
> zero.  According to the manual page non-zero should be returned on
> failure.  Fix this.
>     $ btrfs inspect-internal dump-super /dev/zero
>     superblock: bytenr=65536, device=/dev/zero
>     ---------------------------------------------------------
>     ERROR: bad magic on superblock on /dev/zero at 65536
> 
>     $ echo $?
>     0
> 
> Signed-off-by: Mike Fleetwood <mike.fleetwood@googlemail.com>

Makes sense, thanks.

> ---
>  cmds/inspect-dump-super.c                       | 11 ++++++++---
>  tests/misc-tests/015-dump-super-garbage/test.sh |  6 +++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index d843562..4187da8 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -52,9 +52,9 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>  	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
>  		error("bad magic on superblock on %s at %llu",

I've added a notice to use --force to show it.

>  				filename, (unsigned long long)sb_bytenr);
> -	} else {
> -		btrfs_print_superblock(&sb, full);
> +		return 1;
>  	}
> +	btrfs_print_superblock(&sb, full);
>  	return 0;
>  }
>  
> @@ -177,7 +177,12 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
>  				putchar('\n');
>  			}
>  		} else {
> -			load_and_dump_sb(filename, fd, sb_bytenr, full, force);
> +			if (load_and_dump_sb(filename, fd,
> +						sb_bytenr, full, force)) {
> +				close(fd);
> +				ret = 1;
> +				goto out;
> +			}
>  			putchar('\n');
>  		}
>  		close(fd);
> diff --git a/tests/misc-tests/015-dump-super-garbage/test.sh b/tests/misc-tests/015-dump-super-garbage/test.sh
> index b346945..1e6afa1 100755
> --- a/tests/misc-tests/015-dump-super-garbage/test.sh
> +++ b/tests/misc-tests/015-dump-super-garbage/test.sh
> @@ -6,9 +6,9 @@ source "$TEST_TOP/common"
>  
>  check_prereq btrfs
>  
> -run_check "$TOP/btrfs" inspect-internal dump-super /dev/urandom
> -run_check "$TOP/btrfs" inspect-internal dump-super -a /dev/urandom
> -run_check "$TOP/btrfs" inspect-internal dump-super -fa /dev/urandom
> +run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super /dev/urandom
> +run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super -a /dev/urandom
> +run_mustfail "attempt to print bad superblock without force" "$TOP/btrfs" inspect-internal dump-super -fa /dev/urandom
>  run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
>  run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
>  run_check "$TOP/btrfs" inspect-internal dump-super -Ffa /dev/urandom
> -- 
> 1.8.3.1

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C347C7365
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjJLQro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjJLQrn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 12:47:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4D3A9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 09:47:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E3501F8AB;
        Thu, 12 Oct 2023 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697129260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AN2Gt/C1B8sUGt/ntLJc4LaQ2Q08ZWHCXUxRkk/PPrE=;
        b=IjEFJoW4yf2/DK9iMYsjrBOsOUKotbirCtc8QM/jD0aOlwl/HMsMGEg4ohabiKJ8P1PIOQ
        568f4tj9iXZ3EMCHKOUR9vub6TX/cAVJHkQQifgu2xHdFWlGRW1tFCeG2g8ML8+eoAO+QY
        2f1QLWyYVvEzIA4SxU8UejUCygvQe1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697129260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AN2Gt/C1B8sUGt/ntLJc4LaQ2Q08ZWHCXUxRkk/PPrE=;
        b=BhRAIYf/unFc2jolgxEdrzORpGeaE6MONy5gPwwGwOsnucEEXCljF6iOnsdxmFaSDaxzHP
        aYXlpuC42vd0YCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7296139ED;
        Thu, 12 Oct 2023 16:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tdGaMysjKGXxWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 Oct 2023 16:47:39 +0000
Date:   Thu, 12 Oct 2023 18:40:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmds/scrub: using device's used_bytes to
 print summary for running scrubs
Message-ID: <20231012164052.GL2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <be6f1470add5193fcb435e7bbba875dc60a2a2ba.1697086519.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6f1470add5193fcb435e7bbba875dc60a2a2ba.1697086519.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -9.74
X-Spamd-Result: default: False [-9.74 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.94)[94.69%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 12, 2023 at 03:25:35PM +1030, Qu Wenruo wrote:
> [BUG]
> For running scrubs, with v6.3 and newer btrfs-progs, it can report
> incorrect "Total to scrub":
> 
>   Scrub resumed:    Mon Oct  9 11:28:33 2023
>   Status:           running
>   Duration:         0:44:36
>   Time left:        0:00:00
>   ETA:              Mon Oct  9 11:51:38 2023
>   Total to scrub:   625.49GiB
>   Bytes scrubbed:   625.49GiB  (100.00%)
>   Rate:             239.35MiB/s
>   Error summary:    no errors found
> 
> [CAUSE]
> Commit c88ac0170b35 ("btrfs-progs: scrub: unify the output numbers for
> "Total to scrub"") changed the output method for "Total to scrub", but
> that value is only suitable for finished scrubs.
> 
> For running scrubs, if we use the currently scrubbed values, it would
> lead to the above problem.
> 
> The real scrubbed bytes is only reliable for finished scrubs, not for
> running/canceled/interrupted ones.
> 
> [FIX]
> Change print_scrub_dev() to do extra checks, and only for finished
> scrubs to use the scrubbed bytes.
> Otherwise fall back to the device's bytes_used.
> 
> Issue: #690
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> ---
>  cmds/scrub.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/scrub.c b/cmds/scrub.c
> index c45ab3dd2a31..247e056ac70d 100644
> --- a/cmds/scrub.c
> +++ b/cmds/scrub.c
> @@ -323,9 +323,22 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
>  	if (p) {
>  		if (raw)
>  			print_scrub_full(p);
> -		else
> +		else if (ss->finished)
> +			/*
> +			 * For finished scrub, we can use the total scrubbed
> +			 * bytes to report "Total to scrub", which is more
> +			 * accurate (e.g. mostly empty block groups).
> +			 */
>  			print_scrub_summary(p, ss, p->data_bytes_scrubbed +
>  						   p->tree_bytes_scrubbed);

Please also use { } around single statement blocks but with a long
comment.

> +		else
> +			/*
> +			 * For any canceled/interrupted/running scrub,
> +			 * we're not sure how many bytes we're really
> +			 * going to scrub, thus we use device's used
> +			 * bytes instead.
> +			 */
> +			print_scrub_summary(p, ss, di->bytes_used);
>  	}
>  }
>  
> -- 
> 2.42.0

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37779307E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbjIEU4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjIEU4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:56:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379A19A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 13:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62AF82008E;
        Tue,  5 Sep 2023 20:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693947396;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOvJ/GrxYHr2uEa050PGlWLCpjiO66XsKGEtbgmHTBs=;
        b=QnZbis0ScRZuCalaGsEAoto2BxAvCJnoPmu2cZW4dntkjwakCWY5EmpdfZxeBMcaWYiEPw
        tTfq4yb8S54ANQ0uO5G0zk76W/aHUDpUFpV/MGHI3rtme0CF8PVqt2ph9qQriX+Y+eYSuJ
        7nmxCvJxD+AJ6lRc9mfprczGqE5XhQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693947396;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOvJ/GrxYHr2uEa050PGlWLCpjiO66XsKGEtbgmHTBs=;
        b=OCfP+UaU+f2B6BLWs9b6jomZgy26L5eF4i64jXKoQJTSD9s4tdxcDLpFac5y5ukamdiMoa
        7bFadZvPBBoSx4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39A8D13911;
        Tue,  5 Sep 2023 20:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oNRwDQSW92T5GgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 20:56:36 +0000
Date:   Tue, 5 Sep 2023 22:49:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs-progs: add extent buffer leak detection to
 make test
Message-ID: <20230905204956.GJ14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693945163.git.josef@toxicpanda.com>
 <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 05, 2023 at 04:21:53PM -0400, Josef Bacik wrote:
> I introduced a regression where we were leaking extent buffers, and this
> resulted in the CI failing because we were spewing these errors.
> 
> Instead of waiting for fstests to catch my mistakes, check every command
> output for leak messages, and fail the test if we detect any of these
> messages.  I've made this generic enough that we could check for other
> debug messages in the future.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

There already is a script to verify more than just the error leaks, I've
added it to all the test type running scripts so it would fail.
> ---
>  tests/common | 108 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 47 deletions(-)
> 
> diff --git a/tests/common b/tests/common
> index 602a4122..607ad747 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -160,6 +160,18 @@ _is_target_command()
>  	return 1
>  }
>  
> +# Check to see if there's any debug messages that may mean we have a problem.
> +_check_output()
> +{
> +	local results="$1"
> +
> +	if grep -q "extent buffer leak" "$results"; then
> +		_fail "extent buffer leak reported"

There's more than that we'd like to catch, see tests/scan-results.sh.

> +		return 1
> +	fi
> +	return 0
> +}
> +
>  # Expanding extra commands/options for current command string
>  # This function is responsible for inserting the following things:
>  # - @INSTRUMENT before 'btrfs'  commands

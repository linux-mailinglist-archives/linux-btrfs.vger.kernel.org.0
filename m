Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09D7B592C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjJBRYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjJBRYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 13:24:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93167B4
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 10:24:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AADA21870;
        Mon,  2 Oct 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696267409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SPvsDy8xEvhSXCEIA3pT5uOs5Axgx8am50JatSJFLEg=;
        b=kmZRISYMk1q/I/w2G1FTUh5l8UR14JeSoxSnNCXCV06i1xBw8Y1L6SIBPNRCaYhSxJjNJD
        VqXAv9dUlHD5szFz0PgqGPf+Cl6uyQUWAUWpNsMJurw0thAAHNfvDeD2/ej1ZXh9RDYo8K
        9oM3vypEIi9L4q1kNYffzWPEgoiDBOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696267409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SPvsDy8xEvhSXCEIA3pT5uOs5Axgx8am50JatSJFLEg=;
        b=1Wm4pvQ2BL/sQLzgeFR4Hs9zuH9IPfdwVN241GVl2mb4be5j7vg7gRHFkbJCCO+9P+F0nn
        k1B40AFhdkA0SxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 204D213434;
        Mon,  2 Oct 2023 17:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ykHJBpH8GmXNPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 17:23:29 +0000
Date:   Mon, 2 Oct 2023 19:16:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Message-ID: <20231002171647.GX13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694749532.git.anand.jain@oracle.com>
 <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
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

On Fri, Sep 15, 2023 at 12:08:59PM +0800, Anand Jain wrote:
> The misc-test/034-metadata_uuid test case, has four sets of disk images to
> simulate failed writes during btrfstune -m|M operations. As of now, this
> tests kernel only. Update the test case to verify btrfstune -m|M's
> capacity to recover from the same scenarios.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/misc-tests/034-metadata-uuid/test.sh | 70 ++++++++++++++++------
>  1 file changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
> index 479c7da7a5b2..0b06f1266f57 100755
> --- a/tests/misc-tests/034-metadata-uuid/test.sh
> +++ b/tests/misc-tests/034-metadata-uuid/test.sh
> @@ -195,13 +195,42 @@ check_multi_fsid_unchanged() {
>  	check_flag_cleared "$1" "$2"
>  }
>  
> -failure_recovery() {
> +failure_recovery_progs() {
> +	local image1
> +	local image2
> +	local loop1
> +	local loop2
> +	local devcount
> +
> +	image1=$(extract_image "$1")
> +	image2=$(extract_image "$2")
> +	loop1=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image1")
> +	loop2=$(run_check_stdout $SUDO_HELPER losetup --find --show "$image2")
> +
> +	run_check $SUDO_HELPER udevadm settle
> +
> +	# Scan to make sure btrfs detects both devices before trying to mount
> +	#run_check "$TOP/btrfstune" -m --noscan --device="$loop1" "$loop2"
> +	run_check "$TOP/btrfstune" -m "$loop2"

This lacks $SUDO_HELPER so it does fails when the whole testuite is not
run by a root user. Please make sure that 'make test-...' actually works
before sending the patches.

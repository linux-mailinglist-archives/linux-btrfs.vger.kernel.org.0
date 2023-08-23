Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE07786147
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHWURi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjHWURH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 16:17:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44D10D3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 13:17:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 97193224C8;
        Wed, 23 Aug 2023 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692821821;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9gSgpeGCDcmSR6a1EEwAfqDW5imgUc5UyRWuZK1CGI=;
        b=HS+ePt7NvABJTvldxJzOF6O9bLt/R4p1Xg2fuoQ3vGFoR/mrRIu+U22TCuBMJF2WudfzVC
        jzb7bsxWnzmkzpb/UgUfApavzp2DC7jejM4TA8lO0C+ijC1uZWg4W/LcRrP/oVZfM8LHJ+
        +e4Oq0MMqGFV/B5xJf94+BjWYtFD4hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692821821;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9gSgpeGCDcmSR6a1EEwAfqDW5imgUc5UyRWuZK1CGI=;
        b=S649/Nv1mPjhsrq200xsDT2QOmgKSTaKyJ2Pev4O3r/m8xmF5ZY0rDjT2Hryw0ajCwnEet
        q4r21OZlZCIRdqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C38013458;
        Wed, 23 Aug 2023 20:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XGhiHT1p5mQ1IwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Aug 2023 20:17:01 +0000
Date:   Wed, 23 Aug 2023 22:10:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/16] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Message-ID: <20230823201029.GK2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692018849.git.anand.jain@oracle.com>
 <af8ae1adbb827a1de806af25a63622b19d6765de.1692018849.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8ae1adbb827a1de806af25a63622b19d6765de.1692018849.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 14, 2023 at 11:28:12PM +0800, Anand Jain wrote:
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
> index f2daa76304de..6aa1cdcb47ae 100755
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

Why is this line here? It looks like a valid command line and then it's
confusing. If there's some condition like that you want to require
scanning then put it to comment and explain it, e.g. "we can't use
--noscan here because ...".

> +	run_check "$TOP/btrfstune" -m "$loop2"
> +
> +	# perform any specific check
> +	"$3" "$loop1" "$loop2"
> +
> +	# cleanup
> +	run_check $SUDO_HELPER losetup -d "$loop1"
> +	run_check $SUDO_HELPER losetup -d "$loop2"
> +	rm -f -- "$image1" "$image2"
> +}

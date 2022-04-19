Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE25072EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354593AbiDSQZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352524AbiDSQZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 12:25:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF83A5DA
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 09:22:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3356F210F1;
        Tue, 19 Apr 2022 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650385343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7H4WcqVjLONpikjigObqqsAa9cdNeYkahcDd5+gR1A=;
        b=pDLQW2a2EGjQcdjZHpbSH2aqkJaEcEyq4NjfiI2w41r2axKTnOpBQ5WFusnjWji6Tyzvgy
        pxJaNBvm9omtLd4MUhkugnejE4kfXEHeob3AS2YuxNs9BPj0X1NrpBtYwmU7qkQhe0rRWb
        LPktmySNIhZe23Msb0ZIPhUob+bbLgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650385343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7H4WcqVjLONpikjigObqqsAa9cdNeYkahcDd5+gR1A=;
        b=sZGKRZcc7y5VdcJu9ry4uVHbg4sVngFE4Jvw9L3NWX2RoirYbmP/qZhHvqBXH6kf27YoA2
        3RS7dOwgHi0C4oDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1607B132E7;
        Tue, 19 Apr 2022 16:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDplBL/hXmI1UgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 16:22:23 +0000
Date:   Tue, 19 Apr 2022 18:18:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: check: fix wrong total bytes check for
 seed device
Message-ID: <20220419161819.GF2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <8ed9c80d960090f44b11c4420b5bfbe04170c4a4.1650180472.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed9c80d960090f44b11c4420b5bfbe04170c4a4.1650180472.git.wqu@suse.com>
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

On Sun, Apr 17, 2022 at 03:30:35PM +0800, Qu Wenruo wrote:
> @@ -8579,7 +8583,9 @@ static bool is_super_size_valid(void)
>  	if (!IS_ALIGNED(super_bytes, gfs_info->sectorsize) ||
>  	    !IS_ALIGNED(total_bytes, gfs_info->sectorsize) ||
>  	    super_bytes != total_bytes) {
> -		warning("minor unaligned/mismatch device size detected");
> +		warning("minor unaligned/mismatch device size detected:");
> +		warning("  super block total bytes=%llu found total bytes=%llu",
> +			super_bytes, total_bytes);

Minor thing, the message in warning() should be split the string and
indent, not add another call, that's how it it is done now. If we decide
to do some kind of auto split or reformat then we can do it inside the
helper.

>  		warning(
>  		"recommended to use 'btrfs rescue fix-device-size' to fix it");
>  	}
> -- 
> 2.35.1

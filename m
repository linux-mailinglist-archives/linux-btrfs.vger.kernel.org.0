Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743E50DFC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiDYMSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiDYMSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 08:18:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6E1A041
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 05:15:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C700A210EA;
        Mon, 25 Apr 2022 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650888937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URODi4g8YJzYFDuETcUtphp4dlW1xKTCmuEFZeydb0M=;
        b=y70RK24bAD1POkptF7WRYeqF4OSAtBf86f25JNPwW1jzICaEvaR1DOQKIjbJIP2OrARnSB
        s/K32nHYqU3bNgupnLF8R+NlIl44BccGJxdLFM2p4pUE6MfLpxHqie9pu3zn+PNV8LCiyG
        jYyIeJaBOTi2PUs2u7vuo99+S3kTi/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650888937;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URODi4g8YJzYFDuETcUtphp4dlW1xKTCmuEFZeydb0M=;
        b=eLRccupwgfjizz5SAMdAZPgEYrp6Wt+LjQiQNwKoXorWOH3FFTxKYVr39ctcN0IucXyF5T
        NXZvtzKsd3b4Q2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABD4613AE1;
        Mon, 25 Apr 2022 12:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EO0kKemQZmKdZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 12:15:37 +0000
Date:   Mon, 25 Apr 2022 14:11:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs-progs: make "btrfstune -S1" to reject fs
 with dirty log
Message-ID: <20220425121130.GN18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650368004.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650368004.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 19, 2022 at 07:36:20PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add a test case for it
> 
> 
> A seed device with dirty log can be rejected by kernel, as kernel will
> try to replay log even on RO mount.
> But log replay on RO device is strongly prohibited, thus such seed
> device will be rejected without a way to sprout.
> 
> Fix the problem by letting "btrfstune -S1" to check if the fs has dirty
> log first.
> 
> Also add a test case for it, using a btrfs-image dump.
> 
> Qu Wenruo (2):
>   btrfs-progs: do not allow setting seed flag on fs with dirty log
>   btrfs-progs: make sure "btrfstune -S1" will reject fs with dirty log

Added to devel, thanks.

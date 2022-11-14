Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD6628963
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKNTbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiKNTb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 14:31:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034829824
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 11:31:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 636A933D35;
        Mon, 14 Nov 2022 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668454279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlNzPmvuJiR6LK6Qhnbfba09pRhYLGJoiki3JnhmJAo=;
        b=XV4JPryiUvNaxIThfcfjqzm4V7cIItMvssi2e/qcChkZdfHisOLo3cw4abKWh6nvj/oY4p
        6UqofTb3eCDjcZd33k/ULCH7bDy+Y7UDBm73TSfaLK2FLYpJPMqiRCQwjntdM3aNCaqBPb
        O9Kv1/DuEam8ps3XixmBVIfTfcKgCQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668454279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlNzPmvuJiR6LK6Qhnbfba09pRhYLGJoiki3JnhmJAo=;
        b=Q2x5gkR5uOb+fRmNiGGJg/YOzWOaF3z6oVVWvyCBgNJFV4rQJ1AzEBhnHb0nIp7VJb6w4g
        hTZAbwH1EFBHfMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D36213A8C;
        Mon, 14 Nov 2022 19:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1873DYeXcmMWGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 19:31:19 +0000
Date:   Mon, 14 Nov 2022 20:30:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use btrfs_dev_name() helper to handle missing
 devices better
Message-ID: <20221114193053.GX5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <071d7f1c5f10d185146b83dd665a68ae5a4c9303.1668303064.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071d7f1c5f10d185146b83dd665a68ae5a4c9303.1668303064.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 13, 2022 at 09:32:07AM +0800, Qu Wenruo wrote:
> [BUG]
> If dev-replace failed to re-construct its data/metadata, the kernel
> message would be incorrect for the missing device:
> 
>  BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
>  BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev (efault)
> 
> Note the above "dev (efault)" of the second line.
> While the first line is properly reporting "<missing disk>".
> 
> [CAUSE]
> Although dev-replace is using btrfs_dev_name(), the heavy lifting work
> is still done by scrub (scrub is reused by both dev-replace and regular
> scrub).
> 
> Unfortunately scrub code never uses btrfs_dev_name() helper, as it's
> only declared locally inside dev-replace.c.
> 
> [FIX]
> Fix the output by:
> 
> - Move the btrfs_dev_name() helper to volumes.h
> 
> - Use btrfs_dev_name() to replace open-coded rcu_str_defref() calls
>   Only zoned code is not touched, as I'm not familiar with degraded
>   zoned code.
> 
> Now the output looks pretty sane:
> 
>  BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
>  BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev <missing disk>
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

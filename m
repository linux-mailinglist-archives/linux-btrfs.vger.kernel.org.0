Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825768F8AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjBHUQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjBHUQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:16:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC5BB91;
        Wed,  8 Feb 2023 12:16:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEFE22072F;
        Wed,  8 Feb 2023 20:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675887377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38eF0iECejPU1a+Mp9LNCQL5AtFm/MRsX4YHeT+eHjQ=;
        b=OTKBCKRZ0paCbhC5M7ppg5l7EieTxW6EO6FOfgXB7EfQpHMjl2O1cwFlpYWiZ6CXK80DHV
        HcIC9wmYQn4+1SMUmRVqdAjbbp8bzopce29yVcPX8TyttLWM+Om9ToVFAtwSpoHstFy1IS
        Uqk36Oj1eawOpAT7RyMQ8KJfxjupOZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675887377;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38eF0iECejPU1a+Mp9LNCQL5AtFm/MRsX4YHeT+eHjQ=;
        b=AFiLHQGaQps31IHCAoJ0eIQqaZXKLlh6YfHwRpnwzIKgm+q0JaeY93T8UUWA6tIJ2QUzxD
        4SYyJuE/6wXAGPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9316D1358A;
        Wed,  8 Feb 2023 20:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oML6IhED5GNNLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 08 Feb 2023 20:16:17 +0000
Date:   Wed, 8 Feb 2023 21:10:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ye.xingchen@zte.com.cn
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix compile error about uninitialized variable
Message-ID: <20230208201028.GK28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202302011022199155711@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302011022199155711@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 01, 2023 at 10:22:19AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> fs/btrfs/tree-log.c:6166:6: note: 'last_range_start' was declared here
> fs/btrfs/volumes.c:2598:27: note: 'seed_devices' was declared here
> fs/btrfs/send.c:1909:13: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]

We have the warning -Wmaybe-uninitialized enabled locally for fs/btrfs/
and no pending compiler warnings but in case you find something please
tell us which compiler and version it is. Sometimes it makes sense to
fix warnings for older yet still widely used versions.

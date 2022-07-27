Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8235833C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiG0Tlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0Tlu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:41:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C952444
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 12:41:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C47020D26;
        Wed, 27 Jul 2022 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658950907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BP71F4Q+gj1LLU2wOiO5FyG0pzFgVr5h3nntFMbujXY=;
        b=PVF9LrNgCdz0CIQTuvZXyeJzCinSVKaz9ioftrHrqMQw46HKZH2M98ZPWpLin2+Ee8WePC
        BJVJ2TXAOnmhh6xE4fVQJXcJYuo/S5IjhHdpFk3E+W6rSN95WDE+8hMAwYygyQ1AbpUfyo
        WG4eNmZwRq6aeq+8b8M+5LEGCTSUvwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658950907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BP71F4Q+gj1LLU2wOiO5FyG0pzFgVr5h3nntFMbujXY=;
        b=tVwptrG8Q6HdsNJEKDVXe+R7lHrLOMEMDdsoaOGY65vT9FWNUKR3F2uZiMwttj62AEPB+Y
        zgpWm42h/XWkL8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ED1B13A8E;
        Wed, 27 Jul 2022 19:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QGkeFvuU4WK0TQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 19:41:47 +0000
Date:   Wed, 27 Jul 2022 21:36:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] device-utils.c: Use linux mount.h instead of sys/mount.h
Message-ID: <20220727193649.GY13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Khem Raj <raj.khem@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20220725185835.1356165-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725185835.1356165-1-raj.khem@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 11:58:35AM -0700, Khem Raj wrote:
> This file includes linucx/fs.h which includes linux/mount.h and with
> glibc 2.36 linux/mount.h and glibc mount.h are not compatible [1]
> therefore try to avoid including both headers
> 
> [1] https://sourceware.org/glibc/wiki/Release/2.36
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

I don't have 2.36 available yet so can't test it, but it builds on all
the older distros so it's safe. Added to devel, thanks.

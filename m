Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE058819F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiHBSEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiHBSDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 14:03:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02E51A36
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 11:03:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B062520A95;
        Tue,  2 Aug 2022 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659463425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oscnt2PCKQZlRLg7yHY6yvxxwxObWeszcjiAU/36RjU=;
        b=UNVSjw2Nd9MzUnhM2GnPNjyeaX30vfbJ6Yw04EcQe40gK5Ml49eoFzygchXNndMUBLzWqw
        ns9cKeQKMkfGLk/Txxg0eIMwDtCl13urE9/DHphvNhtL3x4E2rTGSpkja4Hh+G0zgEL7g4
        htfKWTSvweha/4xZV+95pGHJ16wcQM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659463425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oscnt2PCKQZlRLg7yHY6yvxxwxObWeszcjiAU/36RjU=;
        b=oM8Gr8X2tdHUiAx59ZHBf2sOXASCgKMC06domavUtue5a3wAPiC7CvOuA/ocZOnpuLCri+
        wGNMzsPmxd121dBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86EF91345B;
        Tue,  2 Aug 2022 18:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PxI+HwFn6WIDTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 18:03:45 +0000
Date:   Tue, 2 Aug 2022 19:58:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/7] btrfs: Annotate wait events with lockdep
Message-ID: <20220802175843.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220725221150.3959022-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725221150.3959022-1-iangelak@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 03:11:44PM -0700, Ioannis Angelakopoulos wrote:
> Hello,
> 
> With this patch series we annotate wait events in btrfs with lockdep to
> catch deadlocks involving these wait events.
> 
> Recently the btrfs developers fixed a non trivial deadlock involving
> wait events
> https://lore.kernel.org/linux-btrfs/20220614131413.GJ20633@twin.jikos.cz/
> 
> Currently lockdep is unable to catch these deadlocks since it does not
> support wait events by default.
> 
> With our lockdep annotations we train lockdep to track these wait events
> and catch more potential deadlocks.
> 
> Specifically, we annotate the below wait events in fs/btrfs/transaction.c
> and in fs/btrfs/ordered-data.c:
> 
>   1) The num_writers wait event
>   2) The num_extwriters wait event
>   3) The transaction states wait events
>   4) The pending_ordered wait event
>   5) The ordered extents wait event

That's very useful, thanks. I've edited some changelogs, reformatted
some comments or minor style things. It would be nice to get it merged
soon but we also need time for testing, so tentative plan is to get it
to rc3 at the latest. Until then it'll be in misc-next.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106B6526E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiLTTZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiLTTZp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:25:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A1B19
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:25:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42A41768DC;
        Tue, 20 Dec 2022 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671564342;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gbp5Ss6+9wktso8ymIaca4JHriYKLZSlezsQd29zyOQ=;
        b=tMNFjWHsRuLOIwuQHd4eWtpVAQgnfLvFPbrUs5B5TcXCuvHdGW2QquJkPjg5EamdFrG/+0
        rnZzkAsrzquFYamNuP9fo7rR9CIwfwQ+5QkD3P4+h+JiJqjgywF9FTJz7yChgf0O5NEvee
        oYSTJgeR74rGhOyAoiqI4D2bAL/YSSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671564342;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gbp5Ss6+9wktso8ymIaca4JHriYKLZSlezsQd29zyOQ=;
        b=Jbl5DGo6Re+5vk9EMMy5eO85orxg8I3uULYfHyM3eK3gfNpTOuhdkOad8dPsBac99fWqg8
        fRx82K0KXLO6WOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12ACB13254;
        Tue, 20 Dec 2022 19:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sMumAzYMomPdPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:25:42 +0000
Date:   Tue, 20 Dec 2022 20:24:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Message-ID: <20221220192456.GR10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
 <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
 <20221219070514.tgfqoiethziuwfdq@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219070514.tgfqoiethziuwfdq@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 19, 2022 at 07:05:15AM +0000, Naohiro Aota wrote:
> On Fri, Dec 16, 2022 at 03:15:56PM -0500, Josef Bacik wrote:
> > There's a special case for loading the device zone info if we have the
> > zone cache which is a fair bit of code.  Extract this out into it's own
> > helper to clean up the code a little bit, and as a side effect it fixes
> > an uninitialized error we get with -Wmaybe-uninitialized where it
> > thought zno may have been uninitialized.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I'm going to rewrite the code around here with the following WIP branch, to
> improve the zone caching.
> 
> https://github.com/naota/linux/commits/feature/zone-cache
> 
> Specifically, this commit removes the for-loop and the "if (i ==
> *nr_zones)" block you moved in this patch. So, the resulting code will be
> small enough to keep it there.
> 
> https://github.com/naota/linux/commit/8d592ac744111bb2f51595a1608beecadb2c5d03
> 
> Could you wait for a while for me to clean-up and send the series? I'll
> also check the series with -Wmaybe-uninitialized.

I'd like to have the warnigs fixes first but if there is a shorter fix
that would not move the code then it can go in now and you wouldn't have
to redo your changes.

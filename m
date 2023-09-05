Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35C792E9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 21:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbjIETQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjIETQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 15:16:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7F10DE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 12:16:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 823131FFE2;
        Tue,  5 Sep 2023 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693940984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlaurX9qjfmboJ+Ht6H2xbwD9IqE9gAVsbeTmxeGf4k=;
        b=E1xaMgDP5sZe7brpjiTA3sBzemvI0oBLmSh5dk83sH4cx/Usu8W/Xi9GD87++tgwmPzVlS
        vWISmw4PZ5NLPzK3NHj64F6RwqoeAh5XGvoZzn/MZZIYDI1f7SbhtLidQ0sagy/yvUFbd2
        A4GXcQdevfWtL4ozmwwWNygYlIlXbQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693940984;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlaurX9qjfmboJ+Ht6H2xbwD9IqE9gAVsbeTmxeGf4k=;
        b=ReEKbFC0syT9eG1HIjCmriGRcTuQJ47pdbv18IV0hchQRe1Qx6yyxYwluv2UXLrKeArvIV
        dkFpQMyckouSWDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6933813911;
        Tue,  5 Sep 2023 19:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C37uGPh892SsaAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 19:09:44 +0000
Date:   Tue, 5 Sep 2023 21:03:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a free_root_extent_buffers helper
Message-ID: <20230905190304.GH14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
 <20230829174533.GI14420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829174533.GI14420@twin.jikos.cz>
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

On Tue, Aug 29, 2023 at 07:45:34PM +0200, David Sterba wrote:
> On Fri, Aug 25, 2023 at 09:17:45AM -0400, Josef Bacik wrote:
> > Our CI started failing a bunch because I accidentally introduced an
> > extent buffer leak.  This is because we haphazardly have ->commit_roots
> > used in btrfs-progs, and they get freed when the transaction commits and
> > then they're cleared out.  In the kernel we make sure to free all this
> > when we free the root, but we don't have the same thing in btrfs-progs.
> > Fix this by bringing over the free_root_extent_buffers helper and use
> > this for free'ing up all the roots.  This brings us inline with the
> > kernel more and eliminates the extent buffer leak.
> 
> With this patch applied in devel I still see the leaks after mkfs.

I've removed this patch, there are more patches introducing the leaks so
I'd like to get a clean series without the fixups.

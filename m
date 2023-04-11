Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2D6DE32C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDKRwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKRww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 13:52:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B11173C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 10:52:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4A1F1F45E;
        Tue, 11 Apr 2023 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681235569;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0QLN+GLgy+rl63YEhwLCa7r98y0nxnfHvq4nEsirqI=;
        b=bqqU66/ukH0Mxj4gXm8ab8AeozbNkY7Y10k8QxUlMBs7UbC6WGbGNxzlQvEXB7DdKRz5qQ
        zBZ/1wyi8o0LAWnq3ZLYyoYFynIzL8CLdlAHIZgtNBZJZtbuBsOY+ba8rSnhkeyrZu1kPo
        vJas6nuGh/AaiNNBnD4R7Qb50DEPgbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681235569;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0QLN+GLgy+rl63YEhwLCa7r98y0nxnfHvq4nEsirqI=;
        b=0WF40b15tzJTBcd7/1fsk+OWduxBU6VVwf4++dPu9wFhM2m3ZtoDXbQtaBXLZszm8aGQAV
        4xMa8j7ezy80gOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86C1113519;
        Tue, 11 Apr 2023 17:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5pktIHGeNWSdSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Apr 2023 17:52:49 +0000
Date:   Tue, 11 Apr 2023 19:52:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Michael Bromilow <stick.insects22@gmail.com>
Cc:     Boris Burkov <boris@bur.io>, Chris Mason <clm@meta.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230411175239.GA19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
 <20230404185138.GB344341@zen>
 <6a54fa77-9a0c-8844-2eb0-b65591e97a16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a54fa77-9a0c-8844-2eb0-b65591e97a16@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 03:03:37AM +0100, Michael Bromilow wrote:
> On 04/04/2023 19:51, Boris Burkov wrote:
> > On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
> >> So, honestly from my POV the async discard is best suited to consumer
> >> devices.  Our defaults are probably wrong because no matter what you
> >> choose there's a drive out there that makes it look bad.  Also, laptops
> >> probably don't want the slow dribble.
> > 
> > Our reasonable options, as I see them:
> > - back to nodiscard, rely on periodic trims from the OS.
> > - leave low iops_limit, drives stay busy unexpectedly long, conclude that
> >    that's OK, and communicate the tuning/measurement options better.
> > - set a high iops_limit (e.g. 1000) drives will get back to idle faster.
> > - change an unset iops_limit to mean truly unlimited async discard, set
> >    that as the default, and anyone who cares to meter it can set an
> >    iops_limit.
> > 
> > The regression here is in drive idle time due to modest discard getting
> > metered out over minutes rather than dealt with relatively quickly. So
> > I would favor the unlimited async discard mode and will send a patch to
> > that effect which we can discuss.
> 
> Will power usage be taken into consideration? I only noticed this regression
> myself when my laptop started to draw a constant extra ~10W from the constant
> drive activity, so I imagine other laptop users would also prefer a default
> which avoids this if possible. If "relatively quickly" means anything more
> than a few seconds I could see that causing rather significant battery life
> reductions.

This may need to be configured from userspace, e.g. from
laptop-mode-tools, I'm not sure if any of the power usage info is
available from kernel.

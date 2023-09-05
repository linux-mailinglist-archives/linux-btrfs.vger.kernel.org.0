Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3779379257D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjIEQDD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354723AbjIENv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:51:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8811197
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 06:51:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C0421FE09;
        Tue,  5 Sep 2023 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693921913;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fASa9sF+dtg8wX4Bv4sw0cFA1ohN9qLhrUWElzCScEw=;
        b=JGnyzSyEXbwNjJ2Z9cm+DkDfVGQ/kqAwgdNDsZbOkcrsDH7TeNmATZ12MRzoTM/6msYU0F
        dabvIWbdK4j+rlA5uL/Nbh86ZL+PMt1a/3NrTpSRZ8x+olP+piqwq4UXixP3wgl1ntTYrI
        x9hRPlNNbK/xgobfWeoPdBGeZBmLqIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693921913;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fASa9sF+dtg8wX4Bv4sw0cFA1ohN9qLhrUWElzCScEw=;
        b=KM2Dotk5eMPFcIGMfmBzDz2kXud+cCFoTuMiRU2e0cOVRex7eFLda0HalHCBYvG9cRl6Oo
        gNoI9faKY+pCOvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 757D813499;
        Tue,  5 Sep 2023 13:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cz0IHHky92Q4QwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 13:51:53 +0000
Date:   Tue, 5 Sep 2023 15:45:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 00/12] btrfs: ctree.[ch] cleanups
Message-ID: <20230905134513.GB14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692994620.git.josef@toxicpanda.com>
 <e0ef816c-45d4-43a2-aca3-8000c2c53679@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ef816c-45d4-43a2-aca3-8000c2c53679@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 28, 2023 at 04:25:47PM +0000, Johannes Thumshirn wrote:
> On 25.08.23 22:21, Josef Bacik wrote:
> > v1->v2:
> > - added "btrfs: include linux/security.h in super.c" to deal with a compile
> >    error after removing it from ctree.h in certain configs.
> > 
> > --- Original email ---
> > Hello,
> > 
> > While refreshing my ctree sync patches for btrfs-progs I ran into some oddness
> > around our crc32c related helpers that made the sync awkward.  This moves those
> > helpers around to other locations to make it easier to sync ctree.c into
> > btrfs-progs.
> > 
> > I also got a little distracted by the massive amount of includes we have in
> > ctree.h, so I moved code around to trim this down to the bare minimum we need
> > currently.
> > 
> > There's no functional change here, just moving things about and renaming things.
> > Thanks,
> > 
> > Josef
> > 
> 
> I'd fold 6/12 into the patches moving the hash functions, but otherwise

Agreed, updating includes as a collateral change is acceptable, though
in this series the point was to get the includes ready before the final
change to ctree.h. I'll fold the patch as you suggest, thanks.

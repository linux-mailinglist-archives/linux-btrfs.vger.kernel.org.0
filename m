Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0677D4B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjHOU67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbjHOU6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 16:58:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2168EF2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 13:58:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA7441F8C3;
        Tue, 15 Aug 2023 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692133121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9ULxqgGN7A6Q0sWgeDW6yVT5h6AfpOMTWbv5jeO7N8=;
        b=WiokdLoEBgaErhXo2uRJ5iCWRiOPX+Ebr+cept4km/tBJnijDfeXPik6uYBvrlI0eslKal
        hpbXIafy6ZKg4sSTd0xbXgGvvEnyXMjm9LMpok4OPTGQczejuDHE34jgFQFTieoGLLSHFy
        30V64IqEgQDbhPVpsg1/+U6Xr9FXKZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692133121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9ULxqgGN7A6Q0sWgeDW6yVT5h6AfpOMTWbv5jeO7N8=;
        b=pfp4iROvZG47VLPgdMnUhsE+nl5KtIVNE5n0DVcXSp5rt8hm34c/Y1gMiT3iUK2keqgzgT
        0kVnzL9LUY+9UnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BDA51353E;
        Tue, 15 Aug 2023 20:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7/A/JQHn22QNBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Aug 2023 20:58:41 +0000
Date:   Tue, 15 Aug 2023 22:52:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: scrub: improve the scrub performance
Message-ID: <20230815205214.GG2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1691044274.git.wqu@suse.com>
 <20230810180905.GM2420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810180905.GM2420@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 08:09:05PM +0200, David Sterba wrote:
> On Thu, Aug 03, 2023 at 02:33:28PM +0800, Qu Wenruo wrote:
> > [REPO]
> > https://github.com/adam900710/linux/tree/scrub_testing
> > 
> > [CHANGELOG]
> > v2:
> > - Fix a double accounting error in the last patch
> >   scrub_stripe_report_errors() is called twice, thus doubling the
> >   accounting.
> 
> I've added the series to for-next. Current plan is to get it to 6.5
> eventually and then backport to 6.4. I need to review it more carefully
> than last time the scrub rewrite got merged and also give it a test on
> NVMe drives myself. Fallback plan is 6.6 and then do the backports.
> We're approaching 6.5 final and even though it's a big regression I
> don't want to introduce bugs given the remaining time to fix them.

Moved from for-next to misc-next. With the fixup of kvzalloc of scrub
context due to increased side. As mentioned on slack, the testing was
not conclusive, I can't reproduce the slow scrub on single or raid0
profiles, both versions go up to full speed (3G/s on a PCIe, but in a VM
so there are caching effects). But given the time we need to move
forward so I've added the series to misc-next.

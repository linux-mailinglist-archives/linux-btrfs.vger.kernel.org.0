Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBE52152E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiEJM1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbiEJM1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:27:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D517CE61
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 05:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1151F1F895;
        Tue, 10 May 2022 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652185395;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RdFrZZ8xX20UxirFlPDx1nvadSD7exhKjA2DJb53sg=;
        b=K3ndyHr0eBwag2+3cHVn17LXMuBZtoV6jq6vCl2KeyzobcIBp1JuzS7h7cawfXZ6fWQztU
        AX/9dXXkKw2Qn++lXLyKD4GtGqjFuG+qPtmWuNpDnBFIy8Zcrb5FTS+UKvga5HWHhp6fw8
        qmHBktetj5F3k23jRJIT2UxrTwowD5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652185395;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RdFrZZ8xX20UxirFlPDx1nvadSD7exhKjA2DJb53sg=;
        b=iyTrk/8j8ih19OU1MrY/vUDQqfhqh/N0Ik0RykTGfjt9vzWanNY9vWH41ewS9QHjjG/inC
        mcEst22xXUJX4qCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7E7413AC1;
        Tue, 10 May 2022 12:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4oHeMzJZemLABgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 May 2022 12:23:14 +0000
Date:   Tue, 10 May 2022 14:19:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Message-ID: <20220510121900.GN18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
 <20220510114858.GL18596@twin.jikos.cz>
 <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
 <b3bd300f-7b1c-6bef-5377-b437e947f1c1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3bd300f-7b1c-6bef-5377-b437e947f1c1@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 10, 2022 at 08:10:22PM +0800, Qu Wenruo wrote:
> On 2022/5/10 20:02, Qu Wenruo wrote:
> > On 2022/5/10 19:48, David Sterba wrote:
> >> On Tue, May 10, 2022 at 02:03:18PM +0800, Qu Wenruo wrote:
> >>> For the default CRC32 checksum, print-tree now prints tons of
> >>> unnecessary padding zeros:
> >>>
> >>>    btrfs-progs v5.17
> >>>    chunk tree
> >>>    leaf 22036480 items 7 free space 15430 generation 6 owner CHUNK_TREE
> >>>    leaf 22036480 flags 0x1(WRITTEN) backref revision 1
> >>>    checksum stored
> >>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
> >>>    checksum calced
> >>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
> >>>    fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e
> >>>
> >>> This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
> >>> experimental, new option to switch csums"), and it looks like most
> >>> distros just enable EXPERIMENTAL features by default.
> >>
> >> Which distros?
> >
> > Archlinux.
> >
> > Their PKGBUILD can be found here:
> > https://github.com/archlinux/svntogit-packages/blob/packages/btrfs-progs/trunk/PKGBUILD
> >
> >
> > Which doesn't enable experimental explicitly, but still got the full
> > csum output.
> 
> OK, got the reason why the EXPERIMENTAL thing doesn't work as expected.
> 
> In configure, we set $EXPERIMENTAL=0 by default, then
> add the line into confdefs.h:
> 
> #define EXPERIMENTAL 0
> 
> However in print-tree.c, we use
> 
> #ifdef EXPERIMENTAL
> 
> Then it always get enabled, no matter if it's 0 or 1.
> 
> We should either don't define it at all, and use the "#ifdef" way, or we
> should go "#if EXPERIMENTAL" instead.

Oh you're right, #ifdef is wrong, it's supposed to be either
"if (EXPERIMENTAL)" or "#if". My bad, I'll fix it.

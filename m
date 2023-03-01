Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D46A64E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 02:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCABlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 20:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCABlt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 20:41:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBFF97E
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 17:41:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A690C1FE12;
        Wed,  1 Mar 2023 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677634906;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IckHbDCo626p2JsCfqzuoW9SnY6e/KzUF25vwy6ouvQ=;
        b=sc35etPemiZh837A7O4/Hye8aWAzOCOOMz094j1jnS94DbBFJ4EV/9G5cSK3eFwpgs+zLC
        cqITFm2mstT5zxOs7GLgBb3793R1Yhbb9iAIVgozVbBkuCBSiwtC5XWoYarn7YCjqMC7p+
        r5aAesQvlOhgtfmTmCrJfNe3eKlR7RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677634906;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IckHbDCo626p2JsCfqzuoW9SnY6e/KzUF25vwy6ouvQ=;
        b=z1Nw/eTa1o3RXiI/8P/+3w7MJUoVWn+SrXpaw6CHO1V+UvjCHseFppa5bUg+cN9iG7lxaU
        lJ/CZMh3dBaOhiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7407513A3E;
        Wed,  1 Mar 2023 01:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pIHMGlqt/mOhYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 01:41:46 +0000
Date:   Wed, 1 Mar 2023 02:35:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.2
Message-ID: <20230301013546.GU10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
 <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
 <20230301001504.GT10580@suse.cz>
 <a6fbb53a-f5bd-3d01-5944-1e7dfe60985e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6fbb53a-f5bd-3d01-5944-1e7dfe60985e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 08:30:05AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/3/1 08:15, David Sterba wrote:
> > On Wed, Mar 01, 2023 at 08:17:59AM +0800, Qu Wenruo wrote:
> >> On 2023/3/1 07:07, Tomasz Kłoczko wrote:
> >>> On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
> >> cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o
> >> cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o
> >> cmds/reflink.o mkfs/common.o check/mode-common.o check/mode-lowmem.o
> >> check/clear-cache.o libbtrfsutil.a  -rdynamic -L.   -luuid  -lblkid
> >> -ludev  -L. -pthread  -lz  -llzo2 -lzstd
> >>
> >> According to the Makefile, it looks like Fedora build is not using the
> >> built-in crypto code.
> >>
> >> If using libsodium, I got the same error, as libsodium goes a different
> >> name for its blake2b_init (crypto_generichash_blake2b_init).
> > 
> > Oh right, thanks, I can reproduce it now.
> 
> And bisection points to the following two patches:
> 
> bbf703bfd3f68958d33d139eb22057ab397e6c68 btrfs-progs: crypto: call 
> sha256 implementations by pointer
> d1c366ee42bd3d2abb4fd855ac4a496b720d8bb6 btrfs-progs: crypto: call 
> blake2 implementations by pointer

Yeah I know, I did some last minute changes to the commits because 32bit
builds on intel and arm failed due to the flag and feature detection.
The fix is not straightforward but now I have something that works.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F62576582
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiGOQ6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbiGOQ55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 12:57:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326647AB3F
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 09:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B568420393;
        Fri, 15 Jul 2022 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657904244;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQDOzMayGpqH+bIMZth8L3q+pR4w2anXAFC8nz5vlU=;
        b=Jzy6IWSSrg/H9q/E5x8yA7abAEHo50Obe42daSZ5CalTP1SwKbx6X/h0O5GxoOTuaTQCJS
        2oPZX6RQIohFJWZE1VVLdJJVKrMaL9wOIrqx3tEA7fSAfFXCZINFtHGr8ZA0hiRNUWnQh0
        oCtg8na1FISmdgGptRJ+R0qQQO3C2oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657904244;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmQDOzMayGpqH+bIMZth8L3q+pR4w2anXAFC8nz5vlU=;
        b=csNflpR98b7asizwh+JznwYsF4fNgBhv80TIlybv4Je23kJImRNsVTTNPsLHAlOjdFoB7A
        4zqaKy50wrG15YAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 874D113754;
        Fri, 15 Jul 2022 16:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6pz8H3Sc0WJLewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Jul 2022 16:57:24 +0000
Date:   Fri, 15 Jul 2022 18:52:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/3] btrfs: fix a couple sleeps while holding a spinlock
Message-ID: <20220715165232.GC13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1657097693.git.fdmanana@suse.com>
 <20220713135955.GA1114299@falcondesktop>
 <20220715120129.GA13489@twin.jikos.cz>
 <383472a6-75e2-8c70-2c1e-a27234e7b761@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <383472a6-75e2-8c70-2c1e-a27234e7b761@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 15, 2022 at 03:47:34PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.07.22 г. 15:01 ч., David Sterba wrote:
> > On Wed, Jul 13, 2022 at 02:59:55PM +0100, Filipe Manana wrote:
> >> On Wed, Jul 06, 2022 at 10:09:44AM +0100, fdmanana@kernel.org wrote:
> >>> From: Filipe Manana <fdmanana@suse.com>
> >>>
> >>> After the recent conversions of a couple radix trees to XArrays, we now
> >>> can end up attempting to sleep while holding a spinlock. This happens
> >>> because if xa_insert() allocates memory (using GFP_NOFS) it may need to
> >>> sleep (more likely to happen when under memory pressure). In the old
> >>> code this did not happen because we had radix_tree_preload() called
> >>> before taking the spinlocks.
> >>>
> >>> Filipe Manana (3):
> >>>    btrfs: fix sleep while under a spinlock when allocating delayed inode
> >>>    btrfs: fix sleep while under a spinlock when inserting a fs root
> >>>    btrfs: free qgroup metadata without holding the fs roots lock
> >>
> >> David, are you going to pick these up or revert the patches that did the
> >> radix tree to xarray conversion?
> > 
> > Switching sping lock to mutex seems quite heavy weight, and reverting
> > xarray conversion is intrusive, so it's choosing from two bad options,
> > also that we haven't identified the problems earlier. Doing such changes
> > in rc6 is quite unpleasant, I'll explore the options.
> 
> 
> I'm actually in favor of using the mutexes. For example looking at the 
> users of root->inode_lock:

We want to do the xarray conversion eventually but this would be better
done in the whole cycle, so I'm going to send the revert.

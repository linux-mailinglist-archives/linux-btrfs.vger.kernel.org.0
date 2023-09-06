Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1E7941B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjIFQtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIFQtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:49:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51A198B
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:49:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D04B20292;
        Wed,  6 Sep 2023 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694018954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxE43GEsurDXg94jo8ghpZXuffkbvRdtXnlDm6SenVc=;
        b=ckB3uzZmlBpKVFyxge52t0s5K+boaMCRLqNxGmn9T0hLM4v0nBrptC4E7lTj1jkcE9C3Mr
        0/hXERpCBAygpfwsAQJGV/425k2G+WyJ73FbwEtKJGVWPgGitq0HGXM+D3fKdDj/fkc+I8
        TboqXWZbeHioqzxK0125xW3/f5CJtYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694018954;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxE43GEsurDXg94jo8ghpZXuffkbvRdtXnlDm6SenVc=;
        b=TQTjzw1N+jNAsGKc9Rdq3Bg+1lMstZz/9rH7YXfWbbR6e8MOvF1DpWkcV0xqalqb6S4EQP
        ryg/1Kd/YTjUA2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC6B31346C;
        Wed,  6 Sep 2023 16:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H4rxOImt+GQGDAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:49:13 +0000
Date:   Wed, 6 Sep 2023 18:42:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: prealloc btrfs_qgroup_list for
 __add_relation_rb()
Message-ID: <20230906164233.GR14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ca35f1e6134d6e14abee25f1c230c55b1d3f8ae0.1693534205.git.wqu@suse.com>
 <20230905124610.GW14420@twin.jikos.cz>
 <2c59efaf-f46a-4ab4-9360-a64917267c2d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c59efaf-f46a-4ab4-9360-a64917267c2d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 06:19:31AM +0800, Qu Wenruo wrote:
> On 2023/9/5 20:46, David Sterba wrote:
> > On Fri, Sep 01, 2023 at 10:11:16AM +0800, Qu Wenruo wrote:
> >> Currently we go GFP_ATOMIC allocation for qgroup relation add, this
> >> includes the following 3 call sites:
> >>
> >> - btrfs_read_qgroup_config()
> >>    This is not really needed, as at that time we're still in single
> >>    thread mode, and no spin lock is held.
> >>
> >> - btrfs_add_qgroup_relation()
> >>    This one is holding spinlock, but we're ensured to add at most one
> >>    relation, thus we can easily do a preallocation and use the
> >>    preallocated memory to avoid GFP_ATOMIC.
> >>
> >> - btrfs_qgroup_inherit()
> >>    This is a little more tricky, as we may have as many relationships as
> >>    inherit::num_qgroups.
> >>    Thus we have to properly allocate an array then preallocate all the
> >>    memory.
> >>
> >> This patch would remove the GFP_ATOMIC allocation for above involved
> >> call sites, by doing preallocation before holding the spinlock, and let
> >> __add_relation_rb() to handle the freeing of the structure.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > This does not seem to apply cleanly on anything recent, neither master,
> > misc-next (with unrelated patches) or the series cleaning GFP_ATOMIC
> > from qgroups. The last mentioned series looks good so far so I'm about
> > to merge it soon so you can then refresh this patch on top of that.
> 
> That's a little weird, as this patch is the last one from my
> qgroup_mutex branch.
> 
> And this patch doesn't really touch anything from the qgroup iterator
> part, thus I don't know why it doesn't apply cleanly.
> 
> But for sure, I can refresh it when needed.

The missing dependency was the patch "btrfs: qgroup: pre-allocate
btrfs_qgroup to reduce GFP_ATOMIC usage", with that applied there's only
a minor conflict with the 'nofs_flags' variable from some previous
iterations. Added to misc-next, thanks.

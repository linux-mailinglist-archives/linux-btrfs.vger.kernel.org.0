Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C35A6961
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiH3RQt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH3RQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 13:16:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CB0D25D0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 10:16:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C56231FA1E;
        Tue, 30 Aug 2022 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661879804;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4HdGoHfUg2nqKr0z1gTh+2C6POHQpuGuvfDJBs7Yfo=;
        b=B0qEl8WMJ8MNIaQO8pGRSuu9iC8QJyLZTd2Ha6ZO8gDLWIc9UVQSnYhEcWTwcC7M1LQtsw
        4bt1xsGWHSirnAgIzjtk8ua6/ZVUtJ6V4N89xYIbWP2ZpYr1ik0qChYbXtE8qoJwJZ0eoQ
        0ulHaKIr3fUmlQuBrFY/0AgXJ4hXvR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661879804;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4HdGoHfUg2nqKr0z1gTh+2C6POHQpuGuvfDJBs7Yfo=;
        b=opSinNbEnfD5v78O9ohk0rFQdBSHojLCoqy8GamzqnMJXOkJ3D43n06B4gv6+tzEYXrxtO
        JCm8cNGQyb+d8UCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912D013B0C;
        Tue, 30 Aug 2022 17:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YLh/IvxFDmNTXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 Aug 2022 17:16:44 +0000
Date:   Tue, 30 Aug 2022 19:11:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs-progs: check for invalid free space tree entries
Message-ID: <20220830171126.GA13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <e3fa3936cd8b01a05390d364a2cf41ca6c3f7834.1659128926.git.josef@toxicpanda.com>
 <8f9f288a-4c29-8128-327c-5430945e5984@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9f288a-4c29-8128-327c-5430945e5984@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 12:46:53PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/30 05:08, Josef Bacik wrote:
> > While testing some changes to how we reclaim block groups I started
> > hitting failures with my TEST_DEV.  This occurred because I had a bug
> > and failed to properly remove a block groups free space tree entries.
> > However this wasn't caught in testing when it happened because
> > btrfs check only checks that the free space cache for the existing block
> > groups is valid, it doesn't check for free space entries that don't have
> > a corresponding block group.
> >
> > Fix this by checking for free space entries that don't have a
> > corresponding block group.  Additionally add a test image to validate
> > this fix.
> 
> David, something is wrong with the patch in upstream, but not in the
> patch in the mailing list.
> 
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   check/main.c                                  |  79 ++++++++++++++++++
> >   .../corrupt-free-space-tree.img.xz            | Bin 0 -> 1368 bytes
> >   2 files changed, 79 insertions(+)
> >   create mode 100644 tests/fsck-tests/058-bad-free-space-tree-entry/corrupt-free-space-tree.img.xz
> >
> > diff --git a/check/main.c b/check/main.c
> > index 4f7ab8b2..fb119bfe 100644
> > --- a/check/main.c
> > +++ b/check/main.c
> > @@ -5729,6 +5729,83 @@ static int verify_space_cache(struct btrfs_root *root,
> >   	return ret;
> >   }
> >
> > +static int check_free_space_tree(struct btrfs_root *root)
> > +{
> > +	struct btrfs_key key = {};
> > +	struct btrfs_path *path;
> > +	int ret = 0;
> > +
> > +	path = btrfs_alloc_path();
> > +	if (!path)
> > +		return -ENOMEM;
> > +
> > +	while (1) {
> > +		struct btrfs_block_group *bg;
> > +		u64 cur_start = key.objectid;
> > +
> > +		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > +		if (ret < 0)
> > +			goto out;
> 
> Here, the original code just goto out tag, and there we call
> btrfs_free_path() and free everything.
> 
> But in devel branch, we're using on-stack path, and out tag no longer
> has the btrfs_release_path(), but just return.

I did the conversion from allocated to on-stack variable and caused the
bug, tanks for catching it.

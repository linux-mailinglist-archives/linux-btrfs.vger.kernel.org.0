Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90377F6C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350978AbjHQMvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350994AbjHQMut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:50:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0B2D78
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:50:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 750411F37E;
        Thu, 17 Aug 2023 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692276646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myYUGxJEy//L0X8mScQFrpkrUMekJEZihM90TXz1MHg=;
        b=2XJ9/EuL4gcNnfYWFFQ/CRFkGTMKMhS9x4fwgbkgzik+kq9YB2sxfc80es/BeRReBK0bbr
        EVAHrrz22C5wlpPR9nOgDxrEhOII5a90DFOTTzyR4QlAlSBTJhyrLZvyfnILDNTpY0Bl1h
        xHUlgDaFfiHzYKSV0BeOLHhpT2dxMlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692276646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myYUGxJEy//L0X8mScQFrpkrUMekJEZihM90TXz1MHg=;
        b=TA3unoS42gXS6fmBB2s+X94Kb/+eiR1yZflrRXGQcWIhZ9mQlPSwguOKeszb/Pznn8T1FB
        Yo99b4VidFKbbZAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 427801392B;
        Thu, 17 Aug 2023 12:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T/h/D6YX3mTCagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 12:50:46 +0000
Date:   Thu, 17 Aug 2023 14:44:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/3] btrfs: exit gracefully if reloc roots don't match
Message-ID: <20230817124417.GQ2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1691054362.git.wqu@suse.com>
 <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
 <ZNPoAZ6nNYdm8OOK@twin.jikos.cz>
 <ed1f5dfa-76ca-4e4b-8e5a-cfa09cef38d7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1f5dfa-76ca-4e4b-8e5a-cfa09cef38d7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 08:57:24AM +0800, Qu Wenruo wrote:
> On 2023/8/10 03:24, David Sterba wrote:
> > On Thu, Aug 03, 2023 at 05:20:42PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> Syzbot reported a crash that an ASSERT() got triggered inside
> >> prepare_to_merge().
> >>
> >> [CAUSE]
> >> The root cause of the triggered ASSERT() is we can have a race between
> >> quota tree creation and relocation.
> >>
> >> This leads us to create a duplicated quota tree in the
> >> btrfs_read_fs_root() path, and since it's treated as fs tree, it would
> >> have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.
> >>
> >> The bug itself is fixed by a dedicated patch for it, but this already
> >> taught us the ASSERT() is not something straightforward for
> >> developers.
> >>
> >> [ENHANCEMENT]
> >> Instead of using an ASSERT(), let's handle it gracefully and output
> >> extra info about the mismatch reloc roots to help debug.
> >>
> >> Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
> >> merge_reloc_roots() later.
> >> Also replace those ASSERT(0)s with WARN_ON()s.
> >>
> >> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++--------
> >>   1 file changed, 36 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >> index 9db2e6fa2cb2..2bd97d2cb52e 100644
> >> --- a/fs/btrfs/relocation.c
> >> +++ b/fs/btrfs/relocation.c
> >> @@ -1916,7 +1916,38 @@ int prepare_to_merge(struct reloc_control *rc, int err)
> >>   				err = PTR_ERR(root);
> >>   			break;
> >>   		}
> >> -		ASSERT(root->reloc_root == reloc_root);
> >> +
> >> +		if (unlikely(root->reloc_root != reloc_root)) {
> >> +			if (root->reloc_root)
> >> +				btrfs_err(fs_info,
> >> +"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
> >> +					  root->root_key.objectid,
> >> +					  root->reloc_root->root_key.objectid,
> >> +					  root->reloc_root->root_key.type,
> >> +					  root->reloc_root->root_key.offset,
> >> +					  btrfs_root_generation(
> >> +						  &root->reloc_root->root_item),
> >> +					  reloc_root->root_key.objectid,
> >> +					  reloc_root->root_key.type,
> >> +					  reloc_root->root_key.offset,
> >> +					  btrfs_root_generation(
> >> +						  &reloc_root->root_item));
> >> +			else
> >> +				btrfs_err(fs_info,
> >> +"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
> >> +					  root->root_key.objectid,
> >> +					  reloc_root->root_key.objectid,
> >> +					  reloc_root->root_key.type,
> >> +					  reloc_root->root_key.offset,
> >> +					  btrfs_root_generation(
> >> +						  &reloc_root->root_item));
> >> +			list_add(&reloc_root->root_list, &reloc_roots);
> >> +			btrfs_put_root(root);
> >> +			btrfs_abort_transaction(trans, -EUCLEAN);
> >> +			if (!err)
> >> +				err = -EUCLEAN;
> >> +			break;
> >> +		}
> >>
> >>   		/*
> >>   		 * set reference count to 1, so btrfs_recover_relocation
> >> @@ -1989,7 +2020,7 @@ void merge_reloc_roots(struct reloc_control *rc)
> >>   		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
> >>   					 false);
> >>   		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
> >> -			if (IS_ERR(root)) {
> >> +			if (WARN_ON(IS_ERR(root))) {
> >>   				/*
> >>   				 * For recovery we read the fs roots on mount,
> >>   				 * and if we didn't find the root then we marked
> >> @@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc)
> >>   				 * memory.  However there's no reason we can't
> >>   				 * handle the error properly here just in case.
> >>   				 */
> >> -				ASSERT(0);
> >>   				ret = PTR_ERR(root);
> >>   				goto out;
> >>   			}
> >> -			if (root->reloc_root != reloc_root) {
> >> +			if (WARN_ON(root->reloc_root != reloc_root)) {
> >>   				/*
> >> -				 * This is actually impossible without something
> >> -				 * going really wrong (like weird race condition
> >> -				 * or cosmic rays).
> >> +				 * This can happen if on-disk metadata has some
> >> +				 * corruption, e.g. bad reloc tree key offset.
> >
> > Based on the comments, hitting that conditition is possible by corrupted
> > on-disk, so the WARN_ON should not be here. I did not like the ASSERT(0)
> > and I don't like the WARN_ON either. It's an anti-pattern and we should
> > not spread it.
> >
> > Some hints and suggestions are documented here
> > https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handling-unexpected-conditions
> > but we can make it more explicit how to them.
> 
> I don't like the WARN_ON() either, however I didn't have any better
> idea/practice at that time.
> 
> For now, I believe WARN_ON() should only be utilized when there is a
> strong need for a backtrace, and it's not covered by any existing
> facility like btrfs_abort_transaction().
> 
> If we go that idea, the WARN_ON() is not needed at all, since the there
> is only one call chain leading to the error, and the error message alone
> is enough to locate the call chain.
> 
> For other situations where there are multiple call chains involved, we
> may want to remove unnecessary WARN_ON(), with btrfs_abort_transaction()
> closer to the error.
> 
> Would this idea be more practical?

As a general idea yes. Not in all cases where the call chain is
different we need to know it but we'll deal with that case by case.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7459604CC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiJSQHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiJSQGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 12:06:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4DAF1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 09:06:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C38B3203B7;
        Wed, 19 Oct 2022 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666195567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIUfAQgH7L0iRE2EoUwq87OMX63+LfM4L5EAmsya06M=;
        b=fM8A4QGZVXfSVCFUGYyrhW83/pgDSxSe9V/J7eKkb+nxhctdGZeKinUsV+8OPQZNRDUBon
        xGzcjPXyI72YLNNpad/n5Baz7tOBYmrV5yd8nGmSb0w0fitO4mOynLJnhR9njLg/M0/sQo
        NEq0gmeck7BI6CxPWuv4IYur+XXnWpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666195567;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIUfAQgH7L0iRE2EoUwq87OMX63+LfM4L5EAmsya06M=;
        b=X0XmkIufNEN4cUkphnCwf7YG2zG3t4mxOL+CgEqWovm/NJ0mGFrRMsfA3wHigAbrT44sZW
        kjPgXNiwfS0uVtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B8F413345;
        Wed, 19 Oct 2022 16:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /c3uJG8gUGMOZAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 19 Oct 2022 16:06:07 +0000
Date:   Wed, 19 Oct 2022 18:05:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Parameter cleanup
Message-ID: <20221019160557.GE13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666103172.git.dsterba@suse.com>
 <4be6c68f-efe7-5dfa-e4cc-054e3f6badcb@wdc.com>
 <20221019151606.GC13389@twin.jikos.cz>
 <3b368917-4165-b1e7-c262-d529ca211e5c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b368917-4165-b1e7-c262-d529ca211e5c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 03:23:23PM +0000, Johannes Thumshirn wrote:
> On 19.10.22 17:16, David Sterba wrote:
> > On Wed, Oct 19, 2022 at 10:28:53AM +0000, Johannes Thumshirn wrote:
> >> On 18.10.22 16:27, David Sterba wrote:
> >>> A few more cases where value passed by parameter can be used directly.
> >>   ✓ [PATCH 2/4] btrfs: sink gfp_t parameter to btrfs_qgroup_trace_extent
> >>   ✓ [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
> >>   ✓ [PATCH 4/4] btrfs: sink gfp_t parameter to alloc_scrub_sector
> >>   ---
> >>   ✓ Signed: DKIM/suse.com
> >> ---
> >> Total patches: 4
> >> ---
> >>  Link: https://lore.kernel.org/r/cover.1666103172.git.dsterba@suse.com
> >>  Base: not specified
> >> Applying: btrfs: sink gfp_t parameter to btrfs_backref_iter_alloc
> >>
> >> Error in reading or end of file.
> >> fs/btrfs/relocation.c: In function ‘build_backref_tree’:
> >> fs/btrfs/relocation.c:474:16: error: too many arguments to function ‘btrfs_backref_iter_alloc’
> >>   474 |         iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
> >>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> >> In file included from fs/btrfs/relocation.c:25:
> >> fs/btrfs/backref.h:158:28: note: declared here
> >>   158 | struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
> >>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > I have it in a branch on top of some misc-next snapshot, the date is
> > from 3 days ago and rebase to current misc-next is clean and builds.
> > 
> 
> My topmost commit is 8ffce84c9455 ("btrfs: send: fix send failure of a subcase of orphan inodes")
> and I still experience build failures.

Works for me:

- checkout commit 8ffce84c9455
- b4 ... | git am (same as yours)
- make

And also on my current misc-next 81c7fe2157e5182.

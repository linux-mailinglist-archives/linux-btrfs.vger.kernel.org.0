Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E363770BCC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjEVMAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjEVMAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:00:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E757E43
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 04:59:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C4691FEA9;
        Mon, 22 May 2023 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684756778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vd4NsnYUEVf+bpc6It12PqvH2vHRnVx216lrG4wnJJw=;
        b=EMV5kuwT3EERf6Y4CUiys+cWte5e6nY89s5NHsuA7/gZ9HuCDunboviBIbqsM1x6RcQJEZ
        UbjSX99RlEFntiSW888GG9cbJk+HqQ4orQVQ6nBaUWrOjA5w81Gv9FEc6pcG6NPlucqp5h
        bRxQG7AOd+i7nvHspmmii6UV3hdEEGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684756778;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vd4NsnYUEVf+bpc6It12PqvH2vHRnVx216lrG4wnJJw=;
        b=XUdt//9aR7YV/zd02kmfwfHVreaxVrB8y3kQByarmVMf4U0+BH5kpbvp1iBBMLR7J9kZGX
        qqCdb2A/wJ0IkrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 594BE13336;
        Mon, 22 May 2023 11:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HnTxFCpZa2TMSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 11:59:38 +0000
Date:   Mon, 22 May 2023 13:53:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: trigger orphan inodes cleanup during sync
 ioctl
Message-ID: <20230522115332.GL32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
 <20230522114329.GK32559@twin.jikos.cz>
 <89804ef5-2dfc-ecb0-cc48-87bed8694e67@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89804ef5-2dfc-ecb0-cc48-87bed8694e67@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 22, 2023 at 07:51:17PM +0800, Qu Wenruo wrote:
> On 2023/5/22 19:43, David Sterba wrote:
> > On Fri, May 12, 2023 at 07:42:05AM +0800, Qu Wenruo wrote:
> >> There is an internal error report that scrub found an error in an orphan
> >> inode's data.
> >>
> >> However there are very limited ways to cleanup such orphan inodes:
> >>
> >> - btrfs_start_pre_rw_mount()
> >>    This happens at either mount, or RO->RW switch.
> >>    This is not a valiable solution for rootfs which may not be unmounted
> >>    or RO mounted.
> >>
> >>    Furthermore this doesn't cover every subvolume, it only covers the
> >>    currently cached subvolumes.
> >>
> >> - btrfs_lookup_dentry()
> >>    This happens when we first lookup the subvolume dentry.
> >>    But dentry can be cached thus it's not ensured to be triggered every
> >>    time.
> >>
> >> - create_snapshot()
> >>    This only happens for the created snapshot, not the source one.
> >>
> >> This means if we didn't trigger orphan items cleanup, there is really no
> >> way to manually trigger it.
> >>
> >> Thus this patch would add a manual trigger for sync ioctl.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Reason for RFC:
> >> Although this patch is very small, it involves a behavior change and
> >> hugely delay the sync ioctl.
> >> ---
> >>   fs/btrfs/ioctl.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index df7603c30686..51ad2f0f9dd8 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -3111,6 +3111,11 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
> >>   {
> >>   	struct btrfs_trans_handle *trans;
> >>   	u64 transid;
> >> +	int ret;
> >> +
> >> +	ret = btrfs_orphan_cleanup(root);
> >> +	if (ret < 0)
> >> +		return ret;
> >
> > I think this should not fail the whole sync ioctl, namely when it would
> > not even try to start the transaction commit.
> 
> If the cleanup failed, it's mostly possible that the subvolume tree is
> corrupted, and we would still abort transaction during that subvolume
> tree operation.

Yes, and that's the right place to detect the error.

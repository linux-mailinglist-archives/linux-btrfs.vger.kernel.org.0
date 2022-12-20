Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5836E652770
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiLTTz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiLTTzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:55:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46161EC55;
        Tue, 20 Dec 2022 11:53:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CD44764EF;
        Tue, 20 Dec 2022 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671566032;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jP7cOlzdQLz38OgaGOcsb9anR7C9s6SwVuf2yXeXxt0=;
        b=GsEjVPTajiJGYzjwxs+kmWycYcr0taR2CcWe87UUxU9FuQiNsC9JDgmMmcMSjJT5VwbWPl
        1loLd4Yda1SbKhpI29Uxv31dihbg/t3NyVlJAG3jjXgEkbgPopjDGHfAtBb6OPVBK4CpQJ
        NPeOZQvaAOksWNOFga7HgYs06hsBHlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671566032;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jP7cOlzdQLz38OgaGOcsb9anR7C9s6SwVuf2yXeXxt0=;
        b=Vn5a1KAYIMs3+PjcDp5Y4caiTrJMsXNc4MgiK0o50MRUCcTV6yUE6WPv+OnF9S9VBEt83F
        Nh0QeNHj60udVlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2961213254;
        Tue, 20 Dec 2022 19:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yUY3CdASomN7SAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:53:52 +0000
Date:   Tue, 20 Dec 2022 20:53:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     wqu@suse.com
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>,
        Chung-Chiang Cheng <cccheng@synology.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@cccheng.net, Johnny Chang <johnnyc@synology.com>
Subject: Re: [PATCH] btrfs: refuse to remount read-write with unsupported
 compat-ro features
Message-ID: <20221220195306.GU10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221201160724.2593341-1-cccheng@synology.com>
 <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com>
 <CAHuHWtnbVsS2pp5EySmZ_72fCrDqKJTAOkssa-D-X5wKoR9uWQ@mail.gmail.com>
 <CAL3q7H5+aVYC-nQaX4_F=eRPpU8xRNEE73MHy-_fdoQFwNMDsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5+aVYC-nQaX4_F=eRPpU8xRNEE73MHy-_fdoQFwNMDsA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 06, 2022 at 11:14:56AM +0000, Filipe Manana wrote:
> On Tue, Dec 6, 2022 at 2:42 AM Chung-Chiang Cheng <shepjeng@gmail.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 6:45 PM Filipe Manana <fdmanana@kernel.org> wrote:
> > >
> > > Wasn't this already done by the following commit?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d5d61454c365718655cfc87d8200c84e25d596
> > >
> > > Thanks.
> > >
> >
> > Wow. I did not notice this commit doing the same job by Qu. But I have
> > tested the latest linux-6.1 rc-7, and it's still able to mount a unsupported
> > comat-ro btrfs as read-write via remount.
> >
> > It's caused by the follow-up commit d7f67ac9a928 ("btrfs: relax
> > block-group-tree feature dependency checks"). This commit checks read-
> > only with the current superblock, which will always pass in the situation
> > remounting from read-only to read-write. It seems `btrfs_check_features()`
> > cannot cover this scenario.
> >
> >         if (compat_ro_unsupp && !sb_rdonly(sb)) {
> >                                 ^^^^^^^^^^^^^^
> 
> Yep, that's a bug.
> btrfs_check_features() is called before the read only flag is updated
> in the super block.
> 
> So the condition should be:
> 
> if (compat_ro_unsupp && sb_rdonly(sb) && we_want_to_transition_to_rw)
> 
> We need to pass the flags passed to btrfs_remount() to
> btrfs_check_features() for that "we_want_to_transition_to_rw" check.
> 
> That seems to be what needs to be fixed.

Qu, can you please have a look, it's caused by commit
81d5d61454c365718655cfc87d8200c84e25d596 that's also in stable kernels
so this should be fixed quickly.

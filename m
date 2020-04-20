Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36F51B1992
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 00:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDTWdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 18:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgDTWdP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 18:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD72CAF30;
        Mon, 20 Apr 2020 22:33:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49B5ADA72D; Tue, 21 Apr 2020 00:32:30 +0200 (CEST)
Date:   Tue, 21 Apr 2020 00:32:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] btrfs: Fix refcnt leak in btrfs_recover_relocation
Message-ID: <20200420223229.GH18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1587361180-83334-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <CAL3q7H4hoSF6=S_ZqTCiKNed0NkFymemGZh4vrRNQ3Nrf9xwkA@mail.gmail.com>
 <CAL3q7H4Yr2cdEgLWVAR2N_hPYEsra8yLA89meUMcvxH1VjtA6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4Yr2cdEgLWVAR2N_hPYEsra8yLA89meUMcvxH1VjtA6A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 06:35:56PM +0100, Filipe Manana wrote:
> On Mon, Apr 20, 2020 at 6:34 PM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Mon, Apr 20, 2020 at 6:50 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
> > >
> > > btrfs_recover_relocation() invokes btrfs_join_transaction(), which joins
> > > a btrfs_trans_handle object into transactions and returns a reference of
> > > it with increased refcount to "trans".
> > >
> > > When btrfs_recover_relocation() returns, "trans" becomes invalid, so the
> > > refcount should be decreased to keep refcount balanced.
> > >
> > > The reference counting issue happens in one exception handling path of
> > > btrfs_recover_relocation(). When read_fs_root() failed, the refcnt
> > > increased by btrfs_join_transaction() is not decreased, causing a refcnt
> > > leak.
> > >
> > > Fix this issue by calling btrfs_end_transaction() on this error path
> > > when read_fs_root() failed.
> > >
> > > Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error
> > > handling")
> > > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Looks good, thanks.
> 
> Btw, the subject could be more clear.
> Instead of
> 
> "btrfs: Fix refcnt leak in btrfs_recover_relocation"
> 
> something like
> 
> "btrfs: fix transaction leak in ..."
> 
> David can probably fixup that when he picks the patch.

Yes, thanks, simple fixups are fine.

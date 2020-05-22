Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729141DE84B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgEVNvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 09:51:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgEVNvc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 09:51:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 439D3B00E;
        Fri, 22 May 2020 13:51:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2FA6BDA9B7; Fri, 22 May 2020 15:50:36 +0200 (CEST)
Date:   Fri, 22 May 2020 15:50:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
Message-ID: <20200522135035.GM18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200519021320.13979-1-wqu@suse.com>
 <20200519140414.GD18421@twin.jikos.cz>
 <49d73606-df91-d030-cb70-c34796c792b3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d73606-df91-d030-cb70-c34796c792b3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 07:00:26AM +0800, Qu Wenruo wrote:
> >> [FIX]
> >> The fix is to clear fs_root->reloc_root and put it at
> >> merge_reloc_roots() time, so that we won't leak reloc roots.
> >>
> >> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
> > 
> > Thanks. I've applied it before my cleanups (read_fs_root) but the fix
> > still depends on the refcounted root trees so it's no applicable to any
> > older stable trees.
> > 
> No problem, I would craft fixes for older branches.
> 
> But for that case, what's the proper tags to specify the stable kernel
> ranges?

I've added the "CC: stable@" tags to the applied patches, they'll fail
to apply once picked by stable team, and then we need the backports.
Which means use the upstram patches, resolve the conflicts (ie. only
code changes) and then send it to stable@. The tags don't need to be
updaated.

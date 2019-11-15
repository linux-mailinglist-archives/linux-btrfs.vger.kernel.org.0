Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D711AFE27B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 17:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfKOQR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 11:17:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfKOQR0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36A26B150;
        Fri, 15 Nov 2019 16:17:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BAD1DA7D3; Fri, 15 Nov 2019 17:17:28 +0100 (CET)
Date:   Fri, 15 Nov 2019 17:17:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
Message-ID: <20191115161728.GZ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <Damenly_Su@gmx.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
 <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
 <bf2131c4-c780-a66f-8963-452082438375@gmx.com>
 <9840c8eb-9fc9-972c-8b0a-1907228d7a2c@gmx.com>
 <ceecb3e5-09eb-1978-1bc2-2cb636ee7a98@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceecb3e5-09eb-1978-1bc2-2cb636ee7a98@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 06:17:17PM +0800, Su Yue wrote:
> >>>> + * Return the block group that contains or after bytenr
> >>>> + */
> >>>
> >>> What about "Return the block group thart starts at or after @bytenr" ?
> >>>
> >>
> >> That's what documented in kernel already.
> >> The thing I try to express is "contains".
> >> For such a block group marked as B[n, m).
> >> btrfs_lookup_first_block_group(x) (x > n && x < m). Kernel code will
> >> return the block group next to B. However, progs side will return the
> >> block group B.
> >
> > "Contains" indeed covers your example.
> > But the "after @bytenr" part looks strange to me.
> >
> > Did you mean if @bytenr is not covered by any block group, then the next
> > block group starts after @bytenr is returned?
> >
> Yes, that's precisely what I mean.

I'll use the wording as suggested by Qu. Thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992B30278D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbhAYQMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 11:12:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbhAYQLf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 11:11:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53CEEAE14;
        Mon, 25 Jan 2021 16:10:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E976EDA7D2; Mon, 25 Jan 2021 17:09:07 +0100 (CET)
Date:   Mon, 25 Jan 2021 17:09:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fdmanana@gmail.com, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: rework the order of btrfs_ordered_extent::flags
Message-ID: <20210125160907.GL1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210121061354.61271-1-wqu@suse.com>
 <20210121164706.GD6430@twin.jikos.cz>
 <CAL3q7H4D_Hu=Xk0+dazruwnqwW7+kqdS3VXTxQ5kWSe+EuT8kg@mail.gmail.com>
 <616293a7-1bee-f256-ac47-02d5c0750da6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616293a7-1bee-f256-ac47-02d5c0750da6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 25, 2021 at 09:35:22PM +0800, Qu Wenruo wrote:
> >> Added to misc-next thanks.
> > 
> > Btw, I see that you added a Reviewed-by tag from me to the patch.
> > However I did not give the tag, not because I forgot but because there
> > was a small detail in a comment that should be fixed, which was not
> > addressed in misc-next.
> 
> And that comment update should not mention directIO completely.
> 
> Should I resend the patch with proper comment updated?

Yes please.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923CE4744AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhLNOT4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 09:19:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58324 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhLNOTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 09:19:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE8AB1F37C;
        Tue, 14 Dec 2021 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639491594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+K46k478oUVkXYKrqTdVKkvw91f4yk7wFvLkWw42J9A=;
        b=H2R6yLAVtjfzfth92t4UqD/c7VhvnKFrDUkgfhLs1UJbVGn6B395lW/IpCYYTanMb1gl2X
        I2dkT2wlLEjRzJkTmUTHR3yo4UFn+jrLovDCrrtXxKv+0TXNd4DPp1n43YvDfGLIfRX00W
        K2ALpb40AhemdQWXjuqeh4A1PHzQv60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639491594;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+K46k478oUVkXYKrqTdVKkvw91f4yk7wFvLkWw42J9A=;
        b=koWl/oiKNmQ5QfaKWu+i17+0zuQNXLgKRk7aIQqMzgz4cZR+/4FS+aOuwUus29eD8rGy6u
        +ipVOHgiVIMd80Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C50BDA3B81;
        Tue, 14 Dec 2021 14:19:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EC1DDA781; Tue, 14 Dec 2021 15:19:36 +0100 (CET)
Date:   Tue, 14 Dec 2021 15:19:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: check WRITE_ERR when trying to read an extent
 buffer
Message-ID: <20211214141936.GU28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Filipe Manana <fdmanana@suse.com>
References: <1676bf652be3e37ef3ae55ed784c8f0ab2ff3f8f.1639423346.git.josef@toxicpanda.com>
 <YbhyxZPERYm4DYFU@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbhyxZPERYm4DYFU@debian9.Home>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 10:32:37AM +0000, Filipe Manana wrote:
> On Mon, Dec 13, 2021 at 02:22:33PM -0500, Josef Bacik wrote:
> > Filipe reported a hang when we have errors on btrfs.  This turned out to
> > be a side-effect of my fix 666cc468424b ("btrfs: clear extent buffer
> > uptodate when we fail to write it") which made it so we clear
> 
> The commit in Linus' tree is c2e39305299f0118298c2201f6d6cc7d3485f29e.
> 
> > EXTENT_BUFFER_UPTODATE on an eb when we fail to write it out.
> > 
> > Below is a paste of Filipe's analysis he got from using drgn to debug
> > the hang
> > 
> > """
> > btree readahead code calls read_extent_buffer_pages(), sets ->io_pages to
> > a value while writeback of all pages has not yet completed:
> >    --> writeback for the first 3 pages finishes, we clear
> >        EXTENT_BUFFER_UPTODATE from eb on the first page when we get an
> >        error.
> >    --> at this point eb->io_pages is 1 and we cleared Uptodate bit from the
> >        first 3 pages
> >    --> read_extent_buffer_pages() does not see EXTENT_BUFFER_UPTODATE() so
> >        it continues, it's able to lock the pages since we obviously don't
> >        hold the pages locked during writeback
> >    --> read_extent_buffer_pages() then computes 'num_reads' as 3, and sets
> >        eb->io_pages to 3, since only the first page does not have Uptodate
> >        bit set at this point
> >    --> writeback for the remaining page completes, we ended decrementing
> >        eb->io_pages by 1, resulting in eb->io_pages == 2, and therefore
> >        never calling end_extent_buffer_writeback(), so
> >        EXTENT_BUFFER_WRITEBACK remains in the eb's flags
> >    --> of course, when the read bio completes, it doesn't and shouldn't
> >        call end_extent_buffer_writeback()
> >    --> we should clear EXTENT_BUFFER_UPTODATE only after all pages of
> >        the eb finished writeback?  or maybe make the read pages code
> >        wait for writeback of all pages of the eb to complete before
> >        checking which pages need to be read, touch ->io_pages, submit
> >        read bio, etc
> > 
> > writeback bit never cleared means we can hang when aborting a
> > transaction, at:
> > 
> >     btrfs_cleanup_one_transaction()
> >        btrfs_destroy_marked_extents()
> >          wait_on_extent_buffer_writeback()
> > """
> > 
> > This is a problem because our writes are not synchronized with reads in
> > any way.  We clear the UPTODATE flag and then we can easily come in and
> > try to read the EB while we're still waiting on other bio's to
> > complete.
> > 
> > We have two options here, we could lock all the pages, and then check to
> > see if eb->io_pages != 0 to know if we've already got an outstanding
> > write on the eb.
> > 
> > Or we can simply check to see if we have WRITE_ERR set on this extent
> > buffer.  We set this bit _before_ we clear UPTODATE, so if the read gets
> > triggered because we aren't UPTODATE because of a write error we're
> > guaranteed to have WRITE_ERR set, and in this case we can simply return
> > -EIO.  This will fix the reported hang.
> > 
> > Reported-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> As this is already in Linus' tree, and it was tagged for stable backports, it should
> include:
> 
> Fixes: c2e39305299f01 ("btrfs: clear extent buffer uptodate when we fail to write it")
> 
> David can probably add that and fix the commit id above.

Yeah, thanks for catching it. The stable backport of c2e39305299f01 has
been released meanwhile so this one need to go in the next round.

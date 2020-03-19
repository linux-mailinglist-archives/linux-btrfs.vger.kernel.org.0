Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C406918BC7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgCSQ24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 12:28:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgCSQ2w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 12:28:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7746CACC6;
        Thu, 19 Mar 2020 16:28:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DAFCFDA70E; Thu, 19 Mar 2020 17:28:22 +0100 (CET)
Date:   Thu, 19 Mar 2020 17:28:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] uboot: fs/btrfs: Fix LZO false decompression error
 caused by pending zero
Message-ID: <20200319162822.GG12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthias Brugger <mbrugger@suse.com>,
        Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org
References: <20200319123006.37578-1-wqu@suse.com>
 <20200319123006.37578-3-wqu@suse.com>
 <49c5af50-8c09-9b49-ab44-ebe5eb9a652c@gmail.com>
 <20200319135641.GB12659@twin.jikos.cz>
 <46e58bc7-4a4c-fa2a-33cd-0e8df65d6bac@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e58bc7-4a4c-fa2a-33cd-0e8df65d6bac@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 03:34:12PM +0100, Matthias Brugger wrote:
> 
> 
> On 19/03/2020 14:56, David Sterba wrote:
> > On Thu, Mar 19, 2020 at 02:33:28PM +0100, Matthias Brugger wrote:
> >>>  		dlen -= out_len;
> >>>  
> >>>  		res += out_len;
> >>> +
> >>> +		/*
> >>> +		 * If the 4 bytes header does not fit to the rest of the page we
> >>> +		 * have to move to next one, or we read some garbage.
> >>> +		 */
> >>> +		mod_page = tot_in % PAGE_SIZE;
> >>
> >> in U-Boot we use 4K page sizes, but the OS could use another page size (16K or
> >> 64k). Would we need to adapt that code to reflect which page size is used on the
> >> medium we want to access?
> > 
> > Yes, it is the 'sectorsize' as it's set up in fs_info or it's equivalent
> > in uboot. For kernel the page size == sectorsize is kind of implicit and
> > verified at mount time.
> > 
> 
> Does this mean we would need to add a Kconfig option to set the sectorsize in
> U-Boot?

No, the value depends on the filesystem so it can't be a config option.
What I mean is btrfs_super_block::sectorsize, where the superblock is
btrfs_info::sb.

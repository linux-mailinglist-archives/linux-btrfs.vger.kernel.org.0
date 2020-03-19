Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0294518B86A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCSN5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 09:57:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbgCSN5M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 09:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 932F3AE4E;
        Thu, 19 Mar 2020 13:57:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89DC7DA70E; Thu, 19 Mar 2020 14:56:42 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:56:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] uboot: fs/btrfs: Fix LZO false decompression error
 caused by pending zero
Message-ID: <20200319135641.GB12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Matthias Brugger <matthias.bgg@gmail.com>, Qu Wenruo <wqu@suse.com>,
        u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
References: <20200319123006.37578-1-wqu@suse.com>
 <20200319123006.37578-3-wqu@suse.com>
 <49c5af50-8c09-9b49-ab44-ebe5eb9a652c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c5af50-8c09-9b49-ab44-ebe5eb9a652c@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 02:33:28PM +0100, Matthias Brugger wrote:
> >  		dlen -= out_len;
> >  
> >  		res += out_len;
> > +
> > +		/*
> > +		 * If the 4 bytes header does not fit to the rest of the page we
> > +		 * have to move to next one, or we read some garbage.
> > +		 */
> > +		mod_page = tot_in % PAGE_SIZE;
> 
> in U-Boot we use 4K page sizes, but the OS could use another page size (16K or
> 64k). Would we need to adapt that code to reflect which page size is used on the
> medium we want to access?

Yes, it is the 'sectorsize' as it's set up in fs_info or it's equivalent
in uboot. For kernel the page size == sectorsize is kind of implicit and
verified at mount time.

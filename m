Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFB2AC2C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgKIRqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 12:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:38598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbgKIRqb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 12:46:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8279EAFD5;
        Mon,  9 Nov 2020 17:46:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F692DA7D7; Mon,  9 Nov 2020 18:44:49 +0100 (CET)
Date:   Mon, 9 Nov 2020 18:44:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 27/32] btrfs: scrub: use flexible array for
 scrub_page::csums
Message-ID: <20201109174449.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-28-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-28-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:03PM +0800, Qu Wenruo wrote:
> There are several factors affecting how many checksum bytes are needed
> for one scrub_page:
> 
> - Sector size and page size
>   For subpage case, one page can contain several sectors, thus the csum
>   size will differ.
> 
> - Checksum size
>   Since btrfs supports different csum size now, which can vary from 4
>   bytes for CRC32 to 32 bytes for SHA256.
> 
> So instead of using fixed BTRFS_CSUM_SIZE, now use flexible array for
> scrub_page::csums, and determine the size at scrub_page allocation time.
> 
> This does not only provide the basis for later subpage scrub support,

I'd like to know more how this would help for the subpage support.

> but also reduce the memory usage for default btrfs on x86_64.
> As the default CRC32 only uses 4 bytes, thus we can save 28 bytes for
> each scrub page.

Because even with the flexible array, the allocation is from the generic
slabs and scrub_page is now 128 bytes, so saving 28 bytes won't make any
difference.

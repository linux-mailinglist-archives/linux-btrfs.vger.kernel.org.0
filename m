Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E30362910
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhDPUJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 16:09:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236021AbhDPUJw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 16:09:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF785AD80;
        Fri, 16 Apr 2021 20:09:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D21F4DA790; Fri, 16 Apr 2021 22:07:09 +0200 (CEST)
Date:   Fri, 16 Apr 2021 22:07:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <20210416200709.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415053011.275099-1-wqu@suse.com>
 <YHnT8Dwobux2J9Pt@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHnT8Dwobux2J9Pt@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 16, 2021 at 11:14:08AM -0700, Boris Burkov wrote:
> On Thu, Apr 15, 2021 at 01:30:11PM +0800, Qu Wenruo wrote:
> > +/*
> > + * The buffer size if strlen("4096 8192 16384 32768 65536"),
> > + * which is 28, then round up to 32.
> 
> I think there is a typo in this comment, because it doesn't quite parse.

Typo fixed.

> > + */
> > +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
> >  int btrfs_check_sectorsize(u32 sectorsize)
> >  {
> > +	bool sectorsize_checked = false;
> >  	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
> >  
> >  	if (!is_power_of_2(sectorsize)) {
> > @@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
> >  		      sectorsize);
> >  		return -EINVAL;
> >  	}
> > -	if (page_size != sectorsize)
> > +	if (page_size == sectorsize) {
> > +		sectorsize_checked = true;
> > +	} else {
> > +		/*
> > +		 * Check if the sector size is supported
> > +		 */
> > +		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> > +		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> > +		int fd;
> > +		int ret;
> > +
> > +		fd = open("/sys/fs/btrfs/features/supported_sectorsizes",
> > +			  O_RDONLY);
> > +		if (fd < 0)
> > +			goto out;
> > +		ret = read(fd, supported_buf, sizeof(supported_buf));
> > +		close(fd);
> > +		if (ret < 0)
> > +			goto out;
> > +		snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
> > +			 "%u", page_size);
> > +		if (strstr(supported_buf, sectorsize_buf))
> > +			sectorsize_checked = true;
> 
> Two comments here.
> 1: I think we should be checking sectorsize against the file rather than
> page_size.

What do you mean by 'against the file'?

I read it as comparing what system reports as page size, converted to
string and looked up in the sysfs file.

> 2: strstr seems too permissive, since it doesn't have a notion of
> tokens. If not for the power_of_2 check above, we would admit all kinds
> of silly things like 409. But even with it, we would permit "4" now and
> with your example from the comment, "8", "16", and "32".

In general you're right. Practically speaking, this will work. We know
what the kernel module puts to that file and if getconf returns some
absurd number for PAGE_SIZE other things will break. The code assumes
perfect match, in any other case it prints the warning. So even if
there are some funny values either in getconf or the sysfs file, it
leads to something noticealbe to the user. A silent error would be worse
and worth fixing, but that way around it works.

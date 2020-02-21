Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7B167ED7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBUNlG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:41:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgBUNlG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:41:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF8ADAEA8;
        Fri, 21 Feb 2020 13:41:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53292DA70E; Fri, 21 Feb 2020 14:40:47 +0100 (CET)
Date:   Fri, 21 Feb 2020 14:40:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Samir Benmendil <me@rmz.io>
Subject: Re: [PATCH 1/2] btrfs-progs: check: Detect file extent end overflow
Message-ID: <20200221134046.GH2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Samir Benmendil <me@rmz.io>
References: <20200219070443.43189-1-wqu@suse.com>
 <3bc4fa9f-ffbd-9965-bdf7-07606218c526@suse.com>
 <fba00905-f71f-5488-0fd3-ef2458bfcd31@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba00905-f71f-5488-0fd3-ef2458bfcd31@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 07:37:02PM +0800, Qu Wenruo wrote:
> >> @@ -1595,6 +1597,8 @@ static int process_file_extent(struct btrfs_root *root,
> >>  		num_bytes = btrfs_file_extent_num_bytes(eb, fi);
> >>  		disk_bytenr = btrfs_file_extent_disk_bytenr(eb, fi);
> >>  		extent_offset = btrfs_file_extent_offset(eb, fi);
> >> +		if (u64_add_overflow(key->offset, num_bytes))
> >> +			rec->errors |= I_ERR_FILE_EXTENT_OVERFLOW;
> >>  		if (num_bytes == 0 || (num_bytes & mask))
> >>  			rec->errors |= I_ERR_BAD_FILE_EXTENT;
> >>  		if (num_bytes + extent_offset >
> >> diff --git a/check/mode-common.h b/check/mode-common.h
> >> index edf9257edaf0..daa5741e1d67 100644
> >> --- a/check/mode-common.h
> >> +++ b/check/mode-common.h
> >> @@ -173,4 +173,11 @@ static inline u32 btrfs_type_to_imode(u8 type)
> >>
> >>  	return imode_by_btrfs_type[(type)];
> >>  }
> >> +
> >> +static inline bool u64_add_overflow(u64 a, u64 b)
> >
> > Rename this to check_add_overflow and use the generic version from the
> > kernel :
> 
> That's also my first idea.
> 
> But I'm not a fan of the 3rd parameter, and there is no other type other
> than u64, so I hesitate to use the generic one.
> 
> However since you mentioned the kernel one, I guess it's time to
> backport it to user space.

Yes please, copying the support code from kernel is ok.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DFEC18D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfKALIc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 07:08:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfKALIc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 07:08:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11EF4AF22;
        Fri,  1 Nov 2019 11:08:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50AF6DA783; Fri,  1 Nov 2019 12:08:37 +0100 (CET)
Date:   Fri, 1 Nov 2019 12:08:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu WenRuo <wqu@suse.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christian Pernegger <pernegger@gmail.com>
Subject: Re: [PATCH] btrfs-progs: rescue-zero-log: Modify super block directly
Message-ID: <20191101110834.GL3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christian Pernegger <pernegger@gmail.com>
References: <20191026101127.36851-1-wqu@suse.com>
 <20191101105216.GJ3001@twin.jikos.cz>
 <65d30567-a0cb-4430-43ba-94e5fe597f8e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d30567-a0cb-4430-43ba-94e5fe597f8e@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 01, 2019 at 10:56:36AM +0000, Qu WenRuo wrote:
> >> +	btrfs_csum_data(btrfs_super_csum_type(sb), (u8 *)sb + BTRFS_CSUM_SIZE,
> >> +			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> >> +	memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
> >> +	ret = pwrite64(fd, sb, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
> > 
> > So this only writes on the one device that's passed to the command.
> > Previously it would update superblocks on all devices.
> 
> Oh, you got me.
> 
> That's indeed the case. I guess we need to do the same skip_bg behavior
> just like kernel to handle multiple devices.

In progs we can add another mode for open_ctree to open only devices,
then iterate over their superblocks and update it in place.

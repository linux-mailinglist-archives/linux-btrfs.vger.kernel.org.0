Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7773433D1CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhCPK3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 06:29:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236599AbhCPK3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 06:29:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63D64ACA8;
        Tue, 16 Mar 2021 10:29:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E439FDA6E2; Tue, 16 Mar 2021 11:27:02 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:27:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
Message-ID: <20210316102702.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
 <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
 <59a9ee34-1893-a642-2a00-8cc42ec7a31f@gmx.com>
 <20210315184414.GZ7604@twin.jikos.cz>
 <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 08:05:31AM +0800, Qu Wenruo wrote:
> > In that case one file with the list of supported values is a better
> > option. The main point is to have full RW support, until then it's
> > interesting only for developers and they know what to expect.
> >
> 
> Indeed only full RW support makes sense.
> 
> BTW, any comment on the file name? If no problem I would just use
> "supported_sectorsize" in next update.
> 
> Although I hope the sysfs interface can be merged separately early, so
> that I can add the proper support in btrfs-progs.

Yeah, exporting the information via sysfs is the easy stuff so you can
postpone it as you need.

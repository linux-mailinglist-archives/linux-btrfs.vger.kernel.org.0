Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D90148CDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgAXRWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 12:22:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbgAXRWj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 12:22:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42806ACC6;
        Fri, 24 Jan 2020 17:22:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E7CADA730; Fri, 24 Jan 2020 18:22:21 +0100 (CET)
Date:   Fri, 24 Jan 2020 18:22:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable
 feature
Message-ID: <20200124172221.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200124072521.3462-1-anand.jain@oracle.com>
 <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
 <d5103932-90ef-6674-05c2-4d7723ce0c25@oracle.com>
 <3592adb3-f29c-9b21-6679-f69aae59f7ef@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3592adb3-f29c-9b21-6679-f69aae59f7ef@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 04:55:23PM +0800, Qu Wenruo wrote:
> >> For performance, we still have problem, but that should only be snapshot
> >> dropping.
> >> Balance is no longer a big problem.
> >>
> >> Personally I think the current man page still stands.
> > 
> >  IMO kernel version in the man page is bit confusing though when
> >  its still unstable.
> 
> OK, for the kernel version part the patch makes sense.

Perhaps the page should be more specific about the problems (snapshot
deletion, metadata balance) and the versions where it's considered
problematic and since where it's not. The significant improvement for
the metadata balance you implemented is IMO worth mentioning, maybe also
on the wiki page feature changelog.

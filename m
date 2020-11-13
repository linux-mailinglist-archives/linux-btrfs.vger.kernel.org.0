Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46EE2B2114
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMQyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:49768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgKMQyu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:54:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50A36AD4A;
        Fri, 13 Nov 2020 16:54:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4BB3DA87A; Fri, 13 Nov 2020 17:53:05 +0100 (CET)
Date:   Fri, 13 Nov 2020 17:53:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Message-ID: <20201113165305.GE6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
References: <2bb63b693331e27b440768b163a84935fe01edda.1605182240.git.johannes.thumshirn@wdc.com>
 <3454d885-21db-199a-76bf-0da6f9971671@suse.com>
 <SN4PR0401MB35987501AB13F33A9498D85D9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987501AB13F33A9498D85D9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 12, 2020 at 12:09:52PM +0000, Johannes Thumshirn wrote:
> On 12/11/2020 13:03, Nikolay Borisov wrote:
> > Would a simple 'if()' here catch the case where fs_info is not
> > initialized essentially open-coding what Anand has proposed? My idea is
> > to be able to provide the filesystem id when we can (best effort) and
> > simply use pr_warn otherwise, but without having to change the internals
> > of btrfs_printk and instead handle the single problematic call site ?
> > 
> 
> Unfortunately not, I've been trying to do that but the device->fs_info pointer
> exists and accessing it triggers a KASAN splat.
> 
> Actually btrfs_printk() is already checking if fs_info is NULL or not to decide
> whether to print <unknown> or fs_info->sb->s_id.
> 
> Another option would be to do btrfs_warn_in_rcu(NULL but that doesn't buy us a lot
> more.

It does, not calling pr_warn and using the helpers that print the
standard header. I really want to avoid using the raw pr_* functions if
possible, in this case we can use the NULL parameter.

Previous discussion:
https://lore.kernel.org/linux-btrfs/20200110090555.7049-1-anand.jain@oracle.com/t/#u

We can update btrfs_printk to leave out "(device %s)" completely in
case there's no fs_info, and then switch everything to the helpers (there
are still too many pr_* left).

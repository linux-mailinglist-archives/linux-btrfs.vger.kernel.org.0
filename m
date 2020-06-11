Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3141F6969
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFKNwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 09:52:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKNwx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 09:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55E0FAF30;
        Thu, 11 Jun 2020 13:52:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06F98DA82A; Thu, 11 Jun 2020 15:52:44 +0200 (CEST)
Date:   Thu, 11 Jun 2020 15:52:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: BTRFS: Transaction aborted (error -24)
Message-ID: <20200611135244.GP27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Greed Rong <greedrong@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 11, 2020 at 08:37:11PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/6/11 下午7:20, David Sterba wrote:
> > On Thu, Jun 11, 2020 at 06:29:34PM +0800, Greed Rong wrote:
> >> Hi,
> >> I have got this error several times. Are there any suggestions to avoid this?
> >>
> >> # dmesg
> >> [7142286.563596] ------------[ cut here ]------------
> >> [7142286.564499] BTRFS: Transaction aborted (error -24)
> > 
> > EMFILE          24      /* Too many open files */
> > 
> > you can increase the open file limit but it's strange that this happens,
> > first time I see this.
> 
> Not something from btrfs code, thus it must come from the VFS/MM code.

Yeah, this is VFS. Creating a new root will need a new inode and dentry
and the limits are applied.

> The offending abort transaction is from btrfs_read_fs_root_no_name(),
> which is updated to btrfs_get_fs_root() in upstream kernel.
> Overall, it's not much different between the upstream and the 5.0.10 kernel.
> 
> But with latest btrfs_get_fs_root(), after a quick glance, there isn't
> any obvious location to introduce the EMFILE error.
> 
> Any extra info about the worload to trigger the bug?

I think it's from get_anon_bdev, that's called from btrfs_init_fs_root
(in btrfs_get_fs_root):

1073 int get_anon_bdev(dev_t *p)
1074 {
1075         int dev;
1076
1077         /*
1078          * Many userspace utilities consider an FSID of 0 invalid.
1079          * Always return at least 1 from get_anon_bdev.
1080          */
1081         dev = ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBITS) - 1,
1082                         GFP_ATOMIC);
1083         if (dev == -ENOSPC)
1084                 dev = -EMFILE;
1085         if (dev < 0)
1086                 return dev;
1087
1088         *p = MKDEV(0, dev);
1089         return 0;
1090 }
1091 EXPORT_SYMBOL(get_anon_bdev);

And comment says "Return: 0 on success, -EMFILE if there are no
anonymous bdevs left ".

The fs tree roots are created later than the actual command is executed,
so all the errors are also delayed. For that reason I moved eg. the root
item and path allocation to the first phase. We could do the same for
the anonymous bdev.

The problem won't go away tough, the question is why is the IDA range
unnamed_dev_ida exhausted.

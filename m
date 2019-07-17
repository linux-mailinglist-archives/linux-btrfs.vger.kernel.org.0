Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433DE6BE30
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGQOYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 10:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:48150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfGQOYs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 10:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39818ADCF;
        Wed, 17 Jul 2019 14:24:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7AD36DA8E1; Wed, 17 Jul 2019 16:25:24 +0200 (CEST)
Date:   Wed, 17 Jul 2019 16:25:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Compilation breakage
Message-ID: <20190717142524.GF20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <CAHp75VcjxDjCy3JhZHEFjBcNX_L60J8pWOQX=8_5BxyW3bN6ag@mail.gmail.com>
 <CAHp75Vdb6uJ6Fkw43UrgLv=4vVx5k_g-f=fZ5KNnETfWo9G+ng@mail.gmail.com>
 <20190716134055.GG16644@x250.microfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716134055.GG16644@x250.microfocus.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 03:40:56PM +0200, Johannes Thumshirn wrote:
> On Tue, Jul 16, 2019 at 04:29:27PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 16, 2019 at 4:28 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > The following commit broke compilation
> > >
> > > commit d5178578bcd461cc79118c7a139882350fe505aa
> > > Author: Johannes Thumshirn <jthumshirn@suse.de>
> > > Date:   Mon Jun 3 16:58:57 2019 +0200
> > >
> > >    btrfs: directly call into crypto framework for checksumming
> > >
> > > ERROR: "crc32c_impl" [fs/btrfs/btrfs.ko] undefined!
> > > ERROR: "crc32c" [fs/btrfs/btrfs.ko] undefined!
> > >
> > > Obviously if we call directly libcrc32c, we may not remove a dependency.
> 
> This should already be fixed (there where actually three patches fixing this
> issue).
> https://lore.kernel.org/linux-btrfs/1562593403-19545-1-git-send-email-linux@roeck-us.net/
> https://lore.kernel.org/linux-btrfs/20190708125134.3741552-1-arnd@arndb.de/
> and
> https://lore.kernel.org/linux-btrfs/20190702143903.49264-1-yuehaibing@huawei.com/
> 
> David I thought you staged the one from yuehaibing.

Yes, the patch is queued for the next pull.

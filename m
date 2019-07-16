Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212C76A9CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfGPNk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 09:40:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfGPNk5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 09:40:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5D96ADA2;
        Tue, 16 Jul 2019 13:40:56 +0000 (UTC)
Date:   Tue, 16 Jul 2019 15:40:56 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Compilation breakage
Message-ID: <20190716134055.GG16644@x250.microfocus.com>
References: <CAHp75VcjxDjCy3JhZHEFjBcNX_L60J8pWOQX=8_5BxyW3bN6ag@mail.gmail.com>
 <CAHp75Vdb6uJ6Fkw43UrgLv=4vVx5k_g-f=fZ5KNnETfWo9G+ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdb6uJ6Fkw43UrgLv=4vVx5k_g-f=fZ5KNnETfWo9G+ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 04:29:27PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 16, 2019 at 4:28 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > The following commit broke compilation
> >
> > commit d5178578bcd461cc79118c7a139882350fe505aa
> > Author: Johannes Thumshirn <jthumshirn@suse.de>
> > Date:   Mon Jun 3 16:58:57 2019 +0200
> >
> >    btrfs: directly call into crypto framework for checksumming
> >
> > ERROR: "crc32c_impl" [fs/btrfs/btrfs.ko] undefined!
> > ERROR: "crc32c" [fs/btrfs/btrfs.ko] undefined!
> >
> > Obviously if we call directly libcrc32c, we may not remove a dependency.

This should already be fixed (there where actually three patches fixing this
issue).
https://lore.kernel.org/linux-btrfs/1562593403-19545-1-git-send-email-linux@roeck-us.net/
https://lore.kernel.org/linux-btrfs/20190708125134.3741552-1-arnd@arndb.de/
and
https://lore.kernel.org/linux-btrfs/20190702143903.49264-1-yuehaibing@huawei.com/

David I thought you staged the one from yuehaibing.

Thanks (and sorry for the inconvenience),
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

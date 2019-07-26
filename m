Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8972376938
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbfGZNuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 09:50:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388359AbfGZNog (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA119AD18;
        Fri, 26 Jul 2019 13:44:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04038DA811; Fri, 26 Jul 2019 15:45:10 +0200 (CEST)
Date:   Fri, 26 Jul 2019 15:45:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] btrfs: use xxhash64 for checksumming
Message-ID: <20190726134508.GB2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
 <c2f5e995-6edf-991a-51a6-2c7ba43df41b@gmx.com>
 <20190725141837.GA3936@x250.microfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725141837.GA3936@x250.microfocus.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 04:18:37PM +0200, Johannes Thumshirn wrote:
> On Thu, Jul 25, 2019 at 08:02:12PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2019/7/25 下午5:33, Johannes Thumshirn wrote:
> > > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > > ---
> > >  fs/btrfs/Kconfig                | 1 +
> > >  fs/btrfs/ctree.h                | 1 +
> > >  fs/btrfs/disk-io.c              | 1 +
> > >  fs/btrfs/super.c                | 1 +
> > >  include/uapi/linux/btrfs_tree.h | 1 +
> > >  5 files changed, 5 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > > index 38651fae7f21..6d5a01c57da3 100644
> > > --- a/fs/btrfs/Kconfig
> > > +++ b/fs/btrfs/Kconfig
> > > @@ -5,6 +5,7 @@ config BTRFS_FS
> > >  	select CRYPTO
> > >  	select CRYPTO_CRC32C
> > >  	select LIBCRC32C
> > > +	select CRYPTO_XXHASH
> > 
> > Just an off topic idea, can we make such CRYPTO_* support configurable?
> > E.g. make something like CONFIG_BTRFS_CRYPTO_XXHASH.
> > 
> > Not sure if everyone would like to pull all hash algorithm.
>  
> This is something I thought about as well, but I was afraid of people shooting
> themselves in the foot if they forget to switch them on and mkfs with the
> wrong option.

> Not sure what's the better way here? Dave?

I'd go to pull everything unconditionally, which means that all
dependent modules are built and does not require the user to tweak the
config.

I understand that there are setups that don't want to provide all hash
algorithms eg. due to space constraints. That will be still possible and
puts the "burden" on the distributor/integrator. Simply don't provide
the .ko files. The crypto API can detect that during mount the shash
descriptor cannot be instantiated and will fail. In specialized setups
this is ok, because lack of the hash algorithm is known.

For everybody else, the filesystem should come with all parts included
so the features work.

The situation with zlib/lzo/zstd is different because we use the library
functions, not the separate .ko modules. This is a bit more convenient.

We don't want to do that with the hash algorithms though because there
are usually optimized verions that we do want to use, and the crypto API
does all the work.

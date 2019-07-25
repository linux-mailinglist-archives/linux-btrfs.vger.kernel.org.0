Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3794750CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfGYOSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 10:18:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbfGYOSj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 10:18:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36649AE56;
        Thu, 25 Jul 2019 14:18:38 +0000 (UTC)
Date:   Thu, 25 Jul 2019 16:18:37 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] btrfs: use xxhash64 for checksumming
Message-ID: <20190725141837.GA3936@x250.microfocus.com>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
 <c2f5e995-6edf-991a-51a6-2c7ba43df41b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2f5e995-6edf-991a-51a6-2c7ba43df41b@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 08:02:12PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/7/25 下午5:33, Johannes Thumshirn wrote:
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  fs/btrfs/Kconfig                | 1 +
> >  fs/btrfs/ctree.h                | 1 +
> >  fs/btrfs/disk-io.c              | 1 +
> >  fs/btrfs/super.c                | 1 +
> >  include/uapi/linux/btrfs_tree.h | 1 +
> >  5 files changed, 5 insertions(+)
> > 
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index 38651fae7f21..6d5a01c57da3 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -5,6 +5,7 @@ config BTRFS_FS
> >  	select CRYPTO
> >  	select CRYPTO_CRC32C
> >  	select LIBCRC32C
> > +	select CRYPTO_XXHASH
> 
> Just an off topic idea, can we make such CRYPTO_* support configurable?
> E.g. make something like CONFIG_BTRFS_CRYPTO_XXHASH.
> 
> Not sure if everyone would like to pull all hash algorithm.
 
This is something I thought about as well, but I was afraid of people shooting
themselves in the foot if they forget to switch them on and mkfs with the
wrong option.

Not sure what's the better way here? Dave?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

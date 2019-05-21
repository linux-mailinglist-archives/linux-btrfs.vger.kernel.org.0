Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1941325006
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEUNXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 09:23:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEUNXX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 09:23:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA77EAE8A;
        Tue, 21 May 2019 13:23:21 +0000 (UTC)
Date:   Tue, 21 May 2019 15:23:21 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>
Subject: Re: [PATCH v2 09/13] btrfs: Simplify btrfs_check_super_csum() and
 get rid of size assumptions
Message-ID: <20190521132321.GD7200@x250>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-10-jthumshirn@suse.de>
 <1d61314d-246d-ee95-1643-5c4cc2c5e919@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d61314d-246d-ee95-1643-5c4cc2c5e919@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 04:01:36PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.05.19 г. 11:47 ч., Johannes Thumshirn wrote:
> > Now that we have already checked for a valid checksum type before calling
> > btrfs_check_super_csum(), it can be simplified even further.
> > 
> > While at it get rid of the implicit size assumption of the resulting
> > checksum as well.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > 
> > ---
> > Changes to v1:
> > - Check for disk_sb->csum instead of raw buffer (Nikolay)
> > ---
> >  fs/btrfs/disk-io.c | 37 +++++++++++++------------------------
> >  1 file changed, 13 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 74937effaed4..edb8bc79b01b 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -375,33 +375,22 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
> >  {
> 
> This function no longer requires the btrfs_fs_info argument so it should
> be removed.  While on the topic of refactoring this function - why not
> change it's return type to bool since it can't return anything other
> than 0/1 ?

Patch 11/13 will need fs_info again.
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

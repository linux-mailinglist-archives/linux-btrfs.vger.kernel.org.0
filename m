Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4E380D35
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 17:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhENPei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 11:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234872AbhENPec (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 11:34:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 171A4B0D7;
        Fri, 14 May 2021 15:33:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 259D1DAF1B; Fri, 14 May 2021 17:30:49 +0200 (CEST)
Date:   Fri, 14 May 2021 17:30:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: disable space cache using proper function
Message-ID: <20210514153049.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210514020308.3824607-1-naohiro.aota@wdc.com>
 <275c2c31-c8e4-cf9e-9137-483efd3e1efa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <275c2c31-c8e4-cf9e-9137-483efd3e1efa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 06:05:05PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/14 上午10:03, Naohiro Aota wrote:
> > As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
> > it to disable space cache v1 properly.
> >
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >   fs/btrfs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 4a396c1147f1..89ffc17d074c 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -592,7 +592,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> >   		if (btrfs_is_zoned(info)) {
> >   			btrfs_info(info,
> >   			"zoned: clearing existing space cache");
> > -			btrfs_set_super_cache_generation(info->super_copy, 0);
> > +			btrfs_set_free_space_cache_v1_active(info, false);
> 
> Can we have a better naming?
> 
> The set_..._active() really looks like to *enable* space cache, other
> than disabling it.

Agreed, it's really confusing and does the opposite of the name, this
needs fixing.

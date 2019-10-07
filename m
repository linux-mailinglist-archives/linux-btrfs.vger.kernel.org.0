Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A872CE829
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJGPps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 11:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727711AbfJGPps (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 11:45:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50EF6AC19;
        Mon,  7 Oct 2019 15:45:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB404DA7FB; Mon,  7 Oct 2019 17:46:02 +0200 (CEST)
Date:   Mon, 7 Oct 2019 17:46:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: sysfs: export supported checksums
Message-ID: <20191007154602.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191007091104.18095-1-jthumshirn@suse.de>
 <20191007091104.18095-4-jthumshirn@suse.de>
 <bb3aa7b2-ee08-a4f2-99f3-1d10750322d4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb3aa7b2-ee08-a4f2-99f3-1d10750322d4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 06:36:14PM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.10.19 г. 12:11 ч., Johannes Thumshirn wrote:
> > From: David Sterba <dsterba@suse.com>
> > 
> > Export supported checksum algorithms via sysfs.
> > 
> > Co-developed-by: David Sterba <dsterba@suse.com> 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  fs/btrfs/ctree.c |  5 +++++
> >  fs/btrfs/ctree.h |  2 ++
> >  fs/btrfs/sysfs.c | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index b66509ee62eb..5debd74dc61c 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -53,6 +53,11 @@ const char *btrfs_super_csum_name(u16 csum_type)
> >  	return btrfs_csums[csum_type].name;
> >  }
> >  
> > +size_t btrfs_get_num_csums(void)
> > +{
> > +	return ARRAY_SIZE(btrfs_csums);
> > +}
> 
> nit: This function is used only once and the ARRAY_SIZE() macro is
> descriptive enough, why not just remove it and opencoude the call to
> array_size

Agreed, ARRAY_SIZE in loops is fine, it's a compile-time constant.

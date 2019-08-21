Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C454097798
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHUKwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 06:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfHUKwq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 06:52:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97202B049;
        Wed, 21 Aug 2019 10:52:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 464CEDA7DA; Wed, 21 Aug 2019 12:53:10 +0200 (CEST)
Date:   Wed, 21 Aug 2019 12:53:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: compression: replace set_level callbacks
 by a common helper
Message-ID: <20190821105309.GV24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1566313756.git.dsterba@suse.com>
 <779b3811b04d18b861f14166b2f67ac402df7a88.1566313756.git.dsterba@suse.com>
 <adfb48ec-8cc8-2d0a-bce8-fda730e2f919@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfb48ec-8cc8-2d0a-bce8-fda730e2f919@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 06:16:27PM +0800, Anand Jain wrote:
> On 21/8/19 12:17 AM, David Sterba wrote:
> > The set_level callbacks do not do anything special and can be replaced
> > by a helper that uses the levels defined in the tables.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/compression.c | 20 ++++++++++++++++++--
> >   fs/btrfs/compression.h |  9 ++-------
> >   fs/btrfs/lzo.c         |  6 ------
> >   fs/btrfs/zlib.c        |  9 ---------
> >   fs/btrfs/zstd.c        |  9 ---------
> >   5 files changed, 20 insertions(+), 33 deletions(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 60c47b417a4b..53376c640f61 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -1039,7 +1039,7 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
> >   	struct list_head *workspace;
> >   	int ret;
> >   
> > -	level = btrfs_compress_op[type]->set_level(level);
> > +	level = btrfs_compress_set_level(type, level);
> >   	workspace = get_workspace(type, level);
> >   	ret = btrfs_compress_op[type]->compress_pages(workspace, mapping,
> >   						      start, pages,
> > @@ -1611,7 +1611,23 @@ unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
> >   			level = 0;
> >   	}
> >   
> > -	level = btrfs_compress_op[type]->set_level(level);
> > +	level = btrfs_compress_set_level(type, level);
> > +
> > +	return level;
> > +}
> > +
> > +/*
> > + * Adjust @level according to the limits of the compression algorithm or
> > + * fallback to default
> > + */
> > +unsigned int btrfs_compress_get_level(int type, unsigned level)
> > +{
> > +	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
> > +
> > +	if (level == 0)
> > +		level = ops->default_level;
> > +	else
> > +		level = min(level, ops->max_level);
> >   
> >   	return level;
> >   }
> > diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> > index cffd689adb6e..4cb8be9ff88b 100644
> > --- a/fs/btrfs/compression.h
> > +++ b/fs/btrfs/compression.h
> > @@ -156,13 +156,6 @@ struct btrfs_compress_op {
> >   			  unsigned long start_byte,
> >   			  size_t srclen, size_t destlen);
> >   
> > -	/*
> > -	 * This bounds the level set by the user to be within range of a
> > -	 * particular compression type.  It returns the level that will be used
> > -	 * if the level is out of bounds or the default if 0 is passed in.
> > -	 */
> > -	unsigned int (*set_level)(unsigned int level);
> > -
> >   	/* Maximum level supported by the compression algorithm */
> >   	unsigned int max_level;
> >   	unsigned int default_level;
> > @@ -179,6 +172,8 @@ extern const struct btrfs_compress_op btrfs_zstd_compress;
> >   const char* btrfs_compress_type2str(enum btrfs_compression_type type);
> >   bool btrfs_compress_is_valid_type(const char *str, size_t len);
> >   
> > +unsigned int btrfs_compress_set_level(int type, unsigned level);
> > +
> 
>     btrfs_compress_set_level() is undefined.

Indeed, by some mistake the function is named btrfs_compress_get_level
and my compiler does not care to fail the build.

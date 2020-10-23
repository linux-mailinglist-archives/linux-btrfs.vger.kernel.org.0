Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA2297331
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbgJWQGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 12:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:45264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464934AbgJWQGw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 12:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CDA7AFC0;
        Fri, 23 Oct 2020 16:06:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67EDDDA7F1; Fri, 23 Oct 2020 18:05:19 +0200 (CEST)
Date:   Fri, 23 Oct 2020 18:05:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't fallback to buffered read if we don't
 need to
Message-ID: <20201023160519.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <0584c1f8bdbef5e56a684919df24481e90ddf334.1603375354.git.johannes.thumshirn@wdc.com>
 <20201022150033.uqvg2wqtjo5fnx5b@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022150033.uqvg2wqtjo5fnx5b@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 10:00:33AM -0500, Goldwyn Rodrigues wrote:
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 6f5ecba74f54..1c97e559aefb 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -3612,7 +3612,8 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  		inode_lock_shared(inode);
> >  		ret = btrfs_direct_IO(iocb, to);
> >  		inode_unlock_shared(inode);
> > -		if (ret < 0)
> > +		if (ret < 0 || !iov_iter_count(to) ||
> > +		    iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
> >  			return ret;

JFYI, this conflicts with patch "btrfs: split btrfs_direct_IO to read
and write" from your dsync/dio series it will need to be refreshed.

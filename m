Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546611820A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgCKSX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:23:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37449 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgCKSX3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:23:29 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so1426369pjb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UaW/kiwp4EQPMIwS10YXB2Dg8Fx2HQIsG2KtmEKxJI=;
        b=h5kReBrMswYCewnmW/5hs1ykx/Y103k0Vd5luR+2Wgl+Dzrex51AfWDEEqLGLzGtp9
         g8gZsDKAbpD4Q+LqH9ANw+6S9KwswBwKpvPVDlDH1xLXvcqfPHaVuIDvt/HdteYQ+eyK
         zxd9sk0O4604iHJpiwBsiucMTcJlp58sI3JkDArEIql3RnfnX4ttwrDCZEppTpeaeILn
         sCkDiK6xvC3p1b6oobFC5YhSHjZdZWq4Sqb0mdXTd69VEPZMo6nFd60Mq3m2oNCao+l+
         /ej6wIU3L4WNv27jjPi+OySBwX6EnS4mhb6vDFbci15CMtDsRSzJeT3LCuu9wbyerm2k
         4zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UaW/kiwp4EQPMIwS10YXB2Dg8Fx2HQIsG2KtmEKxJI=;
        b=dFK4g6b9oHezbzwL0anOtC1KQqT72qxfPr2mURWDdvmeaY6LuD8GSKeFhDAQCklZ5N
         Awo0oJAXyoGSL2WOfTcEABFntjD3KxK8d2WtvjDPoe3lerAPOA8lgFAInwDGcP3HPmx3
         FxbZzTq1TXFcPd/m/n42KeRXH+rXrGju/NwXbmuYH3IY2lKrGDr/dd3swyXhoouQfTzT
         vT+7tNHkESov7DB5dxvoSHu69VKxoRFoLQQSYx6ZT5OHh3pkseZ40INPNI2fDEVTDGeF
         KEAis9CenIB3wS5mGviLzDJ3otsBlLrW6qPGT03ot+wlMFsL28evzNYb7Iaq71k9qN7q
         Up+Q==
X-Gm-Message-State: ANhLgQ1Lo4WD/SFLBLhNXptxbLRzajWuRRs1V6SdYwpHGr4OgqS2F18y
        TzozraO2vFwtBcjmg4c8YSBbxA==
X-Google-Smtp-Source: ADFU+vux2OMUd5MEf8QwJMlTRyWXAJRg43O4+SAFF6yyggLYWYHs1szaaK/Qrh6zTle1ZRgsswkq4w==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr59315pjv.142.1583951006661;
        Wed, 11 Mar 2020 11:23:26 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c53a])
        by smtp.gmail.com with ESMTPSA id z3sm52319321pfz.155.2020.03.11.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:23:26 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:23:25 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/15] btrfs: clarify btrfs_lookup_bio_sums documentation
Message-ID: <20200311182325.GA296369@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <2ee5f090b52dc23569bf94a5a2609dfc49ac4a4b.1583789410.git.osandov@fb.com>
 <a7522f01-8aad-bdcc-4576-4c73d7719bc9@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7522f01-8aad-bdcc-4576-4c73d7719bc9@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 01:56:44PM -0400, Josef Bacik wrote:
> On 3/9/20 5:32 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Fix a couple of issues in the btrfs_lookup_bio_sums documentation:
> > 
> > * The bio doesn't need to be a btrfs_io_bio if dst was provided. Move
> >    the declaration in the code to make that clear, too.
> > * dst must be large enough to hold nblocks * csum_size, not just
> >    csum_size.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   fs/btrfs/file-item.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 6c849e8fd5a1..fa9f4a92f74d 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -242,11 +242,13 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
> >   /**
> >    * btrfs_lookup_bio_sums - Look up checksums for a bio.
> >    * @inode: inode that the bio is for.
> > - * @bio: bio embedded in btrfs_io_bio.
> > + * @bio: bio to look up.
> >    * @offset: Unless (u64)-1, look up checksums for this offset in the file.
> >    *          If (u64)-1, use the page offsets from the bio instead.
> > - * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
> > - *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
> > + * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
> > + *       checksum (nblocks = bio->bi_iter.bi_size / sectorsize). If NULL, the
> > + *       checksum buffer is allocated and returned in btrfs_io_bio(bio)->csum
> > + *       instead.
> >    *
> >    * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
> >    */
> > @@ -256,7 +258,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >   	struct bio_vec bvec;
> >   	struct bvec_iter iter;
> > -	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
> >   	struct btrfs_csum_item *item = NULL;
> >   	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> >   	struct btrfs_path *path;
> > @@ -277,6 +278,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> >   	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
> >   	if (!dst) {
> > +		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
> > +
> 
> Looks like you have some extra changes in here?

I mentioned it in the commit message: "Move the declaration in the code
to make that clear". It looks weird to document that the bio only needs
to be a btrfs_io_bio if dst == NULL and then always get the btrfs_bio,
even if we don't use it.

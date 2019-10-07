Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B335ACE42C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJGNs1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 09:48:27 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25804 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfJGNs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 09:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570456072; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SEeidJTj1+sCGWSgP1POPGiftIuzrVT9eAWrZhYrkquzTOmKhENkZEXwRDFez5A85g2Giogd5uX581rLl2lJEgX7XMpOXWBkN7zDjywiftZo7Tawstxnwf9XdLFn+WnhiJ+DGXYBIxYoJfkWn2/02H2tdmjZdkqqiX8b3j8Vl8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570456072; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=PeBL9H7aIqWruIaqRv2yewdKCrTrd0EOYabbDMB6wbs=; 
        b=HyGCBxNbXLjXbA0KYUNDKtuNyZNWwzJcXYgg9q4iGkO7Dj9T9SFce/3ybn+wRBttFZiaH6+QCsgLZJjVqC1JrirjZ5Q3S5DG7JZkWDR9HLLldbqUXrp0YgXSHvhvWlkCwKjKGy/db5eS+bgqx39paEGpo0J4f6fmTV/Y8rFUzmo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570456072;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=5322; bh=PeBL9H7aIqWruIaqRv2yewdKCrTrd0EOYabbDMB6wbs=;
        b=NlKDwffVUgfggrTy0hBIqUR69lv4wn6FcKgtDd5XhQ61CSuvx26ChBrAyFvGCV3X
        tGB75hXmBDZEl1ah03Xcy3k/7P5+jigE56cYKDdDH8+VuCFA1IeorL5yKW+tejU/NF3
        hGFR2sqg2OzTqXfWm7/qe54qahqEnj4Nl8bkHIwY=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 15704560715756.927754514769845; Mon, 7 Oct 2019 21:47:51 +0800 (CST)
Date:   Mon, 07 Oct 2019 21:47:51 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "dsterba" <dsterba@suse.cz>
Cc:     "clm" <clm@fb.com>, "josef" <josef@toxicpanda.com>,
        "dsterba" <dsterba@suse.com>,
        "linux-btrfs" <linux-btrfs@vger.kernel.org>
Message-ID: <16da679ed94.10b6d7c5824950.6097727071158168841@mykernel.net>
In-Reply-To: <20191006232834.GY2751@twin.jikos.cz>
References: <20191005051736.29857-1-cgxu519@mykernel.net>
 <20191005051736.29857-2-cgxu519@mykernel.net> <20191006232834.GY2751@twin.jikos.cz>
Subject: Re: [PATCH 2/3] btrfs: code cleanup for compression type
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2019-10-07 07:28:32 David Ster=
ba <dsterba@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sat, Oct 05, 2019 at 01:17:35PM +0800, Chengguang Xu wrote:
 > > Let BTRFS_COMPRESS_TYPES represents the total number
 > > of cmpressoin types and fix related calling places.
 > > It will be more safe when adding new compression type
 > > in the future.
 >=20
 > I think we're not going to add a new type anytime soon, zstd provides
 > the choice between fast and good ratio. This itself is not an objection
 > to your patch but is not IMO the true reason for the changes.
 >=20
 > Can you please describe the motivation behind the patches? Eg. if it's a
 > general cleanup or if there are other changes planned on top.

Actually, it's just a general cleanup. I found another enum in btrfs code f=
or RAID types
and I think that usage makes me(at least :-)) easy to understand the code. =
So the
motivation is to keep code style consistency and  make the code a bit more =
readable.


 >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/btrfs/compression.c  |  2 ++
 > >  fs/btrfs/compression.h  | 12 ++++++------
 > >  fs/btrfs/ioctl.c        |  2 +-
 > >  fs/btrfs/tree-checker.c |  4 ++--
 > >  4 files changed, 11 insertions(+), 9 deletions(-)
 > >=20
 > > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
 > > index d70c46407420..93deaf0cc2b8 100644
 > > --- a/fs/btrfs/compression.c
 > > +++ b/fs/btrfs/compression.c
 > > @@ -39,6 +39,8 @@ const char* btrfs_compress_type2str(enum btrfs_compr=
ession_type type)
 > >      case BTRFS_COMPRESS_ZSTD:
 > >      case BTRFS_COMPRESS_NONE:
 > >          return btrfs_compress_types[type];
 > > +    default:
 > > +        break;
 > >      }
 > > =20
 > >      return NULL;
 > > diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
 > > index dd392278ab3f..091ff3f986e5 100644
 > > --- a/fs/btrfs/compression.h
 > > +++ b/fs/btrfs/compression.h
 > > @@ -101,11 +101,11 @@ blk_status_t btrfs_submit_compressed_read(struct=
 inode *inode, struct bio *bio,
 > >  unsigned int btrfs_compress_str2level(unsigned int type, const char *=
str);
 > > =20
 > >  enum btrfs_compression_type {
 > > -    BTRFS_COMPRESS_NONE  =3D 0,
 > > -    BTRFS_COMPRESS_ZLIB  =3D 1,
 > > -    BTRFS_COMPRESS_LZO   =3D 2,
 > > -    BTRFS_COMPRESS_ZSTD  =3D 3,
 > > -    BTRFS_COMPRESS_TYPES =3D 3,
 > > +    BTRFS_COMPRESS_NONE,
 > > +    BTRFS_COMPRESS_ZLIB,
 > > +    BTRFS_COMPRESS_LZO,
 > > +    BTRFS_COMPRESS_ZSTD,
 > > +    BTRFS_COMPRESS_TYPES
 >=20
 > Please note that the on-disk format values should be expressed by the
 > values, even if it's the same as the automatic enum assignments.

I'll fix in v2.

 >=20
 > Regarding change of the BTRFS_COMPRESS_TYPES value, I vaguely remember
 > we had patches for that but I don't recall why it was not changed. The
 > progs have an extra BTRFS_COMPRESS_LAST (=3D=3D 4) that would be used th=
e
 > same way as you do in this patch.

In previous patch, we had compression type(1-3, skip 0) in the code,
so there may be a bit of  confusion for BTRFS_COMPRESS_TYPES(=3D=3D4) .=20
I think it's not a problem now but maybe  change name to BTRFS_NR_COMPRESS_=
TYPES(like RAID type enum)=20
is better.

 >=20
 > BTRFS_COMPRESS_* is not in the public API so changing the value should
 > be safe, but needs double checking.
 >=20
 > >  };
 > > =20
 > >  struct workspace_manager {
 > > @@ -163,7 +163,7 @@ struct btrfs_compress_op {
 > >  };
 > > =20
 > >  /* The heuristic workspaces are managed via the 0th workspace manager=
 */
 > > -#define BTRFS_NR_WORKSPACE_MANAGERS    (BTRFS_COMPRESS_TYPES + 1)
 > > +#define BTRFS_NR_WORKSPACE_MANAGERS    BTRFS_COMPRESS_TYPES
 > > =20
 > >  extern const struct btrfs_compress_op btrfs_heuristic_compress;
 > >  extern const struct btrfs_compress_op btrfs_zlib_compress;
 > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
 > > index de730e56d3f5..8c7196ed7ae0 100644
 > > --- a/fs/btrfs/ioctl.c
 > > +++ b/fs/btrfs/ioctl.c
 > > @@ -1411,7 +1411,7 @@ int btrfs_defrag_file(struct inode *inode, struc=
t file *file,
 > >          return -EINVAL;
 > > =20
 > >      if (do_compress) {
 > > -        if (range->compress_type > BTRFS_COMPRESS_TYPES)
 > > +        if (range->compress_type >=3D BTRFS_COMPRESS_TYPES)
 > >              return -EINVAL;
 > >          if (range->compress_type)
 > >              compress_type =3D range->compress_type;
 > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
 > > index f28f9725cef1..2d91c34bbf63 100644
 > > --- a/fs/btrfs/tree-checker.c
 > > +++ b/fs/btrfs/tree-checker.c
 > > @@ -168,11 +168,11 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
 > >       * Support for new compression/encryption must introduce incompat=
 flag,
 > >       * and must be caught in open_ctree().
 > >       */
 > > -    if (btrfs_file_extent_compression(leaf, fi) > BTRFS_COMPRESS_TYPE=
S) {
 > > +    if (btrfs_file_extent_compression(leaf, fi) >=3D BTRFS_COMPRESS_T=
YPES) {
 > >          file_extent_err(leaf, slot,
 > >      "invalid compression for file extent, have %u expect range [0, %u=
]",
 > >              btrfs_file_extent_compression(leaf, fi),
 > > -            BTRFS_COMPRESS_TYPES);
 > > +            BTRFS_COMPRESS_TYPES - 1);
 > >          return -EUCLEAN;
 > >      }
 > >      if (btrfs_file_extent_encryption(leaf, fi)) {
 > > --=20
 > > 2.21.0
 > >=20
 > >=20
 > >=20
 >


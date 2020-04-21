Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06D91B254C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDULrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDULrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 07:47:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9849DC061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 04:47:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so14038759qke.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zs2GBV8VMH1/nBOL7LE2hYaJOAplneifvpYkFVc9i6E=;
        b=TfKG9rmFr2MJKEMWvJyAOvvhsTpSol2o/1utnaJcx2JRk/4hyPjIG2Fz9pcnK58MdI
         orcPqOnrW6C7BcKeVFHQ+2CBlWGH7hK1rYMYv4zDQresLi/DgY6GPweC32+FjtNcSnNM
         +WKvhqoEPnD8waYdAi8DfohdWW+QtT9M/aqcaUYpzASE6s1ERggNjvDjwE5+7z/MArEF
         ti/e7HTyOgvjSSEosr2cimUrjI88uAFi9RuEEUL5KA2Cw0wGIafLceT9K9rQwCo9rRnz
         Q3VtMHnLVptmC7F0RdbCnFIAhbCz+RAcSACb9tnaLC2/3OgvTMwcYZWmUaIKVV86e3cL
         asRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zs2GBV8VMH1/nBOL7LE2hYaJOAplneifvpYkFVc9i6E=;
        b=mJkdYVYEzx2aDr1MKhEcRqdgG4xdaayZYw8A5NM8Gv03f3N2GbFjVU2LKtGg72CtDY
         e2ZvPGjmUsc/BLbxgxbIoE+a6BHIhJ+Pxo1V7Pl2Bp/U+naztTb8XRO8LlRJncF+k1AB
         xGQYJGwqCM78X6PxObQMlzxm8UrXS2wXATF924pR9hIrDC56p1sBYzKD1dMxwEdW/6fr
         zhlTzn2tYCJR1ts3hmD65v9QEYwAR/ilEJ6xqqe1Z4adINdzzVGRm69UNZCK7F3DWw+E
         lLLizLmkgQf3FksjKXhDy9Qh0cvNZumGXDK/6VPee/5qQKOMWzsGpc0CmoCrBritjntv
         PPWA==
X-Gm-Message-State: AGi0PuZYAyIc8Z4miuhbqICxZUWc4fP8UAYtQrWTszLHnwEFQ/kz701U
        WbH88rVHC0GWBoc+ElEk05N4jL+SYMb8yfmy9SA=
X-Google-Smtp-Source: APiQypJDTJ00139QgKPocWy8shGan+VkbqAhc0B0SLqfHehmd4L7/7fC/FP1HjZoI543rZEks48w8/yeybhsgCLbqMI=
X-Received: by 2002:a37:9ccb:: with SMTP id f194mr6774460qke.151.1587469630787;
 Tue, 21 Apr 2020 04:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UfgrWR1rn-VbHHcK0+2cN08m0C529NtY-ofUMNX3mM4NoTaw@mail.gmail.com>
 <20200414145801.GR5920@twin.jikos.cz>
In-Reply-To: <20200414145801.GR5920@twin.jikos.cz>
From:   stijn rutjens <rutjensstijn@gmail.com>
Date:   Tue, 21 Apr 2020 13:46:59 +0200
Message-ID: <CA+UfgrV2sBYjLQg35OtezUs1r2HSge5TTX+rbWoqBgo66HzD5w@mail.gmail.com>
Subject: [PATCH v2] btrfs: allow setting per extent compression
To:     dsterba@suse.cz, stijn rutjens <rutjensstijn@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

""Hi,
I've added an ioctl flag to notify the interface we want to use the
upper 4 bits for the compression level (which has significantly
decreased the size of the patch). How do you want to split the patch
up?

> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index bb374042d..e1603e1cf 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -67,7 +67,7 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> >       btrfs_set_file_extent_ram_bytes(leaf, item, ram_bytes);
> >       btrfs_set_file_extent_generation(leaf, item, trans->transid);
> >       btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
> > -     btrfs_set_file_extent_compression(leaf, item, compression);
> > +     btrfs_set_file_extent_compression(leaf, item, compression & 0xF);
>
> As a general comment, open coding the level as "& 0xf" should be replaced
> with a helper.

I've now changed this to use the already written "btrfs_compress_type"
and "btrfs_compress_level" helpers

> But in all cases where btrfs_set_file_extent_compression is called,
> there shluld be already only the type. Ie. it's up to the calling code
> to pass the correct value. An assert would be good.
>
> The number of entry points where the type and level are available is
> limited to ioctls or properties and the level is not part of the on-disk
> format so all code that handles the format should assume the value is
> valid.
this is also fixed

> > +                     ret = btrfs_compress_pages(
> > +                             compress_type | (compress_level << 4),
> > +                             inode->i_mapping, start,
> > +                             pages,
> > +                             &nr_pages,
> > +                             &total_in,
> > +                             &total_compressed);
> > +             }
> >               if (!ret) {
> >                       unsigned long offset = offset_in_page(total_compressed);
> >                       struct page *page = pages[nr_pages - 1];
> > @@ -2362,7 +2379,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
> >       btrfs_set_file_extent_offset(leaf, fi, 0);
> >       btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
> >       btrfs_set_file_extent_ram_bytes(leaf, fi, ram_bytes);
> > -     btrfs_set_file_extent_compression(leaf, fi, compression);
> > +     btrfs_set_file_extent_compression(leaf, fi, compression & 0xF);
> >       btrfs_set_file_extent_encryption(leaf, fi, encryption);
> >       btrfs_set_file_extent_other_encoding(leaf, fi, other_encoding);
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 0fa1c386d..2a9c1f312 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -1414,7 +1414,11 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
> >               return -EINVAL;
> >
> >       if (do_compress) {
> > -             if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > +             /*
> > +             * The bottom 4 bits of compress_type are for used for the
> > +             * compression type, the other bits for the compression level
> > +             */
> > +             if ((range->compress_type & 0xF) >= BTRFS_NR_COMPRESS_TYPES)
> >                       return -EINVAL;
>
> For the backward compatibility, the check without "& 0xf" is sufficient,
> but a new flag is needed to actually tell the ioctl code to read the
> level. I'm not sure that relying on automatic parsing of the high 4 bits
> is a good idea, usually all new data are accompanied by new flags.

fixed

> >               if (range->compress_type)
> >                       compress_type = range->compress_type;
> > @@ -1572,9 +1576,9 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
> >                       filemap_flush(inode->i_mapping);
> >       }
> >
> > -     if (range->compress_type == BTRFS_COMPRESS_LZO) {
> > +     if ((range->compress_type & 0xF) == BTRFS_COMPRESS_LZO) {
> >               btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> > -     } else if (range->compress_type == BTRFS_COMPRESS_ZSTD) {
> > +     } else if ((range->compress_type & 0xF) == BTRFS_COMPRESS_ZSTD) {
> >               btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> >       }
>
> For further iterations of the patch, I suggest to split it into more
> patches by logical change, like adding helpers, extending the ioctl,
> adding asserts, etc.

The ioctl interface is now extended (see patch-extend-ioctl.patch)
for the other patch, see patch-extend-inode.patch
Where should asserts be added?

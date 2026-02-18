Return-Path: <linux-btrfs+bounces-21752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCa2GkC8lWntUQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21752-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:18:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A11568E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9802330209CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD02BD030;
	Wed, 18 Feb 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Onq8ALfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605129A9E9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420722; cv=pass; b=BCzJPNB6rhYLQh6EyNSjmWSlj65Z+WzJtqCGxNkp5dNx2+p8FppOmroHW31dVIgP27ZWuNJiB230fwKl2ui1UptX830YQbUorsAE1ogy0AN2QHms55Y5ByrgAlzqYZ9V9zLzDsGjapomdH2parVwBaE9L8qNC9eeYnkuSOtA7k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420722; c=relaxed/simple;
	bh=sLMGR09zI4y3gpjzSi6grOOg7wQjmI4f5Efbabe2ap4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qItm2AlfxkFyzrxTnkuNDVY+cu2uPZUqhZGzEyK5BqLm4gfWxhFpuESxkmnu1mg7VQvu/t1tZgmifUHWkUK8ID/7ZTB5L5CIpziWqSVKJbR/uy3xeJ5XFYLZZmPh4u0oXUxmgaWwMvRRJ1m7O2RGhDuebE7jxd3bSUUwhnoTiIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Onq8ALfd; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-437711e9195so3752881f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 05:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771420719; cv=none;
        d=google.com; s=arc-20240605;
        b=Vh9F3I9u/d0lq8FX/jhHvTNL8wKzQFb5cANWZDGNEYXQrqcFaK0DYmen/7Y9TDVdN7
         GEyqCohZbsF07EleHS8A55/pjb18hpCiKy74vhxbb9G8E2ASU8CX9XSqd1fPmY2ohzXq
         uNb3BOx7PVhxGN6D8lPg/HafaRSDOmdJzweTY/WRzIVD28u5ZLxC8C2tR0fZYVsugjR6
         SV/do9OEtqIspo/Bbra9PtfM45FUkJAWsi7r/YKtROxBKkt/LYKQbX5neLjyj0Gp5vyC
         KmeQBCMxr8eRHjFm03VT9EuI8Za/cXQ51hE0qnjOFiC0EhmuBbyjYozKb17Nl8OcGB7F
         PJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        fh=URVYzOLK82+plcOY+z8a4obkmzcOeB6nJS1N2jgGVR8=;
        b=fcjNhRhwotkEJF92/2PERcZFFZiEK/bN0YuzMXpLFst8nnM8ijcmP8G2sfHJM2nua8
         RG5B5lgMOgrinx1ekftLAxhDY2dHxb1gLiJUu/XxfadZW1/blbWrcG0r1qfdLbohNGGX
         PfaJPvbko2/FTVSXcFiDBr6h5TRMupdSFA6VUnjxkKtxAoNjmb6hI6N/+dZpInGBrG+8
         KbPjpvyptfjzlVrjmwgeDaXWSA1M3XpTyJsBpcWBP4jGxVVv3u8wc1UCaWo6u6/8mL1+
         hGj3qZPxMbmZE/ttdPjBEJM6hB4z4lo+NLrz+9JXLX6wI3yHHsFint+dumdnZpczLB4n
         k+7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771420719; x=1772025519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        b=Onq8ALfdPQu6Dgw3a15nKbA09J6rzOwkPAfTk8y9o9yjRD3hqfqxCygRhg/J1sLKfM
         Zda5bkTSUgAHkYZ2+B2mAFmjB6ppVM8wLv27EGpnDQwFb+GlpW6Uyte60rYXZ/8e0ln2
         EuVFhhGluTzk3tW/Fdrs2OW/oWgIN1edYnlXhbo7Uc3Q4n0yo/YISsXUI/5xk6YcwfeD
         SU5IVMR1MzlTKb2N/eeJyfLmw6Kdf79yYFdTbCz1tAEq+u/4S+SBqsdpH833JE1w5Quh
         4PWRWOUoT773pY2oqnObD4ayXyAnXLMsF8T4bkTlnQnul9dCmLQgJ4Oi+qw83KsFdXXR
         t0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420719; x=1772025519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHxjjrT8dDKAZN0w50HLXW8C36xUtCBdYdPVz0Pgsc8=;
        b=HLyovtWHWeIXwDpHRt6hNlgGPvqdKDA7meaRPDyblQuS9mXCTDIb1KbMlPPLRaZ0eA
         1wYYko8VTtuhos869fO13DTHMSg51HbgU2a0MKF/HK1K6L7gVL71Txt3GBzMAYU6YUHv
         GYMcc0T01IOkb55Z8skN2Xm7gE99dnl97AWppMMfKGE9u6L5hxZfwku5h2mmFHzJt62p
         SbXkjDMBKEV/pPdu5v7rrqqJ8fTpCfQnHuRHrw14vhsW35ya06Ak94H8y8sQQr2UjO5+
         pgg5664s3SWXToBXkqHInTCb+jx48Wwp6uVL8BGrpQ/W66Ob29mZ7itdD+EMfCzr15f8
         kbAA==
X-Forwarded-Encrypted: i=1; AJvYcCXsXy89hZZwG/i8Q3Xpm39Pr6XrUY4bSy2F0Gd5RzWd6/Nz3XMqNFFkj0b2FhNdZUU24zFrqMS1Z4ME5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqgTLk4EJpwH+c82X2R2WGy5cw3zgUHaWVk57ANa/XY+gw4+D
	rngowd4KPuIqVw0Q5stSm0Ef/jXYHc9Myv6wLyO0w5uvUDB6wpI9PK+11lqf89lVjAik45EQb+p
	OZ3obTPuHSrr5LIQZjnOB7B0goxxT7AqfdthJrD5Ziw==
X-Gm-Gg: AZuq6aLAnRjl0d/RUN9U9EA6MUvgtuBq2rC0GqpxILBrrSlcU9gaWn/26exRttdgPfW
	W5YXQ8kU2bQGCpbx0DmBvcI6c+rWq8G0eAWF34zGezXscEGR+0vwk9kk4cr+GEYJrScdbiQgKqi
	4bZKpxFjRgIzOP+LgvyzgFWCJhgmmJTLZjGID9csjPMW7OC646ux3fKzAPR7+8DiOdS/O8MaLke
	4pKXVSe8DFbKAk3iFeDryvDbKTONLoF4eOO7ADr4uzmtfitwLKXr5wYj7IswFQES8iIrMj2b0tt
	9baSkGw9lolOicobXlJLVB+qR/0rj0may9s1+VH2mIjQZ+hGBYKIl7Lnwes6k8HIz379r8QFLvU
	oa+U0
X-Received: by 2002:a05:6000:26cd:b0:435:a815:dd8d with SMTP id
 ffacd0b85a97d-43796b04f57mr32979736f8f.55.1771420719317; Wed, 18 Feb 2026
 05:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-12-neelx@suse.com>
 <20260208153808.3476221-1-clm@meta.com>
In-Reply-To: <20260208153808.3476221-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 14:18:28 +0100
X-Gm-Features: AaiRm51fAAFTVBcqF-KI5-Lr8gaWIksaX5IH6JtEAzcWunIgDM49UiSlrdWV5YQ
Message-ID: <CAPjX3FdXC5LX6UBmsCf6cdGquwsPrh3gp3OKj0NEerXkbFSd5w@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] btrfs: add inode encryption contexts
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21752-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 124A11568E1
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:38, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > fscrypt stores a context item with encrypted inodes that contains the
> > related encryption information.  fscrypt provides an arbitrary blob for
> > the filesystem to store, and it does not clearly fit into an existing
> > structure, so this goes in a new item type.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 2d6114c2937b897d844735aa16d5369e3ec6d135
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: add inode encryption contexts
>
> fscrypt stores a context item with encrypted inodes that contains the
> related encryption information.  fscrypt provides an arbitrary blob for
> the filesystem to store, and it does not clearly fit into an existing
> structure, so this goes in a new item type.
>
> > diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
> > index 6cfba7d94e726..e9b024d671a22 100644
> > --- a/fs/btrfs/fscrypt.c
> > +++ b/fs/btrfs/fscrypt.c
>
> [ ... ]
>
> > @@ -1,10 +1,126 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/iversion.h>
> >  #include "ctree.h"
> > +#include "accessors.h"
> >  #include "btrfs_inode.h"
> > +#include "disk-io.h"
> > +#include "fs.h"
> >  #include "fscrypt.h"
> > +#include "ioctl.h"
> > +#include "messages.h"
> > +#include "transaction.h"
> > +#include "xattr.h"
> > +
> > +static int btrfs_fscrypt_get_context(struct inode *inode, void *ctx, size_t len)
> > +{
> > +     struct btrfs_key key = {
> > +             .objectid = btrfs_ino(BTRFS_I(inode)),
> > +             .type = BTRFS_FSCRYPT_INODE_CTX_KEY,
> > +             .offset = 0,
> > +     };
> > +     struct btrfs_path *path;
> > +     struct extent_buffer *leaf;
> > +     unsigned long ptr;
> > +     int ret;
> > +
> > +
> > +     path = btrfs_alloc_path();
> > +     if (!path)
> > +             return -ENOMEM;
> > +
> > +     ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
> > +     if (ret) {
> > +             len = -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     leaf = path->nodes[0];
> > +     ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
> > +     /* fscrypt provides max context length, but it could be less */
> > +     len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
> > +     read_extent_buffer(leaf, ctx, ptr, len);
> > +
> > +out:
> > +     btrfs_free_path(path);
> > +     return len;
> > +}
> > +
> > +static int btrfs_fscrypt_set_context(struct inode *inode, const void *ctx,
> > +                                  size_t len, void *fs_data)
> > +{
> > +     struct btrfs_trans_handle *trans = fs_data;
> > +     struct btrfs_key key = {
> > +             .objectid = btrfs_ino(BTRFS_I(inode)),
> > +             .type = BTRFS_FSCRYPT_INODE_CTX_KEY,
> > +             .offset = 0,
> > +     };
> > +     struct btrfs_path *path = NULL;
> > +     struct extent_buffer *leaf;
> > +     unsigned long ptr;
> > +     int ret;
> > +
> > +     if (!trans)
> > +             trans = btrfs_start_transaction(BTRFS_I(inode)->root, 2);
> > +     if (IS_ERR(trans))
> > +             return PTR_ERR(trans);
> > +
> > +     path = btrfs_alloc_path();
> > +     if (!path) {
> > +             ret = -ENOMEM;
> > +             goto out_err;
> > +     }
> > +
> > +     ret = btrfs_search_slot(trans, BTRFS_I(inode)->root, &key, path, 0, 1);
> > +     if (ret < 0)
> > +             goto out_err;
> > +
> > +     if (ret > 0) {
> > +             btrfs_release_path(path);
> > +             ret = btrfs_insert_empty_item(trans, BTRFS_I(inode)->root, path, &key, len);
> > +             if (ret)
> > +                     goto out_err;
> > +     }
> > +
> > +     leaf = path->nodes[0];
> > +     ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
> > +
> > +     len = min_t(size_t, len, btrfs_item_size(leaf, path->slots[0]));
> > +     write_extent_buffer(leaf, ctx, ptr, len);
> > +     btrfs_mark_buffer_dirty(trans, leaf);
> > +     btrfs_release_path(path);
> > +
> > +     if (fs_data)
> > +             return ret;
>
> Does this code leak the path when fs_data is non-NULL?
>
> In btrfs_fscrypt_set_context(), a path is allocated via btrfs_alloc_path()
> but when fs_data is provided (during inode creation with a transaction
> handle), the function returns here without calling btrfs_free_path(path).
>
> The btrfs_release_path() call above only releases internal references to
> extent buffers and locks but does not free the path structure itself.
>
> This leak occurs on every encrypted inode creation. The fix would be to add
> btrfs_free_path(path) before the return.

That's correct. Good catch!

--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -155,7 +155,7 @@ static int btrfs_fscrypt_set_context(struct inode
*inode, const void *ctx,
     btrfs_release_path(path);

     if (fs_data)
-        return ret;
+        goto out_err;

     BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
     btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));

Thanks.

--nX

> > +
> > +     BTRFS_I(inode)->flags |= BTRFS_INODE_ENCRYPT;
> > +     btrfs_sync_inode_flags_to_i_flags(BTRFS_I(inode));
> > +     inode_inc_iversion(inode);
> > +     inode_set_ctime_current(inode);
> > +     ret = btrfs_update_inode(trans, BTRFS_I(inode));
> > +     if (ret)
> > +             goto out_abort;
> > +     btrfs_free_path(path);
> > +     btrfs_end_transaction(trans);
> > +     return 0;
> > +out_abort:
> > +     btrfs_abort_transaction(trans, ret);
> > +out_err:
> > +     if (!fs_data)
> > +             btrfs_end_transaction(trans);
> > +     btrfs_free_path(path);
> > +     return ret;
> > +}
>
> [ ... ]
>


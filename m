Return-Path: <linux-btrfs+bounces-21709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOuYItGIlGmxFQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21709-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 16:27:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FFE14D8E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F2C3034675
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6FE36B045;
	Tue, 17 Feb 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tfoa6DlL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69F28D8DB
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342012; cv=pass; b=C/K52fWmn5WOFZyHgoG7EqmekW4urzWvgZYiJagHCF19gghQQeOFrFkMpqQieNkwD2v3WSgH4o1rkZur5Q9nRFtsgCAbyVyCCso/69rNwmnaeZYNgOQc9NOfvu1k6hwKhPAJl1w98esx9VuT1jDJhdOYac2MK9vfJfuH3SCEK/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342012; c=relaxed/simple;
	bh=QU9gfqo/KGzkYFSrwSgaxescpixzrT1ChZPSPllm5xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKKiHHzL31iJ6gg+WJTTNSmUfS2IqlWywmn76LW1tuCJsJqHSkQeYL7LBP4HGlBkSigjMthUHXwqLkDmRADs3Jt95Ae2Mup3YmbIp8p+Nvzcla/OLQGZ7H8G0oE+MgLbtPLiT3rdrUrPNxwaxxryhLHJjwFdYiy5SCp23/ZYI7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tfoa6DlL; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43767807cf3so3308252f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 07:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771342009; cv=none;
        d=google.com; s=arc-20240605;
        b=NxmCd9X7/a/MeU91iWXmvp41ihC06t2zkjlVZ6gWDeEc1sHq8oiKRaijM+CH8zZ4p0
         Y8ihJG7gTvh6klOqIuTsG/uotfvzcNhhfTFqVwmDq1cUZrEh+P1Gj58XT+9GgJOf7Nqm
         rw4TVycB7krj9aRJbOoZOEwa5E4syye00rtP2aZRWGEA8vX5AJUExpH+OQSu2fo6NZrD
         E2f+n9Pvs0I2FXvtoHTDIDUx2XRUZ4g20RihdoEREMJC3VMzRWyuNDYF0yzjivKKcT3z
         h7mpWYdkQDpU+QddnB+TFca5LZghsH+d4xE5vFiXJN8fLDTEk2fhcxZWMbD7zM1+QY6G
         LJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        fh=W9iJDiRLm86STL+4KaiLYbZ3Fsl0qu9TfAdb0oT0QrY=;
        b=JfQsijOR3LBNL4I6etAls4ifXpgvbXe6WY+Xkqni7hW2gMk54VzUSNGiguXGMTCa6t
         Z/4Dlt/dz0XFKbZP+5reMHS+3/4wD8GrxZg3J3AuTG9AKt5h3FNL+Kfhphfax9Bhzjg8
         9yIDWAip8boZRfPzXrLO5WQVGxkCm6/5wcrLAmSPqVMM67RrKPoMrfb8254Rv+fAdzho
         fJ5JZOftnlCU/P2mje7eFJ3TiuimP/X8AvSdqqB/EuM2vC3t8S79gvBsgV/CeRRy85jU
         uZeZPX729ZyIh6/k6wIOaj+fYWPvEA4HLVYOoPjbYyy4ESAjg0/f9UHQP0bsMmnp2MAb
         OeRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771342009; x=1771946809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        b=Tfoa6DlLAeYMFJe1P9zNlaGNGLAcninuSHjbgk9TuOno+zCq1H2OodBzFSs2DjXmlY
         8+iaWSgz2DFwLDr0Qw3CeJ0zd+7quytkef1PAl6ZRbdqWFT5iUKJpkHx95vSiP8Z8Ku5
         2TsC9nQkvJEyNPp4P+SK6pgmPPKIziGavu7d71AYX0ZVMV8+shEm+R6V6LgGoIbqp03g
         Zvg8qKWQuaeP/Zng3GdsYzEoZ0LYxhlNHY7qXdm8SzQ4tNa52nia3HZa/IgMgkxRUVJ/
         ihGfgJqfsZbXLW41eriFyD5VVDgTRV5UvC5sfaD51IQuUJ8UBNFQSTdEA3ZhKa6sYyyK
         UWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342009; x=1771946809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wuz1nEPgQgJZb0CfkGexL1RSDUl2223kduCyuikvpw=;
        b=EI4XcpK7jgpQreXfbnNluHenKcRZH5E8JrMrL+/uhvlw160hktiBBh0NHjXrQ61Gf/
         sVwIuxqPxmovUd4/sP/MDJg8C0rC/j8lCXBluc/aES2deOaaei4CvdCZFqpXe0wLK59y
         oEkTSB3qEADum4RIFOByH7D+KkOc3iUnLvUQFSIi0NjOa8tfFe0+0mo3OEiS1q9Ur4VY
         fxbU7XI1J7IoL1R6J9AGKQuVoN8ym54aaZJEA9DrwZR6deWlYhIx/HR2zvtj3BBhxrdV
         ip3WilcuZgzt3lu62b5lq5NkuSusfphf1VlZyFsMrkBxgZEik4ZLMESWLcHjC5TgZvsC
         WW/g==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ugt+hfxakoTzybRcRa86+Dswv42qRddAhYtJPsSMtp1fYUXfqtSV98UB5hpGiaLpAEOoWZHMQfo+bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6E8LLK0q6Fd1JjWFNX/yGBpxHnecXbFw5Fy3VJNzMOKsjv4Am
	ZCg6YeNjcROxAiB/mnmeLfYBApWGMueOX3qBi7csp6ocPcvzHyThiyaGAhW5sGOYg39gpLO8lKF
	1BCkH6kzRFwCl9PuF+h3RpPY+q/qP/Uzs+4BYth0JLQ==
X-Gm-Gg: AZuq6aJCVTyfDjcUx8W0GOQU71ZDGE135/fC4AXbZQhfSR8hD0EgCh4sCyLK4yJ2TOR
	9xN4X5OH9eLCg01U1YFF6viQ80WHLQPJzwhCDGYSb5jsi4Iq5SJH+OFoL10P1+wG0OOQphQ936l
	m8++MyT2hC4uGMVvPItRRv+vfh1TwVK75xwHqkcZdRSHXT6orK070wMbdwT70rdBY72+XM0U85s
	iyV1luxyPvs1rKnOeD1evvbFSKOSAge7afK+tkVIgxa4McSOy0w0l2Ivov9xPSOXm0BSztWyAWW
	jkyh8JstrdRgdgRYJugElk/ax3I2kotHAtKkcdYZCV/6qpmjqfI2C/PbPEz4cS0IBm1H1jb2k4X
	8O0QUkqlKLOYERcI=
X-Received: by 2002:a5d:5f94:0:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4379db263a3mr24419508f8f.5.1771342009087; Tue, 17 Feb 2026
 07:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-11-neelx@suse.com>
 <20260208154525.3580889-1-clm@meta.com>
In-Reply-To: <20260208154525.3580889-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 17 Feb 2026 16:26:38 +0100
X-Gm-Features: AaiRm520Z8Hl9bm0ivGx5cxjGTTyaohyph4iD5YmFA_17gCb_AqQi4Gw0P2mfxo
Message-ID: <CAPjX3Fd0mAMwust4F5VjS02sT4rE-OauSrEho9VSPPe5gi8WPQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/43] btrfs: start using fscrypt hooks
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21709-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 28FFE14D8E9
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:46, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > In order to appropriately encrypt, create, open, rename, and various
> > symlink operations must call fscrypt hooks. These determine whether the
> > inode should be encrypted and do other preparatory actions. The
> > superblock must have fscrypt operations registered, so implement the
> > minimal set also, and introduce the new fscrypt.[ch] files to hold the
> > fscrypt-specific functionality.
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
> commit 4d7d769810b1d47ec75a6efa0f691c43d9969b54
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: start using fscrypt hooks
>
> This commit adds fscrypt support to btrfs by implementing fscrypt hooks
> in various inode operations including create, open, rename, and symlink
> operations.
>
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b6c763a17406b..9d90e2e946fc4 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
>
> [ ... ]
>
> > @@ -6506,6 +6510,12 @@ int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
> >               return ret;
> >       }
> >
> > +     ret = fscrypt_prepare_new_inode(dir, inode, &args->encrypt);
> > +     if (ret) {
> > +             fscrypt_free_filename(&args->fname);
> > +             return ret;
> > +     }
> > +
>
> When fscrypt_prepare_new_inode() fails, are the ACLs leaked?
>
> Looking earlier in the function, posix_acl_create() allocates args->acl
> and args->default_acl. When fscrypt_prepare_new_inode() fails, the
> error path frees the filename but doesn't release these ACLs.
>
> Callers like btrfs_symlink() skip btrfs_new_inode_args_destroy() on
> error, so the ACLs would never be released. Should this add
> posix_acl_release() calls before returning?

True. Fixed with the below hunk. Thanks!

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6574,7 +6574,7 @@ int btrfs_new_inode_prepare(struct
btrfs_new_inode_args *args,

     ret = fscrypt_prepare_new_inode(dir, inode, &args->encrypt);
     if (ret) {
-        fscrypt_free_filename(&args->fname);
+        btrfs_new_inode_args_destroy(args);
         return ret;
     }


> [ ... ]
>
> > @@ -8994,20 +9015,28 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >       };
> >       unsigned int trans_num_items;
> >       int ret;
> > -     int name_len;
> >       int datasize;
> >       unsigned long ptr;
> >       struct btrfs_file_extent_item *ei;
> >       struct extent_buffer *leaf;
> > +     struct fscrypt_str disk_link;
> > +     size_t max_len;
> > +     u32 name_len = strlen(symname);
> > +
> > +     /*
> > +      * BTRFS_MAX_INLINE_DATA_SIZE() isn't actually telling the truth, we actually
> > +      * limit inline data extents to min(BTRFS_MAX_INLINE_DATA_SIZE(), sectorsize),
> > +      * so adjust max_len given this wonderful bit of inconsistency.
> > +      */
> > +     max_len = min_t(size_t, BTRFS_MAX_INLINE_DATA_SIZE(fs_info), fs_info->sectorsize);
> >
> > -     name_len = strlen(symname);
> >       /*
> > -      * Symlinks utilize uncompressed inline extent data, which should not
> > -      * reach block size.
> > +      * fscrypt sets disk_link.len to be len + 1, including a NUL terminator,
> > +      * but we don't store that '\0' character.
> >        */
> > -     if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
> > -         name_len >= fs_info->sectorsize)
> > -             return -ENAMETOOLONG;
> > +     ret = fscrypt_prepare_symlink(dir, symname, name_len, max_len + 1, &disk_link);
> > +     if (ret)
> > +             return ret;
> >
> >       inode = new_inode(dir->i_sb);
> >       if (!inode)
>
> [ ... ]
>
> > @@ -9044,10 +9073,22 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >               inode = NULL;
> >               goto out;
> >       }
> > +
> > +     if (IS_ENCRYPTED(inode)) {
> > +             ret = fscrypt_encrypt_symlink(inode, symname, name_len, &disk_link);
> > +             if (ret) {
> > +                     btrfs_abort_transaction(trans, ret);
> > +                     btrfs_free_path(path);
> > +                     discard_new_inode(inode);
> > +                     inode = NULL;
> > +                     goto out;
> > +             }
> > +     }
> > +
> >       key.objectid = btrfs_ino(BTRFS_I(inode));
> >       key.type = BTRFS_EXTENT_DATA_KEY;
> >       key.offset = 0;
> > -     datasize = btrfs_file_extent_calc_inline_size(name_len);
> > +     datasize = btrfs_file_extent_calc_inline_size(disk_link.len - 1);
> >       ret = btrfs_insert_empty_item(trans, root, path, &key, datasize);
> >       if (unlikely(ret)) {
> >               btrfs_abort_transaction(trans, ret);
>
> [ ... ]
>
> > @@ -9084,6 +9125,29 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >       return ret;
> >  }
>
> Does this code leak disk_link.name when creating encrypted symlinks?
>
> According to fscrypt.h, when fscrypt_encrypt_symlink() is called,
> 'one will be kmalloc()'ed and the filesystem will be responsible
> for freeing it'. However, btrfs_symlink() never frees disk_link.name
> in any exit path, whether success or failure.
>
> Looking at ext4/namei.c:3443-3444, it correctly handles this:
>
>     if (disk_link.name != (unsigned char *)symname)
>         kfree(disk_link.name);
>
> Should similar cleanup be added here?

Agreed. I think this fixes that leak (untested):

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9196,7 +9196,7 @@ static int btrfs_symlink(struct mnt_idmap
*idmap, struct inode *dir,
         btrfs_free_path(path);
         discard_new_inode(inode);
         inode = NULL;
-        goto out;
+        goto free_name;
     }
     leaf = path->nodes[0];
     ei = btrfs_item_ptr(leaf, path->slots[0],
@@ -9215,6 +9215,9 @@ static int btrfs_symlink(struct mnt_idmap
*idmap, struct inode *dir,

     d_instantiate_new(dentry, inode);
     ret = 0;
+free_name:
+    if (disk_link.name != (unsigned char *)symname)
+        kfree(disk_link.name);
 out:
     btrfs_end_transaction(trans);
     btrfs_btree_balance_dirty(fs_info);

Thanks again!

--nX


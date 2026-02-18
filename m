Return-Path: <linux-btrfs+bounces-21753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNGMNUzHlWkFUwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21753-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:06:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A19A156F90
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D53E5300BCBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA75330321;
	Wed, 18 Feb 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dyNzfm15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9843033DC
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423552; cv=pass; b=YqjBM7IoqhjrlqLLThuO2Btungm8yebjZFCL2r3Yv6BHRcPHly1aRjOV7WQVoN7wkvVeA/oNhqmmL9vNXM3E3fuECjSNUKUiTGzmBKTjBXeTnrd30LPosBt1Ao/tvWto+1QCiNmiZz22WKEUdqBtDJC8XdtsIaCJVR7UBRB4SYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423552; c=relaxed/simple;
	bh=0IPQfandQcQcgM/09gru9lXRdDMyChSp6OWGiSUPAb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlQv5n4dLXbnuZ9awXJDmOoQOBzGPzYaR2uWRkijZ20hsaXRFoNSjPs9ysbfwDFlVdlSUoeRbjBnIG0fVcAv6OyAiBAFlwRVcnUtABx5fXUkPQtnRylRECwQiTIdJfM7NT+WKGLsfuqwfo6BNe/Fb/qK2W5KBEO3fMVA7NOTe0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dyNzfm15; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso22849305e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 06:05:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771423548; cv=none;
        d=google.com; s=arc-20240605;
        b=MX5E0wUIV0+SlP3qb1gNAdpbkVZPYGuuhcu0j3vdSnCLWfBrVsXuKRHxuIVWneGJmz
         aFSDlJuMJ8d7ddwayV2z9oVhZIktNl75kWeAwAP2Gfe4o4lUiVh8ouz++pVJ1T4oFZFK
         03tHGNz8zP6rFMSf9DtHUwAUwx1WOuhycRiDSkRsto5nZswTADMMY5C3KHs/X5LzWhm5
         bF3iYddNeRResBegZGHtpws1ZeQDkVDyK77VzM/s1w4JsvcCG/GoYzPxctlvbfESwBIC
         aC/eD8WIMKRb7VFd2bJlCE9kn2akTVHgKEUfjZHUdTmaL53NGM8jPro5P43kM7XXNxPw
         AGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        fh=wJczvvPXKky6gIVtqIB1opAmdZC71lyXjpcnEUB8yXE=;
        b=K7VF4fKEQUJy9gf2UWkmqaTV3yLuWDMa/BdxvN7SkdFnY19q8TYI59ixSu2BTWx7Yk
         jAsWr5PlpqaOovMYzV17EAvSI6WYu7O/UPOfgKQtLP5ESA7lY+q62T4ZUJ/ctShY/5be
         QXxutZMWoWELbxiM4cqLLPT7VSiY338UhZtsJI/N97xFH6LujQCFJnBiiUns9JFhtdAb
         zydL985l4rmaxrdeHKFlweJWVOqpHkAbo6pS5tMubwe+U2yGeQcSNRjm0qLfilGVU+AV
         L8Xo3xrIhuWzsI54KHaLITRoHHC6g6Pr/EOiOyp3XzS6kCxvPAD0a/UxpH9FIqBpPDaU
         w0ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771423548; x=1772028348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        b=dyNzfm150yPWPRdOJcw6LyIJ4XntfMbNBXzov9rUmvcdHnJDvKWPkDWKM3TztbQvkE
         pzEt9TUbqJp65oD4B77ioqUynrlzYLn4RZ+H64gYMUrB2MeWJd4s1rIK5JbOW2RD43UE
         st7c9uQNIxiivA9EkzF1m38q0WkSvzgO2S2AzbYTuGk62vGvKWPRdnMxX+FTPBDarXgB
         p9MkVWtwB3vh5JcDYLpxCA1oyzao1FNWEPWfybwJCOoybp6PybozGDyn40WyaQVRyAbm
         ireEeWHy7PjmfuVBZX7ScZguZ+rcLi2uPECCeyQ3ZK4tQ+rg9aL351fOslGxCqx14fCf
         j4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423548; x=1772028348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG0K+ScZHI1JMARqHPSZnWOCAEhLzuWZYvaV9Vd0R8Y=;
        b=Y0nENeQn/7N7S4EE3rcUe0Hf76Z3cDW7TW/1Z/agZrS5kSHFPNM1KZs7gKCfLk5dA5
         jt4nAiXK/NiSo+l+TzfrYL6gxxVeriB7klCyKyfO5Wmqt0udxQ3IMDLvha7d6d7CgcLR
         KbI+OKZeedqvAXsREvu+B0fdHT6FLHgsVUrceDHyy+mYFNrkIbRpoyVd5sITvBLSbA0e
         P4OmuxI3F5xP0JxDMmwH8XaR/qlmY3YyavdAMbcwi1etLs4ggzrI9V4ILIzKlM70Zg9v
         XseXcf/w1h3mMYlu39dozXyheAI9BjJg/+9Enk5tKMLWTX3c8BxfhUrxMcqdCkc5EA1Z
         FHDA==
X-Forwarded-Encrypted: i=1; AJvYcCWNZZrrE7WwQ3Wi38xNziZ1qtFot5D6cGPK6epHixbTfN40c7o1GbgX90C5HT2Mitq0ZtBPhzPtKv6kQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rO8kaHITtL8HAbniDiKk8DhbxEZIEI9SC6C1IuHdzHnRihxP
	jVrJFZb5p5HvG6QYshJKjc3Y29udGp2mfYkWvbF8Gv4q6SE9e1vc23cg7h+roDtRsRFx+wRfnnf
	wmOPO69NTXyPYqF0+0TA0x5mHEkkRh5htc4gMPOwhhA==
X-Gm-Gg: AZuq6aIG8jSiDXdaiqct5Ic1hpRw25eWNVo5B/bGXhNicK7rA56UDMZPzMq76jkM3L8
	eUegfP4UFqmHTJ7goTrbuiwDuJM8jgWcnajCLex7ZLSYH9QREjVCo4iQToAnO5LLz2v0YBs2S1R
	s1mCfKOpEOWfLZ1rwvLvsiPpCF7GsDOunT0xFqaai5/2uqGpQNIRlyh+XCget+wiIctXTokmpD5
	exuMIhgT43NZoajeYfBS2WvFpYSO+tvTWVCRoY19VVBpX5+dD/LcLCBszjA1SiCbXndiAsIdSQX
	vsGkMlI9EIaTFtjgxu5TL6oDoYF07rGPxYvWUAe3SZvK8UWv9VGQufhhibme+gq5Q/QaPwtNtvi
	j0GO7
X-Received: by 2002:a05:600c:6912:b0:483:709e:f22d with SMTP id
 5b1f17b1804b1-4837108fc46mr300110235e9.27.1771423547925; Wed, 18 Feb 2026
 06:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-14-neelx@suse.com>
 <20260208153607.3466929-1-clm@meta.com>
In-Reply-To: <20260208153607.3466929-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 15:05:37 +0100
X-Gm-Features: AaiRm510tlnOinFS7nG7T90JA_M8mhwdBINiTRaMYypuSLi3O4tUUbZEt6vztBA
Message-ID: <CAPjX3FdE9nLWE12KRxpXyj9Hy-Z1JSmWcDMBgT0fuyQsfafAHw@mail.gmail.com>
Subject: Re: [PATCH v6 13/43] btrfs: adapt readdir for encrypted and nokey names
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osandov.com:email,meta.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21753-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 4A19A156F90
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:36, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Omar Sandoval <osandov@osandov.com>
> >
> > Deleting an encrypted file must always be permitted, even if the user
> > does not have the appropriate key. Therefore, for listing an encrypted
> > directory, so-called 'nokey' names are provided, and these nokey names
> > must be sufficient to look up and delete the appropriate encrypted
> > files. See 'struct fscrypt_nokey_name' for more information on the
> > format of these names.
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
> commit e264482bd61ca8096981d81cc5e7c839284ac969
> Author: Omar Sandoval <osandov@osandov.com>
>
> btrfs: adapt readdir for encrypted and nokey names
>
> This commit adapts the btrfs readdir implementation to handle encrypted
> filenames and nokey names, enabling directory listing and deletion of
> encrypted files even without the encryption key.
>
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 1739a0b29c49d..c19213fab3dda 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
>
> [ ... ]
>
> > @@ -1820,7 +1823,25 @@ bool btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
> >               d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
> >               btrfs_disk_key_to_cpu(&location, &di->location);
> >
> > -             over = !dir_emit(ctx, name, name_len, location.objectid, d_type);
> > +             if (di->type & BTRFS_FT_ENCRYPTED) {
> > +                     int ret;
> > +                     struct fscrypt_str iname = FSTR_INIT(name, name_len);
> > +
> > +                     fstr->len = fstr_len;
> > +                     /*
> > +                      * The hash is only used when the encryption key is not
> > +                      * available. But if we have delayed insertions, then we
> > +                      * must have the encryption key available or we wouldn't
> > +                      * have been able to create entries in the directory.
> > +                      * So, we don't calculate the hash.
> > +                      */
> > +                     ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname, fstr);
> > +                     if (ret)
> > +                             return ret;
> > +                     over = !dir_emit(ctx, fstr->name, fstr->len, location.objectid, d_type);
> > +             } else {
> > +                     over = !dir_emit(ctx, name, name_len, location.objectid, d_type);
> > +             }
>
> Does the return statement at line 1840 cause silent error loss?
>
> The function btrfs_readdir_delayed_dir_index returns bool, but
> 'return ret;' returns an int error code from fscrypt_fname_disk_to_usr.
> Since ret is negative on error (e.g., -EUCLEAN from fname_decrypt
> failures), this converts to 'true' in bool context.
>
> The caller btrfs_real_readdir at inode.c:6410 interprets true as "stop
> iteration normally":
>
>     if (btrfs_readdir_delayed_dir_index(inode, &fstr, ctx, &ins_list))
>         goto nopos;
>
> The nopos label at line 6417 sets ret = 0, which means readdir()
> completes successfully with incomplete results when crypto operations
> fail on encrypted directory entries.

This still seems correct to me. While rebasing, however, I missed that
the return type changed in 41e4ea0bf555 ("btrfs: make
btrfs_readdir_delayed_dir_index() return a bool instead").
If I'm not mistaken, we can just `return true;` here:

--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1837,7 +1837,7 @@ bool btrfs_readdir_delayed_dir_index(const
struct inode *inode,
              */
             ret = fscrypt_fname_disk_to_usr(inode, 0, 0, &iname, fstr);
             if (ret)
-                return ret;
+                return true;
             over = !dir_emit(ctx, fstr->name, fstr->len,
location.objectid, d_type);
         } else {
             over = !dir_emit(ctx, name, name_len, location.objectid, d_type);

> [ ... ]
>
> > diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> > index 085a83ae9e62f..6e10dd4a4e9e1 100644
> > --- a/fs/btrfs/dir-item.c
> > +++ b/fs/btrfs/dir-item.c
>
> [ ... ]
>
> > @@ -227,6 +228,47 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
> >       return di;
> >  }
> >
> > +/*
> > + * Lookup for a directory item by fscrypt_name.
> > + *
> > + * @trans:   The transaction handle to use.
> > + * @root:    The root of the target tree.
> > + * @path:    Path to use for the search.
> > + * @dir:     The inode number (objectid) of the directory.
> > + * @name:    The fscrypt_name associated to the directory entry
> > + * @mod:     Used to indicate if the tree search is meant for a read only
> > + *           lookup or for a deletion lookup, so its value should be 0 or
> > + *           -1, respectively.
> > + *
> > + * Returns: NULL if the dir item does not exists, an error pointer if an error
> > + * happened, or a pointer to a dir item if a dir item exists for the given name.
> > + */
> > +struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *trans,
> > +                                                struct btrfs_root *root,
> > +                                                struct btrfs_path *path, u64 dir,
> > +                                                struct fscrypt_name *name, int mod)
> > +{
> > +     struct btrfs_key key;
> > +     struct btrfs_dir_item *di = NULL;
> > +     int ret = 0;
> > +
> > +     key.objectid = dir;
> > +     key.type = BTRFS_DIR_ITEM_KEY;
> > +     key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
> > +     /* XXX get the right hash for no-key names */
>
> Can this dereference a NULL pointer for long nokey names?
>
> When btrfs_unlink() calls fscrypt_setup_filename() with lookup=1 for a
> nokey encrypted filename, fname->disk_name.name is NULL for long nokey
> names (see fscrypt_setup_filename lines 370-375 in fs/crypto/fname.c).
>
> The call chain is: btrfs_unlink -> btrfs_unlink_inode ->
> __btrfs_unlink_inode (line 4396) -> btrfs_lookup_dir_item_fname.
>
> This passes NULL to btrfs_name_hash() at line 257, which calls
> crc32c(NULL, len), causing a kernel crash. The XXX comment at line 258
> acknowledges this is unhandled.
>
> Note: This issue is addressed in a later commit in the patch series
> (fabad1c3ea821 'btrfs: handle nokey names').

Yes, this is handled right in the next commit.

Thanks.

--nX


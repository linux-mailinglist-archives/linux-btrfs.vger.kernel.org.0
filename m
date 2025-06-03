Return-Path: <linux-btrfs+bounces-14401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38619ACC18D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 09:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E792D188FF21
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822127FB2C;
	Tue,  3 Jun 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrD0xFCN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813F27F732
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748937342; cv=none; b=uVAaAsXKfYmrj11Lt4TeB7TD6n5iDic1uhiTamj0rAHRLSEgZ4KiwYfIHY9dULwOGfk8170OcEy6EtCNx9kywMH/qtT1ST8KJ7C5ingQ11w6tJCCOxF81+mlTgQTuFOacaEyOQOFnYpImsNwVhlKkkjfpo1k6fzZ5EID//ixzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748937342; c=relaxed/simple;
	bh=aPro4V0pCkhVRZhShT785cG7yAmLSnAu38cCe+cEc0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TptYBsmTLS5ig01DpE0cBacVBi3a8yEngoN6p1F/8oO0QOaOZMgVcOSCi767QU4CooJY6VQKafJZUSBIAejGvItzQj/pIJ8ZI4b41Y4LP1Oj4PUPWqCRuIqECdpY0Uc5nZbjLsVDN2fm8u1G/H6Vo8pOMK65x+dMPLZAXyc4tIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrD0xFCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565AC4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748937342;
	bh=aPro4V0pCkhVRZhShT785cG7yAmLSnAu38cCe+cEc0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PrD0xFCNNAvGPPNPW5zMFKZBfjlwWVD4PiqUpdFAlfVEb9/Z4kS7rFUqQFe7UJImt
	 BTbvdAT03J2s2OuFXyQWtyaBDtgH0Tc4Up+E7FN9D9idOHKZv6MA7oFEkSAx9VLMXt
	 mMDmkpXxQxMKXYH3k0jHnDRJoyW7G4x22iNPNYkv3KKW2POhtB3TCKy7J5KxAgLDyC
	 b7gz46LBU+LKzGY89w1xdrCjVaGqo30wLZwfJBYqr4XVM3mjkJg3Lp4NK20P/+xmHt
	 3JfzZmkVBmqCrZwy9mti2JimldjqdSHf//rL2hGJsJcBlGTKzEU6lF1KUL2r5Y3+48
	 zDVW7dofMYPug==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb39c45b4eso843396566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Jun 2025 00:55:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeAK+QF+NfLNI83bSrQDPTTbrrxZCSwNLgbdR1wiEh9rr4qYDT
	3exj23Lq+gBa14TtEp5bue368+MXyB+dcxyfRNl0SJvkfAFPITcqXbZJpayTD99ZT8OTINxxkCH
	5WMkXr0VvdwiP89tT1yNkp1ijhmtuDTw=
X-Google-Smtp-Source: AGHT+IEZgrFXxI4EzjWARnnw+bXYFN2Mxnbr7/e2BPbO+r7jFdrtYEZDT3UD9WQPg72cy0EEOWb7BE6zbyntzq13FAg=
X-Received: by 2002:a17:907:94c3:b0:ad8:8e56:3c5c with SMTP id
 a640c23a62f3a-adb32264c50mr1544845866b.11.1748937340892; Tue, 03 Jun 2025
 00:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748789125.git.fdmanana@suse.com> <10075404e05fae4f219cd308bff91a25ac3bd6fe.1748789125.git.fdmanana@suse.com>
 <20250603010310.GA1509461@zen.localdomain>
In-Reply-To: <20250603010310.GA1509461@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Jun 2025 08:55:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5a5gzL6BMsbpG3JBNwPeFxWq70Nt_Mz7YVPgCF=QJizw@mail.gmail.com>
X-Gm-Features: AX0GCFt_Vxonr-GUyaatOIKZ6TRXokGtE5ryqJrwuZIgTJKLbPG6H4HigYB3cIw
Message-ID: <CAL3q7H5a5gzL6BMsbpG3JBNwPeFxWq70Nt_Mz7YVPgCF=QJizw@mail.gmail.com>
Subject: Re: [PATCH 01/14] btrfs: fix a race between renames and directory logging
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:03=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Jun 02, 2025 at 11:32:54AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have a race between a rename and directory inode logging that if it
> > happens and we crash/power fail before the rename completes, the next t=
ime
> > the filesystem is mounted, the log replay code will end up deleting the
> > file that was being renamed.
> >
> > This is best explained following a step by step analysis of an interlea=
ving
> > of steps that lead into this situation.
> >
> > Consider the initial conditions:
> >
> > 1) We are at transaction N;
> >
> > 2) We have directories A and B created in a past transaction (< N);
> >
> > 3) We have inode X corresponding to a file that has 2 hardlinks, one in
> >    directory A and the other in directory B, so we'll name them as
> >    "A/foo_link1" and "B/foo_link2". Both hard links were persisted in a
> >    past transaction (< N);
> >
> > 4) We have inode Y corresponding to a file that as a single hard link a=
nd
> >    is located in directory A, we'll name it as "A/bar". This file was a=
lso
> >    persisted in a past transaction (< N).
> >
> > The steps leading to a file loss are the following and for all of them =
we
> > are under transaction N:
> >
> >  1) Link "A/foo_link1" is removed, so inode's X last_unlink_trans field
> >     is updated to N, through btrfs_unlink() -> btrfs_record_unlink_dir(=
);
> >
> >  2) Task A starts a rename for inode Y, with the goal of renaming from
> >     "A/bar" to "A/baz", so we enter btrfs_rename();
> >
> >  3) Task A inserts the new BTRFS_INODE_REF_KEY for inode Y by calling
> >     btrfs_insert_inode_ref();
> >
> >  4) Because the rename happens in the same directory, we don't set the
> >     last_unlink_trans field of directoty A's inode to the current
> >     transaction id, that is, we don't cal btrfs_record_unlink_dir();
>
> Presumably, an alternative fix would be to also call
> btrfs_record_unlink_dir() for same directory renames? However, it seems
> like pinning the log commit for the duration of the rename is going to
> be faster than falling back to a full transaction commit.
>
> Did I understand the rationale correctly?

Yes, you understood correctly.
We want to avoid setting last_unlink_trans for the directory, in case
of same directory renames, to avoid full transaction commits.

>
> >
> >  5) Task A then removes the entries from directory A (BTRFS_DIR_ITEM_KE=
Y
> >     and BTRFS_DIR_INDEX_KEY items) when calling __btrfs_unlink_inode()
> >     (actually the dir index item is added as a delayed item, but the
> >     effect is the same);
> >
> >  6) Now before task A adds the new entry "A/baz" to directory A by
> >     calling btrfs_add_link(), another task, task B is logging inode X;
> >
> >  7) Task B starts a fsync of inode X and after logging inode X, at
> >     btrfs_log_inode_parent() it calls btrfs_log_all_parents(), since
> >     inode X has a last_unlink_trans value of N, set at in step 1;
> >
> >  8) At btrfs_log_all_parents() we search for all parent directories of
> >     inode X using the commit root, so we find directories A and B and l=
og
> >     them. Bu when logging direct A, we don't have a dir index item for
> >     inode Y anymore, neither the old name "A/bar" nor for the new name
> >     "A/baz" since the rename has deleted the old name but has not yet
> >     inserted the new name - task A hasn't called yet btrfs_add_link() t=
o
> >     do that.
> >
> >     Note that logging directory A doesn't fallback to a transaction
> >     commit because its last_unlink_trans has a lower value than the
> >     current transaction's id (see step 4);
> >
> >  9) Task B finishes logging directories A and B and gets back to
> >     btrfs_sync_file() where it calls btrfs_sync_log() to persist the lo=
g
> >     tree;
> >
> > 10) Task B successfully persisted the log tree, btrfs_sync_log() comple=
ted
> >     with success, and a power failure happened.
> >
> >     We have a log tree without any directory entry for inode Y, so the
> >     log replay code deletes the entry for inode Y, name "A/bar", from t=
he
> >     subvolume tree since it doesn't exist in the log tree and the log
> >     tree is authorative for its index (we logged a BTRFS_DIR_LOG_INDEX_=
KEY
> >     item that covers the index range for the dentry that corresponds to
> >     "A/bar").
> >
> >     Since there's no other hard link for inode Y and the log replay cod=
e
> >     deletes the name "A/bar", the file is lost.
> >
> > The issue wouldn't happen if task B synced the log only after task A
> > called btrfs_log_new_name(), which would update the log with the new na=
me
> > for inode Y ("A/bar").
> >
> > Fix this by pinning the log root during renames before removing the old
> > directory entry, and unpinning after btrfs_log_new_name() is called.
> >
> > Fixes: 259c4b96d78d ("btrfs: stop doing unnecessary log updates during =
a rename")
> > CC: stable@vger.kernel.org # 5.18+
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> The explanation and fix make sense to me, thanks.
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> One qq: would it be possible / make sense to have an absolutely minimal
> fix patch that only restores the log pinning order (as changed by
> 259c4b96d78d) without the additional refactoring of the subvol root
> checking logic (i.e., getting rid of the per-root pin tracking bools)?
> Then separately do that refactoring?

A fix doesn't have to necessarily make code exactly equal to what it
was before, unless the only solution is a full revert, which usually
happens for fairly recent commits.

The code is slightly different, yes, but many things have changed
after that commit over the years.
I wouldn't call it a refactoring, and I don't see why you think it
makes backporting harder, in fact trying to do it exactly as before
would actually make the backport harder on more recent kernels.

The code now is equivalent, with more comments about what is being done and=
 why
The addition is to avoid logging new names in case we have set the log
for full commit, due to renaming a root, but that doesn't make it
harder to backport at all.

Thanks.


>
> > ---
> >  fs/btrfs/inode.c | 81 ++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 64 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 7074f975c033..7bad21ec41f8 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -8063,6 +8063,7 @@ static int btrfs_rename_exchange(struct inode *ol=
d_dir,
> >       int ret;
> >       int ret2;
> >       bool need_abort =3D false;
> > +     bool logs_pinned =3D false;
> >       struct fscrypt_name old_fname, new_fname;
> >       struct fscrypt_str *old_name, *new_name;
> >
> > @@ -8186,6 +8187,31 @@ static int btrfs_rename_exchange(struct inode *o=
ld_dir,
> >       inode_inc_iversion(new_inode);
> >       simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry)=
;
> >
> > +     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID &&
> > +         new_ino !=3D BTRFS_FIRST_FREE_OBJECTID) {
> > +             /*
> > +              * If we are renaming in the same directory (and it's not=
 for
> > +              * root entries) pin the log early to prevent any concurr=
ent
> > +              * task from logging the directory after we removed the o=
ld
> > +              * entries and before we add the new entries, otherwise t=
hat
> > +              * task can sync a log without any entry for the inodes w=
e are
> > +              * renaming and therefore replaying that log, if a power =
failure
> > +              * happens after syncing the log, would result in deletin=
g the
> > +              * inodes.
> > +              *
> > +              * If the rename affects two different directories, we wa=
nt to
> > +              * make sure the that there's no log commit that contains
> > +              * updates for only one of the directories but not for th=
e
> > +              * other.
> > +              *
> > +              * If we are renaming an entry for a root, we don't care =
about
> > +              * log updates since we called btrfs_set_log_full_commit(=
).
> > +              */
> > +             btrfs_pin_log_trans(root);
> > +             btrfs_pin_log_trans(dest);
> > +             logs_pinned =3D true;
> > +     }
> > +
> >       if (old_dentry->d_parent !=3D new_dentry->d_parent) {
> >               btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
> >                                       BTRFS_I(old_inode), true);
> > @@ -8257,30 +8283,23 @@ static int btrfs_rename_exchange(struct inode *=
old_dir,
> >               BTRFS_I(new_inode)->dir_index =3D new_idx;
> >
> >       /*
> > -      * Now pin the logs of the roots. We do it to ensure that no othe=
r task
> > -      * can sync the logs while we are in progress with the rename, be=
cause
> > -      * that could result in an inconsistency in case any of the inode=
s that
> > -      * are part of this rename operation were logged before.
> > +      * Do the log updates for all inodes.
> > +      *
> > +      * If either entry is for a root we don't need to update the logs=
 since
> > +      * we've called btrfs_set_log_full_commit() before.
> >        */
> > -     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > -             btrfs_pin_log_trans(root);
> > -     if (new_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > -             btrfs_pin_log_trans(dest);
> > -
> > -     /* Do the log updates for all inodes. */
> > -     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > +     if (logs_pinned) {
> >               btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
> >                                  old_rename_ctx.index, new_dentry->d_pa=
rent);
> > -     if (new_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> >               btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
> >                                  new_rename_ctx.index, old_dentry->d_pa=
rent);
> > +     }
> >
> > -     /* Now unpin the logs. */
> > -     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > +out_fail:
> > +     if (logs_pinned) {
> >               btrfs_end_log_trans(root);
> > -     if (new_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> >               btrfs_end_log_trans(dest);
> > -out_fail:
> > +     }
> >       ret2 =3D btrfs_end_transaction(trans);
> >       ret =3D ret ? ret : ret2;
> >  out_notrans:
> > @@ -8330,6 +8349,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> >       int ret2;
> >       u64 old_ino =3D btrfs_ino(BTRFS_I(old_inode));
> >       struct fscrypt_name old_fname, new_fname;
> > +     bool logs_pinned =3D false;
> >
> >       if (btrfs_ino(BTRFS_I(new_dir)) =3D=3D BTRFS_EMPTY_SUBVOL_DIR_OBJ=
ECTID)
> >               return -EPERM;
> > @@ -8464,6 +8484,29 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> >       inode_inc_iversion(old_inode);
> >       simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry)=
;
> >
> > +     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID) {
> > +             /*
> > +              * If we are renaming in the same directory (and it's not=
 a
> > +              * root entry) pin the log to prevent any concurrent task=
 from
> > +              * logging the directory after we removed the old entry a=
nd
> > +              * before we add the new entry, otherwise that task can s=
ync
> > +              * a log without any entry for the inode we are renaming =
and
> > +              * therefore replaying that log, if a power failure happe=
ns
> > +              * after syncing the log, would result in deleting the in=
ode.
> > +              *
> > +              * If the rename affects two different directories, we wa=
nt to
> > +              * make sure the that there's no log commit that contains
> > +              * updates for only one of the directories but not for th=
e
> > +              * other.
> > +              *
> > +              * If we are renaming an entry for a root, we don't care =
about
> > +              * log updates since we called btrfs_set_log_full_commit(=
).
> > +              */
> > +             btrfs_pin_log_trans(root);
> > +             btrfs_pin_log_trans(dest);
> > +             logs_pinned =3D true;
> > +     }
> > +
> >       if (old_dentry->d_parent !=3D new_dentry->d_parent)
> >               btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
> >                                       BTRFS_I(old_inode), true);
> > @@ -8528,7 +8571,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> >       if (old_inode->i_nlink =3D=3D 1)
> >               BTRFS_I(old_inode)->dir_index =3D index;
> >
> > -     if (old_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > +     if (logs_pinned)
> >               btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
> >                                  rename_ctx.index, new_dentry->d_parent=
);
> >
> > @@ -8544,6 +8587,10 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> >               }
> >       }
> >  out_fail:
> > +     if (logs_pinned) {
> > +             btrfs_end_log_trans(root);
> > +             btrfs_end_log_trans(dest);
> > +     }
> >       ret2 =3D btrfs_end_transaction(trans);
> >       ret =3D ret ? ret : ret2;
> >  out_notrans:
> > --
> > 2.47.2
> >


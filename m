Return-Path: <linux-btrfs+bounces-15758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A800B16644
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AD51AA7A20
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2391DF97C;
	Wed, 30 Jul 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UynEjseE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594C881E
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900269; cv=none; b=iZe0tz/Z2oZHIuFOynei1TPWb/f2bFw9ptCydAZljgdaiTseA3HOV6XvUpN+3VEVws7iRWlNjgd9/Yqy9fbAtsM1LIxeA9ByBw85w3jqmas/M9Go0no8KA7BAlwYPEFAkj4DjdTg+iBy53XFdgkGtDswNuuZz0VYm8yEikGFGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900269; c=relaxed/simple;
	bh=c6OfomfVLXb9/Tc/cRj8JJgPhZJReyEmKDciTGRSi/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf/+4v53OjquNsgfHtH4vBNTmO+WhF4qTjCEGpCkhnkEW69czEgHV0fEpU1MSHBri8ScELYJTP+bRUd2mMkUwxD1TUfI0EreuMf6UmRcoIhv2oF2WdSSSqcQ2YC0ZGMIzj+WL8yKsvMgsDw61T6FfOQY1iFimDH9RmYw8U2fIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UynEjseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A85C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753900269;
	bh=c6OfomfVLXb9/Tc/cRj8JJgPhZJReyEmKDciTGRSi/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UynEjseEB4K4LAo0w450n1jg0UtEPswhs74aoVyYh2UbDPoJvy/dCBSNQ67DEjFqh
	 XwKVEqX8jaRHUF74tOk5ruXdlr+nX1jdbluGhp9rVJnqXFaBLKznREyX/JD82zWQ7W
	 6tTuCGQK38B2tiD1vPKbsPhAgBWAZIZjxIklQWGd0Bu4izqatWWB49XgsBTWV3JCnf
	 PdRAGY4ArgGcSHrBECwrM+8TDzrOPVuYzmG9lvK7FcCio9sLW4CNHnAb/zS6gJdpa9
	 wjyF4itbP3tFVjY1VHnL3QoqfPW+PRaTzCp2q/G0wWKh2vOqJiYGfGbsm0tJb5/cD9
	 ySxpd3gjHX8Ng==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae9c2754a00so21860766b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 11:31:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZGeap/JS7z/pwqUkMff4LbgFopA4Mw3FnFMSbCZncZedNqRTw
	9cr/5UO8b0vjINcLJsosBHWtAZLEGM5gtvpEsOoEppEwAD0ijOsjbi0TwNIX5rcgHMNVlhYJSD8
	ytNByMAnc2n2AnG5P/cxLOj/Ay6Vensc=
X-Google-Smtp-Source: AGHT+IFGKv0e7rc1+UKwcclietBT6yIKQvztd8GhS32p+j2ZU4tpeeFU1+EBGo5ApojDKV8eLuTOQ9spZ0tVaGy61u0=
X-Received: by 2002:a17:907:7ba1:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-af8fda5745emr565409866b.3.1753900267787; Wed, 30 Jul 2025
 11:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com>
 <20250730173855.GB2742973@zen.localdomain>
In-Reply-To: <20250730173855.GB2742973@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Jul 2025 19:30:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4HbqbGnX8jzTSHcEh8X5nZc2mW+COG+Avv_by8xRfVJA@mail.gmail.com>
X-Gm-Features: Ac12FXw1r0GXP91ue0XMMte-_j1pYWjE2A4B1MBmYPk3ZMQ7wgSO66PgpETunSs
Message-ID: <CAL3q7H4HbqbGnX8jzTSHcEh8X5nZc2mW+COG+Avv_by8xRfVJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix race between logging inode and checking if it
 was logged before
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 6:37=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Jul 29, 2025 at 06:02:05PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's a race between checking if an inode was logged before and loggi=
ng
> > an inode that can cause us to mark an inode as not logged just after it
> > was logged by a concurrent task:
> >
> > 1) We have inode X which was not logged before neither in the current
> >    transaction not in past transaction since the inode was loaded into
> >    memory, so it's ->logged_trans value is 0;
> >
> > 2) We are at transaction N;
> >
> > 3) Task A calls inode_logged() against inode X, sees that ->logged_tran=
s
> >    is 0 and there is a log tree and so it proceeds to search in the log
> >    tree for an inode item for inode X. It doesn't see any, but before
> >    it sets ->logged_trans to N - 1...
> >
> > 3) Task B calls btrfs_log_inode() against inode X, logs the inode and
> >    sets ->logged_trans to N;
> >
> > 4) Task A now sets ->logged_trans to N - 1;
> >
> > 5) At this point anyone calling inode_logged() gets 0 (inode not logged=
)
> >    since ->logged_trans is greater than 0 and less than N, but our inod=
e
> >    was really logged. As a consequence operations like rename, unlink a=
nd
> >    link that happen afterwards in the current transaction end up not
> >    updating the log when they should.
> >
> > The same type of race happens in case our inode is a directory when we
> > update the inode's ->last_dir_index_offset field at inode_logged() to
> > (u64)-1, and in that case such a race could make directory logging skip
> > logging new entries at process_dir_items_leaf(), since any new dir entr=
y
> > has an index less than (u64).
> >
> > Fix this by ensuring inode_logged() is always called while holding the
> > inode's log_mutex.
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> The fix and explanation of the inode_logged() vs btrfs_log_inode() logic
> as it pertains to setting logged_trans make sense to me.
>
> I do have one question, though, if you don't mind:
>
> How come higher level inode locking doesn't protect us? What paths down
> into inode_logged() and btrfs_log_inode() can run concurrently on the
> same inode? Intuitively, I would expect that anything which calls
> btrfs_log_inode() would need to write lock the inode and anything that
> calls inode_logged() would at least read lock it? Poking around the code
> myself as well, but figured I would ask..

Higher inode level locking usually happens - we protect using the
inode's vfs level lock - in the fsync call, during renames, unlinks.
But in some cases when logging one inode we need to log another one -
for example when logging a file that had a link removed in the current
transaction, we log all previous parents, see for example:

commit 18aa09229741364280d0a1670597b5207fc05b8d ("Btrfs: fix stale dir
entries after removing a link and fsync")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D18aa09229741364280d0a1670597b5207fc05b8d

There are several other cases while logging an inode we need to log
others (due to name collisions, logging new dentries for new inodes,
etc).
In these cases we can't take the vfs inode lock, as that would create
ABBA type deadlocks, so we rely only on the inode's log_mutex and that
is safe for directories and files as long as we don't log extents
(LOG_INODE_EXISTS mode).

So that's why logged_inode() and inode logging can race.

>
> Thanks,
> Boris
>
> >
> > Fixes: 0f8ce49821de ("btrfs: avoid inode logging during rename and link=
 when possible")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 34 ++++++++++++++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 43a96fb27bce..8c6d1eb84d0e 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -3485,14 +3485,27 @@ int btrfs_free_log_root_tree(struct btrfs_trans=
_handle *trans,
> >   * Returns 1 if the inode was logged before in the transaction, 0 if i=
t was not,
> >   * and < 0 on error.
> >   */
> > -static int inode_logged(const struct btrfs_trans_handle *trans,
> > -                     struct btrfs_inode *inode,
> > -                     struct btrfs_path *path_in)
> > +static int inode_logged_locked(const struct btrfs_trans_handle *trans,
> > +                            struct btrfs_inode *inode,
> > +                            struct btrfs_path *path_in)
> >  {
> >       struct btrfs_path *path =3D path_in;
> >       struct btrfs_key key;
> >       int ret;
> >
> > +     /*
> > +      * The log_mutex must be taken to prevent races with concurrent l=
ogging
> > +      * as we may see the inode not logged when we are called but it g=
ets
> > +      * logged right after we did not find it in the log tree and we e=
nd up
> > +      * setting inode->logged_trans to a value less than trans->transi=
d after
> > +      * the concurrent logging task has set it to trans->transid. As a
> > +      * consequence, subsequent rename, unlink and link operations may=
 end up
> > +      * not logging new names and removing old names from the log.
> > +      * The same type of race also happens if out inode is a directory=
 when
> > +      * we update inode->last_dir_index_offset below.
> > +      */
> > +     lockdep_assert_held(&inode->log_mutex);
> > +
> >       if (inode->logged_trans =3D=3D trans->transid)
> >               return 1;
> >
> > @@ -3594,6 +3607,19 @@ static int inode_logged(const struct btrfs_trans=
_handle *trans,
> >       return 1;
> >  }
> >
> > +static inline int inode_logged(const struct btrfs_trans_handle *trans,
> > +                            struct btrfs_inode *inode,
> > +                            struct btrfs_path *path)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&inode->log_mutex);
> > +     ret =3D inode_logged_locked(trans, inode, path);
> > +     mutex_unlock(&inode->log_mutex);
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Delete a directory entry from the log if it exists.
> >   *
> > @@ -6678,7 +6704,7 @@ static int btrfs_log_inode(struct btrfs_trans_han=
dle *trans,
> >        * inode_logged(), because after that we have the need to figure =
out if
> >        * the inode was previously logged in this transaction.
> >        */
> > -     ret =3D inode_logged(trans, inode, path);
> > +     ret =3D inode_logged_locked(trans, inode, path);
> >       if (ret < 0)
> >               goto out_unlock;
> >       ctx->logged_before =3D (ret =3D=3D 1);
> > --
> > 2.47.2
> >


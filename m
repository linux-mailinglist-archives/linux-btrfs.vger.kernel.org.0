Return-Path: <linux-btrfs+bounces-10477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3149F4C4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F401891780
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D91F4721;
	Tue, 17 Dec 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjF9Zc5G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECE1F2360;
	Tue, 17 Dec 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441676; cv=none; b=T70tNy0s9rsAW07bvELqpc+/9rOBUgTjTiBMOyi01/eeNucp7VqqbgYoHW4E6KK8d/WD3rD+x25XY0NyxMmnNUxNxehnNRIcL/7VVJrbI0UiIxKeSTPsjwzOeS6jAlyHDi/9hqC3uHsBZ6WEeZJGfMIXfDDVKKb5TnPdwO7JKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441676; c=relaxed/simple;
	bh=lz1BDubUThnIaImK55i42Dmzh4zororNqc8GEHLXdcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSvTdXKXU698uG48qeSt2Mv91Jm8IspWu1FkuilWJJRvbTKRyqaLcPMiCX16OmoNFCBQ4XLo1I+oCSl3o+0eL4He3cXQebNQDSg1yJXZcUMQxpDdorJqzd8g1VASonnQGF7jWtm/8/abeEd24TnkPn+s+/nnMIKo5w2wAe20ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjF9Zc5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A881C4CEDE;
	Tue, 17 Dec 2024 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734441676;
	bh=lz1BDubUThnIaImK55i42Dmzh4zororNqc8GEHLXdcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TjF9Zc5Go8FP7q0IaF36NMXC4NH0JXrHcKjsWBRM52aTEFwR6kyWJxc9uY7uFxYB/
	 ruutgNWb1fbp3+ukgKkhMXdVtTp2SsnYHRV+Rg96K2Kli6xZpSwQ+VBrYstcaDb10u
	 ZE9YNXs3lwXkdiEUvJ7Hk4Pfpufjyy/KW+f/AxZ1hdKC9oB7zqNgkC0IviUprdZ5w9
	 yEHKUFwdxYyTQu9OcH6uPwba+TtLsHLRP+ezxFaGF7a6SRi++Mk7KWRvOdpwClHcju
	 XrLc6mpsG5GNdNi4H4lubPIxaVEEtgQu46wosya1/fbSSma0JwMWMwM2tNRFmz91wc
	 AVDOtdvKBxCAw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so8584437a12.3;
        Tue, 17 Dec 2024 05:21:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYWbaDQwiKjUDn/DSZn3XweAWwrcKH3z8Lvkg5GYyiKZ/7L6MAzNKNb767fnunjO9Xxa7OfgvBBdgRv/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLwH/h+n9xGv8zioNpUUg814T6pfLU821j6Km+1ZxyNv7Q0G4
	8DB5bW7AZbkC4UstsOsPeJdPgtLIBU5w1uWKbN/cuZnrpnv/2VAn4Dadn2jtstajELVrfNfFwRF
	qRRmztIecxNOw0jvRyiV9qFfJcrk=
X-Google-Smtp-Source: AGHT+IFxMD1nUlVD9gGHX9OcPkRtAxGMpOywf+SAbDFMXhIkSA27ZGpD2syVGSswat7uVI29Iw9egJv32BSXtXQ1JaM=
X-Received: by 2002:a17:907:72c4:b0:aa6:824c:4ae5 with SMTP id
 a640c23a62f3a-aab77eda8f2mr1409202966b.56.1734441674713; Tue, 17 Dec 2024
 05:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211111315.65007-1-sunjunchao2870@gmail.com> <CAL3q7H5DhmjX_G7PGQQ40O7wtaV7TqFp_7L9yL7asjLA27J8pA@mail.gmail.com>
In-Reply-To: <CAL3q7H5DhmjX_G7PGQQ40O7wtaV7TqFp_7L9yL7asjLA27J8pA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 13:20:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H44KsXkB4Q=y5YnGrAVW91S73mac+9ObvC+S6oO6uih2Q@mail.gmail.com>
Message-ID: <CAL3q7H44KsXkB4Q=y5YnGrAVW91S73mac+9ObvC+S6oO6uih2Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix an assertion failure related to squota feature.
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, clm@fb.com, 
	josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:35=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Wed, Dec 11, 2024 at 11:13=E2=80=AFAM Julian Sun <sunjunchao2870@gmail=
.com> wrote:
> >
> > With the config CONFIG_BTRFS_ASSERT enabled, an assertion
> > failure occurs regarding the simple quota feature.
> >
> > [    5.596534] assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOT=
A), in fs/btrfs/qgroup.c:365
> > [    5.597098] ------------[ cut here ]------------
> > [    5.597371] kernel BUG at fs/btrfs/qgroup.c:365!
> > [    5.597946] CPU: 1 UID: 0 PID: 268 Comm: mount Not tainted 6.13.0-rc=
2-00031-gf92f4749861b #146
> > [    5.598450] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [    5.599008] RIP: 0010:btrfs_read_qgroup_config+0x74d/0x7a0
> > [    5.604303]  <TASK>
> > [    5.605230]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> > [    5.605538]  ? exc_invalid_op+0x56/0x70
> > [    5.605775]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> > [    5.606066]  ? asm_exc_invalid_op+0x1f/0x30
> > [    5.606441]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> > [    5.606741]  ? btrfs_read_qgroup_config+0x74d/0x7a0
> > [    5.607038]  ? try_to_wake_up+0x317/0x760
> > [    5.607286]  open_ctree+0xd9c/0x1710
> > [    5.607509]  btrfs_get_tree+0x58a/0x7e0
> > [    5.608002]  vfs_get_tree+0x2e/0x100
> > [    5.608224]  fc_mount+0x16/0x60
> > [    5.608420]  btrfs_get_tree+0x2f8/0x7e0
> > [    5.608897]  vfs_get_tree+0x2e/0x100
> > [    5.609121]  path_mount+0x4c8/0xbc0
> > [    5.609538]  __x64_sys_mount+0x10d/0x150
> >
> > The issue can be easily reproduced using the following reproduer:
> > root@q:linux# cat repro.sh
> > set -e
> >
> > mkfs.btrfs -f /dev/sdb > /dev/null
> > mount /dev/sdb /mnt/btrfs
> > btrfs quota enable -s /mnt/btrfs
> > umount /mnt/btrfs
> > mount /dev/sdb /mnt/btrfs
> >
> > The root cause of this issue is as follows:
> > When simple quota is enabled, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA
> > flag is set after btrfs_commit_transaction(), whereas the
> > BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE flag is set before btrfs_commit_tr=
ansaction(),
> > which led to the first flag not being flushed to disk, and the second
> > flag is successfully flushed. Finally causes this assertion failure
> > after umount && mount again.
> >
> > To resolve this issue, the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA flag
> > is set immediately after setting the BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MO=
DE.
> > This ensures that both flags are flushed to disk within the same
> > transaction.
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
>
> Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas=
")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good, thanks.
> We should also turn the reproducer into a test case for fstests.

Pushed it to the for-next branch with a few changes to the changelog:

1) Renamed the subject to "btrfs: fix transaction atomicity bug when
enabling simple quotas".
     Note that we don't add punctuation at the end of the subject line.

2) Changed the paragraphs that explain the bug below the reproducer to:

"The issue is that when enabling quotas, at btrfs_quota_enable(), we set
BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE at fs_info->qgroup_flags and persist
it in the quota root in the item with the key BTRFS_QGROUP_STATUS_KEY, but
we only set the incompat bit BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA after we
commit the transaction used to enable simple quotas.

This means that if after that transaction commit we unmount the filesystem
without starting and committing any other transaction, or we have a power
failure, the next time we mount the filesystem we will find the flag
BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE set in the item with the key
BTRFS_QGROUP_STATUS_KEY but we will not find the incompat bit
BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA set in the superblock, triggering an
assertion failure at:

    btrfs_read_qgroup_config() -> qgroup_read_enable_gen()

To fix this issue, set the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA flag
immediately after setting the BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE.
This ensures that both flags are flushed to disk within the same
transaction."

Thanks.


>
> > ---
> >  fs/btrfs/qgroup.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index a6f92836c9b1..f9b214992212 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1121,6 +1121,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo,
> >         fs_info->qgroup_flags =3D BTRFS_QGROUP_STATUS_FLAG_ON;
> >         if (simple) {
> >                 fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_SIM=
PLE_MODE;
> > +               btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
> >                 btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->tr=
ansid);
> >         } else {
> >                 fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INC=
ONSISTENT;
> > @@ -1254,8 +1255,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo,
> >         spin_lock(&fs_info->qgroup_lock);
> >         fs_info->quota_root =3D quota_root;
> >         set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> > -       if (simple)
> > -               btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
> >         spin_unlock(&fs_info->qgroup_lock);
> >
> >         /* Skip rescan for simple qgroups. */
> > --
> > 2.39.5
> >
> >


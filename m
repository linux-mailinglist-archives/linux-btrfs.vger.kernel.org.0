Return-Path: <linux-btrfs+bounces-21711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHETMiqslGl7GQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21711-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:58:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA214ECEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E923053BAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB0372B2D;
	Tue, 17 Feb 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StGRKmj5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544037105D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351013; cv=none; b=Ac2a9SjxX9WAl4aZnOKIIgj6jHQoFJ09EnEJ74IAZNrZs2Xhu2KPJGF3RiGbJ994UTBbbySZd3P4SaUYdxi0kv/yXRrQIlXdPHnignLRqe8LglFbV5vwF4eLpkNHcMH0zSLqd1JmF6RWn9yOyDsM5LmvlHChX4JCmK2aMckKuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351013; c=relaxed/simple;
	bh=GJUFOmhRNj9EGe0GZsQND00GxAZXnX2m1Pgza3fP+NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibylyl+/YQ1oCnN1kdQ5YuW5RJ7TsmEVs1Z1tvHu77y2XM2Pa7CV4T8CecPVcz4/XSAth0k+DQ+VEaLzFQxpTcWMFuVgWJjh8hJdku9NbW+5AYmzLdacn1KZWPF3KosvBD5p/nw2DG7ZppT9/GRNJ4ohw7gG9uTV824h6Om2Frk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StGRKmj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB8C19421
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771351012;
	bh=GJUFOmhRNj9EGe0GZsQND00GxAZXnX2m1Pgza3fP+NQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StGRKmj53b1vuuENRcePYUqonlm1/+Ba0Zc84gHwwvq/DSG/vmP79M40f0leky7pF
	 k88m2eBlGdXb4TBZklYipopI8N5LD17tf7VRTVpu1oajPq9YjdkR63iPDe0hFd5F5x
	 KpzhaKen0udXBPJbs4peytagFfcb8zuaWLvBoBmUVlz7GwXIRBzK0VupZEOf3SbLe3
	 cBUNJmKF4majaXwmsI6/5AQv41ClrvaNVFG3V5ut5Ospivl1DgQbQ1PUPVCAkFiZfB
	 7aVjawSXOI02DMknmhyebJLInwDv2ZWU1K8LIxv3GXaeykZix9li63eko9bES/Obez
	 cAIRurf+lKIfg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b884ad1026cso596547666b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 09:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMef7cxe+CgeozuCdrgi+rXoLCnKJX9avyj9iPAWOM4xQOs/2X93M2icbWrq8oCXd5mV9KY8k7MBeEng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVcipSW1kaRL+nqTMhAPuu3rGxXE/ofqUJdQ9KgEmyflefauJ
	B+lG9gP3wzkjvQ4/i9/LPGefeH5ar+hZvpCxTdrkPmC0eijxznl6yDHiwB6GVgFDr5PQ1wlWRWM
	taI6dv137Nkji+77S+H4LuKI+8mJLo+Q=
X-Received: by 2002:a17:907:3e88:b0:b8f:a5c8:f75 with SMTP id
 a640c23a62f3a-b8fb4528579mr733729866b.52.1771351011329; Tue, 17 Feb 2026
 09:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216221632.23087-1-jkchen@ugreen.com> <CAL3q7H7-SNQMoXzvTVCVzZx9gYXq3rzRfRp5OERz+riPQ-=tow@mail.gmail.com>
 <CAJFOPmtqt_u_JUQyntOjr+0W9X_CgcAXCkx8gArR9-L57Et5TA@mail.gmail.com>
In-Reply-To: <CAJFOPmtqt_u_JUQyntOjr+0W9X_CgcAXCkx8gArR9-L57Et5TA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Feb 2026 17:56:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7z4uEZphBRs=oQJHBko00+=U23aUMi1T39t99tAFcbLQ@mail.gmail.com>
X-Gm-Features: AaiRm50wImHFSrKgOaepZzW-84KsjiMRlGoZFQqBps-YUM-bMQYeNBerlEHfHoE
Message-ID: <CAL3q7H7z4uEZphBRs=oQJHBko00+=U23aUMi1T39t99tAFcbLQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check snapshot_force_cow earlier in can_nocow_file_extent
To: Guan-Jie Chen <jk.chen1095@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkchen <jkchen@ugreen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21711-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ugreen.com:email]
X-Rspamd-Queue-Id: 26CA214ECEF
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 5:17=E2=80=AFPM Guan-Jie Chen <jk.chen1095@gmail.co=
m> wrote:
>
> Hi Filipe,
>
> Thanks again for picking up the patch.
>
> I realized that I should use my full real name and my personal email
> for the Signed-off-by line. Could you please update it to:
>
> Signed-off-by: Chen Guan Jie <jk.chen1095@gmail.com>

Ok, updated it.

>
> Sorry for the trouble, and thank you for your help.
>
> Best regards,
> Chen Guan Jie
>
> On Tue, Feb 17, 2026 at 19:42 Filipe Manana <fdmanana@kernel.org> wrote:
>>
>> On Mon, Feb 16, 2026 at 10:17=E2=80=AFPM jkchen <jk.chen1095@gmail.com> =
wrote:
>> >
>> > When a snapshot is being created, the atomic counter snapshot_force_co=
w
>> > is incremented to force incoming writes to fallback to COW. This is a
>> > critical mechanism to protect the consistency of the snapshot being ta=
ken.
>> >
>> > Currently, can_nocow_file_extent() checks this counter only after
>> > performing several checks, most notably the expensive cross-reference
>> > check via btrfs_cross_ref_exist(). btrfs_cross_ref_exist() releases th=
e
>> > path and performs a search in the extent tree or backref cache, which
>> > involves btree traversals and locking overhead.
>> >
>> > This patch moves the snapshot_force_cow check to the very beginning of
>> > can_nocow_file_extent().
>> >
>> > This reordering is safe and beneficial because:
>> > 1. args->writeback_path is invariant for the duration of the call (set
>> >    by caller run_delalloc_nocow).
>> > 2. is_freespace_inode is a static property of the inode.
>> > 3. The state of snapshot_force_cow is driven by the btrfs_mksnapshot
>> >    process. Checking it earlier does not change the outcome of the NOC=
OW
>> >    decision, but effectively prunes the expensive code path when a
>> >    fallback to COW is inevitable.
>> >
>> > By failing fast when a snapshot is pending, we avoid the unnecessary
>> > overhead of btrfs_cross_ref_exist() and other extent item checks in th=
e
>> > scenario where NOCOW is already known to be impossible.
>> >
>> > Signed-off-by: jkchen <jkchen@ugreen.com>
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>
>> Looks good, I'll add it to the github for-next branch, thanks.
>>
>> > ---
>> >  fs/btrfs/inode.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> > index 845164485..3549031f3 100644
>> > --- a/fs/btrfs/inode.c
>> > +++ b/fs/btrfs/inode.c
>> > @@ -1921,6 +1921,11 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>> >         int ret =3D 0;
>> >         bool nowait =3D path->nowait;
>> >
>> > +       /* If there are pending snapshots for this root, we must COW. =
*/
>> > +       if (args->writeback_path && !is_freespace_inode &&
>> > +           atomic_read(&root->snapshot_force_cow))
>> > +               goto out;
>> > +
>> >         fi =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_=
extent_item);
>> >         extent_type =3D btrfs_file_extent_type(leaf, fi);
>> >
>> > @@ -1982,11 +1987,6 @@ static int can_nocow_file_extent(struct btrfs_p=
ath *path,
>> >                 path =3D NULL;
>> >         }
>> >
>> > -       /* If there are pending snapshots for this root, we must COW. =
*/
>> > -       if (args->writeback_path && !is_freespace_inode &&
>> > -           atomic_read(&root->snapshot_force_cow))
>> > -               goto out;
>> > -
>> >         args->file_extent.num_bytes =3D min(args->end + 1, extent_end)=
 - args->start;
>> >         args->file_extent.offset +=3D args->start - key->offset;
>> >         io_start =3D args->file_extent.disk_bytenr + args->file_extent=
.offset;
>> > --
>> > 2.43.0
>> >
>> >


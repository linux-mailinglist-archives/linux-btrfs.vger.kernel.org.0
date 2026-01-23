Return-Path: <linux-btrfs+bounces-20951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFJ1E3M9c2kztgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20951-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:20:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0C73288
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404FD3043D1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3E305E32;
	Fri, 23 Jan 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGGQEh7e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF9224AFA
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159901; cv=none; b=K6OZN+YhT92eHhQgYgsmqx+aE97wv7npaAG5kHnjR/wxrna3L0ej3LGIpE98jlGGzO/iVofRlv2LF3vYqPxgnRidzCcEupYZUvPFq1umRnWzGPlsdm1R2CqI+Iqay46F+aJS5YmLyDorup7VMdpIU5Z/NJZ8R476ohkvZogO2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159901; c=relaxed/simple;
	bh=r30qw2RkOQhIF+bAlbkb5eCtfOvWPoBJmBzjkQCT+eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdc12sbb0zDue7PqVRwoWyK/DdHysRu8lk8s+3ceaKsx85WQF72Sv3EBQcJncQ6lNySHgMx52gtT/HC7GGuohISTEaj2RTSthdojR2Pbj/KiA4oXtqhsjl+6l0O+hGzLu1NR8JUkC/nbWTKe/svdjU/Hqm19lbVDGpYbBA15P3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGGQEh7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE22C19425
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769159901;
	bh=r30qw2RkOQhIF+bAlbkb5eCtfOvWPoBJmBzjkQCT+eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGGQEh7eoZn3R5B75b3qqcphYoJpQMS/nSywQLo4/krQ9AEZR37oR5fp4XHWVl+cU
	 S7BkiP4RNfp79yhc4w4Htl42nstcerEqxJNOyR/mqsmSKvjNbkD6udkoDJj/VfsQ5N
	 0VGFAIOoMYxH5IPzCorEJvTpyp2yafNz2lN1Ng7q+vjNASCA2MqZRD0UK8+fLVdi6L
	 k49oYLZhHTdn6Kyh3CM2W/D+pP4tjvbx7u5Hi/pdh/dR8tuf3C34rG3UUIgG+Ub4BU
	 vCtX+YxxqAxkU3Y9f2ohMkSUK/fyXgwzodYpmeiA7CaWt2ddyoAfPJtNx8KhWiFBa2
	 vJlUswzNUsClQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso3112198a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 01:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTyre2gDF87ymwDKR3uk5kFDeOJM7pGLW3FuSZcXepFJGJYHj2czmO8AbSFiL8mJfHp3CzeS5nDmW2fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gDVrlPs9fOc9nDqURMIDTylyB1eh3goN/l/KuAWNHQubYxyW
	kezerPtUl1OmWb1ioWDQJWBRkmuEXq21S7VVcKDDVX11nG9TQxBZxkRMsLjadw4Rcp4FpKyJryM
	eAt1UrHOGc0CvBMd7UYMOEYRRihlaROQ=
X-Received: by 2002:a17:906:478c:b0:b87:33f3:605b with SMTP id
 a640c23a62f3a-b885acd422amr160409366b.27.1769159899587; Fri, 23 Jan 2026
 01:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H69QyeobkY-+YO9JsCKfrQ1EYeZN0fVOFFkkC5fXh90SQ@mail.gmail.com>
 <20260123024555.525434-1-jinbaohong@synology.com>
In-Reply-To: <20260123024555.525434-1-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Jan 2026 09:17:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4F_BR00Ro5uMV4rA=jbbK-9a9+CHzPYBmVsYRFShD8Cw@mail.gmail.com>
X-Gm-Features: AZwV_Qg2qieh8uOqeY0VXxKO0gyOlcpSvkSt6mYVPdKIIw0Kiz0avsxQ4tB6FqU
Message-ID: <CAL3q7H4F_BR00Ro5uMV4rA=jbbK-9a9+CHzPYBmVsYRFShD8Cw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix transaction commit blocking during trim of
 unallocated space
To: jinbaohong <jinbaohong@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20951-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Queue-Id: E6E0C73288
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 2:46=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
> wrote:
>
> > > > @@ -6564,21 +6681,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_=
info, struct fstrim_range *range)
> > > >                         "failed to trim %llu block group(s), last e=
rror %d",
> > > >                         bg_failed, bg_ret);
> > > >
> > > > -       mutex_lock(&fs_devices->device_list_mutex);
> > > > -       list_for_each_entry(device, &fs_devices->devices, dev_list)=
 {
> > > > -               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_=
state))
> > > > -                       continue;
> > > > -
> > > > -               ret =3D btrfs_trim_free_extents(device, &group_trim=
med);
> > > > -
> > > > -               trimmed +=3D group_trimmed;
> > > > -               if (ret) {
> > > > -                       dev_failed++;
> > > > -                       dev_ret =3D ret;
> > > > -                       break;
> > > > -               }
> > > > +       ret =3D btrfs_trim_free_extents(fs_info, &group_trimmed);
> > > > +       trimmed +=3D group_trimmed;
> > > > +       if (ret) {
> > > > +               dev_failed++;
> > > > +               dev_ret =3D ret;
> >
> > Oh wait, there's a difference here from what we had before.
> >
> > Before this patch, every time we failed to trim a device, we would
> > increment the counter and continue to the next device.
> > But now after this patch once we get a failure with one device, we
> > don't continue with the rest (and the dev_failed counter is always 1).
> >
> >
> >
> >
> > > >         }
> > > > -       mutex_unlock(&fs_devices->device_list_mutex);
> > > >
> > > >         if (dev_failed)
> > > >                 btrfs_warn(fs_info,
> > > > --
> > > > 2.34.1
>
> Hi Filipe,
>
> I think the original behavior is actually preserved here.
> The original code has a `break;` when a device fails, so
> it also stops processing remaining devices on the first
> failure, and `dev_failed` is always at most 1.
>
> The new code preserves this same behavior -
> btrfs_trim_free_extents() returns immediately on error,
> and the caller increments `dev_failed` once.

Oh yes, right.

The intention was to continue to the next device, and that previously
could be fixed by replacing the "break" with "continue".
Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
error better") added the counter and it mentioned it wanted to change
the behaviour to trim the next devices when we fail one.

>
> That said, do you think we should change this behavior so
> that trimming continues with the remaining devices even
> after a failure?

I think we should fix it, yes.
With this patch it's not as straightforward as replacing the "break"
with a "continue".

So the best here would be two patches: first one fixing that,
replacing the break with continue, and then your patch that fixes
blocking transaction commits for too long.

Are you ok with that?

Thanks!

>
> Thanks for the review.
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.


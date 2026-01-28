Return-Path: <linux-btrfs+bounces-21165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNWqK7b4eWkE1QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21165-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 12:53:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4FA0E16
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33D6F306049F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DA34D4D3;
	Wed, 28 Jan 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR8mdWDW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624A2EFDBF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601001; cv=pass; b=k2L1sjV3c9qOZvyYTpBlhrZSMvUfONQ76XLnAjmMCLYjxRkFK0J31JC7+RshWTn/GzV/4BUmh7l/hUSLKB8uEvOEPNKeURrfQGNl51AKDNxoyvS52xUxFBOBFogiqQB9yveGxypDz/rR2zJx8UXpqYGUTqY0CzBSUJtSiyijcDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601001; c=relaxed/simple;
	bh=hSMXOh0Oo+nPWIXGNy6Xy2ffhiMjw7bfObWyXyyTRFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p98cJlynBQFcnBzEo/t2uZC6OcO0rLhBQrXwKxpzfHBocq3dfCsHLHxuYr8lvP3t7kiEr7oO3O3ffPV4UgkbcPUwy7CpFbeJIz11Ze08TxyY5R2hURyyM1+ifBYBnB94XvEiKAwsItqls37EaJw/ZvUOXjbAFHcj8zEmO+M3rDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR8mdWDW; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so12533890a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 03:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769600998; cv=none;
        d=google.com; s=arc-20240605;
        b=W75/nWvJQcl/r4etuN3KG56IPcP0DayW9AY33wBQkmfGaRIUf+VWoVZIprNNuDj5uv
         ccZxYOAm/zIkK9zMW2k9ZMowH99i15wNAbbeg6zerDiknCzfsrZPR3tqZxpg15pqoR52
         ONP2IKFA04p4MBi6SpclueOPO9/IzrPM8yCtksBDJVOa9iaioIuJKUblA1UyCtjyX25q
         qIzMb/MawlpSqvmGzXhM1nxJhJEmKXOjtLMyYO2Hpqz3b58YmV4Npcwwh9IgIJRBSpWJ
         zYQwilCUrMW7qv/wlVsjidGkCWhPC6s1I74eYHCC33l6xNlBgVLenpr2tsw33Gyg/pbA
         rYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        fh=F3zCb+2MCWnN++Dqn2hDwXpciUlAUwAY6QDloJKX+sU=;
        b=kmrjEJBc1/lTxRrZnqniw6O1VCuzvZg7Jo2szK1BruAwprAEMOy/Cf4uKsfiyNqv+o
         019ycOeBXIuPDSbMKXpLq7wB5A51CQSWR1i0ZrFjrjSH60gvOGBvGYAVgocj/ANxgNlI
         Vqcw75kD13sR9uRw6gA2K/Wi6shNGtUKkb+s8RHAdVIYIm5HLRpkmsw9iM/yVT3tGCPz
         mcWEynQqkH8EU6bO4pDlY8QEdwH4q4vz4q6t1Qe1djIkA/ukhkuWRiirlyQpL1OaJvva
         weNlfvc2wog2ZkJ2kVwCb811oF843ULh23CJToCPHN4NVsinEZmXJpq/FTwuObtHFKKR
         VkWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600998; x=1770205798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=FR8mdWDWBW61A+py/5HoKRuev9mIZIpSmqKtTdkiRzhJx4yurwTyHJqiayDAei1JJV
         D8rE15bAbp4yruitOxN9ghocp5wUSHwvtzUpipos6frHL91+9nHe4nsGR8VxAuGxJkQY
         tnIovD3EuXHOfvTUV81DwMwIcNnJFeO2rPKJTX5gK5nMutc6lAxKlRsr0kF9eQb13l1F
         xQMfKXrVAS1lxlIvk+4hGHrRSlVu7uUqk3G2YfvExfFWKiyZE0qMJQgnaSXieYTrDUCR
         0hHT05bTTVJeGqZ/a5iyA5Rp/Ex6gwYwk1F7BGNNHEbliXytUdSPaj5GtEEG8G+yy+Bx
         714w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600998; x=1770205798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOBXUmD9goqwIlvz3iQRg+SdG5i2nFccs0lUKwf+dUE=;
        b=i4iUmI2WNNDQkdbhykNMq49oRzKoqsTutUbWR9qL/pF9HUTi/CTdx25yuv2ufda4YN
         M8yz/ZuguUojrWxbxHXkB5DDTCpQanEZjqRxb8NGBS/O2gxM596YO9/dYRZO9fNUK41A
         3oM/qkMDMcj8aO99jtGN6Loy9sA58UTkapJumN5AcrkK0TVB9dHwKcr7NKXPxjbMZHck
         whtpGRgklbH+lBH0EyCuCSn/r1jHFSWl1YU5RPHM96FGS43AX6+xpydgyI1PsSITVza+
         ZlDfibs280MlDpkcrBjWIQnsLcDXdWJXIjkLvnJ/LE+BPoMMXIiuhhXxodiCGxVK41we
         DjZA==
X-Forwarded-Encrypted: i=1; AJvYcCXE3Jc/dBjzM+lTJJ1BpK66si/TXbtBXB9gTc8mf/zPNTMzr7xGJBuiRnaphsXrCAc+b9DBoTirceeFrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykNC6BPK1JHxqMRL63vvCpO7xTVc/haWCWJ52GpYenuT7o+KVC
	Dv/z4MDmTEnnZZYQ8tkM/Ra9WusFSzhodAMmP5dYjteTHpCdoe/wVxujWNGGaX2EwtBctksJacb
	uc/U0L0HOG7aBcQIz0LKhTvjC4nuiH/A=
X-Gm-Gg: AZuq6aIAD54d+fVBvDGczlxCH/7RZtWPzMaceruQ+/QXrKK8zveacnS30/2yQ9mUqN5
	yvUYwW+OdbjjhzP+wZWLJWOhHmteGOWe0yHhdaC7HmsM3jqRZQZ3kOmk8Ewd3OdmlTHEpmKil2o
	till6M/zxsU/jOkxVicn6jlEpZ+IOzHNXrPShyslEGhha2lVLPFX3XrVzTZDaAqtPPybxUXMe5v
	qNhafnLzG1SP8owWiaGbs+v0NjfvMTHcUUaF0jr/AmS05pujDuueGAplLMzmspDuyuXFxyOf6/d
	NxiM9+dmbzCIE+BIrtPs1chKDOUCTw==
X-Received: by 2002:a05:6402:35c1:b0:658:2fd1:b0ab with SMTP id
 4fb4d7f45d1cf-658a60b78d2mr2846925a12.29.1769600997470; Wed, 28 Jan 2026
 03:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 12:49:45 +0100
X-Gm-Features: AZwV_QiAes4F6-nhL9J4dFPbEOm7D7xrxYRKJxjry6rXeIbQy7RViH-qtuWr0fQ
Message-ID: <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21165-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70C4FA0E16
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:45=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Jan 23, 2026 at 9:08=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > Em 23/01/2026 10:24, Andr=C3=A9 Almeida escreveu:
> > >
> > > Em 22/01/2026 17:07, Amir Goldstein escreveu:
> > >> On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gma=
il.com>
> > >> wrote:
> > >>>
> > >>> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida
> > >>> <andrealmeid@igalia.com> wrote:
> > >>>>
> > >> ...
> > >>>> Actually they are not in the same fs, upper and lower are coming f=
rom
> > >>>> different fs', so when trying to mount I get the fallback to
> > >>>> `uuid=3Dnull`. A quick hack circumventing this check makes the mou=
nt
> > >>>> work.
> > >>>>
> > >>>> If you think this is the best way to solve this issue (rather than
> > >>>> following the VFS helper path for instance),
> > >>>
> > >>> That's up to you if you want to solve the "all lower layers on same=
 fs"
> > >>> or want to also allow lower layers on different fs.
> > >>> The former could be solved by relaxing the ovl rules.
> > >>>
> > >>>> please let me know how can
> > >>>> I safely lift this restriction, like maybe adding a new flag for t=
his?
> > >>>
> > >>> I think the attached patch should work for you and should not
> > >>> break anything.
> > >>>
> > >>> It's only sanity tested and will need to write tests to verify it.
> > >>>
> > >>
> > >> Andre,
> > >>
> > >> I tested the patch and it looks good on my side.
> > >> If you want me to queue this patch for 7.0,
> > >> please let me know if it addresses your use case.
> > >>
> > >
> > > Hi Amir,
> > >
> > > I'm still testing it to make sure it works my case, I will return to =
you
> > > ASAP. Thanks for the help!
> > >
> >
> > So, your patch wasn't initially working in my setup here, and after som=
e
> > debugging it turns out that on ovl_verify_fh() *fh would have a NULL
> > UUID, but *ofh would have a valid UUID, so the compare would then fail.
> >
> > Adding this line at ovl_get_fh() fixed the issue for me and made the
> > patch work as I was expecting:
> >
> > +       if (!ovl_origin_uuid(ofs))
> > +               fh->fb.uuid =3D uuid_null;
> > +
> >          return fh;
> >
> > Please let me know if that makes sense to you.
>
> It does not make sense to me.
> I think you may be using the uuid=3Doff feature in the wrong way.
> What you did was to change the stored UUID, but this NOT the
> purpose of uuid=3Doff.
>
> The purpose of uuid=3Doff is NOT to allow mounting an overlayfs
> that was previously using a different lower UUID.
> The purpose is to mount overlayfs the from the FIRST time with
> uuid=3Doff so that ovl_verify_origin_fh() gets null uuid from the
> first call that sets the ORIGIN xattr.
>
> IOW, if user want to be able to change underlying later UUID
> user needs to declare from the first overlayfs mount that this
> is expected to happen, otherwise, overlayfs will assume that
> an unintentional wrong configuration was used.
>
> I updated the documentation to try to explain this better:
>
> Is my understanding of the problems you had correct?
> Is my solution understood and applicable to your use case?
>

Hi Andre,

Sorry to nag you, but if you'd like me to queue the suggested change to 7.0=
,
I would need your feedback soon.

FWIW, I think that this change of restrictions for uuid=3Dnull could be bac=
kported
to stable kernels, but I am not going to mark it for auto select, because
I'd rather see if anyone shouts with upstream kernel first when (if) we mak=
e
this change and manually backport later per demand.

Thanks,
Amir.


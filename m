Return-Path: <linux-btrfs+bounces-20978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BBY5FPGidGkH8QAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20978-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 11:46:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388737D47E
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 11:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685AE3012E83
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9C2D374F;
	Sat, 24 Jan 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWrdm395"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4419CD0A
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251532; cv=pass; b=PFITQDxXd5NEHhSNLYl3rButbDoscx6+Mj5Uv8t7BMo9njKA6LkG1UmKdtAbWGG+dZ37XmcE5z/C5jNd9R8w+ygrvQ4RIDQIjYVU1dSHA6wxsH39gQzKOHR56Y9hvfg4qbGowkqpgsYlAwnoHxd0dA6CvyIkXh4l51ozutMaOVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251532; c=relaxed/simple;
	bh=OhfWhlQZiS1Yq37GsKg1ZRvFgI+/q0guhtaSDhFcjg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqwJXeAoBMiqPPHpTf3SX8P0R+LnaMhK/8ier+UehFAHCawiRcTvpoJKVaPGVu+CNz0kCP09oq8BYe/6bFSPz0qkNG3m8iQEauckslwUCeY0BxEWFDr5Ow2BVvbnAOJfRsIkU0TNLjQ3zKcNmEDj27zoq1NY9SBwnoZuHzvYtxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWrdm395; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so4623101a12.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 02:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769251529; cv=none;
        d=google.com; s=arc-20240605;
        b=Ra+695ia7ZBOla/snyuhq/ts7vXy5El6x3LxUi2h6YXz+mAGI//96v0qgosGPG5VT9
         zbHY48tHe8nTaNU0bRp88AZFaGHF0wzpew4W467nUdlkMVLZBNmQnD9IIFCcp8eUIcwY
         62qdwqVlVFOwW7g8Ohqkn1OCBpAoDDqZVCxfXzf5bzOiymZRD6m8XcooLWVVSVFFM0Jq
         QKO/ZkGQ3gDHekHAZWvYDC8tyNn4Ne6Rh1TjxPUa+84oEaZpq7pK3/4n9Z+3L1prWP+o
         vyDK8s5bFU610xgCzSJjN23Tnbny37QoBiRMVaoDDoO/Dkp8X2P2L156LptKdhr6faXS
         cYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        fh=Byev+Cx+4X9xZe5LOp54RjwEw7LoXgDdTJqM3UW1u6M=;
        b=ia0RT5E9D0LXGNixwFpRlJi804S/g1W/bjxkDDkrKiDbkPmTh7Hk2gr91eEeRwzWGC
         pLkf29QTx3uasKED6oR/Gmqwjd3MhYsGRNTtk1YLvHX2duxlmzSWJcI9HxqOV9qjYXuN
         O3oMbW53WCUBnOdwis48aSpCeSQh8p+moBaJw3FHci8AlHqHOW4gOlNO+JhrNLbfROTq
         ChKzAFBaCdwVjXt3nUpVWHLM/BoNwF3G68rh2mfGfVDDIo6Tr1IdTxJ755M4E084hc16
         U+Y3u+byx3T3QMsT4Mw/7ggMh1UbLcSXb0/lY+aZGRYNt2W386p6w2cLuNKI+N8hTHOh
         trQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769251529; x=1769856329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        b=nWrdm395wUmY0BCaISWaPOutLg163MXaaFaptr3TTl4rfWl7AxdcgS6OuDLbYYEpaz
         wME6dE/pV4njENzX/dnctf1XEEQ37vKc7YP2fi/sWsKFP+qDie/YBSevOnzomRoJtiYo
         KMqzTpsJ+MwgRfGOu231yJ8/8kW47AMeWL50DlUX42blTBQKPcLC4C0MmTkdbDquDbra
         aGjiNQRHD9Am8aaaPhEa0sTUxxFWuByY0Y9yX5e9Avzpr8Y2dA3dbTopa12UxBbIXfwl
         mnW4sFPT0BasxFjWJrHNA5XOdlSRWKTj9C+w4Ku3fYVpEGO2k7fWwPo1tQsGP0cKx0hy
         T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251529; x=1769856329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        b=QM4pnQTEaiSIgEQtvenBFyPMeKWq+Vw+flQDA3Xpz2wjsrrQt6JF69+4gyy4OnCJ7K
         el23nEkPxPFGJdUL4F8p8rpHjK/saJJCfhoTsufu73FGicaOlR30IcZabVT2wTjl93sS
         WmcMDOCMUBBBFwlfXh/YWepoF4PhzkRzZSsBFUL09nenX0KjU15eb7XF3R0cktck5UaR
         cRc4QAjNctBCszvgsHpxdJkF53R8YIut2tWAdqO55ZFVHv1JiVCuvt3DltnaybZrL9lN
         l2dYj2Feps86yBMqr73ruRB53vbrOsq2BJrqJRysVxATviHjFw0EwAgTbxlzcyezxhI4
         yerw==
X-Forwarded-Encrypted: i=1; AJvYcCVN1CCLzB8EE/kNFPRWjuXG9Xf3GsiwoUlCX7daoo5sruRK1kW4YmOaVESxR3DSY4ZvH+M48ehuaoicxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMPLGrzKAqjrWWdDWNctjjicBHo/InMPoXFxizWYbrfEVb91n
	73q7MWtF0zVlL7MQ8iZAfLu7SdmDHwKTx2hvqHTkDgDiK/t/g3x3AX1Cf/3Z495SggcPLcV67t1
	L2dAU9fRw6IAxWzfiPeli9LAWMvzrhDg=
X-Gm-Gg: AZuq6aJfVJLBtWUKJRLFSowHsbV17ZZ0LJ5Q6uIiRw0OjQYLo5EQ3miFrqSCPP/YT7f
	9TPrjwD+8ezibADRU6oN22g/+dvcsgg2JUZspDR0h3C7Op+KEoujbRS00hEynWSQtG4rIiTc2Ka
	wvqciJrfrIBZooagK9dqPv2b54BYmF4M/PuL23mIUPDjm3EwNIWaAYmO+keZr3RFk89633ZcHUU
	5K6WBvUlYo66owQhBN091rEa4HHVqkyLGWDco/thcBUDHAaZobz8sGh4oBOApfyhCiTz56jhS81
	zybYQaBkmGSAs/dh7vG1ChQHICqitKjbcolq7u4=
X-Received: by 2002:a17:907:1c0a:b0:b87:173f:630 with SMTP id
 a640c23a62f3a-b885ae61dc2mr478554866b.40.1769251528580; Sat, 24 Jan 2026
 02:45:28 -0800 (PST)
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
In-Reply-To: <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 24 Jan 2026 11:45:17 +0100
X-Gm-Features: AZwV_QilNv7skh3Dbv-Uyf4qbklEv15lpqvlCHXP7YddmY5hXQul6pw3DTKCtH8
Message-ID: <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20978-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 388737D47E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 9:08=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 23/01/2026 10:24, Andr=C3=A9 Almeida escreveu:
> >
> > Em 22/01/2026 17:07, Amir Goldstein escreveu:
> >> On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com>
> >> wrote:
> >>>
> >>> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida
> >>> <andrealmeid@igalia.com> wrote:
> >>>>
> >> ...
> >>>> Actually they are not in the same fs, upper and lower are coming fro=
m
> >>>> different fs', so when trying to mount I get the fallback to
> >>>> `uuid=3Dnull`. A quick hack circumventing this check makes the mount
> >>>> work.
> >>>>
> >>>> If you think this is the best way to solve this issue (rather than
> >>>> following the VFS helper path for instance),
> >>>
> >>> That's up to you if you want to solve the "all lower layers on same f=
s"
> >>> or want to also allow lower layers on different fs.
> >>> The former could be solved by relaxing the ovl rules.
> >>>
> >>>> please let me know how can
> >>>> I safely lift this restriction, like maybe adding a new flag for thi=
s?
> >>>
> >>> I think the attached patch should work for you and should not
> >>> break anything.
> >>>
> >>> It's only sanity tested and will need to write tests to verify it.
> >>>
> >>
> >> Andre,
> >>
> >> I tested the patch and it looks good on my side.
> >> If you want me to queue this patch for 7.0,
> >> please let me know if it addresses your use case.
> >>
> >
> > Hi Amir,
> >
> > I'm still testing it to make sure it works my case, I will return to yo=
u
> > ASAP. Thanks for the help!
> >
>
> So, your patch wasn't initially working in my setup here, and after some
> debugging it turns out that on ovl_verify_fh() *fh would have a NULL
> UUID, but *ofh would have a valid UUID, so the compare would then fail.
>
> Adding this line at ovl_get_fh() fixed the issue for me and made the
> patch work as I was expecting:
>
> +       if (!ovl_origin_uuid(ofs))
> +               fh->fb.uuid =3D uuid_null;
> +
>          return fh;
>
> Please let me know if that makes sense to you.

It does not make sense to me.
I think you may be using the uuid=3Doff feature in the wrong way.
What you did was to change the stored UUID, but this NOT the
purpose of uuid=3Doff.

The purpose of uuid=3Doff is NOT to allow mounting an overlayfs
that was previously using a different lower UUID.
The purpose is to mount overlayfs the from the FIRST time with
uuid=3Doff so that ovl_verify_origin_fh() gets null uuid from the
first call that sets the ORIGIN xattr.

IOW, if user want to be able to change underlying later UUID
user needs to declare from the first overlayfs mount that this
is expected to happen, otherwise, overlayfs will assume that
an unintentional wrong configuration was used.

I updated the documentation to try to explain this better:

Is my understanding of the problems you had correct?
Is my solution understood and applicable to your use case?

Thanks,
Amir.

diff --git a/Documentation/filesystems/overlayfs.rst
b/Documentation/filesystems/overlayfs.rst
index ab989807a2cb6..af5a69f87da42 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -753,9 +753,9 @@ Note: the mount options index=3Doff,nfs_export=3Don
are conflicting for a
 read-write mount and will result in an error.

 Note: the mount option uuid=3Doff can be used to replace UUID of the under=
lying
-filesystem in file handles with null, and effectively disable UUID checks.=
 This
+filesystem in file handles with null, in order to relax the UUID checks. T=
his
 can be useful in case the underlying disk is copied and the UUID of this c=
opy
-is changed. This is only applicable if all lower/upper/work directories ar=
e on
+is changed. This is only applicable if all lower directories are on
 the same filesystem, otherwise it will fallback to normal behaviour.


@@ -769,7 +769,7 @@ controlled by the "uuid" mount option, which
supports these values:
     UUID of overlayfs is null. fsid is taken from upper most filesystem.
 - "off":
     UUID of overlayfs is null. fsid is taken from upper most filesystem.
-    UUID of underlying layers is ignored.
+    UUID of underlying layers is ignored and null used instead.
 - "on":
     UUID of overlayfs is generated and used to report a unique fsid.
     UUID is stored in xattr "trusted.overlay.uuid", making overlayfs fsid


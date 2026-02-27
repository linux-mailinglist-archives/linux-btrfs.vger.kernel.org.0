Return-Path: <linux-btrfs+bounces-22059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJrhF1tkoWnIsQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22059-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 10:31:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A71B552D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E27531117DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7D3D905B;
	Fri, 27 Feb 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUxsZeFP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A543A782B
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184590; cv=none; b=J0mZdVFpHV8a5aSC1b+4TCe65X9bJEUo5FIgl+8+ju1RA5iYux2h3w+0Gm1u7nM9Pea3f19UrRbGA170ASoG1tj6uh4AFncrnP+/gxmHwkzsw7Wu0uZtQMQIG9r8iCySXnHuR0EDIJQmqXFWC6yUcF8BPZ1qywBgv4BiQfIfiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184590; c=relaxed/simple;
	bh=S417trSP2tLA9WhUDVdZuStIiWPOxwBbW5safmgHjUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaRgu2ICPuJUecJWKWhoM7i2x98I3E8XMtAqLux+G33BizN2zH5bNmWoilA6loWCfsGMIOnbW2suyU7ZDyEKj8jSU5hkSyhhbnchhg2tIaZhU51R2ibbTEhMB3jAxF3+QRKA7Rk3T4gNyXUZyrTdb09178bco5vmBACS33GoCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUxsZeFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAC5C19421
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772184590;
	bh=S417trSP2tLA9WhUDVdZuStIiWPOxwBbW5safmgHjUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZUxsZeFPscOvkmzDDgZgDX3vtJJSq/qQXMa2PWN5q2yuK7I9LEEnUYAnYORxYXlb4
	 V42Wrr0NR1JepgYTBcIl1PhsQ/3Wut/NfgJxV8ooEV7g3A0DvUXJ9nBdV4AagZozR4
	 3qU/CmLUd1EUXjDci7gjp8SDvcFBo9A25tKEbeyOAdwIOQiwuXwzq/+V8T2r3MioEE
	 Z5JORA0MiMpG/ZoK7xUL+Lwl4KG58S34LTE18F7jLpTSiSckIhNPyPvOuDlC2RYCyZ
	 RILSFPswumfeZIGMRFJGv2xmMNPoTmdMGi4D7ovY/TlDMnGQQC2n40DBGMwG64Re2O
	 yQyNrPDShSdkg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so2953539a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 01:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWctkkVzr5YSPGSp33StwCkYlq9rQdk9zle7Ao9T8PfGwMm5lJwcVTF5HquHrOXYL9twrTZ7JEOQPI5ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEC2QjJ59l14i5cencCJ/iwBkYN7m6NyJL/8UzL1GMwKHpXjy
	irJjwm/Z1XULYQn79C41WWNm3WYPhts//QcHn2zWIefLnlH1E0wbxSYmLSS/t6y8wiF40pG4gGw
	Bk2JFcPptf70/y9FwbkaB+3d8CFX1Wdk=
X-Received: by 2002:a17:907:3e9c:b0:b87:1839:2600 with SMTP id
 a640c23a62f3a-b93765109f5mr116416366b.33.1772184587743; Fri, 27 Feb 2026
 01:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216002806.3831884-1-mssola@mssola.com> <CAL3q7H4xgLyn5pSToEVj8MiqD4bohDwRYOMPeirqKQgCQ=pzfw@mail.gmail.com>
 <6995a98f.170a0220.4341d.d20aSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6995a98f.170a0220.4341d.d20aSMTPIN_ADDED_BROKEN@mx.google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Feb 2026 09:29:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5YHefunytYMjH+sBN=6K2d8=RsWkpZjTKA6wUAvrO1Nw@mail.gmail.com>
X-Gm-Features: AaiRm50cS3XoUyKc7gmhEXgNWUlT7To9_jAzX-2bNHK-LfkGpn2LyIBzC_ocdyY
Message-ID: <CAL3q7H5YHefunytYMjH+sBN=6K2d8=RsWkpZjTKA6wUAvrO1Nw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: report filesystem shutdown via fserror
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22059-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mssola.com:email,suse.com:email]
X-Rspamd-Queue-Id: B91A71B552D
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:59=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <msso=
la@mssola.com> wrote:
>
> Filipe Manana @ 2026-02-18 11:54 GMT:
>
> > On Mon, Feb 16, 2026 at 3:01=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <m=
ssola@mssola.com> wrote:
> >>
> >> Commit 347b7042fb26 ("Merge patch series "fs: generic file IO error
> >> reporting"") has introduced a common framework for reporting errors to
> >> fsnotify in a standard way.
> >>
> >> One of the functions being introduced is 'fserror_report_shutdown' tha=
t,
> >> when combined with the experimental support for shutdown in btrfs, it
> >> means that user-space can also easily detect whenever a btrfs filesyst=
em
> >> has been marked as shutdown.
> >>
> >> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Once the for-next branch is based on the next kernel rc that includes
> > the new function, I can push the patch there.

Now pushed into the for-next github branch.

>
> Thanks for taking care of this!
>
> >
> > Thanks.
> >
> >> ---
> >> Note that the for-next branch does not include the mentioned commit. I=
've
> >> built and tested this patch on top of current Linus' tree.
> >>
> >>  fs/btrfs/fs.h | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> >> index 3de3b517810e..92fcebf5766e 100644
> >> --- a/fs/btrfs/fs.h
> >> +++ b/fs/btrfs/fs.h
> >> @@ -33,6 +33,7 @@
> >>  #include "async-thread.h"
> >>  #include "block-rsv.h"
> >>  #include "messages.h"
> >> +#include <linux/fserror.h>
> >>
> >>  struct inode;
> >>  struct super_block;
> >> @@ -1199,8 +1200,10 @@ static inline void btrfs_force_shutdown(struct =
btrfs_fs_info *fs_info)
> >>          * So here we only mark the fs error without flipping it RO.
> >>          */
> >>         WRITE_ONCE(fs_info->fs_error, -EIO);
> >> -       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_i=
nfo->fs_state))
> >> +       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_i=
nfo->fs_state)) {
> >>                 btrfs_crit(fs_info, "emergency shutdown");
> >> +               fserror_report_shutdown(fs_info->sb, GFP_KERNEL);
> >> +       }
> >>  }
> >>
> >>  /*
> >> --
> >> 2.53.0
> >>


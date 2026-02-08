Return-Path: <linux-btrfs+bounces-21492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYjB33YiGkCxQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21492-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:39:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AE109E6D
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CA03013D52
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209DD2F9D9A;
	Sun,  8 Feb 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhU/1ib4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72517243969
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575912; cv=none; b=A84ez0LWCUWMw3IPRVuLLBAvfmH0EGE+fO8/Rz3ZC9BV5QcF1MCBlNMh4YC1ngH7hCk8UprImB9R8dBMjz3DErzmWwl8RyaTFtixkAtQEUqE//GLlsdfm9xcbN8ap12VjjmqI+alsajd2u58PEWsDjwPHvuaKXhh4Co6XnYjG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575912; c=relaxed/simple;
	bh=pe1arkh94VOEvuGQyV9/CWHoBvOSxb/OcxSRjDlDQ/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDMB8jX3AJmCRTQD0FRFhJxUHu4DemLVKz7ig21mN1Biq5r3InEvpC0Y+zRpxKr/XxLZnr9tFbkMqQSpMTuE+jleIzvgc7WW37pf61/xgnvBhRW4sLLA8XNapk1Dlq9g5rhAfoNeMuSg6x1y7ChTrcX494XTGG0RTsl2xp/Jl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhU/1ib4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF44C19421
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770575912;
	bh=pe1arkh94VOEvuGQyV9/CWHoBvOSxb/OcxSRjDlDQ/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jhU/1ib4/aTn3GxXqnYUuxVnrBhFBI4nJnrvwlTl7JGYobgxPMUa6oq1omsokpqRw
	 9lYAtbUyqap/pmaN1Q6vbjpJub501dALx9MdWncxCDOQa//T9cRtOMfhRmhb/M/Udm
	 EltafQpVrodd6aHQ/kEA860CC1vfg7P/JzyfrK+EmpMoE6rp0mNTnkFhlRhQ1DwxQA
	 RAporses6J7NkQks2Factli87BJdxQvhW8Yt/CfPQeGbyvib6c753CBzGllniFGtPj
	 BHFpUk+LP/yTaBRbIvrEX6NrMFfCQa/SB7HfulpJdEulKbLofkyQ37fCegzMVkiOr4
	 MhbNKA26KCKmA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso6270594a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 10:38:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3RZf1G1ipIUOG0VtTO2glaoj7rZyIOH1+UiW99ZNQ8DL19jqP
	rmvZe3hhlglcTpFguW2+pbBZb+s835gI5kU+3aLImxUNvnU3St2jTtnQLtn1/675H+J389R6Acp
	ymOF3xhJ8GGJWddeuo47MSFqxdbQT+Qo=
X-Received: by 2002:a17:906:4fd2:b0:b86:edb9:c01b with SMTP id
 a640c23a62f3a-b8edf175e47mr586458866b.8.1770575910881; Sun, 08 Feb 2026
 10:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768993725.git.fdmanana@suse.com> <1974159cc321acb84acea5ccef0427592a576cad.1768993725.git.fdmanana@suse.com>
 <20260208161129.3888234-1-clm@meta.com>
In-Reply-To: <20260208161129.3888234-1-clm@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 8 Feb 2026 18:37:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5nyMS8VfEHDYKY1ELyWv3BTxrc5wkLHycYHGR8sZqa_w@mail.gmail.com>
X-Gm-Features: AZwV_Qi_RHeuZJ10P6OIPrTdPe07k5LgynR2xQyEpqVUcg4fVUkta1D6Ns2DM84
Message-ID: <CAL3q7H5nyMS8VfEHDYKY1ELyWv3BTxrc5wkLHycYHGR8sZqa_w@mail.gmail.com>
Subject: Re: [PATCH 16/19] btrfs: remove out label in finish_verity()
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21492-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6F8AE109E6D
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 4:11=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There is no point in having the label since all it does is return the
> > value in the 'ret' variable. Instead make every goto return directly
> > and remove the label.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch se=
t
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these revi=
ews
> are already useful.  I've kept the headers to make it easier to double ch=
eck
> that I'm actually replying to the right email, but please let me know if =
any
> parts of this are incorrect:
>
> commit 61fb7f04ee06e6c7e113a490af1a057f958f1d05
> Author: Filipe Manana <fdmanana@suse.com>
>
> btrfs: remove out label in finish_verity()
>
> This commit refactors the finish_verity() function by removing the 'out'
> label and making error paths return directly. The goal is to simplify the
> control flow.
>
> > diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> > index a2ac3fb68bc85..06cbd6f00a78c 100644
> > --- a/fs/btrfs/verity.c
> > +++ b/fs/btrfs/verity.c
>
> [ ... ]
>
> > @@ -554,8 +552,7 @@ static int finish_verity(struct btrfs_inode *inode,=
 const void *desc,
> >       btrfs_set_fs_compat_ro(root->fs_info, VERITY);
> >  end_trans:
> >       btrfs_end_transaction(trans);
> > -out:
> > -     return ret;
> > +     return 0;
> >
>
> Does this change introduce an error handling regression? When
> btrfs_update_inode() or del_orphan() fail (lines 546, 549), execution
> jumps to the end_trans label which now returns 0 instead of returning the
> error code in 'ret'.

Correct, fix sent here:

https://lore.kernel.org/linux-btrfs/1d384c9ac09392353418f47a8b41366545d7386=
7.1770575632.git.fdmanana@suse.com/

Thanks.

>
> Looking at btrfs_end_enable_verity() at line 632:
>
>     ret =3D finish_verity(inode, desc, desc_size);
>     if (ret)
>         goto rollback;
>
> If finish_verity incorrectly returns 0 on these failures, the caller will
> not trigger its rollback mechanism, leaving the inode in an inconsistent
> state. The verity flag changes (BTRFS_INODE_RO_VERITY set at line 543)
> would not be persisted to disk and the orphan item would not be properly
> removed.
>
> The original code correctly returned 'ret' via the 'out' label. Should th=
e
> end_trans label also return 'ret' instead of 0?
>
> >  }
>


Return-Path: <linux-btrfs+bounces-21114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N3vBRykeGmGrgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21114-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 12:40:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B180B93B58
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F0F304A65E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD4348477;
	Tue, 27 Jan 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYPFUWuK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED52ED860
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513945; cv=none; b=Bq/xpqYenGqeWO4pcZklp+DIO5S2otVbcelLUzeYXOxyjs/xTU4ZnjHvIXb0jS+NR8Qn6s2tbGNbJYlRzFNkt4/fBCuFQdrju+my3h4tX4XbQt4PeTWDkAX3xRpVSx9jGEGeujwLXQ8YElo7qt6BaSOrGtndnNOnlGWWok1XYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513945; c=relaxed/simple;
	bh=QkKFZDjUQYcw2Im8KtWfeYRYWdUkcGO1huUIFadUTzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nICm2NznM/JGKsUIVxR4IHqXNCN+BXPyt4iMwrNxFnYqL36NislGPV0dBhlcDvOO+jOqg/P9Qqph1Ef1hhBrBDq+FZuqhQaYj4u5YKS9eXbfcfSN4ZQnTDDs/uKIDAIDRSS882Cjn3qUXnBRTJi3cOUqnPWuK7BVosKKT39lOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYPFUWuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6EAC2BC87
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769513944;
	bh=QkKFZDjUQYcw2Im8KtWfeYRYWdUkcGO1huUIFadUTzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aYPFUWuK0SdrbiRWTsBe/5TxWBv5hPtLc6cQgtm9lRTi+xea+AFE3EfjNtO9htSzt
	 exPXqISTzK9rvQNuFdhwiv2NKNlmJLH6gdwA0JYpgEYnrQlvOyXhjMqxKfhX+wuPjn
	 hnbND78isKAIa43gKNLlSs1LgRQ+judo+MupZoguho4YO+EJa/1+50baHdluxXjvHF
	 6SkJRMJnacgo1TUhaV0a4bDcMbiKW8s8fIP/5/hIywnFdqJnodiJjEH64vho3snnBx
	 BmyooDYa3Ym19ow4Ut8JweueL6MAMYv3RpWn6uopJdSh1UhO4MLEsY/ZdEUBiFIlFE
	 +Ob8KrxrcdB8Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8871718b00so625782766b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7wQ6EOoHUiut2uol3Pb94rPhayTaQ8zhuVXqWUURq2ReEK6I5fAThk8q1ZA/oY4ORNGLQ/b7AoNkQvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5oQeq1Cq+ohFjB1ZMcZ7eMhM+2glVvp0HIJKpSzEzhFsqtWB
	aBRIddzlpFQWZcu3ZgodOp3igbbsu7fqz1Z0GtVFgIiuAYUqAfo2ZHB0Dbmi7FtVa4+TkFUvT78
	kPMxj+cs9OPYFLlfI/tIaCUaVlJW4LtY=
X-Received: by 2002:a17:906:7316:b0:b87:205c:1aa7 with SMTP id
 a640c23a62f3a-b8dab37b56cmr110458866b.44.1769513943221; Tue, 27 Jan 2026
 03:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H4=9vH3UP6=i1zTe7MVKf6aWAqEqb7i+Fmxoc3q4qDyKA@mail.gmail.com>
 <20260127074055.781388-1-jinbaohong@synology.com>
In-Reply-To: <20260127074055.781388-1-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 Jan 2026 11:38:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H62qyB_nWL2HHr8ua39K+oZC9TjHhF9BQn7bWJ60t8zQA@mail.gmail.com>
X-Gm-Features: AZwV_Qhk_LfT7UDdQtg3OuiuZIGAO_N9lFd3j-ZdYsg8a7zUMvf-nUEXWi4Q6aE
Message-ID: <CAL3q7H62qyB_nWL2HHr8ua39K+oZC9TjHhF9BQn7bWJ60t8zQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs: continue trimming remaining devices on failure
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
	TAGGED_FROM(0.00)[bounces-21114-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B180B93B58
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 7:41=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
> wrote:
>
> Hi Filipe,
>
> > > @@ -6648,7 +6780,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info=
, struct fstrim_range *range)
> > >                 }
> > >
> > >                 start =3D max(range->start, cache->start);
> > > -               end =3D min(range_end, btrfs_block_group_end(cache));
> > > +               end =3D min(range_end, cache->start + cache->length);
> >
> > Please don't do that. We should use the helper btrfs_block_group_end().
> > Why did you do this change? This seems completely unrelated.
> >
> > Otherwise it looks fine, thanks.
>
> First, sorry about the unrelated change from btrfs_block_group_end() to
> cache->start + cache->length in v3. That was an accidental leftover from
> debugging - I'll make sure it's removed in v4.
>
> Before sending v4, I'd like to discuss some behavior details about trim
> error handling.
>
> =3D=3D=3D 1. Block Group Loop Interrupt Handling =3D=3D=3D
>
> Currently, block_group loop has the same problem:
>
>   ret =3D btrfs_trim_block_group(...);
>   if (ret) {
>       bg_failed++;
>       bg_ret =3D ret;
>       continue;  // Doesn't break on user interrupt
>   }
>
> I think we should also break the block group loop on user interrupt,
> similar to the device loop.

Yes.


>
> =3D=3D=3D 2. First Error vs Last Error =3D=3D=3D
>
> Currently, both block_group and device loops store the last error.
> I'm considering changing this to preserve the first error.
> This would show the root cause rather than the most recent failure.
> What do you think?

That's fine.

>
> =3D=3D=3D 3. ERESTARTSYS/EINTR and Error Code Precedence =3D=3D=3D
>
> After reconsideration, I think user interrupt (-ERESTARTSYS or -EINTR)
> should NOT overwrite a previous device error (if any). For example, if
> device A fails with -EIO, then user interrupts during device B, the
> final dev_ret should be -EIO rather than -ERESTARTSYS/-EINTR.

That's fine too.

>
> =3D=3D=3D 4. Scope of ERESTARTSYS to EINTR Conversion =3D=3D=3D
>
> > > @@ -6685,10 +6687,14 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_in=
fo, struct fstrim_range *range)
> > >                 ret =3D btrfs_trim_free_extents(device, &group_trimme=
d);
> > >
> > >                 trimmed +=3D group_trimmed;
> > > +               if (ret =3D=3D -ERESTARTSYS) {
> > > +                       dev_ret =3D -ERESTARTSYS;
> >
> > And either replace it with -EINTR.
> >
> > Otherwise it looks fine, thanks.
> >
> > > +                       break;
> > > +               }
> > >                 if (ret) {
> > >                         dev_failed++;
> > >                         dev_ret =3D ret;
> > > -                       break;
> > > +                       continue;
> > >                 }
> > >         }
> > >         mutex_unlock(&fs_devices->device_list_mutex);
>
> You mentioned the issue of -ERESTARTSYS. Could you clarify the intended
> scope?
>
> Option A: Convert all btrfs_trim_interrupted() paths to return -EINTR
>           (changes in extent-tree.c and free-space-cache.c)
>
> Option B: Only convert at btrfs_trim_fs() level before returning to
>           user space, keeping -ERESTARTSYS internally.
>
> Which approach do you prefer?

ERESTARTSYS is not meant to be returned to user space, it's a kernel
internal thing.
We should make sure that we return EINTR to user space instead.

Yes, there are other places using and returning ERESTARTSYS which gets
propagated up the call stack and then into user space.
I think we can just replace all ERESTARTSYS with EINTR, it's simpler
than leaving ERESTARTSYS and then converting to EINTR before returning
to userpace.

But please address each of those issues in separate patches, which
with its own changelog describing the change.

Thanks!

>
> Thanks,
> jinbaohong
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.


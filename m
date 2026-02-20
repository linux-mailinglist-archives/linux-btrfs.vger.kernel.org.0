Return-Path: <linux-btrfs+bounces-21811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IArUJEyhmGkPKQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21811-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 19:00:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC84169EF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81227307E0A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30936605B;
	Fri, 20 Feb 2026 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPbd83OH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A62C3259
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610417; cv=none; b=LoUTUI29UjkzT4tfbbNaF2G5nxfEnu8pbXHjT5IuHbYx7dySvy0yXsg+3zRVWi1/8HLwg1enraGdbNPLzJKA3cb0Uo1W3RAMyRo6/s6CFWrRnb+egXrjosHDYbRooZW2ltekkEqAz+RopmWubuWiYN1XGPpyW/DSCpT2eShs3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610417; c=relaxed/simple;
	bh=8KBXGk479TzL2NHOi1uGcfHrznIV7+iRiVRCiA1Eqr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvU08g25mTb7zWXT/VMzkt6uAjQcSXsGZ+eKBG168nBd6H0L4aIh96Di5RVGurHQ4aHNV9jO7AJmajxDgKQ1rS0taDgVywtyNmKDv/kXnJ64uh+QL/8OTjbEXhr0zla0H9zC031kvbFq+gtAjBUUOeWs3b8sq403p1L+9RGZlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPbd83OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A388C116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771610417;
	bh=8KBXGk479TzL2NHOi1uGcfHrznIV7+iRiVRCiA1Eqr0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mPbd83OHq65CfIpDcIvOcGkyGYZnckLP0hIxrE2lN1RLKOJe63cbalvYCmG6ZnW+v
	 98SQjOMCtDf4iIvXj4DVMKD01nEI7Kk3BUE+OiT9RmnYf0+o070YdTuTPsQNanqEJD
	 ZpUosLWy4CUA0NYL5svUylLKMeF9g3EZ86OBMsLYsIv+H2NoLJCZ47wccb/pGAQpWm
	 pqCBS2zaC4B1/uFqKacsxq6qMGE3tPBKZ7KT/DVvUUQc/AqJrTIQSetjVZ9XiPV3ZA
	 K5liPY/qrH6DUHDKkeEZPaE0vhfcdRY61V+wTCeE9MNG4+PzYWE+ezGMu8ab9+rf7P
	 ZdH3mkJZ3VjmA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8860d6251bso334607566b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 10:00:17 -0800 (PST)
X-Gm-Message-State: AOJu0YzAyca9xJIc0GXY83NFnLVNQzKRvGFLquJWLsMVgbX96DuSYXIU
	Ct4cJDNw8VpMOmVngtNBDhABnjmLrXiEaWYBLF37k4gGHIBTKAfWD61sToDt/HJ6Yo8VcAfv1pp
	bZ1MK4qoGgFrSl5AUt0rWe1VAR0PhPE4=
X-Received: by 2002:a17:906:5804:b0:b87:4c74:b316 with SMTP id
 a640c23a62f3a-b9081ba7c36mr15287366b.50.1771610415614; Fri, 20 Feb 2026
 10:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
 <20260220175309.GK26902@twin.jikos.cz>
In-Reply-To: <20260220175309.GK26902@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 20 Feb 2026 17:59:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7aeu5n+A2L9KMc3mt+MpQr6THZ3t7+-S-jX+PwZKKPLw@mail.gmail.com>
X-Gm-Features: AZwV_QhIAKGQjCVktls0o_9TSdrvdlqH2A-J6Piugwu46s_mN3_6rw9ya28OKpE
Message-ID: <CAL3q7H7aeu5n+A2L9KMc3mt+MpQr6THZ3t7+-S-jX+PwZKKPLw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: stop printing condition result in assertion
 failure messages
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
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
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21811-lists,linux-btrfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 3DC84169EF6
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 5:53=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Thu, Feb 19, 2026 at 03:45:39PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > It's useless to print the result of the condition, it's always 0 if the
> > assertion is triggered, so it doesn't provide any useful information.
> > Examples:
> >
> >    assertion failed: cb->bbio.bio.bi_iter.bi_size =3D=3D disk_num_bytes=
 :: 0, in inode.c:9991
> >    assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476
> >
> > So stop printing that, it's always ":: 0" for any assertion triggered.
>
> I've put it there because of the single value conditions like
>
>         ASSERT(flag);
>
> In most cases the condition is compound and boolean so the result is not
> useful and there are also many cases with simple pointer value so the
> exact value is also not providing anything.
>
> For any case we want to know exact values or possibly of subexpressions
> too (like start + length or other calculations) we should use the
> extended ASSERT syntax.
>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/messages.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> > index 81f59afe4a99..17cdc14dc89d 100644
> > --- a/fs/btrfs/messages.h
> > +++ b/fs/btrfs/messages.h
> > @@ -141,11 +141,11 @@ do {                                             =
                               \
> >       verify_assert_printk_format("check the format string" args);     =
       \
> >       if (!likely(cond)) {                                             =
       \
>
> This should probably become "if (likely(!cond))" as mentioned recently.

I think you mean:

if (unlikely(!cond))

I can add that in a separate patch.


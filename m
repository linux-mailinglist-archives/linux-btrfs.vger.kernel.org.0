Return-Path: <linux-btrfs+bounces-13444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09183A9DC44
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FCF7B0064
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648A25C82F;
	Sat, 26 Apr 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Qdae0M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CA6FC5
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685604; cv=none; b=iFXmLas/ndHIV+5HC547Hger7kOviNv80fyLz3ElM2D7vzde5Lu0ZhZamn8Ou5DYropTDflz3wHfGw8XfJse6mvb9o9M48+aYVdct52rRXb6zTg3xpLYLg+z69L6qj4RZGUkmnr8/saAx1rgN1Wd5HsR2GDRMwK1fzasOTrFCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685604; c=relaxed/simple;
	bh=StEF7Ak9ZicB5nCEpQSdOulrmQseWzNzBFEqWvGGrXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDa00QtdjDhX7NbS558P/6KZoQghEpXisXUZLDPmcNyaBaZO+RfDDNRXbnIxmwH581VnOaxC+AbDMaQ7YFsbPRnIVtX4bPR1fYiaFEx9gtbX3r2rsRpu1nV6xrNrecGEo5u/m9lRfUSy7rr2EAZhSNao6NjOEy4CyHagNkggiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Qdae0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07503C4CEEC
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745685604;
	bh=StEF7Ak9ZicB5nCEpQSdOulrmQseWzNzBFEqWvGGrXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b0Qdae0MyV7GiE3MyZrGm54Cc+tBQm9yjcwZEEqdZ+5ndEWvYNnmbVVSDESyRGyGU
	 d8idvMGEmsnb1r4MK0OT4e9dH5mmI9V9EYjsc1h/JwB1SN+Liqu9aJ4StQ8T9qTs+d
	 iaNxNCYWXG8XDInbWNmSvyZ3B/SF80cXGQT1uuinBXaaGZkyEOk0PPq+bio8T96i8C
	 e/A7TjvDAuuMoWnzqlzZg6KDPWEbcp7y8/aFeoJmedJJI0kk2kaBUmTjlVlbsOsSA5
	 kvfP4tNxeC5eTftz2nUF2MNSR8msMWA3Bia2NdWXH7VVUyhZsCzJv687Mapo2r28Bv
	 miqLK+jvBGc6A==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25d2b2354so485164166b.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 09:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU62+/rrVxG3NtWiCs0HnpAY5deOeAl448dsJvi/kbkvURU9huET52RwRRxAylhcoNLlulf5oLH/n5A2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6S1wB7+GTEekQe2qmuDxtuOD6tXfSyeXlAiEC8v0Fw0nC8kH/
	Mle3a48qNx5znqkgUTZ5UN7dW47/kIoU6qhw9qms6jOhCZpqjVpmZFmgGQ1VrqQucTEKz0+fHNT
	n/Tb5PmTIyTHIqFqa78aw11/CqVM=
X-Google-Smtp-Source: AGHT+IF7W6hwNVUHhNQCLlXNK7VPa/flNRc23UrArSSKt4AEbDybte9UhYocjyGUP/yNDMQWcbHwhclcL6fm7yjncXY=
X-Received: by 2002:a17:906:6a23:b0:aca:e33d:48af with SMTP id
 a640c23a62f3a-ace7144ae9dmr595337766b.61.1745685602555; Sat, 26 Apr 2025
 09:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <CAL3q7H60DfC0+ysf_Yw7bBOaDExPqpRU4==xHz4pYxHt3k-woQ@mail.gmail.com>
 <20250425115813.GE31681@suse.cz> <20250425153943.GA1567505@zen.localdomain>
In-Reply-To: <20250425153943.GA1567505@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 26 Apr 2025 17:39:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5+uAE5HtY0JEz=3dcV7PNUVu-5h+mWpbHwYXY8U3=2sQ@mail.gmail.com>
X-Gm-Features: ATxdqUEb0-nSQ-tO7ImRRpR0d6eQi6ZUnAWyedAD92P0JyK54rqm3NhWhncilZQ
Message-ID: <CAL3q7H5+uAE5HtY0JEz=3dcV7PNUVu-5h+mWpbHwYXY8U3=2sQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 4:38=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Apr 25, 2025 at 01:58:13PM +0200, David Sterba wrote:
> > On Fri, Apr 25, 2025 at 10:18:38AM +0100, Filipe Manana wrote:
> > > On Thu, Apr 24, 2025 at 10:54=E2=80=AFPM Boris Burkov <boris@bur.io> =
wrote:
> > > >
> > > > If btrfs_clone_extent_buffer() hits an error halfway through attach=
ing
> > > > the folios, it will not call folio_put() on its folios.
> > > >
> > > > Unify its error handling behavior with alloc_dummy_extent_buffer() =
under
> > > > a new function 'cleanup_extent_buffer_folios()'
> > >
> > > So this misses any indication that this fixes a bug introduced by:
> > >
> > > "btrfs: fix broken drop_caches on extent buffer folios"
> >
> > Thanks for noticing, this was not obvious.
> >
> > > With a subject and description like this, it's almost sure this patch
> > > will be automatically picked for stable backports, and if it gets
> > > backported it will break things unless that other patch is backported
> > > too.
>
> Oops.
> I was trying to *avoid* it getting backported by ommitting the Fixes:
> tag. I should have just squashed them together as you guys say. I was
> worried it might be confusing with Daniel also making related changes,
> but it should have been fine anyway.
>
> Speaking of which, I believe his patch
> "btrfs: put all allocated extent buffer folios in failure case"
> also fixes a leak from my first patch, for folios that are past the
> attached counter in the fail case, so that needs the Fixes: tag too.
>
> > >
> > > Also, since the bug was introduced by the other patch and it's not ye=
t
> > > in Linus' tree, it would be better to update that patch with this
> > > one's content.
> > > That's normally what we do - I know both patches are already in
> > > github's for-next (I didn't even get a chance to review this one sinc=
e
> > > it all happened during my evening), and it's ok to rebase and squash
> > > patches.
>
> Copy
>
> >
> > Agreed, as long as the a buggy patch is in for-next there shuld be no
> > need for a fixup unless the branch is frozen for merge window.
> >
> > Also non-trivial patches should not be pushed to for-next too quickly,
> > exactly to give people chance to have a look. For trivial, clearly
> > correct or non-code updates I would not care much if it's applied
> > without much delay.
>
> Apologies. How long should I leave a fix on the list without pushing it?

Well we don't have it defined and it was never needed, we always used
some sort of good common sense.

In this case, my reasoning is:

1) It's a bug fix that resulted from the reviews from me and Daniel
for the v3 of a previous patch you sent,
    which was merged before we could review since there's a Review tag
from me that applied to v1 only but you carried it to v2 and v3 even
after making a substantial change to v1:

    https://lore.kernel.org/linux-btrfs/9441faad18d711ba7bccd2818e6762df0e9=
48761.1745000301.git.boris@bur.io/

2) I would expect that you would give a chance for me and Daniel to
take a look at it, since this was a follow up to that other patch we
were reviewing.
    But you sent the patch during our evening, and since Qu reviewed
it shortly after, you pushed it right away to for-next, just in a
period of a few hours, before me or Daniel could look at it.
    Remember we are in Europe, several hours apart from your timezone,
we sleep and do other things as well :)

3) Also it wasn't a super critical fix, no urgency to push it so
quickly to for-next since it affected only for-next and for an error
scenario that isn't common (not breaking fstests runs for every one
for example).

This wasn't fixed in a v4 of the former patch because it seems to me
you had this idea that once a patch lands in for-next we can't change
it or drop it...
So if there was a problem with this one too, when I (or Daniel) had a
chance to review, would you follow up with yet another patch on top in
case it introduced a regression too?

Mistakes happen and that's fine, I'm not blaming you for that, and I
don't mind reviewing 2, 3, 10 or more patches if needed, just pointing
out that there's absolutely no need to rush like you did here...

It wasn't a super critical fix, no urgency to push it so quickly to
for-next since it affected only for-next and for an error scenario
that isn't common, plus as mentioned before it would be nice to give a
chance for previous reviewers to look at the patch before getting
merged.

> I did get a non-trivial review (as in he didn't just blindly stamp it)
> from Qu.
>
> Shall I leave it up for ~24 hours or until review from one of you two in
> the future? Or since Filipe noticed the bug in the first place, wait for
> his review in this particular case? For me, getting things off my plate
> makes it less likely I will get pulled away from finishing them, which
> is why I wanted to push it while I was focused on it and felt done. If
> that's inappropriate, that's totally fine by me, just saying.
>
> Sorry for making this a headache with the buggy initial fix and churny
> followups.

That is fine, it happens to everyone from time to time.
Just allow for a chance for previous reviewers to look at a patch,
remembering there is this annoying thing called time zones (evidence
the Earth is not flat) and we may not be able to review things
immediately.


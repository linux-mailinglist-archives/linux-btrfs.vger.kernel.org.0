Return-Path: <linux-btrfs+bounces-8284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD787988014
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D71D1F26E6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF91898E2;
	Fri, 27 Sep 2024 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL4Mm2FF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FA189505
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424674; cv=none; b=rsqZk+/4LSZdRaTUnkWPlqajNBTw0SuXspE4LFjl/2Z25AYy5ifVfBogUPNIhoDTUUkEGIJISRt1JlhnTCqSKShMm6v8O+qvoME+qJfJ+kDawtR4LTjUfBHmGoU9UmvJ8ZRWSQbrQItB5ZWht5ylg1fb/YhfkUG5Qq7OrAvsdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424674; c=relaxed/simple;
	bh=Sa4Wd+BRxe+TbXWgHNvV3z2qf2kimZ2m/wgHIpnv1iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJghRXFN6fDByhEJgHVEh8zIHhbtJ2NMP3S7uQn1KpEesmjIyvnkiGbQAROHu6sJhzGoLnt3TaBvtpm8f9ogeNZCpXANqccsFGs99jyEpquRwrQGL03zwJfooYSHhk07p+XU5R7diim/Wj5BuQ4t7r2quw0AcixCjrDDQP28zO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL4Mm2FF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F7C4CEC7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424674;
	bh=Sa4Wd+BRxe+TbXWgHNvV3z2qf2kimZ2m/wgHIpnv1iA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eL4Mm2FF1CZObjVUngO5YFfFPRPnsy9YLoQWkEfY5Jul18tllqFtyc7ysb2XzBjOU
	 emqA8vCStZWFSj2pUw1nX9rQ6NlZRVOx8SkurtHuIvFSQ8KYWwwt/1aZ6bTVTw6b77
	 J1tMYgBGousDoKgXf6BOHAHkzCTMh6nPN9sJ0p3F2HRh3I8nibdhbO3QeLR3GccgNg
	 TQyutdwERvthzsRh6VWISV/K3aTNHJofDdLXn//gGgOzSq8172OD+38vpb6Y4BWu1H
	 klLJl7Teo9I9chYUHyEFOF+wJHWxXoe+9yP4DcJJlfajUi8iGWCeGbaxyddcLt8zzG
	 xf2ZKNI++uemA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365a9574b6so2956016e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 01:11:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YyyfLeA2Qs+UJi2hVNxyjWTtZZWVlR5a8ZjJ8XjjbbIVPw7D2vV
	3/AcALtLAg5HzBC7ukqDLCxqBYqD0jhVayC5R9/eyMnX/u/f7sJXH8ZqAh5hX+jT2rBTC2WJ1hV
	heCcog84OYOIGNzN7/jvSZZ02XR8=
X-Google-Smtp-Source: AGHT+IFVFx+eLW3rrYk4ENrr07hj2ulRPfoOU2fudE1oYSEmm2IzhOl+WBsnwE1IGmNd18rR8wEJwwSwprLlm1vXClQ=
X-Received: by 2002:a05:6512:a8e:b0:536:a7e0:131a with SMTP id
 2adb3069b0e04-5389fc46bb7mr1949676e87.26.1727424672276; Fri, 27 Sep 2024
 01:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174151.git.fdmanana@suse.com> <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
 <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com> <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
 <9323f10d-dab1-4826-a088-90b1c5bea38c@gmx.com> <CAL3q7H7LBWyfXy7XRJh7ufgLdhTBw4MGZtBtLV+2zCLJ3MrFsQ@mail.gmail.com>
 <57645a54-43e0-4a7d-9b84-4c3b662ea1f5@gmx.com>
In-Reply-To: <57645a54-43e0-4a7d-9b84-4c3b662ea1f5@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 09:10:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5ND+gWDJrGNnRKeNovaRo9UD-CjTCkvTDcUNSRuV1MQg@mail.gmail.com>
Message-ID: <CAL3q7H5ND+gWDJrGNnRKeNovaRo9UD-CjTCkvTDcUNSRuV1MQg@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:02=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/26 20:11, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Sep 26, 2024 at 10:55=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> [...]
> >>> What's the problem?
> >>> The use of the atomic and not incrementing it, as said in the comment=
,
> >>> makes sure we don't do more work than necessary.
> >>>
> >>> It's also running in the system unbound queue and has plenty of
> >>> explicit reschedule calls to ensure it doesn't monopolize a cpu and
> >>> doesn't block other tasks for long.
> >>>
> >>> So how can it cause any problem?
> >>
> >> Then it will be a workqueue taking CPU 100% (or near that).
> >> Even there is only one running work.
> >
> > No it won't.
> > Besides the very frequent reschedule points, the shrinker is always
> > called with a small percentage of the total number of objects to free.
>
> And there is no guarantee that a small number to reclaim is not heavy.
>
> The latency of a scan is not directly related to the passed-in number,
> but the amount of roots/inodes/ems.
>
> E.g. we have tens of thousands of inodes to go through. Even most of
> them have no extent maps, it may still take milliseconds to go through.

You're taking what I've written in the changelog as if I'm not aware of it.
Yes I talk about several milliseconds for 10000 inodes without any
extent maps, on a very busy system and the
times measured were done with bpftrace which include reschedule times,
so accounting for periods the shrinker was not running.

The point of running it asynchronously in the system unbounded queue
is precisely so that in case it takes a long time it doesn't affect
other tasks.

>
> And if we always have a small ems pinned for IO, so even after the

Small ems? How does the size of an extent map matters here?

> current reclaim done, the next reclaim work will still get some small
> number queued to reclaim, again takes several milliseconds to reclaim

And that's precisely why it's run asynchronously in the system
unbounded workqueue, so that no matter how long it takes, it doesn't
affect (delays) other tasks.

> may be a few extent maps, then IO creates new ems bumping up the em
> counts again.

And adding the delay will solve any of that?
Please explain how.

>
> >
> >>
> >> The first one queued the X number to do, and the work got queued, afte=
r
> >> freed X items, the next call triggered, queuing another Y number to re=
claim.
> >
> > And? Work queue jobs are distributed across cores as needed, so that
> > work queue won't be monopolized with extent map shrinking.
>
> Scheduled across different CPUs won't make any difference if the reclaim
> workload is queued and run again and again.
>
> Let me be clear, reschedule and core distribution are not changing the
> nature of a long running CPU heavy workload.

And how does your delay make that better?

> Just take gcc as an example, it's a user space program, which can always
> be preempted, and kernel can always reschedule the user space program to
> whatever CPU core.
> But it's still a long running CPU heavy workload.
>
> The same is for the em shrinker, the difference is the em shrinker is
> just waked up again and again, other than a long running one.

If needed, yes, that's why the shrinker (at a higher level) calls into
the fs shrinker for a small portion of objects at a time.

>
> >
> >>
> >> The we get the same near-100% CPU usage, it may be rescheduled, but no=
t
> >> much difference.
> >> We will always have one reclaim work item running at any moment.
> >
> > And if that happens it's because it's needed.
> > The same goes for space reclaim, it's exactly what we do for space
> > reclaim. We don't add delays there and neither for delayed iputs.
>
> Unlike delayed inodes, em shrinker needs to go through all roots and all
> the inodes if we didn't free enough ems.

For a portion of the total extent maps.
Every time it's called it visits a portion of the total extent maps, a
few roots, a few inodes, sometimes just 1 inode and 1 root.

>
> While delayed inodes has a simple list of all the delayed inodes, not
> really much scanning.

The time to move from one element to the next is shorter, yes, but if
you have many thousands of elements it's still time consuming.

>
> And just as you mentioned in the changelog, the scanning itself can be
> the real problem.

Yes, and that's why it is being done by a single task in the system
unbounded queue, so that no matter how slow or fast it is, it doesn't
cause delay for other tasks.
The problem was that it ran synchronously, through memory allocation
paths (and kswapd), and that time introduced delays and made any
concurrent calls spend a lot of time busy on spin locks, preventing
other tasks from being scheduled and therefore unresponsive.

>
> >
> >>
> >>>
> >>>>
> >>>> The XFS is queuing the work with an delay, although their reason is =
that
> >>>> the reclaim needs to be run more frequently than syncd interval (30s=
).
> >>>>
> >>>> Do we also need some delay to prevent such too frequent reclaim work=
?
> >>>
> >>> See the comment above.
> >>>
> >>> Without the increment of the atomic counter, if it keeps getting
> >>> scheduled it's because we're under memory pressure and need to free
> >>> memory as quickly as possible.
> >>
> >> Even the atomic stays the same until the current one finished, we just
> >> get a new number of items to reclaim next.
> >
> > If we do get it's because we still need to free memory, and we have to =
do it.
> >
> >>
> >> Furthermore, from our existing experience, we didn't really hit a
> >> realworld case where the em cache is causing a huge problem, so the
> >> relaim for em should be a very low priority thing.
> >
> > We had 1 person reporting it. And now that the problem is publicly
> > known, it can be exploited by someone with bad intentions - no root
> > privileges are required.
>
> I do not see how delayed reclaim will cause new problem in that case.
> Yes, it will not reclaim those ems fast enough, but it's still doing
> proper reclaim.

If it's not fast enough it can often have consequences such as
allocations failing anywhere or taking longer for example, or making
the OOM killer start killing processes.

>
> In fact we have more end users affected by the too aggressive shrinker
> behavior than not reclaiming those ems.

Yes, when it ran synchronously, before this patchset.

I don't think you understand why it was aggressive.
This was already explained in the change log and comments, but let me
rephrase it:

1) Multiple tasks, during memory allocations or kswapd, end up
concurrently triggering the fs shrinker which enters the extent map
shrinker, let's say 100 tasks;

2) There's for example 1 000 000 extent maps, and the shrinker decides
for example to try to free 1000 extent maps (the nr_ro_scan argument);

3) The decision for each calling task was made before any other task
was able do do any progress (or very little) dropping extent maps;

4) So while 1000 extent maps may have been enough to release memory,
we end up releasing  (or trying to) 100 * 1000 extent maps
concurrently, causing the heavy spin lock waits and CPU usage.

Making it run asynchronously in the system unbound queue, ensuring
there's only one queued work, and using the atomic without adding
(just swapping if it's 0), solves all that.
In the example above it ensures only 1 task is doing the extent map
shrinking and for at most 1000 extent maps, and not 100 * 1000.


>
>
> And it will be a slap in the face if we move the feature into
> experimental, then move it out and have to move it back again.

Regressions and problems happen often, yes, but we always move forward
by analysing things and fixing them.
I'm sure you've gone through the same in the past.

>
> So I'm very cautious on any possibility that this shrinker can be
> triggered without any extra wait.

I'm very cautious as well, and have been very responsive helping users
ASAP, even spending too often personal time like weekends, evenings,
and holidays.
The last report happened at the only time of the year where I was away
on vacation and had no possibility of having access to a computer and
doing anything, and right at the last 6.10-rc before 6.10 final.

So please don't assume or insinuate I don't care enough. I do care, and a l=
ot.

>
> >
> >>
> >> Thus I still believe a delayed work will be much safer, just like what
> >> XFS is doing for decades, and also like our cleaner kthread.
> >
> > Not a specialist on XFS, and maybe they have their reasons for doing
> > what they do.
> >
> > But the case with our cleaner kthread is very different:
> >
> > 1) First for delayed iputs that delay doesn't exist.
> > When doing a delayed iput we always wake up the cleaner if it's not
> > currently running.
> > We want them to run asap to prevent inode eviction from happening and
> > holding memory and space reservations for too long.
>
> But the delayed iput doesn't need to scan through all the roots/inodes.

And neither does the extent map shrinker, it goes through a small
portion at a time, in a dedicated task run by the system unbounded
queue.

And running delayed iputs still takes time going through a list. If
there are always delayed iputs being added, there's constant work.
Yet in this case you're not worried about adding a delay.

>
> Thanks,
> Qu
>
> >
> > 2) Otherwise the delay and sleep is both because it's a kthread we
> > manually manage and because deletion of dead roots is IO heavy.
> >
> > Extent map shrinking doesn't do any IO. Any concern about CPU I've
> > already addressed above.
> >
> >
>


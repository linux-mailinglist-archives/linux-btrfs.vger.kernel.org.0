Return-Path: <linux-btrfs+bounces-11088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6A0A1DC55
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 19:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7447116617D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866461925A0;
	Mon, 27 Jan 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E/CSiHnc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADF1917E7
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004350; cv=none; b=WWXMWuXHKHBYRm+W1Ni+i+8ubLhto+v6WOBcm8l3LUMb4KP3whuC8K491hnNc3QKyouiBwL7KLzmwi/V7U0m/cz4igs+yrmYqlgImg2gwq3B1l8uCp22hbBdyQlxvgSOPVsHP9rlZFFgWgPgUtOAh0DoY5Bo9Y4DH0WQrlW73Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004350; c=relaxed/simple;
	bh=9UiIaNfzctcNqHxnrhuVX7HOuZstcdzoUYmR9QGLZWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndsW+88o6jovnDHj9+kWIgnmA2xS6+s1hBwrbLT1IwLSqsZxD64NcPd2uz9KNZrutNmLtGP2hKkyqfh8oRONfNC97xaZknlEcd5brXnP6Q8s9ETK+i27J5ROHd0WrZgexmTzco48PsRWR974xoTXpSIx+FduMhiS890gOhKLb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E/CSiHnc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab68d900c01so407264566b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738004346; x=1738609146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDF8FBWI6Q4n9uctDkN/oiHddSWaPtO3tUfRruRSRjE=;
        b=E/CSiHncaXA29BQ0vb2oKgFXOX/MJL9QLCZ/47h8eRXA1n5Nz/Pf3kxdeFLa+KfIFr
         2rhzYuIfx9oa7F0nYpmtSuQFhKWxbwzyJiAgJV1NYt9G5I91PL8mv+k4zfmRMoqgAvTc
         GzpBov8o3Gv7wOx3g1esOMn4OwfZrXV0nC+aqtH+TSOtvTXpgl6oBFRtpymTCN7lh+bJ
         zEkZBRUG8vVxKFH4N+qGYZxIZr1COrGOAsnHGCHO/Eo711C5y38HH9+bJYuY2u53nxdm
         YH5Xsi8DpybLLJtOVmVx5ERb6pRmlykUVksNOYmy5yaLGva4BKgki5+jM15Hn/2KLnUf
         XTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004346; x=1738609146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDF8FBWI6Q4n9uctDkN/oiHddSWaPtO3tUfRruRSRjE=;
        b=MZRrttRleJ8WX6vxUrTvtf/G27AoWUcVsK8UMCM1ETpIRrS7mGppiSp1M440kN48tm
         gZpT0LllrKYS5ek54sNaQ00x+Fzt9q8i9Uq6acaeNbzdSNTt6zyuA/ir7K4Ihcqc1o1E
         siLR6lYJXOMYdPuD2BOAbGQCa/a4ug2RuWy/LF40TrI8HltztWsQfgWDiYRShDXt2SEQ
         Obpj9nLTDdSXwSpJ3iz8eoosbJtrW2Fs29RRACPExPWQx+MStE3D7ZWpX+T8Y2u0ucx7
         DbT63aWtHFBUcQZgE/PS9oPH7377AJAth0IXfQiA0F6FRD4paPI+BQ5GjbDqRxgcANPz
         +AOg==
X-Gm-Message-State: AOJu0YxWbS9euWL0w2ZOZBJxSg59jnUXzOdil2ebUDphXdJamv2vgHY6
	ehtjsHldCZXBKLmiSq7GVk8yh3xG4hb/fA8cLyi/BbBMEzFn1JuYXnFdoBosbzKYGTDZydD811G
	XmzYx6/Cc1Os8SYO+hyljY0AAVvQdzrxp4cO8eWMkEYX+DWy6924=
X-Gm-Gg: ASbGncuiYYoIoJe0C0s77juVxZiP2plNf1yNETpgre1hp46Vj32rxkhAv/RjJRTvjRw
	oB0nhYnt1suWEfmgASAVFhm/u/uLgqntUHyBX+kFDUBsyqsvS4qZKkPIrQSQA
X-Google-Smtp-Source: AGHT+IHkI8ydPUgBq5l5LiuVcPMla4jjz6tIQElJNusgkzrLh2gsfCYvvRHse/DAV5qIXh2vvLd/LWD5D80wlASuDsU=
X-Received: by 2002:a17:907:940c:b0:ab3:a18e:c8b6 with SMTP id
 a640c23a62f3a-ab6bbabe51amr36761366b.10.1738004346383; Mon, 27 Jan 2025
 10:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121183751.201556-1-maharmstone@fb.com> <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
 <080dca03-dd09-488a-b98a-5a107dbb76a7@meta.com> <CAPjX3Fe+LVLn5ghRUNGJt0=_gwjwKM+LT9qt_2S9-0c389kvmQ@mail.gmail.com>
 <293d2d0e-f0bb-4576-9f88-4133f370f933@meta.com>
In-Reply-To: <293d2d0e-f0bb-4576-9f88-4133f370f933@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 27 Jan 2025 19:58:54 +0100
X-Gm-Features: AWEUYZlV50EP19l_j_bhukQ4deJxDB3VCMwWmD963x4X_JzfWc0NxCAcu5zb9oE
Message-ID: <CAPjX3Fe+RX4z=NXi75xFEAnVmSO8if2sqis0Hzz6qXQXe+ZM=w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
To: Mark Harmstone <maharmstone@meta.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 19:11, Mark Harmstone <maharmstone@meta.com> wrote:
>
> On 22/1/25 13:02, Daniel Vacek wrote:
> > >
> > On Wed, 22 Jan 2025 at 12:35, Mark Harmstone <maharmstone@meta.com> wrote:
> >>
> >> Thanks Daniel.
> >>
> >> On 22/1/25 07:42, Daniel Vacek wrote:
> >>   > On Tue, 21 Jan 2025 at 19:38, Mark Harmstone <maharmstone@fb.com> wrote:
> >>   >>
> >>   >> For O_DIRECT reads and writes, both the buffer address and the file
> >> offset
> >>   >> need to be aligned to the block size. Otherwise, btrfs falls back to
> >>   >> doing buffered I/O, which is probably not what you want. It also creates
> >>   >> portability issues, as not all filesystems do this.
> >>   >>
> >>   >> Add a new sysfs entry io_stats, to record how many times DIO falls back
> >>   >> to doing buffered I/O. The intention is that once this is recorded, we
> >>   >> can investigate the programs running on any machine where this isn't 0.
> >>   >
> >>   > No one will understand what these stats actually mean unless this is
> >>   > well documented somewhere.
> >>   >
> >>   > And the more so these are not generic stats but btrfs specific.
> >>
> >> That's fine, I'll send a patch to Documentation/ch-sysfs.rst in
> >> btrfs-progs once this is in. That's what we have for commit_stats.
> >>
> >>   > So I'm wondering what other filesystems do in such a situation? Fail
> >>   > with -EINVALID? Or issue a ratelimited WARNING?
> >>
> >> O_DIRECT isn't part of POSIX, so there's no standard. Ext4 seems to do
> >> something similar to btrfs. XFS has xfs_file_dio_write_unaligned(),
> >> which appears to somehow do unaligned DIO. Bcachefs fails with -EINVAL.
> >> Nobody issues a warning as far as I can see.
> >
> > I mean that also can be improved. Or btrfs can just do better than the others.
> >
> > Maybe a warning is a bit too much in this case, I'm not really sure. I
> > just offered an idea to consider, coz silently falling back to cached
> > IO without letting the user know does not seem right.
> >
> > Well, the question is - If you take it from the app developer point of
> > view. What's the reason to explicitly ask for DIO in the first place?
> > Would you like to know (would you care) it falled back to a cached
> > access because basically a wrong usage? I think that is the important
> > question here.
> >
> > Imagine the developer wants to improve the performance so they change
> > to DIO. But btrfs will never actually end up doing DIO due to the
> > silent fallback. They benchmark. They get the same results. They
> > conclude that DIO won't make a difference and it is not worth pursuing
> > further. Just because not knowing they only missed an offset.
> >
> > That's actually where we are right now and what you are trying to
> > improve, right?
> >
> > What is more likely to be noticed? A warning in the log or some
> > counter some particular filesystem exposes somewhere no one even knows
> > exists.
> >
> > And don't get me wrong, I'm not against the stats. I think both the
> > stats and the warning can be useful here. The warning can even guide
> > you to eventually check/monitor the stats.
> >
> >>   > Logging a warning is a very good starting point for an investigation
> >>   > of the running program on a machine. Even more, the warning can point
> >>   > you exactly to the offending task which the stats won't do as they are
> >>   > anonymous in nature.
> >>
> >> But then you get a closed-source program that does unaligned O_DIRECT
> >> I/O, and now you have dmesg telling you about a problem you can't fix.
> >
> > That's why I mentioned rate limiting. Actually in this case a
> > WARN_ONCE may be the best approach. I think that that is the usual
> > solution in various parts of the kernel. And I think it's always good
> > to know about a problem, even when you cannot fix it.
> >
> > If you can't fix that problem the stat counters would be as useful as
> > the warning, IMO. Just more hidden.
> > And well, you can always reach out to the vendor of that closed source
> > app asking to address the issue.
> >
> > The only problem would be some legacy SW where the original vendor no
> > longer exists. But in that case you can choose to ignore the warning,
> > especially if only issued once.
> >
> > On the other hand, developing a new SW one may not even realize the
> > DIO is not aligned (by a mistake or by a bug) without getting a
> > warning. So being a bit more verbose seems really useful to me.
> >
> >> I believe btrfs' DIO fallback is more or less what Jens' proposed
> >> RWF_UNCACHED patches allow you to do intentionally, so it's not that
> >> there's not a legitimate use case for it. It's just that it's nearly
> >> always a programmer mistake.
> >
> > Agreed, and that's exactly where I think the warning is the most useful, IMO.
> > That's also why compilers shout warnings for many common mistakes,
> > right? Just my 2c.
> >
> >> Mark
> >>
>
> My concern is that putting it in dmesg will add to the overhead of
> distro maintainers, i.e. having to explain to end-users how a warning is
> harmless. And having once had to write a syslog rule to work around
> Citrix's chattiness, I'm not eager to inflict that on anybody else.

Understood. Luckily nowadays this is mostly covered by LLM chatbots.
Anyways, maybe a warning is a bit too strict. Even though it's
targeted on developers, not on users. Still, a misaligned DIO seems
worth reporting one way or another so that the 'buggy' application can
be fixed. And usually the more visible the issue is the faster and
more likely it is to be addressed.

Have you also considered a tracing point or a dynamic debug print alternatives?

> Plus any given piece of software will have far more users than
> developers; the warning is going to be noise for the vast majority of
> people.

As is basically any other line from the bootup. This applies
generally. I don't see one additional line making a huge difference
really.


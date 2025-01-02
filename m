Return-Path: <linux-btrfs+bounces-10694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7E9FFD4B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01788162D2C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B313D297;
	Thu,  2 Jan 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBEBO3ON"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8870814
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840719; cv=none; b=oTvypEeYZE+bpggse3ZPDULl5BBRKql2+8KBeT2wdrmRAg+OdKsaFyOPXjn1EpGUzLbhNj+VamI+51Oo3m6gimzuW86osVPqF84lC5fOvjBRwOKJQjNa8F6TozwZRn9Am384VO5AlPmdjkTrwcXgvBa1Xm/NIx5eW1F0xJNdtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840719; c=relaxed/simple;
	bh=7gV4ijYP+N0D/Q7GGbwpCK5JgjqkYt8YYHFkbzS5jVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLdH0aF+jzUNrowH/r5dfP4FckfGjLK1YAWxcuYDr5HjMzdBvQnxNFIJnGOJzDvX0QPS0JZ921lFToMnU6kNnxEkoP1ZDi01c1Tx7acb1ab1dDZDgY66wk3x6R9V/066Illkp29p5L79fWAS6+crYtO05MmyhAZsipfVOgl+PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBEBO3ON; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f44353649aso12946116a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2025 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735840717; x=1736445517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r42zW4foMWcebJ0RcIJUEwz7sOk8q/lj3bAfzgCtcLM=;
        b=hBEBO3ONuN/+/Ud2UZPbzQXIRj5VvrHDTsLo4Z1k4Z06BGnOZBBxhi4EBEYhXSq2FC
         JxSMUg3L6oMPMxWiAgYzzqGrPthoChZlDo00WAuL2HJXK8lsZoXzfEhiZnV+9Yklt53r
         n88oWV+EMJ8lOAH5DnvI2uQBbAVerqTmg5A3WrqSKXvSG3apNXoh++eyFfWZ4zllvDrc
         YDinAkcxZklYctCfxBiYLyLG9GNNLGsmtp6MjtEq8zMtwJ8G8IU14zohxK5kvFKDTixW
         eTInHdpQ83iZHzWDwxJsOhOQBLMeY688Vbu0VGQTu/X5x8xZRSZUi8K9eqU3ojJwpD1w
         rkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735840717; x=1736445517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r42zW4foMWcebJ0RcIJUEwz7sOk8q/lj3bAfzgCtcLM=;
        b=PuimUmnwcy0Db0G3RFAjLHtcxQz2f615a2xzCOKxzooY6X4X+a9yEMEfIH3jG+fScx
         UZNEVQkgH4CiOwmg4IAn9W4h/h1M6Ah8CBDXynJl3zcarc/44yT8bG8flfuadKdWR8gk
         runW+BAqBdLUUd2XB0Rct4eJCeLRXHR/11D2OvZFBM1ArjadpVOJIpad0GujfIqwkjy5
         Q5l+8Wb9kxt1VorBOvadXn1Tcy7t/3wjcjcOeYqwqTKKbHkk6Vrim2UeCSxTVqsFkYP8
         Zj8mYzhk5/6IjWItQr/X2lNqMQHTEB89dQNhL6BCv9U97VpZ9mB2m57zimJFaQP8ffJE
         dbyQ==
X-Gm-Message-State: AOJu0YwEZHaO23jtQTn+Qx4vlGLpuxnbNHKl43GsbAxMDKPlLZHIgMnC
	GQLEdZfIuEbvSbCL1+fv3VvPieAEoP9OIKLEILfRXK9DkLSc8xqX2WX1QoLeopmkGAv8yQCfqfs
	7yVi4hms3oGqWMgmyAorNIhp/LWWpmV3t
X-Gm-Gg: ASbGncvn4lJ6+HDDn/yE58vEWBlSIS2+hc/t8gju9D9B7zW2JOt+p0bgSJQXobZ2eA+
	yAI8OT1jTTUpFvA2rDNs5zeyrpw6sfpnzDJmVES+ZQXAcwueaUp4olWLMroVH+QPKGFLu
X-Google-Smtp-Source: AGHT+IGWx6JWFOZNX/WQT2yBfINGOWQZMACjS0O9bUUkqKppPNJBQs/GG8dDilyB4rzyd8ub8XMIWjP0cFgQPrCpozo=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f452ec6ed2mr58553050a91.26.1735840716896; Thu, 02 Jan 2025
 09:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJhrHS2b5fv7wmchdqkCy-jEWZ7hD_3YUgCO_oUCNaf9ossq6w@mail.gmail.com>
 <56d3885e-5651-4fd4-af6d-89897f8bd240@gmx.com> <CAJhrHS1xgfrp=Wpk18xCBGUEi2tYxaqCxrMQG5UEGSUbR4G-_w@mail.gmail.com>
 <d5372478-70f4-4a3c-bf9d-26366f955e5e@gmx.com> <2809427a-41f5-4b59-9d03-2c2012e16f76@gmx.com>
 <CAJhrHS3tE22AYSRjBLRC4vkdGaUxX-ibKoXt=K4RAvEbLq3_7Q@mail.gmail.com> <836179ee-60a7-446a-8cf1-54580cbdd5e0@gmx.com>
In-Reply-To: <836179ee-60a7-446a-8cf1-54580cbdd5e0@gmx.com>
From: Ben Millwood <thebenmachine@gmail.com>
Date: Thu, 2 Jan 2025 17:58:25 +0000
Message-ID: <CAJhrHS1B5nyFphU4kmp4KL_qqMKeh+B9GZ8E=ofeu-9rQwOh-A@mail.gmail.com>
Subject: Re: dev extent physical offset [...] on devid 1 doesn't have
 corresponding chunk
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

About three weeks and 97 million items into checking extents, the rpi
was accidentally shut down by something else I was doing, so I might
as well just try the fix now.

I tried to run your binary. It said:

ben@vigilance:~/btrfs-progs $ sudo ./btrfs-corrupt-block -X
/dev/masterchef-vg/btrfs
ERROR: failed to find the offending dev extent item: No such file or direct=
ory
WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D32768
extent buffer leak: start 217866993664 len 16384
extent buffer leak: start 217441599488 len 16384
WARNING: dirty eb leak (aborted trans): start 217441599488 len 16384
extent buffer leak: start 1789991600128 len 16384
WARNING: dirty eb leak (aborted trans): start 1789991600128 len 16384

(unsurprisingly no change in fs mount error message)

On Fri, 20 Dec 2024 at 23:51, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/21 09:41, Ben Millwood =E5=86=99=E9=81=93:
> > Sorry for the delayed reply. I left this for a few days to see how the
> > check would get along.
> >
> > I think probably the terminal I was doing the check in was resized a
> > bit, so the output got a little shuffled around, but it now looks like
> > this:
> >
> > root@vigilance:~# btrfs check --progress --mode lowmem
> > /dev/masterchef-vg/btrfs
> > Opening filesystem to check...
> > Checking filesystem on /dev/masterchef-vg/btrfs
> > UUID: a0ed3709-1490-4f2d-96b5-bb1fb22f0b45
> > [1/7] checking root items                      (0:46:43 elapsed,
> > 68928137 items checked)
> > [2/7] checking extents                         (14:49:23 elapsed,
> > 2419[2/7] checking extents                         (14:49:24 elapsed,
> > 2419[
> > 2/7] checking extents                         (14:49:25 elapsed,
> > 2419[2/7] checking extents                         (14:49:26 elapsed,
> > 2419[2
> > ERROR: device extent[1, 1997265698816, 576716800] did not find the
> > related chunkhecked)
> > [2/7] checking extents                         (164:06:57 elapsed,
> > 34215503 items checked)
> >
> > so it looks like the check has noticed the same problem that the mount
> > has, at least.
> >
> > I don't actually understand all this terminology -- is the "items
> > checked" number for checking extents counting towards the same total
> > as the "root items" number? Or is there any other way of estimating
> > how far it needs to count? (Obviously using that to estimate time
> > remaining would be highly approximate, but hopefully I could still
> > find out if it's measured in weeks or years).
> >
> > On Sun, 15 Dec 2024 at 04:46, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> Do you still remember if there is any error message for the
> >> clear-space-cache interruption and the next RW mount of it?
> >
> > I can't say confidently at this stage, but I think there was no error
> > at clear-space-cache interruption time. I think it's highly possible I
> > could have missed an error at my next RW mount attempt, I was probably
> > trying a lot of mounts and often only paying attention to the part of
> > the error I thought I could debug. (there has been no next
> > *successful* mount of this disk, RW or otherwise...)
> >
> >> Thanks,
> >> Qu
> >>>
> >>> Meanwhile I have created a branch for you to manually fix the bug:
> >>> https://github.com/adam900710/btrfs-progs/tree/orphan_dev_extent_clea=
nup
> >>>
> >>> Since the lowmem is still running, you can prepare an environment to
> >>> build btrfs-progs, so after the lowmem check finished, you can use th=
at
> >>> branch to delete the offending item by:
> >>>
> >>> # ./btrfs-corrupt-block -X <device>
> >
> > (I have been able to build this but haven't run it yet, since I'm
> > still waiting to see if the check says anything interesting)
>
> Please go ahead. Weirdly this error is really a single orphan dev
> extent, without any extra other problem.
>
> Thus that command should fix it.
>
> Thanks,
> Qu
> >
> >
> >>> Thanks,
> >>> Qu
> >>>
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>> smartctl appears
> >>>>>> not to work with this disk, so I can't easily say whether the disk=
 is
> >>>>>> or is not healthy.
> >>>>>>
> >>>>>
> >>>
> >>>
> >>
>


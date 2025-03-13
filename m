Return-Path: <linux-btrfs+bounces-12257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854ADA5EEBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94ED16B499
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F802641EA;
	Thu, 13 Mar 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KczDa0s6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B15C22F163
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856464; cv=none; b=tIv+4ot/P0fEe8fdNQ+RSDaltsB1ZHPiO6/Dz+wts0ehqb/ZxssmFzS891D/wwwGH8ayvVKVWWdLavZK8b720Nqu0BvdCzOCZh4p7qaWnm+8MbKlfTJxPC6+w2DATN8kwERlLESOTsZJs9NrXIMb9g3ki45fbjHuS0LGxpVxTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856464; c=relaxed/simple;
	bh=GQ+KOmzAZ1BMISGMC8OywzwUiJC3V2gKf8ZV2UdbDAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4xcfGNchVpbNJ1iDXiQF8x+AOWYgL8CXlC2LUJ9pbLQPSNDky8trTOTzjRzjUhoDiqZaQiKSnISiLPhj0kpWXG5KJbTQFAs28KCJSnXyBS/dkW1lTyXawzp4Dwu9j8nxRnLPr66/kCgmQymHdD/VXpIjpc04hRSTfqqA7gEbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KczDa0s6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1110428f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741856460; x=1742461260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Q1i2eGa0lIHnKtjtWYNPTUwVrANGD1YisS8qEK5cg=;
        b=KczDa0s6taqN9ayfUp00ckRvsK5mnH/TJso3EXk/AAlA8UEqyl+0s2+Yy404xC5D91
         e/rzSnLltkk2TqMBtBPN9/8+1euUwVVKtPa2qjX7TiMWBnPR+xGhMGOiPhcodozoShK0
         6UE70ykqfbHwlFuiwrUAIpC82tCwG1gJCK3x0cMK1Q4k4zdizsXBNvkkPMcGb9+lh6WT
         16NgnAiw2j+xKZ1O93HnYQ0l2bL2Nw6MoAF7PIsC1v3NS1L5E8Ct5cyPaF997BNOw1c9
         owYOq7e3VLaUnpPpj1R+zt6ZhhDSoO+ksrez/PDvRn/cl7gmxFbY4IISen9GStlFsd63
         78LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856460; x=1742461260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Q1i2eGa0lIHnKtjtWYNPTUwVrANGD1YisS8qEK5cg=;
        b=vTwzN2X1+o4km73PmOo6Ze+Ayd07Gs0HmAAyF1raxSw8cdKtjScbiERrxjC7aVKb2p
         ROzf9gEp5ysXMFY1bhj7gi0eWAnnAU3Ay808WyQzDgeVS2GGOatU0boByqQd9QrKCQj1
         /SXD/zdAIdbVVJEhkkhQ/RX0yCS1D87g2tCzIgQgxtk28xpwKaNhP4EhCWAQHOTU9MwV
         VSQUElX5bn4LR26/TO96dsv1GPD+DgkxMOSGDtfcoRlSxqkFHWuT2J/GZ41wLC5o58Ua
         5VYgtVht5qTpaKv829Gzx1rsf13ER/Q8p65in5FrSLZ+17T3YF3guGSS5Ul7SBVKEC3s
         OaRQ==
X-Gm-Message-State: AOJu0Yy8Iygyn8643WPwQZJ1RR1+l/DqsVofPX1D0chuyKzM7KSqHrgN
	hP5RZeXO/BgCfzr7/3H8ouG04biw+HuxfZ8nd7oShJskqClhI3ZcYYh4C/2TWckBWbgubN+0XWc
	BVCPITd1Jt9n5Dll8dTOHTI4fbAE=
X-Gm-Gg: ASbGncuNa4areyofeooh04ZD3adftJpTZdFQFxBJMnaPCTh1MFBKJyVER1mYF6Vxitw
	knVcGwzdOqnJ/XXt99opB3xjg14/VAkzf2NrhVxbcfZAq5KYPRHfocNHFTcMNRc9xPkz2rEbWWE
	YVphr/VHhGI1Z15dAYff0FyA==
X-Google-Smtp-Source: AGHT+IEyBznlhgpqQsvD3vTMBroeoKVyPusyYZKq4xU6Wfj0IqN3SwM6TIiuTiBh5tS1s2exUFvzq79l40FItsMPW9M=
X-Received: by 2002:a05:6000:2ad:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-395b7397309mr849312f8f.3.1741856460369; Thu, 13 Mar 2025
 02:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com> <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com> <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
 <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com> <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
In-Reply-To: <76e81f2c-17fb-4c11-b1c4-0b4c18b080b5@wdc.com>
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Date: Thu, 13 Mar 2025 17:00:49 +0800
X-Gm-Features: AQ5f1JpycWNLcy9h-JFvf1J7huvvm2E3i8y4zCI7Ib6LolI9vf6zoVy8ATnHBBA
Message-ID: <CAB_b4sBkBOMCpbsf4hmC+wnL9FiH3vk70mq+QrZEAbb8Jfw=jw@mail.gmail.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	WenRuo Qu <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Because this should end up in initial=3Dtrue and not hit the if (!initial=
)
> condition.

> The question now is, why it doesn't.

I read the code again, when btrfs_load_block_group_raid1 raises the
warning, it will return EIO and in btrfs_load_block_group_zone_info
the EIO is handled by setting cache->alloc_offset =3D
cache->zone_capacity;

    if (ret =3D=3D -EIO && profile !=3D 0 && profile !=3D BTRFS_BLOCK_GROUP=
_RAID0 &&
        profile !=3D BTRFS_BLOCK_GROUP_RAID10) {
        /*
         * Detected broken write pointer.  Make this block group
         * unallocatable by setting the allocation pointer at the end of
         * allocatable region. Relocating this block group will fix the
         * mismatch.
         *
         * Currently, we cannot handle RAID0 or RAID10 case like this
         * because we don't have a proper zone_capacity value. But,
         * reading from this block group won't work anyway by a missing
         * stripe.
         */
        cache->alloc_offset =3D cache->zone_capacity;
        ret =3D 0;
    }

The zone_capacity is set in btrfs_load_block_group_raid1 before
raising the warning (and return EIO), so should not be 0.

In this case, to my understanding, cache->alloc_offset !=3D0, but in
__btrfs_add_free_space_zoned initial is defined by

initial =3D ((size =3D=3D block_group->length) && (block_group->alloc_offse=
t =3D=3D 0));

which should be false, that triggered the null deref?

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B43=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 14:29=E5=86=99=E9=81=93=EF=BC=9A
> Is there a chance you can try to recreate the bug with the following
> kprobe applied?

Will try to do if have the time. But can't guarantee will reproduce
the issue since the content on the disk has changed since. And since I
am on trip so following is only possible when I get back, sorry.

Best,
Qiyu

>
> echo 'p:myprobe __btrfs_add_free_space_zoned block_group=3D%di length=3D+=
32(%di):u64 alloc_offset=3D+520(%di):u64 bytenr=3D%si:u64 size=3D%dx:u64 us=
ed=3D%cx:u8' >> /sys/kernel/debug/tracing/kprobe_events
>
> afterwards you need to enable tracing:
> echo 1 > /sys/kernel/debug/trace/events/kprobe/myprobe/enable
> echo 1 > /sys/kernel/debug/trace/tracing_on
> btrfs balance start -mconvert=3Draid1 $MOUNT_POINT
> echo 0 > /sys/kernel/debug/trace/tracing_on
> cat /sys/kernel/debug/trace/trace /tmp/trace.txt
>
> and upload the trace.txt somewhere? And the dmesg as well please.
>
> You might need to activate ftrace_dump_on_oops via:
> echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
>
> Thanks,
>         Johannes


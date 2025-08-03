Return-Path: <linux-btrfs+bounces-15815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F07B19505
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9FD7A7598
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7401DF742;
	Sun,  3 Aug 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0Z3G3Tc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65399C2C9
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249926; cv=none; b=dmODV2mHpXnuqGJNrTGY+T6WDUThXYOZFfP36eqYz4/ZvOuYi4UmhHXstiskZL7WnnjSPY9O++QeD/G0bbFP6s1ObvYkz4MjKuDKkB/HD5SOCLCH1JsB9F61SNI/NtDjvC5kPshNb7wfCRQeGz848nWlrYwruLy3DbhqZ/Xz/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249926; c=relaxed/simple;
	bh=aJPSBAL1il7SVVPZwgPx5ZR0cTnyclrCwTW+afFPSNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq9el9kW62lWjRDzS3gc64LyNn2DGjroUyH7+N0Rf0vo81XPYNdJrvNdwIOo/sx9Cazzq6wdFU8iOH/uiIIou8S4TDGOD7l5bVFmMqsk5QQgNr6PsJ7vLu72ibDZLnXJ//daYNZAvfEyjBoseAVhyM9mevMdw9RmlxoDAvpDAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0Z3G3Tc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7180bb37846so23516447b3.3
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754249924; x=1754854724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJPSBAL1il7SVVPZwgPx5ZR0cTnyclrCwTW+afFPSNQ=;
        b=O0Z3G3TcPn7uT7X1soKFrZ8Zw4QAeFbUWA0doTzsDA/DKdu8aOvo02FUluigTD1Vbe
         nvRg6HWTyy4UzFsEMqPBPfkUyITz2h4lAtvYliQAxg5EOmHtHbP7sQTVcLAgoVGrNJF2
         dzP6iKTulp5WgUSmmiDGnDL8YDzTdgOeho+MZpeWASqEeJE90A+z5LgPGO8aDPLnTRhO
         HSwTPFl4Sj2q10kF8bjBvWZVqzaSetiy7saLoAYN30XY9QCIoKYaFAK5siBwIHZxKgVP
         Mx00Kpgm6mUY0aRdU9LF2EbRlBevmbQ98ywmupEkXIaDp6b4uaoEOn1cD58tzwBLSpYe
         5DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754249924; x=1754854724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJPSBAL1il7SVVPZwgPx5ZR0cTnyclrCwTW+afFPSNQ=;
        b=W/4jjvg8GaDWrw7v+DzshJxT11k8nBgH5dpzk4LILOFQO33Xci5Ms/52LJDMzcv3Xf
         ln9ypEtckippGbZ65kAccETG70IvSUfOZxBhYqjzgQlnbcbekGH48TP+UXEYI9DYa7nx
         O7AiItU5efZqU6y7aMrnUJ4brSTnC5OKyoZ0XI7E0T9IbEQx2KACqX6HeSgvnbS8SkXj
         Zq639vM3J8LDQzA+KPIy+GLbDZfk01S+che1+3+6X627VAyHUjBaEJyJr4OK0z+mNgHb
         LgvBBJNfMUU40HHkyyFBNPzHO9xTAMVzZLE+T9tZ63g+ngkZ7aNZ9bHykZIlgKzJIq9N
         og4w==
X-Gm-Message-State: AOJu0YyyYIwikLukO/wx1MIC3luRTc16F0aMoSoMVvQAdfQhxDtfncDE
	ccaaP5GyQo+sffnFuxCvsCSWT5augnTVQjkQ193icxzhm2PkaQekAdDSzrEz6tkPboVTjMl7KG0
	PenXTzR4Es65cShIMiFXY6jhY77e9q/g=
X-Gm-Gg: ASbGncvkKBA9TFtl09G97r7w/V39OGoEgenKe4HZyMm9+uI/G8MuuGJdeVDZDuwlFUT
	DDjFCBHdS+fhNpuq5GWgvveV62Gm8XuZqtHAME0JQsmwZtCRPRCrMnuArGWpHDJSwWvZ5WDhJW8
	Sau/iq9yGhrlPUztqeBHTdZOEAWQNMbeH+Ic9YFHvRsltdZ6HYX9roTRQZJjb2JfU5IpdJkQApE
	BU0B/E=
X-Google-Smtp-Source: AGHT+IFHvnp3UAQaCVEUyZt+sfdyLr4DXZLMBqhsgbu5NHumE7Ztnl1S94WI6oMSSU0uwE64H94hghV+xUUKk4nK0vk=
X-Received: by 2002:a05:690c:110:b0:71a:1e72:84c3 with SMTP id
 00721157ae682-71b7ecda924mr86323517b3.9.1754249924278; Sun, 03 Aug 2025
 12:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
In-Reply-To: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 3 Aug 2025 15:38:33 -0400
X-Gm-Features: Ac12FXwUHwHZmuFx4VAe_H076VEzM7OENRVQtaSwecsjKBedB39iIMjdBZI7A2s
Message-ID: <CAGdWbB5PUw1gGy9PaOdYn14OfKH8NhO3WOMt_2axg1589t8OJQ@mail.gmail.com>
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Qu Wenruo <wqu@suse.de>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu,

First of all, thanks for your work on BTRFS. I also want to thank the
entire team. Regarding the device opening restrictions from commit
e04bf5d6da76, I wanted to check on potential impacts for btrbk, a
commonly used BTRFS backup tool.

btrbk's documentation recommends mounting BTRFS filesystems with
"subvolid=3D5" for backup operations (see
https://digint.ch/btrbk/doc/readme.html). Many users following this
guidance mount the top-level subvolume specifically for btrbk while
also having other subvolumes mounted for regular use.

While I believe typical single-filesystem scenarios should be
unaffected (multiple subvolume mounts from the same device), I wanted
to confirm that common btrbk use cases won't be impacted by the new
restrictions. This includes:

Mounting subvolid=3D5 alongside other subvolumes from the same filesystem
Multiple BTRFS filesystems being backed up on the same system
Any network backup scenarios where device access patterns might differ

Could you clarify whether btrbk's recommended mounting patterns are
compatible with the changes being considered now?

Thanks for considering the broader ecosystem impact. Have a great day!

Dave


On Sat, Aug 2, 2025 at 3:12=E2=80=AFAM Qu Wenruo <wqu@suse.de> wrote:
>
> Hi,
>
> There is the test case misc/046 from btrfs-progs, that the same seed
> device is mounted multiple times while a sprouted fs already being mounte=
d.
>
> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to
> opened btrfs devices"), every device can only be opened once.
>
> Thus the same read-only seed device can not be mounted multiple times
> anymore.
>
> I'm wondering what is the proper way to handle it.
>
> Should we revert the patch and lose the extra protection, or change the
> docs to drop the "seed multiple filesystems, at the same time" part?
>
> Personally speaking, I'd prefer the latter solution for the sake of
> safety (no one can write our block devices when it's mounted).
>
> Thanks,
> Qu
>


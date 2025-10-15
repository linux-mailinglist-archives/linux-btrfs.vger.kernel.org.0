Return-Path: <linux-btrfs+bounces-17820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E257BDD458
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B1BC501D83
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261A315D47;
	Wed, 15 Oct 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrvzH9IV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82C315D39
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515190; cv=none; b=uZZkney1B388TplmXw11uvgo09YaRp798hkdqxzMiGs9u0qpVfj78DthZ6uBaVykloygE+qzcK+n1k/0L8hrfZGiFfUEq8JuYFsiVYK2zybBMZ94qIhY602Q/GhJIfTKx9xmD9t+xDuEbS2aDnzmtQmPN4CoMMaDQNlUhakrJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515190; c=relaxed/simple;
	bh=qo5hzrJsMWv+0R4QY8p6LXvmKvrjRWFf1Yx0WADmTHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANqc3l3gkZH2fzh4f1Tf8kNJZ1JitiwwjaxuDnPKTbLnQR4PsKRpbuBN3Iwwg1aI7blJLHwGGa3Ww9rCT3lvy+lvjZkPW+LtSyQGI697xPdl4W7QrTaDoQNKpYsbmkI67c85cRFfPZD4RjiEgT3fBocMVU0lVcP7iYvHsLKi/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrvzH9IV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-781421fdcefso23707397b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760515187; x=1761119987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo5hzrJsMWv+0R4QY8p6LXvmKvrjRWFf1Yx0WADmTHk=;
        b=PrvzH9IVKsx1nj97E0zAu2giqpRLihVnWjacVL4YCXsoWQkcLk5lzlWn7h7UovZm7C
         P/wYBXD3Msjq/57LR3erwijERgZh0W6MvskovcxOMfcLnvCnjRic4JESQ1XoGybCTKxP
         CNvHK9cUA6YpWVtPAX1vDgBxaRtjoJUgATYj1tH1+KJYawNKTWoGZC+XyjIhXSW7Pl1N
         E8ej5llENzFOIz+Bx/RDFBuxTGaFjWCEyg6+2jQVSObu7lxm+OoOJRC67GHaTbiZWtGp
         Ntb1U6rrX2pJ8lRPkmH/NY0MTX3Xga3OJbbYuUKldCLqR5fg6uJF5VJlMeA2ylmxvi/d
         K+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515187; x=1761119987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo5hzrJsMWv+0R4QY8p6LXvmKvrjRWFf1Yx0WADmTHk=;
        b=Qv5WJ96eetTmhLDWDQY/RG3OMHJcoN4pa43zQZzKPm2HuCznC9pJdpyLsBZfZh4x1I
         /yIISW1fiQKJXla1B/TctMfDubEUZ4mMCHOI6Fq0WESZzbDODe6fRL8cb+/hDqXZsIKw
         7WZSauX/Y7FVy7NzTQofCz1TbpMO+7KCUq2XZH8uCWYLibdCWCxCIVXbwDmfX+w+3LxT
         9xPV8/3PNQpLYNfIJZqNBJSh2LE0Ab27OSPZkBH6Cw7tYMZyavk7CNJx8sm6yFBf7hyL
         mPjQtd2QiJoiphr9ZnKSpDxItu/RW8oL6B6mHg3U80Idj9m/75uS5dx+86zv8zbn9G5f
         r8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2QAbQtqSopRH/SgN3Bw6hhkd7Hb2rrp5y9zcazfX1XBMKenNqQjOZaF3Dv7KvFkICC9J3H/RrkUuhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkQsTqYvO88fkcPzde7thBgHZXXVPlWstlNJhed9BRmsp+hNT
	nFKd2d7WHqDQOuNU4BgNjZ8sAe/+P9iS0N8QsQUz3Td6DdWjjGyXyTlCqmY/A3b2Fq5+lMoxMZN
	rq9z+cgOtmoKMlfCyHPlpLer+uByZyCU=
X-Gm-Gg: ASbGncuaLnX87uM2VbQRbF8t7H6nRgY4xb02ops0HRSZiOOxI/83eDu16ByrcHLhu1I
	6+5pBf/wpzN74FBYKUXWvoPxkjVPgnNsVf0V2g/X9auwyqw2arVWBs7599cAxlHwgv3iQ5Fua5u
	j24ZYWo5P2bMMwEh9QQHcwLjpNA5hUhlFrmWEvyvaHPM6MafogMdAisyL4CB7bBrE+uHn/5HE40
	QrDv49LXm7lQ2dof1O10DdbjDXG1CCBeLJqB3Xy
X-Google-Smtp-Source: AGHT+IGbBOiKw+MkdFgI/07rSe3Y/gAMehYXtP91sOiZpULZe+J7Goo/xbLnfNZ3Rx9OiRM//RAqKkR6yZljcGIm90s=
X-Received: by 2002:a53:a14b:0:b0:604:3849:89cf with SMTP id
 956f58d0204a3-63ccb8655efmr17588053d50.11.1760515187518; Wed, 15 Oct 2025
 00:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <20251012082355.5226-1-safinaskar@gmail.com> <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
In-Reply-To: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 15 Oct 2025 10:59:11 +0300
X-Gm-Features: AS18NWDhInsTqWiz4CfYTsNFgy2vREaqnckZiHJxlmFB5ZJkbNsQuh3HAQO3mpI
Message-ID: <CAPnZJGBAGO7bmiuL32YW-nq2Ycqy+EDXtfRhYCiiJX5YGxDWuQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org, 
	Chris Murphy <lists@colorremedies.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:00=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> Unfortunately the delay (19s) between the freeze request may not be
> reduced any further, the current check timing is for each full stripe (64=
K).

Personally I'm okay with 19s delay. But less is better, of course.

> But you experienced a full 60s, which I can not explain.

First systemd tries to freeze unit "user.slice", and then it seems to
perform kernel sleep:

Oct 12 10:54:49 comp wpa_supplicant[1108]: nl80211: deinit
ifname=3Dwlp0s20f3 disabled_11b_rates=3D0
Oct 12 10:54:58 comp systemd[1]: NetworkManager-dispatcher.service:
Deactivated successfully.
Oct 12 10:55:49 comp systemd-sleep[2191]: Failed to freeze unit
'user.slice': Connection timed out

systemd tries to freeze that slice and then times out after 60s.

And I think that 60s is unacceptable delay.

> Please try the attached patch, the idea is still based on the older

I will try. Hopefully today. Thank you!

> Thus it should still work without freeze_filesystems set to 1.

Kernel devs plan to make freeze_filesystems=3D1 default.
So we should not care about freeze_filesystems=3D0 case at all.
I'm okay with manually setting it to 1 (and it will be 1 by default anyway)=
.
See https://lore.kernel.org/all/20250402-work-freeze-v2-3-6719a97b52ac@kern=
el.org/

> please do not test any relocation yet.
I don't use relocations. The only operations I use are scrub and trim.

Also, I noticed that poweroff takes a lot of time if scrub is running insid=
e
of systemd service. Systemd is unable to properly terminate that service.
Systemd tries a lot of time, then times out, then poweroff reaches
"systemd-shutdown" stage (which is very late poweroff stage),
then "systemd-shutdown" again tries to kill "btrfs scrub" and then
(after lots of time, again) the system finally powers off.

--=20
Askar Safin


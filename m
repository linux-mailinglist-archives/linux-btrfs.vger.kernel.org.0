Return-Path: <linux-btrfs+bounces-438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CBB7FD84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B639F1C2102C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA3208AD;
	Wed, 29 Nov 2023 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M73kcGgo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA2B2
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 05:38:25 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58dc6afb526so11248eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701265105; x=1701869905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSuVINa7K9SgwjWe2TNSyViX7DTnFOvAQXerkwow0b0=;
        b=M73kcGgo9zCufsobELtUglu3zCvy60YCWBtmr4nzQrxoQePxQ3vKA1a2jC7+QPPORD
         FqtMyOhp0N3Axu0bgWtDYOIt+D2ps6R2X6mzIzaT9YigeduCUUWTyrV0Vxfnxiwydhwv
         oe+8XGG98RaaxLQuujMb8gSFk0yKV7pL++SURgNuUXFeVJIoFqh91pj4b/xZUq8Fx8Uh
         yEYiJGZwDk7NXLofC95JgfXW9t5HbRRr+iARBiS5Lg4V6m8dDti9bBsivp0A/dD3T75y
         HvWVFXfM6cuhYMukXJ+58lDtVHAzTkQwjRN6EHNb9qR+0VehnZL8FH1FwoONPFUFOwHu
         OY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265105; x=1701869905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSuVINa7K9SgwjWe2TNSyViX7DTnFOvAQXerkwow0b0=;
        b=cDMP8Ma6dWs6WyXfN0Mosb5z4GwCkKkV7hQigaBYLYNrUVra/hY56iKC17weUZKDqi
         Ka1aCIKvJxPYBV7/q7PpkD4adK4CTboC+l1rwrGNHMhnyI86u8FSG1qn/DfbdwJ1qzHE
         /LXuVQg1ia0x8sC9V8DbX72AvTVuQgrTdB0Y3soIlL00VuGcYQG9QKJohQa/KV1l3zmy
         ynXgOixdipw48S44OEzjB7SmkEQC5ViSGzdOW36AP1qjMLlmyH1y0+Q2zpYymZFujOlj
         PNjVhSkz8SHnCd14iJ+85rcn4H9xgazw3XzY/K75c0BQzuZhDHmzqt3rnzFrxVlz5S3Z
         OsdQ==
X-Gm-Message-State: AOJu0YyP3IyDNv0tVkUpGNc22sQTPjNj7VRqd1CGItHPwiLbaWdVrJQJ
	byPixkkaSxKhjqFXKpIMIwR3XcSEjZsdXTQ5f7o=
X-Google-Smtp-Source: AGHT+IGY9CLVGNwcg81kRDdHUS3eeYWxcMkFSJ4lMY7aAmWyhLbloCiggAa32D/KL/jYQ5yBHr5oXIQiCvAXq/K4dLw=
X-Received: by 2002:a4a:e89b:0:b0:58d:8879:7005 with SMTP id
 g27-20020a4ae89b000000b0058d88797005mr9271604ooe.0.1701265104784; Wed, 29 Nov
 2023 05:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz> <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com> <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
 <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
In-Reply-To: <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Wed, 29 Nov 2023 16:38:11 +0300
Message-ID: <CAA91j0UMvy0rtW8yr__pfq3LVQ9m7yJdkB0X2p86pn73dEgEBw@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
To: Anand Jain <anand.jain@oracle.com>
Cc: kreijack@inwind.it, dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:28=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
>
> The display-devices-list in /proc/self/mounts method simplifies device
> listing, bypassing the need for sysfs or Btrfs-progs and it replaces the
> lowest-devt approach proposed earlier. And, yeah, all multi-device
> filesystems would need a special case handing in libmount.
>
> Udev's /dev/disk/by-uuid, gets updated upon an (over)write sb event. I
> don't know its updater, it is not in util-linux,  I find no rules in

Today it is 60-persistent-storage.rules which is part of systemd.
Currently the logic makes the last device claiming the same symlink
win. There was PR to keep the first created symlink, but it caused
some regression test failure and was reverted.

> /etc/udev either.
>

Packages install rules in /usr/lib/udev (may be /lib/udev on older
distributions).


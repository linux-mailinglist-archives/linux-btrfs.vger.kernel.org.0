Return-Path: <linux-btrfs+bounces-14080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C960AB9BC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7D168C5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6EB23C4E7;
	Fri, 16 May 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN93aDvv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90268239E6F
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397792; cv=none; b=mInVQQaQ8D5Sh+5nlAUp7flLioimMHKQxNkCKMmXCPS26xbXSHhQVi19HGFyEKgZkqKCiSWf9YSPDWHAq8kC1iqkNImR4lcqZ/SU8qzUD987cmYx4fAsNmkWgW6yuEW9B8ZuDzwN27lA3Rx6lLcjZQt7nXTdIlzD/P5+lHXZGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397792; c=relaxed/simple;
	bh=xgbfn553PH/l8EdxaBoO7XKbN1CJe8Dp7dtKLrbO7GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU8FttFTucdBmgX27uO4PtUruVrdruaodQAOqdNwDirmlesi36Wlj75QW/XL6+uNju24ZE5aRJVp948V9YpvWX7l4CDE9o8dMxoFRhzTnexwAIQFUXuvPDGKzx7iy55k3KcxmYwIgEB07R9QiP37rCNk1H4z4G21VOowTJxR4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN93aDvv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-550e505538aso1324331e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747397789; x=1748002589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEDlbelWBatiP5kb97rZXCgGCoKlB4wWbEKmRY/0Dzo=;
        b=CN93aDvvXkoev7ckUFp+pYF22acLEmwoKhCsg5YXvnhnhO1uiRczFC6g3eG3eGL5SI
         yqdOF9diwo4OgKKUs7+cCPWd05pFT2gAErsm6xk6mSZLvVw8WKvA2LE8QT3meMLkUJQP
         fTPkhQ8iBJaRHt4Bua7+0dX1cwM8DvQb7kPPCxVEuYds32qKXQi2QvBxY9rE+jho86hF
         erA9ZqwUpxpYaqBLbGaJ7X8AUMIGmIyMPIPIGsJ2rMWper105zLQhqxq3YA7BbLpvDJ1
         Q0/lkreGSi2UFVPDIVrJt98KDqzV8dulQhGuHOnKC63GLZzbXhkFkQlkYEw6fp1HtS6X
         /IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747397789; x=1748002589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEDlbelWBatiP5kb97rZXCgGCoKlB4wWbEKmRY/0Dzo=;
        b=UvuvX9Rb6YiiEr8l3xrwSObRWzJ96Bnsdyn9SaC5nMT0Pt+lmQiU6ut+pRADJBj5xl
         UB59EKZXF+ioBqT6fiV9dxTW9FpVdvg87NPzo8TgteBp01izl7sDwI4L7ZrYWZMyMMSa
         nxE2mHBhTI75aJxj6Q++yfHhtibCsL1arqWcKFhI3seeqq5ezmFZj04FbSRfnrXFqRk5
         z3ClJLgueBk5VTwtbrz+RNW1+toohdEU27al31UbzpNONkc/+MoJMbDTEaq7tTYQAPp9
         CxjJqqMWTewrJTNbBTSL34BIO73ayMeMqgJXfXRczDzt0N0WkBJ/QFgprnj77LrXm5UN
         Jntg==
X-Gm-Message-State: AOJu0Yz/XW8Nv4DF/+mgWkSd4hGLAg99hfjyVqsf6cbjzKREtJbuezoy
	anEpTjRho6cLwmoQHYeI280AiyP+djTLaGtEtOe3q9mT+6FiA4xS+wh2f5uwwK3gXuo/7S3xN5K
	1LFCS/8PX/WLTz0z41Vr5ydh0vlXSJcdggQ==
X-Gm-Gg: ASbGnctXt3ccDvubrMsVH6BBJouBColUVWNhEq6tyjzOImqJDKlP53oxCglHQzfKKjq
	k/c3fXl44qypHRied0DLmqOes/p2voxpTVT7ECcEHuZ6HUAYfxmuRV0CKc1PIaP+kkFJq78m5mM
	gTm2tZ8meDzMuWOprP1XxYpjXktV1GjLoL
X-Google-Smtp-Source: AGHT+IFRgekHpQ4/ZlHrZsR7g1InmUJvJxTIAp3rspxJcZ81LYa+iohpmJWSeESgkfbUe7KZoznuP3WuLyy3vHBUkWU=
X-Received: by 2002:a05:6512:3e09:b0:545:3035:f0bb with SMTP id
 2adb3069b0e04-550db97d292mr2482677e87.22.1747397788296; Fri, 16 May 2025
 05:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
In-Reply-To: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 16 May 2025 15:16:16 +0300
X-Gm-Features: AX0GCFsfX6lSNUcIkbsDBKkHXsb80W1l2Ty3PHX4yIN7gDblD4EW6-hoznhW4x4
Message-ID: <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
Subject: Re: Snapshot send, modify, receive ->
To: Leszek Dubiel <leszek@dubiel.pl>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:07=E2=80=AFAM Leszek Dubiel <leszek@dubiel.pl> wr=
ote:
>
>
> On main server there is a subvolume "mylap" (as my laptop):
>
> # btrfs sub show ../mylap | grep UUID
>      UUID:             586996e9-8dea-454d-9a21-ddb414e90ce7     (1)
>      Parent UUID:         8879b3b8-dc33-4941-bd0a-4f1ab1d1fbf3
>      Received UUID:         -
>
> it was snapshoted read-only:
>
> # btrfs sub show 'bak-first' | grep UUID
>      UUID:             3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (2)
>      Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7 (1)
>      Received UUID:         -
>
>
>
> and transfered to backup server btrfs send/receive.
>
>
>
> On backup server it looks like this:
>
> # btrfs sub show 'bak-first' | grep UUID
>      UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665     (3)
>      Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
>      Received UUID:         3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (2)
>
> See the same (2) of "Received UUID" on backup server same as UUID on
> main server.
>
>
>
> On backup server,
> subvolue 'bak-first' was snapshoted read-write as "mytest":
>
> # btrfs sub snap 'bak-first'../mytest
>
> # btrfs sub show ../mytest | grep UUID
>      UUID:             79370999-3114-e545-af15-f1b6b9d74506     (4)
>      Parent UUID:         9ad9ede3-f11e-b144-ba12-3f69dd14e665  (3)
>      Received UUID:         -
>
>
> "mytest" was modified, then snapshoted read-only as "after-modif":
>
> # btrfs sub snapshot -r ../mytest   'after-modif'
>
> # btrfs sub show 'after-modif'
>      UUID:             e7cfb051-10c9-424f-87d8-28b9d5dd6caa
>      Parent UUID:         79370999-3114-e545-af15-f1b6b9d74506 (4)
>      Received UUID:         -
>
>
>
>
>
> Now I want to transfer 'after-modif' back to main server,
> and I get error "did not find source subvol":
>
> # ssh backup-server 'btrfs send -p "bak-first" "after-modif"' | btrfs
> receive ./
> At subvol after-modif
> At snapshot after-modif
> ERROR: clone: did not find source subvol
>
>
> Source subvol is "bak-first" if I understand correctly.
>
> # ssh backup-server 'btrfs sub show "bak-first"' | grep UUID
>      UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665
>      Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
>      Received UUID:         3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)
>
> root@lip24:/mnt/root/mylap_snaps# btrfs sub show "bak-first" | grep UUID
>      UUID:             3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)
>      Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7
>      Received UUID:         -
>
>
> "bak-first" on remote server is the same as "bak-first" on local server
> =E2=80=94 same UUID as Received UUID.
>
>
>
> Is there any solution I can transfer "after-modif" to main server?
>

What you do should work. You may consider running

btrfs receive --dump

to see the actual UUID that is sent.


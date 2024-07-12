Return-Path: <linux-btrfs+bounces-6423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DD92FECC
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027FC1F223FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4D176AAD;
	Fri, 12 Jul 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XofkUO8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A673174EFC;
	Fri, 12 Jul 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802978; cv=none; b=givBwRiuyVt8aPtMQz5ZRwYb8iTWVJKf9tRDtfthQNuTHhEWcQy1najKK57wnZcFS8zrUwbYK5654k0qlKwRVmWCcq3a040gQhDsepWoQLiEpDHKlJjhk3cVI4iM+Ysf20BCKeFxELDsRAw0gAcF1HJ9j8T4JVRJM84cLkvRVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802978; c=relaxed/simple;
	bh=x21D/sA1rh8LcY3pDjplM1ds6ds00E3KusoX2w2Ih2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkKPeKCPnFKw2WvRY/IToSmKPJC+1Hp+WH85oq1bdYNYwMEVld1SmJGfx1fO/syDgYsG9WGQwBNfp5R2GEDfSFJZDpikAKe79m1N6tgUEIEf0zGpXZLNAvDWh+vPYtk385VLFyV2MtwlPsySrvJO67NfLKIN2A1Ngs0V6ZKxCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XofkUO8j; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77b60cafecso285745366b.1;
        Fri, 12 Jul 2024 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802976; x=1721407776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwTvXgr7fqiy9kh1WxOxV8r5cXQ3vEOo5tKrn0G3W/Q=;
        b=XofkUO8jK9FBZ0UARK8IN3ORotdMROqs6R7OZAyC4AgpCpOn+zCrNH4cY1u84Nodu4
         JTSkrBmjG3vBLseXu19DhSMI0z8QQeukqJie2deX7J9mugP0JaacjXiWzukJ3h8llaPi
         rFkrC8lTebFKV7HJ4o0BONsKTmuzkvpXLqNhloPduKXrp56qptqTOqths4ORLk0T3zkr
         KZK6dl1dvzZm9t0fhysIEdxG8U2AAI/8m2IimDIa1KgALepGai4B9gTFrjEQjFIDT7zj
         dVSg7CXTvJwmHCeIcJjsqBw+8oAGJ1VOa4hIvJ+YpncwqShjsWYrYsjWGeOmJYBgCYML
         UTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802976; x=1721407776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwTvXgr7fqiy9kh1WxOxV8r5cXQ3vEOo5tKrn0G3W/Q=;
        b=EyHRSg1At4V0CdH42F+ehT8f31nuCNjJCYY5twQTdvoqAhzr4SPoFN2HbCzEovgTpg
         sfk+DPP2MaWj4x1fQCiOkijUJZDXpQ48itEwhXgTWqpHqOWfu4I6+Un/5kwZdOGnFm0a
         rCfcNLhtcWJRei4YzIhJ5J0Jj/ni9CkaaolKWv+YsdtjD2VFDAclJLjQ3mYjP8WI9f4V
         PUMD/ksUIs9L7y0N7NJVVfa5Hqip/TxxvCqqRFCzxBAafRon15ndWHazhDNGXdVRz91C
         UUQMYRjtBQnNg7y+i44Xzey33cyE2Lxiwb5rD3R/iNU7Gm3yCRDVDjmsK/o+TnZPv38C
         Un5g==
X-Forwarded-Encrypted: i=1; AJvYcCWg15C+9ugpIsJt0cMUVRiz5Y7G3MFXSBZ+yZe37Lj13ak+8mCN7yX6MnMGXUBfXUVUBKXUXekx0+qZd99DoNx1ZYxgcnMIsrN1wylSseBjwLI2dl8cWx1tnYCGaBXbS4iuU5Gx
X-Gm-Message-State: AOJu0YzpwSka2USyMZ6o3fBEaFH+tXe6hi94hL/+FwY4V/VGbD8N0c4Y
	kpwn4vfi1YHbozYJJZmS9F4PAPXnZU5JAI7b2xQzhUjrKBsN13AokLmxlbcrBZFfRO89SG4TNj7
	fZTnTq1RsfB01ue2rWvoNBttN4PvBhua2
X-Google-Smtp-Source: AGHT+IHTQosaWxj1p+zSk5tAh7yvCMrsoQtFXycuCpia2daptmDRGOJ9RmB1qfEgZ2SFSCdNRxzJuwTVROTYJ8tpaYc=
X-Received: by 2002:a17:906:2b57:b0:a77:cca9:b212 with SMTP id
 a640c23a62f3a-a780b7050dfmr878162766b.45.1720802975413; Fri, 12 Jul 2024
 09:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712164132.46225-1-anand.jain@oracle.com>
In-Reply-To: <20240712164132.46225-1-anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Fri, 12 Jul 2024 17:48:58 +0100
Message-ID: <CAL3q7H4cmHXmJJP8-DoRKF-nQe_L+1rwutZ0BHGk5GMzujGAXA@mail.gmail.com>
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.07.13
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:41=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Zorro,
>
> Please pull this branch, which contains a small set of fixes and a new sq=
uota testcase.
>
> Thank you.
>
> The following changes since commit 98611b1acce44dca91c4654fcb339b6f95c2c8=
2a:
>
>   generic: test creating and removing symlink xattrs (2024-06-23 23:04:36=
 +0800)
>
> are available in the Git repository at:
>
>   https://github.com/asj/fstests.git staged-20240713
>
> for you to fetch changes up to 8e0a68f2cbe9cc2698110ac85765a0c4681b290f:
>
>   btrfs: fix _require_btrfs_send_version to detect btrfs-progs support (2=
024-07-12 21:59:22 +0530)
>
> ----------------------------------------------------------------
> Boris Burkov (1):
>       btrfs: add test for subvolid reuse with squota
>
> Filipe Manana (1):
>       btrfs: fix _require_btrfs_send_version to detect btrfs-progs suppor=
t
>
> Johannes Thumshirn (1):
>       btrfs: update golden output of RST test cases

Can you please include the following trivial and reviewed fixes too?

https://lore.kernel.org/fstests/6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.17=
20654947.git.wqu@suse.com/

https://lore.kernel.org/fstests/bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.17=
19594258.git.fdmanana@suse.com/

You reviewed the last one, but you missed it.

Thanks.

>
>  common/btrfs        | 20 ++++++++++++++++----
>  tests/btrfs/304.out |  9 +++------
>  tests/btrfs/305.out | 24 ++++++++----------------
>  tests/btrfs/306.out | 18 ++++++------------
>  tests/btrfs/307.out | 15 +++++----------
>  tests/btrfs/308.out | 39 +++++++++++++--------------------------
>  tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/331.out |  2 ++
>  8 files changed, 98 insertions(+), 74 deletions(-)
>  create mode 100755 tests/btrfs/331
>  create mode 100644 tests/btrfs/331.out
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D


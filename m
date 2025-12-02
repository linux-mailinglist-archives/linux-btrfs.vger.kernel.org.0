Return-Path: <linux-btrfs+bounces-19444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B4C99D1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 03:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178313A517F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 02:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3011FC0EA;
	Tue,  2 Dec 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG8wkB+z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB61EF0B9
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640915; cv=none; b=ovdiJyCz1IiFERew4oZRdVpeeOKNutqQ3kn8fY4iWjWQHstq8NEWGCNVFFremuGJv50oAIBR28mCz9Dt+8blViPsjMjsYZv48TpymwYTZr/LqX4HVKp58V0nT2BvAq3O/DoQgEMCDu/EW292TN3hJKTZdc7zLE5HimugVtTu1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640915; c=relaxed/simple;
	bh=8O0WatjXe16pP4XTf7n0If/PUrvop0v6PXNubK45ano=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxhRxb5bDJJAA9trZqhF9wpbSgu2waf1FwsI/jAJh9RdvEkqqY2ib96UWnMxNw0uZl9qmcBwA3gI7FssH5kV/s8pl6DvkiB9KcJMfUOQ9VlNmTIzRYwF2FX3mGjqEChlCYWf2yBzr1+FOIFzI/miL/byc+2qWjdzrCZSN60NTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG8wkB+z; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbd2b7a7e3so3822622137.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 18:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764640912; x=1765245712; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uk8FqYya7TR12msjRXRBiOV4mxuYvg239XfhHRMrak4=;
        b=YG8wkB+zgYipOqsQEB5/53TJdwhVjn09sVF8qS5ZtHTjr9DB3aXbZq+Yb9l4B8+GDi
         bfTXM78rrKWt2JcMuc/pwVPiHsMY4dP/fW5WxISWihEvjDA40WwK0iCGyWKgnXxMz+7j
         IBtgr5YaAuGxAAIvKDDQXNCVreEh9OFBkid0c1Lgw+LuOzK0DmaCGUxGFIr+mTp3pBkj
         uuQnymf3a6gJwhxXia785qgt/DF6UcBG177PgXDD1N5C2AdMUmX4f7p2OhD/VqsTqYZA
         SYw1BHrZyHgMOww0JI6iKFUpLWwt7w5yNkdO22afpFMlBF8VpSB+S6bPUJMd3AiVYLfh
         ha2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764640912; x=1765245712;
        h=mime-version:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk8FqYya7TR12msjRXRBiOV4mxuYvg239XfhHRMrak4=;
        b=HoB7eK+O9UbHzwyfssjVrSSGrG1Juyq0T8xFr136zj/eNWzqQPCSbW1Fu9Zw/96p0c
         J5vCQC4m0ArkBgRnF6R7y0YH/JLryJei2ElTsrx06ajYWtRFZn32HhQ5tNt3zg/sAChk
         D9hvpGJ3YaQ6t8lxqmcsjOi8uHNz1x7Z2V8fSoYPqYXy+V5Exskic932Vu7qcvQZv6zO
         csOEuL41nk37VQXLEsR0KXt3ChyT9zN1ZoLSmyNuQGF5f7OvKjnZLPD8xK07aBCU3qXJ
         7F2ee3iEg06qg6TQ+201LKTNwy1xwwAw+3OODr1GeglRomS8U8jJdT9zT4msqKWGE2Dh
         Euew==
X-Gm-Message-State: AOJu0YxLNlvPhDfjUojae1G2G4AIrss/LXwGsGaT8rFWrCYTjOK4RGLr
	YYg0UHhk68E0J5FuSMHZwmubUs9OARI+AAeXGzidCpfNNqqObTAe/j42GqV8Aw==
X-Gm-Gg: ASbGncu5Rtk8AQGYTgDc36kraDbBqk6FxjXf17CYHvcULmvWsfvDXP+XetSSU0yjjLt
	xSUaW0btevEfTfZH3p8AggwMbnQwXpY11CNC0VLxWC5skyO18ycXt16Y/D/dIGFVK6Ty7ZkUD6I
	oiQveBW1MasvEwQ6MkKV3CFAqd/TfaVst7gnsIWgrBx3OhPF65SiujHp6vBx70wFMQw3dMjfNq5
	HtYi+lCryNEdohSrLY1XhU4wFriJf8je0SwFnjBBcY+e3rZ9uj7PJP/NuXX1cGuzgKZVzuAbW4V
	SbydHmHB7tdRiMeXH2YHqDInnK0Qh3fFPygkoIkgCUghZSny1DBPinWx8RFgHoPGWSUaNf/uygs
	3m+Gf/+bIwAuWqgC8xL0iGtad16lmuCnn8+q50LUwnJ1ea50YF+sIpuDTxdOc3ep269LvD14xfr
	oA8jQVL1zwJy3FM9hb1Bsx93jbPKmTsLAyXzJmK/IlXQ0p6rd8eysDcwA=
X-Google-Smtp-Source: AGHT+IFXZ0+HZS58Fh20SWLPLo0Fyh7LRphCE/HW1meJn0M9r6HDz6e2LeYjJdAIUA07aHnxrRQqjA==
X-Received: by 2002:a05:6102:e12:b0:5df:ab05:d84c with SMTP id ada2fe7eead31-5e1de4188ccmr18052666137.30.1764640912084;
        Mon, 01 Dec 2025 18:01:52 -0800 (PST)
Received: from localhost (69-171-146-205.rdns.distributel.net. [69.171.146.205])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88652b6d7b0sm93498616d6.41.2025.12.01.18.01.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:01:51 -0800 (PST)
From: Nicholas D Steeves <nsteeves@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject: Does Linux-6.12 have the missing dev = single/degraded chunk bug?
Date: Mon, 01 Dec 2025 21:01:44 -0500
Message-ID: <87ldjliquv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi,

I'm reviewing documentation of outstanding bugs and workarounds, and I'm
wondering what the state of the single/degraded chunk bug is for
Linux-6.12.

Specifically, I seem to remember that the users/sysadmins had to resolve a
raid1 with a missing device the next time the system rebooted.  So the
reproducer was:

1. Device disappears.
2. Reboot occurs.
3. Filesystem fails to mount due to missing device.

Thus

4. Sysadmin mounts with "-o degraded" and btrfs writes profile=single
chunks.
5. For whatever reasons sysadmin doesn't succeed in replacing the
missing device and rebalancing both data and metadata.
6. System reboots a second time.
7. The btrfs volume is now permanently read-only.

I vaguely remember that profile=degraded chunks may have been introduced
some time between 2022 and now.  Does this mean state #7 no longer
occurs, because profile=degraded chunks are written at state #4, and
that a sysadmin can still add a new device and rebalance after the
second reboot?

Finally, are raid1, raid10, and raid1c3 and raid1c4 all comparably
mature at this point?

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmkuSIgTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYWSbD/93B2TIx3u1EKuYv0H9AwBdPDKKS1qB
EgxrMGK40AOQxFp8SaNSRj2Mgm7G5Vv8bG6YcMWpw+0rX/+2IYChcDcDq6fd56Jk
dkbvzIMBGN7A9lIRIhyDXprn5VXXMWEf7FFdVrgtp8JPOtk6AVOhzIzPOIbm60oC
Dr5UKU7mZnoemCVtVKztvA/YoaFR0eijE9eMu2V57dOSfqoMT3d9qETDRKt3YYDf
2O4sruXPShGiXSoyUAIox8oYUxNmbui1pmVlepoxQF19+yGA8Zq6OSZRfUIjIJ6h
QvwylZGGNcHj1sHY8vcYl3JkFwjW6SDTXiTdpnK9qpx//P1eRnsOvuWEWOl77x0g
LO5wm7DSmAy2kXD1SkCCoVSWsM14HCCHGswXJJS20f71PWN7PGKiJWpNthQFS6fG
jnNv8cgne16RnXjTQm+KcGSxuaWHdUT8Ko3TMCg/x0CCJmGK9TBmlVSkm+wMrTIA
IGZyr1/5MsKiU63iq16dk7MvBkdY1IR8YCH00TTzaBaDZ7YG48OPcZF7E0iDZBtX
Ys/dDPzNI4Lnp0J4Jwu4Q9uiPfsaXXUpi4oiZnCmjFz6uT7lzFsCFSPgjKm6aoQE
lxsfu8tp9WaV5qVmIjAFHMReqd2WqnVw4PUJYndZLeX4NMgFx1sFqwCuejl6mcYQ
4aODuQO7pjEUVg==
=Nni6
-----END PGP SIGNATURE-----
--=-=-=--


Return-Path: <linux-btrfs+bounces-19443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37691C99B91
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 02:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4E40345A38
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 01:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623531A9F83;
	Tue,  2 Dec 2025 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Vs15Y4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FF36D4F7
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638476; cv=none; b=JTFYHOISfquNJWJtFqfmGxz02vSd0/u9qz0gJTw+eEPnush7nmIJd7FfS2nHJVr6XRZmhcdVHGDvsIJFzapHWl74fy0fR/JQZmk8rRCG52l+e3vMV7FADhZZZEicqLo7adPyg002eg5N0xx4vcAgXYSOGS+HmxzoavHPztNd9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638476; c=relaxed/simple;
	bh=S/LVPNBudVh6umeT6J9FYbKq+3CP8R1lW+A/qr0NqA4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpzG+FFQ8SFwZdA3+U2VO80TtVqIRdHZv8LOOQk+t1AO2FFSO8a04o+wc5svXKUGKb5+tbyux6dVreNoafGSkiG++i9AFmtY2qye9WGOw0HdEHG5A6Bw+JcLmhgBaR9yiTLfXyiw3CGNSXKr0Qb2mYlXq3BMT6oBxY3ZganAIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Vs15Y4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8824ce9812cso54574396d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 17:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764638474; x=1765243274; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTdUHXFs3zoOsFkW7n2JmABrCMHhhgSC12CcUawBeR0=;
        b=T9Vs15Y4Ues82UQ7DjOIYQJgofgzpIZRtCPFvK7W2eD62GY6leEujVX6M7teP1Fw6D
         1/k6NyxRnOPqK8rFJUsnYrgrvFqDCd3zMqcOEyO3u5BMqjQ5abjeg3yJ0PJ0ZiFGz9Nk
         CBK3j/frxZJiM+pqJ6j+OO5dQoQgn+FtyN4UHH9A9l6p/hIJkBeOeCrFv4Vx3JB2qwyA
         VmMN/4BENtQyyNIDJo/3CHzPeX2tU7ntnDUGw+3CiGtBe+WFSUukSFBsS79BZJu19AUq
         S2E96M/2ewnPCMhUIWvZcMTXqeDEg1qLFQAdZPLZoG+AcYyMmnllqY5Fp4Tc5+vvfSjh
         Shgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764638474; x=1765243274;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTdUHXFs3zoOsFkW7n2JmABrCMHhhgSC12CcUawBeR0=;
        b=pSHaNyHrskE3YUI6wSFfaNQx53sCGYoktfrEZENSYp1JEi/TEOtiNQKb5fbBYsI32k
         IkMDsqTwWON+7QV3JY4FgDbDX7GRKn+OGek57luo6g+qRZs7I1KK89jEVysoFJNgJIfA
         ARrzCHLdI6BWTgyGVtb+XncTplypg5Xbm1bXWPI4zPaVAGEMMEIcFDheC9VlKENeEr2L
         LTk49an9f5F71CzbJp+nz1Yn4/k5a656Bm4DX4gXM6V4kgBnDxpoDdhbcUSvjF0FiyOn
         F0BHvTpTvEYmJSMCZ9dWEsJlk6Xg8RFjnbOLic2YuTIF4qy3OeJJT6D4uMm7rVQK8WIh
         nugw==
X-Forwarded-Encrypted: i=1; AJvYcCX6dbOxPU1raT1wHvNtfCPXX1YMlcoeSE0grvheKGbt2EOMit80gf1I2f4NhrtiHpFTNBuJLze5f5TGbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8ESoMHOkE2Fdp+OaLFKLDLO41VCcH8RGINzCtClJs++www9H
	VERtuXM75wVrQlME6m5XnnBLpbb8tv/JfHjQFfoP4iM3XKAfMnGuHC5QoSCcKg==
X-Gm-Gg: ASbGncsTkz5en/eJ7aSolZki7eHQkJpWRXcXZU8fJngd7Nki7sW9smDgTZXn1pj3jaB
	XfumQw3vq9ock/9bH0jjqgvLs7BZJfjPItdLIMcKUj4zOl83Kku/t1uvdexmHyLI50VGl58nXRR
	/ir7ojqGzukQ2yR7Qp/wDm4mtxSzygMs+82OqOx4IVmm4a7LWD+1/uOHWTUusvTJVEnH3YcYMuL
	KBeA5QnYqCagUpxEnIioOSFHHDbXpRpFWfy7UqWVFUo8IDZFB4RYU4e6kyd5iFDt5D+RiB7eqGe
	/lqXHCW+L2kYoEUaDS4Cb196J3KEBLhcwZdVdZsc73kmd6nNNnoaqBreg7+VxeYe1YzKCnVDub4
	mMybnpU8tw/GFaMjC/1l7RDDPlEXGMOC6jPOdCB/80bFplyM7x8c+Ch8nXrrp9asJ1+KhwgPNfy
	s89bTv0B+RM5iopvfEM/q/LcSMQDYEFIibcuYZAyzznxmK
X-Google-Smtp-Source: AGHT+IGbFc8QsykDZ6vwG5JtmlzjIN0nGhutFlChf8Wn+QCdzctIowPebtJfWIliAyLApVF2SuOq2g==
X-Received: by 2002:ac8:5fcd:0:b0:4ee:2423:d544 with SMTP id d75a77b69052e-4ee58a853c8mr544075791cf.11.1764638474009;
        Mon, 01 Dec 2025 17:21:14 -0800 (PST)
Received: from localhost (69-171-146-205.rdns.distributel.net. [69.171.146.205])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4efd3443375sm83592701cf.29.2025.12.01.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 17:21:13 -0800 (PST)
From: Nicholas D Steeves <nsteeves@gmail.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: add block-group-tree to the default
 mkfs/convert features
In-Reply-To: <cover.1764228560.git.wqu@suse.com>
References: <cover.1764228560.git.wqu@suse.com>
Date: Mon, 01 Dec 2025 20:21:11 -0500
Message-ID: <87o6ohisqg.fsf@gmail.com>
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

Hi Qu,

Qu Wenruo <wqu@suse.com> writes:

> [CHANGELOG]
> v2:
> - Automatically remove bgt feature when dependent feature is missing
>   Instead of erroring out. This will allow us to run the existing
>   no-holes/v1 free space cache test cases without any modification.
>
> I was planning to do this during v6.12 but forgot it and now the next
> LTS kernel release is not that far away, it's finally time to make the
> switch.
>

Does this also mean that block-group-tree is considered recommended and
production-ready for users of linux-6.12 LTS, or that it will only be
recommended for the next LTS kernel series?

Also, are there any known disadvantages that result from having used
btrfstune compared with a pristine FS created with
mkfs.btrfs -O block-group-tree ?

Best,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmkuPwcTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYeNhD/9plhwzJa64EO7u9bYnmJmJ/5X5xmzy
gVyCM0ydHzxx2dj7YJEbfLH2xhKBLCn0TCESkCEwlksYwi2yd79xJ2Qml8s43/A2
wyyumCyIcSu6IzOlDmiB+20oU1mBCzyDeNoVo4uUefftAp8mXlGu9ULJfHXhhVQj
+w3TR+Vwtm86bbW3SGwqxjFiLA7Anqg+oIog28Kx21nqXbd1D1PQ3M3H46SCjmxi
Z+9GAIDl1JUX0lticGrIGi/ebkPwr6qIwxYp4wDKKQTUkJT+z5uD82koAbb+ZQts
dJw2K4gBINIjz3usPBu1D/hag5SVTuTRvmAN+CPUlxfQFknr1GEaL4Ay4RvjenC7
N/a5ngr0IhAzheoiGHVcBPCHCdpaoqOnNb9iPt0jGS4CgWn72c/DjXpZ4JLDFmIC
3/g7hK0y1jS6jD7Bj9O8g+Z4jEJiOp/Nv4GmS4YnA6v+ghbX/LxPmsWOLPI/QxR9
+4jvKmNcCcCOCXCkBcpsSbc9vkdxzPdLYc/tEi4nIPsJcToV+AJBJsHk8CFzxdPy
cvbF10qrG/Yho1m/NELYgKQHWmlXeLpYcVrYoyJqX55wfuh3cAQSi3qlfPlWXs9A
3Wt/SbjnODrcphQ+UiRlQiyTwiSDu6uiS698EvJb3q2NoPWyeCa9GcGJYtcH9Mv+
j5IpkG9piHHcEw==
=bbKA
-----END PGP SIGNATURE-----
--=-=-=--


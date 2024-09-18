Return-Path: <linux-btrfs+bounces-8113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85A97BFE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC228345C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8931C9EC8;
	Wed, 18 Sep 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5FcgAVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9311C985B;
	Wed, 18 Sep 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726682031; cv=none; b=hANmc7vmZWmYzia0CX4Ld8C5TCzyOi12TTPC1QDxY19PQJP63fbkTq/+IAFm3afaPxDg1ApeWYtDlVcCCT/WJ2wu9Thmfc67AlmMUAxxFBwY77h6NvgQR/UObdIhe54Se/lgylKRq0De6Z4IawAm6IpX/qBsYhhRSqf+UfFBMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726682031; c=relaxed/simple;
	bh=Ykc8UooszRe21YQSnpLQ3ufl/viE6Z7EZv6rt0bXFMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH0kufiOUd7DOF4e2u6iprwEjdCK35GsK309Rc7BJkil51uqR+4dxQqCBnvoW/fFuX8SkGVAciCo18jrH5s2az10XAY0r+16x0xCPBcLiHPSvyYcPVJyJdCaamb3h5+LgNCr0CoZSyf1Nou4RswTZIxckfDNK/LAaYHNrd1a0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5FcgAVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00CC4CEC2;
	Wed, 18 Sep 2024 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726682031;
	bh=Ykc8UooszRe21YQSnpLQ3ufl/viE6Z7EZv6rt0bXFMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5FcgAVlO6SiFNYQkqYZ4s2V84h3YCaAmJNEcJIf/umkgJKLvYYQYZgmBRCZvrgL/
	 s9ycvKG7ZwIRQJbFDQZmmfh0/uhEL5QWsFBxdgvxbilsw637elZq7KKVHsSwtWA585
	 Tp6aWdgrCUmjJrcEdrTxHciEDHel1dtgkJ71Hl0uCkpy4pBqNnILK2QzcFWVQy75tg
	 1Esxvu0amCbCC0mSF2GrJvmfJLbGHCEWvSRLay9vCBI103FUBA/JwCwn7zonBA5Dm0
	 wWdv+2zO1hoU8uGsXzE4oIweIbGE8FigUWJaBVHuWyZ1abpMCSA9XCtgym0H8kKW5Z
	 IrtnRh3pj/6nw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso6342850a12.2;
        Wed, 18 Sep 2024 10:53:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHH9ynpC/c6/hMGl9+86syFJ2OSRX8YDO9ecHszMxSMxycGP5pdWBUHYQAsVZ+jWNKYKyszqUduaoF3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YweImSpy3kq6S5oklATk97Eqfzvd+8xFGf3jvHiebFPTn+hcMqb
	oz71h2yy6GZJhxepTIPbwP9ThW3iKiJkg13K+6koghFT3SX8MtNxz8XAg4NzWl47ICmLORlDXy9
	4ks10yTOT1mym8FqGq4rIGM4w7bU=
X-Google-Smtp-Source: AGHT+IEQLllLYbVQUrzNw7peenr4PgORBuyki0hM8ldBG52kiNJ06aE920l9vDC98sogXJDhO2kFA/8hT/hw8cseWtw=
X-Received: by 2002:a17:907:368d:b0:a8d:2671:4999 with SMTP id
 a640c23a62f3a-a9047d48d31mr2193435666b.39.1726682029712; Wed, 18 Sep 2024
 10:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
In-Reply-To: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Sep 2024 18:53:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7fzCQE0qjZEgeAJ2jvBsJxbYN-S=XpWFu5KDoaXgqsZQ@mail.gmail.com>
Message-ID: <CAL3q7H7fzCQE0qjZEgeAJ2jvBsJxbYN-S=XpWFu5KDoaXgqsZQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/315: update 315.out to adapt mount cmd
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 6:08=E2=80=AFPM An Long <lan@suse.com> wrote:
>
> Mount error info changed since util-linux v2.40
> (91ea38e libmount: report failed syscall name).
> So add "mount" before "system call failed".
>
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/315.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..a19ae8d5 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-
> only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount: TEST_DIR/315/tempfsid_mnt: mount system call failed: File

So this makes the test pass with util-linux v2.40+, but makes it fail
with older versions.
The expectation that everyone is soon upgrading to v2.40 is unrealistic
and some distros, especially enterprise ones, may take a long time to
upgrade.

What we do in fstests is to create a filter function that converts the
output, so that the test runs with any version of util-linux (or any
other package).

Check common/filter, namely the _filter_error_mount() function.

Also, when modifying btrfs tests, please also CC linux-btrfs@vger.kernel.or=
g.

Thanks.




> exists.
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> --
> 2.43.0
>
>


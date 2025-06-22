Return-Path: <linux-btrfs+bounces-14840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A8AE32F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 01:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC63AD7D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jun 2025 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8B1DE4C3;
	Sun, 22 Jun 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FvLbSpmv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BC6136
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Jun 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750633492; cv=none; b=RRMPZLoRRh2lEbxgBRph4hoNYdEUL2efKjqhbBNyTbOXP2325B654YuvMvEnPL15SsgvSdiOFOUGxOfbS8xiSB/ho8WY4uufBDTZC4s632GEJedJPb0s/tyLmrUv89/BcvqYgpK1M0jA+CXu6zXJOCcXPIjjxiPCHCBljMtB9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750633492; c=relaxed/simple;
	bh=oKL7Ajwn6RjSypn8Ok+QViP+Wi07lzTLNuDjrIOhUWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrKvOmn7NHdAI+1Uz0y3DyHf4ph18ZU+BlDlQ0XLnJe0PNrd2SdlNjWZNEjMudN7WnYrOot8t7yKDgv3OQTD06hyFg6TvfkyT33IsC101jo6q075mc6gJzdnUpN0D4tXq5bpgMZZqFvnWck+qcOeSlbyWNdMqVyj+zt+EbHnHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FvLbSpmv; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a582e09144so2120454f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jun 2025 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750633489; x=1751238289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hRQzdZo9TQSEv5a+p3lB9Y8HC+xfJfGwbcANHdv+pSQ=;
        b=FvLbSpmvUQgv5Pui4/zqoscXwiH4zYnynixqwC4+KyO9hZy/vjuSDJJig7XgZqLrKm
         Ht4jy1bJMYzMcaASFTxAXjGKmrnA06uFmxqvoeYHe9B5CG018g9Xi5HPSay1bCoJ3irh
         K5q0aI7JOlOqucUIRdt+ZSgBta7q2T2FpEobWsKcc/Um8mwmIaHUCV+TlWmoQz5BFDxT
         n4IE1qMiVnaCLYFUV4XQQrQF4kXlDsh1vA4AIZ48lyql+wSlaK2Gvjod/+AE9zOpXDN1
         zETa6x1hQHu1Q8fck6kO7X9j+xdXTqod1h8YP7HvyEhXhcNWF9peiEtAXEoR4srteBxS
         AOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750633489; x=1751238289;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRQzdZo9TQSEv5a+p3lB9Y8HC+xfJfGwbcANHdv+pSQ=;
        b=WjWSng2+Dpzy513rT4XrWUmS3cu0o0ccjf9l6M/KMXnL6TSVWKodug4MBVyQdEfbV7
         mO9FUd7WSCFqpZpk6E/FTfFky0+VU2UMjsztwVmrakyqFvE4vEbMApnABfJIpP+er9kV
         7vh+gIEYwZ02Uxj6gl4Wa8A4edOnad2b3+4MoKAssuaQ5vmW9Q/pGJwHiFhX/DMKy42c
         T0r1SEcQ06gpgVWrdJIf465lUQLXW88/gWIkYtfMfXzOJ7KUBjMARI7RErJXaFPsPcor
         dNaQtLUn6JUv9rPFmx4VIcr5Z5RRLZ8bbtKhlMvcbBKaVwEKxGt1LGS2JR0BaexKc7fS
         IeTQ==
X-Gm-Message-State: AOJu0Yzn9f48lGwpsvy5MGF01tKuYabWG8zVr1a9sSEjPW9JYgz3XB6o
	78nhXRPYuh00EBdhV3xl3T27g2TibZOHfqu6ciLJR0XE+fpBHdbMwyUmZW+pwRVW9e8=
X-Gm-Gg: ASbGnctO9gW2+lMiJ9QLVJRxz7XZ2ujDEElfXIPT96JP0Z6RGq2GypqzfzpGKyF9TAl
	sxF4jKZcPfrxFQsSSBN4/Z0XL7yNwQlufQQXYtkBS0MzUkwArLHz1MPVoe5NltuOV2l825f8cwt
	uyiuz6hB66MDk5qQ13VrInVS8fNAjMIS+undkZv9iZWjxrVWZnkGxA5CYoiuN4i0Dor0VEzilCb
	107awUNO++s/macLhWRUjRwiSkNihjnLO2symvr+5Ymua7IFMfsnf5WAGIgpMtcYAiV6e91/Ph4
	8fMmelLRdvGC81MVGc1UdC7DRgPwxIGWRVVYrIysxk8YL0pR0vXIKbsdEPzWGt0E4y1Dh9hZL+W
	uHxtvueq8btgMUg==
X-Google-Smtp-Source: AGHT+IHGsGJ5ViwS3Z+PySWsZj6bHCPteYR7MbOVAnhAfMCwXbqLf3HcP4oD33cy6T/VfdMKWAW47A==
X-Received: by 2002:a05:6000:2810:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3a6d12dd6c5mr5453346f8f.22.1750633488690;
        Sun, 22 Jun 2025 16:04:48 -0700 (PDT)
Received: from [192.168.3.33] (25.37.160.45.gramnet.com.br. [45.160.37.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83c7d45sm68939745ad.55.2025.06.22.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 16:04:48 -0700 (PDT)
Message-ID: <0a414c3661943e45d6b297f62b1c680e14affa75.camel@suse.com>
Subject: Re: [PATCH] btrfs-progs: filesystems: Check DATA profile before
 creating swapfile
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com
Date: Sun, 22 Jun 2025 20:03:13 -0300
In-Reply-To: <20250620165431.GB4037@twin.jikos.cz>
References: <20250606150826.119456-1-mpdesouza@suse.com>
	 <20250620165431.GB4037@twin.jikos.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-20 at 18:54 +0200, David Sterba wrote:
> On Fri, Jun 06, 2025 at 12:08:26PM -0300, Marcos Paulo de Souza
> wrote:
> > Link: https://github.com/kdave/btrfs-progs/issues/840
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >=20
> > I'm not sure if it would be better to just add a new helper method
> > to check
> > for profiles, please let me know if you would like to have a helper
> > instead.
>=20
> > +	ret =3D sysfs_open_fsid_file(fd,
> > "allocation/data/single/total_bytes");
> > +	if (ret < 0) {
> > +		error("swapfile isn't supported on a filesystem
> > with DATA profile different from single");
> > +		ret =3D 1;
> > +		goto out;
> > +	}
>=20
> This works, new helper can be added in case we'd need this pattern
> more
> often.
>=20
> But I'm not sure the error and exit is right here, it's up to the
> kernel
> implementation to check the constraints. In progs it's better to warn
> and say kernel may not support that, for features where this may
> change
> in the future.

I agree, just printing a warning should be good enough for cases like
this, since the file creation works but later on swapon fails due to
the nature of the data profile not being single, returning -EINVAL.
This also throws a btrfs_warn.

>=20
> Do you have a usecase where you rely on this command failing? Maybe
> we
> can enhance it so it verifies the known limitations, separately from
> the
> actual file creation.

Not really, just wanted to fix this behavior after seeing it on btrfs-
progs issues on GitHub.

In this case, do you think this is worth solving? Maybe keeping the
same check for the data profile and just show a warning on btrfs-progs?


Thanks in advance,
  Marcos


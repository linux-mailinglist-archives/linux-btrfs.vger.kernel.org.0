Return-Path: <linux-btrfs+bounces-1679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD783AA57
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5563B27D1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07377649;
	Wed, 24 Jan 2024 12:53:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAB134CA
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100790; cv=none; b=OfxKN3FGNJGS4LWtUPi2wYmxm2/OZjg16eX7x09y/tz/jt0gMq6SxTyEVK9LR4Si/HpX0LmvHgqawztKYzp5ekQQlowcSC/yGfLCjoRwVEAcpn9YPJzodhVzgrkdB+hIPz52HjAghENHScO8qTzebc+FSMDEToaSdcjWzvKUX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100790; c=relaxed/simple;
	bh=dJveWbHUjg4l5AT1Cn9oEAUEtIEBquO3g5+CkzRRPs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnO63Z2ZVll9AyJHkgkCokiwZR2bZ+XyGiHpJDY6m05FiKZ+g5SR4YIjvZrDlS3AkGj2b93hcg9S4wz1Ry1O7OsQi1ZmVzoHYjmvvB3DJ30IYoY/N1XPWR2b/wkKcBgoyRjJ23Mf9W2RW4GaN9rGwESXP9LfUF5Roi4acQy7tSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so546986866b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 04:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100786; x=1706705586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJveWbHUjg4l5AT1Cn9oEAUEtIEBquO3g5+CkzRRPs4=;
        b=S1G3UfrMVqJUl4CgJ3Fz5YKqUh0jOEB/4GPTreMb63V7MFD+muTXu+LDUp3XM7OBTu
         OhhxCtbOjeRM9BBMspgWH80rEENyF2ZLJqSb2DqW+jar+eEGlLALe0Gcq3aL0eaZ8ZG4
         K1ZMC9HewSNf9QHoOiQrWNuTnfMgwyJK3CM1drrPh3TFB2ojTs1kSOL6Re2oTo8XX73J
         RAfB5QL4kXLUc5lxxTZJIPI6brh3n3iRmNlH7hiljCfa+lT/rbdBMiebw8QK8uBCyZsL
         Uz2tD6Kzs4BNsSGxFTd9rkbbUsJYtlekbLc2R9Y2249Wz8sBSSpet1iSkH+pINajomxp
         6Stg==
X-Gm-Message-State: AOJu0Yy3XqE3hhAddlRfL4DBgUG8LMPM1gN1WX+/gnMYTO4mS0HFcOiC
	BRLRtz+tD8VVc68Ggh4Nilf3EjYYV3UwqnUjUVilMzXgIa95URcpjJ5ZETc+6ZSuag==
X-Google-Smtp-Source: AGHT+IHK6sy0vBRwNbtJQ7lwH2m92dkFWdgPYw+FgWprBhvvXFYLaxCqmNZ+D4NWrL5lN8HkEqGvLw==
X-Received: by 2002:a17:907:1685:b0:a31:33d6:7cd2 with SMTP id cx5-20020a170907168500b00a3133d67cd2mr361105ejd.108.1706100785749;
        Wed, 24 Jan 2024 04:53:05 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id st8-20020a170907c08800b00a2ff7a6b47esm4137868ejc.46.2024.01.24.04.53.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:53:05 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso5995085a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 04:53:05 -0800 (PST)
X-Received: by 2002:a05:6402:50d:b0:55c:3072:2167 with SMTP id
 m13-20020a056402050d00b0055c30722167mr1719001edv.78.1706100785341; Wed, 24
 Jan 2024 04:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705711967.git.boris@bur.io> <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
In-Reply-To: <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 24 Jan 2024 07:52:28 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
Message-ID: <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 7:55=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> This leads to various races and it isn't helpful, because you can't
> specify a subvol id when creating a subvol, so you can't be sure it
> will be the right one. Any requirements on the automatic subvol can
> be gratified by using a higher level qgroup and the inheritance
> parameters of subvol creation.
>

Hold up, does this mean that qgroups can't be used *at all* on Fedora,
where we use subvolumes for both the root and user home directory
hierarchies?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


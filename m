Return-Path: <linux-btrfs+bounces-16022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF6B2264E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F11AA5C85
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460032EE260;
	Tue, 12 Aug 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4iujG1T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090319D07A
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000312; cv=none; b=hlnBJpqyNZ+jNk8d2XuAFQR3MbOe+jOhkwIhUk0pdz/2jRZjg/CK4XYBfiTAJfE6OH9xKy74Sx2jboxNGsKkBLCjReQdKyjRdXKgK3Fyslh8OFQGu+2qMfmoseny1dQWLPUhsQOGTCKSEQe/s2jo6nNko/5S5cmmpCGQQ7mzduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000312; c=relaxed/simple;
	bh=KtNJ/z03HqhgbXBSbxTlr0UHY38Erc6lealCWiOaVOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrywHVFFuLPZCcSmXRvwUXIpO3PZuhsG/mZ0AkbwxgEVVM6qpcP5II8tHTNgrLtWDjA8vueiAjUg9Z54pytT0HCnVboMr7B+XeiRviLOsMXBQNdkh3E6kvBAF6jy7nj/xPBjfhGRE1+hS4/42wwOnDrLBYGw/NyV8AuqJd0NwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4iujG1T; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76c1008fd60so357593b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755000310; x=1755605110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DawMIil5uFYCFXLPBGO/a0KWrw615DSmM5ZKYKQujO8=;
        b=k4iujG1TOXzfPO+3XomeYxZON5tETgnpE26LkAaFfe4ifPPBl7q4JQelti8+x2Kw3/
         a3rczASXNR2nyOJC7RA6lBjBkTBdE5svpPWcvHCIbquvoF5aioiu0gVuIpWDi4rua5zk
         vqgDTk9afMi2CLjnvHsdZfNioL5Cg8gf6xKUsgu3wDeuoAw4AOcuKdO9B+VjEKO79MRN
         AnDGUfjHHIxl4MK1j+ktU/iMhSme8PySaDRIYx44lPAKsfmOvHoBmtjkkmmUcXE5cjyy
         Ywg/8u3irY8uBbas4m+pS69d91+IEjJPU0jGzV9KWUco2NeKhGHxkAW54o7Gkz3aEdfi
         TwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000310; x=1755605110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DawMIil5uFYCFXLPBGO/a0KWrw615DSmM5ZKYKQujO8=;
        b=uydkLyFh1OesOcHeZWcyv3rKCoRv9xvpnrOwmijvYg2tF3xi21Wb7M354/MROlh2Is
         GxCDYgQW3qERDhFb3idCuGvIQ+yykSvyKXwBfVtRwGDfcCm/ACnWtv80Xl8DaPlBnQSJ
         J1H+XXm7VM3YPzqMEqOJgUAq31c6nmqcRLXPSRsEkRN0t6xdvWFLDuWdHXxOsBqk1Okj
         oZ6XrEz57L2OW6Jg7kUlHAQKr4eM2QTPKqM+cZ4bE7lhuXwPinDABxJSS9o9sA7+Qkyq
         9QVgKLWeUJuMC+xTsnJKnltoaRd5Qk/s5dXA+DKDk6ok5X6SMrteneRV1UNRtQCd67Va
         IjpA==
X-Gm-Message-State: AOJu0YzkoPTUsWB8RiZKdZoNqXcHlUHilbR8tTJl/tLRj8p8U0om6Wkt
	ie1N53/dr2l/whIlEUNQNq+YQRyldR0kSPvBmAj9xStlSW1o5s55kXBx/K/HrijKe+5Yuw==
X-Gm-Gg: ASbGncu4JvVySDSrazgTGOxIJ58OgPuCU/FnTPcrWYfUtzntRzJi4PxvIgFeic1pZN2
	XiII9srrepPMdoPGwnZMXLSSwxpcjGAZWQjrV/IVHBAAxp5j0rBth0NsKx0SL/PPdMfmh+JQjVu
	8u3vxc2SuxXUFc2mfRfdMion+xzvK8bKUwx9xsf508kadUk0MPhIT6LbSX6oTJlWvqyynbBCQQi
	/COHPo0qmFhesCX762G3AlXRak0f+iybhZ3HCm+RrD2xwWuCjnP934Bv+cfiFr9Og419KDnhcRu
	U1Ewrh3xOFRZ7xPVEtAIr/xe1amVeHK9HeXSFPB/ax/S3Heu+Rm2Sb98zp0jy3VQEZQmVG9FhDU
	xWUANsbOh496gsLZ2ID30LOe/QvwHpgvvz1PEv83b4uQthP15hJ+bwFr91rKxlvuxDA==
X-Google-Smtp-Source: AGHT+IFSMbT9kUqxJgsjtSsyU6KqRkiaCWXNwzhSZBRpcH3TiYRCagqlwtAYYliGxUWTSNgtAsGOlA==
X-Received: by 2002:a05:6a00:a0c:b0:769:c482:5de0 with SMTP id d2e1a72fcca58-76e1842a690mr614262b3a.3.1755000310281;
        Tue, 12 Aug 2025 05:05:10 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8de28sm29048930b3a.39.2025.08.12.05.05.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:05:09 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject:
 Re: [PATCH v2 0/3] btrfs: search_tree ioctl performance improvements and
 cleanups
Date: Tue, 12 Aug 2025 20:05:04 +0800
Message-ID: <12722055.O9o76ZdvQC@saltykitkat>
In-Reply-To: <20250726135214.16000-1-sunk67188@gmail.com>
References:
 <20250612043311.22955-1-sunk67188@gmail.com>
 <20250726135214.16000-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> This series optimizes the search_tree ioctl path used by tools like
> compsize and cleans up related code:
>=20
> Patch 1: Narrow loop variable scope
>=20
> Patch 2: Early exit for out-of-range keys
>=20
>     Replace continue with early exit when keys exceed max_key
>=20
>     Provide measurable performance improvements:
>     Cold cache: 34.61s =E2=86=92 30.40s (about 12% improvement)
>     Hot cache: 14.19s =E2=86=92 10.57s (about 25% improvement)
>=20
> Patch 3: Simplify key range checking
>=20
>     Replace key_in_sk() helper with direct comparisons
>=20
>     Add ASSERT for min_key validation (safe due to forward search)
>=20
>     Maintain equivalent functionality with cleaner implementation
>=20
> These changes optimize a critical path for filesystem analysis tools while
> improving code maintainability. The performance gains are particularly
> noticeable when scanning large filesystems.
>=20
> Thanks,
> Sun YangKai
>=20
> ---
>=20
> Changes since v1:
>=20
> * Replace the WARN_ON with ASSERT, since the condition is a runtime error.
>   Suggested by David Sterba.
>=20
> ---
>=20
> Sun YangKai (3):
>   btrfs: narrow loop variable scope in copy_to_sk()
>   btrfs: early exit the searching process in search_tree ioctl
>   btrfs: replace key_in_sk() with a simple btrfs_key compare
>=20
>  fs/btrfs/ioctl.c | 55 +++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 36 deletions(-)

Politely ping. Is there anything blocking this?





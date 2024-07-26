Return-Path: <linux-btrfs+bounces-6709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAD93CC7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 03:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258AD1F22288
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35AAD55;
	Fri, 26 Jul 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="qEfFIYg+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9AFC1F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957825; cv=none; b=V1rkhiI8SYX3ax83dwnE4pYNeq72yOl3TAhiueXUpJgOvp9Fini90UlAa19Ti9/dn+S0eQ1dKRi2ycFWUb3/UJ8niBiQGB87SyyDiaKAifLWTda6U27FO4GoNBaYaiOgC6ffele++YKs/tuudiWx82eWMpgJM4nk6/p2UlQHKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957825; c=relaxed/simple;
	bh=FypBir/YFpE1c+Es0Rxc53b2QfHADQDDjGR1V2Ypxr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxqoDG1wPCnzzTv3Cz2L0m/rPi0iNPiiJQONzZG3YdKMRmXedR2HKwWR0XaTaZf/Z91ztgezCA1AYLWpilrP8y9uWvA5ZE92FNAW0OH4dvkgWiyDTOwXlSyBAtD/dX4bR5HDuQEwmn8/f9AwXzNzYwYF42MpjhI3Ks9A7We2avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=qEfFIYg+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc56fd4de1so1155835ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1721957823; x=1722562623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UeN3uWChM3FelIakWkdSa3P3QzaD+ogRTOlyJYCsDMk=;
        b=qEfFIYg+pfcDA/4aZKhFmUtfo2e8Eopj+LTI7otF/PNEuWdHsm72k81YgrAeVZ76UE
         uja92t3xg0+FZFBKLdKu19uhU73LSFlV356qNjhINofDqyM/RGmuVw++nJWLCr63SJuw
         AvCM5dNrtTFLBmqmURev44ChL5aXX1U06dzqgkHz/d5aGR7+kflMZK38vd/rpxolec7S
         +ON4I/DppvZluDN85zW2kA4ZjVUVuNHAJ8rAo2jNjdBtoU8EjRTLmtKBKT90zmJ+Uunr
         LPR5aN12Jsa3o/v187I7a/QmJz/ZaSTq/iczmiEJoG72P1dVUo7Ksb2KNVxF7XvWKfcR
         4lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721957823; x=1722562623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeN3uWChM3FelIakWkdSa3P3QzaD+ogRTOlyJYCsDMk=;
        b=u7cOQfpJJbFoA9WS9oC45xdPB+/t25j/LUFrp3Wz+5AchQBiZ3y9nd/0n2xvgegrPv
         nNL/rhlEoq1cnd2EdYtYf5Crrv94Duf/F+O8TrdM/lM4GHwp8QytfsDc6+CkacCZQx1K
         2r/Gzkvr4DYKnCnL72ZptPfINquVctqYZFP8xswdVmfP5J95s02NV2bouBRkn0kzMd+u
         NpVPbxisiohpGEMysADw5xZScr1Civ6BP/NXVDN6XaW02GhrQyDABkJhX2tTjWfcDi/I
         ErDdNlW0zzTeUVmEZ66cs5pYrAj2Vc+r+0IYC4X6L38ePOHEAai6W3cCAENBvUKFFQFE
         TgyA==
X-Forwarded-Encrypted: i=1; AJvYcCUTnFW/jZYwrVo1zriBLCKmYP4zybFPSVU+ZbNctE+jDZejWS0IHFVUUiRjaf87TRYV4zPrPAG3V0Zcg/QLVyY86r7FU6gck1xtr9k=
X-Gm-Message-State: AOJu0YzWNMhRfj9+EarPEO5yTmrdECzwG9FXFuyeipQEqQ1lIuE6PGM4
	PEm83BT11c7PfhA1nQdE5BN7ViZsNqVjJWztbRiK2+P1RigK7Tm2ezgAqschgz8=
X-Google-Smtp-Source: AGHT+IHtDa+WL1PtRAqZKz8R9qMDJH8fi0fztybqn1RyPFxQ+b5TN2qWYsZdmT8gAJkLgTlOVLZZPg==
X-Received: by 2002:a17:903:2443:b0:1fd:70a6:ffbf with SMTP id d9443c01a7336-1fed26cb5eamr81351815ad.2.1721957822480;
        Thu, 25 Jul 2024 18:37:02 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::7a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f5fcd6sm20546485ad.218.2024.07.25.18.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 18:37:01 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:37:01 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Neal Gompa <neal@gompa.dev>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Message-ID: <ZqL9vYnNkQm_bSHs@telecaster>
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
 <20240726011224.GE17473@twin.jikos.cz>
 <CAEg-Je_7OeESAbQ0zBD=fuvY_WHE05vk0iR=Vv4Bq5vAc_qCJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_7OeESAbQ0zBD=fuvY_WHE05vk0iR=Vv4Bq5vAc_qCJw@mail.gmail.com>

On Thu, Jul 25, 2024 at 09:29:44PM -0400, Neal Gompa wrote:
> On Thu, Jul 25, 2024 at 9:12 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Jul 25, 2024 at 04:28:35PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > Python 3.13, currently in beta, removed the internal
> > > _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> > > it in the path_converter() function because it was based on internal
> > > path_converter() function in CPython [1]. This is causing build failures
> > > on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> > > version that only uses public functions based on the one in drgn [4].
> > >
> > > 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c69056ffc73/Modules/posixmodule.c#L1253
> > > 2: https://bugzilla.redhat.com/show_bug.cgi?id=2245650
> > > 3: https://github.com/kdave/btrfs-progs/issues/838
> > > 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/libdrgn/python/util.c#L81
> > >
> > > Reported-by: Neal Gompa <neal@gompa.dev>
> > > Reported-by: Sam James <sam@gentoo.org>
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> >
> > Thanks, this is more convoluted than I expected. Does this work on other
> > python versions, like 3.8 and above? I'd have to check what's the lowest
> > expected python version derived from the base line for distro support so
> > 3.6 is just a guess.
> 
> Well, I can't build it on AlmaLinux 8 with Python 3.6 because
> libgcrypt is too old, but it builds and works fine on CentOS Stream 9
> (which has Python 3.9).

Yup, this works for drgn on Python 3.6-3.13.


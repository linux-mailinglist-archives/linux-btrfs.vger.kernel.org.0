Return-Path: <linux-btrfs+bounces-9746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86999D0AE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 09:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64364B22BBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE117B50F;
	Mon, 18 Nov 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE5vcpz/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B850194125
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918421; cv=none; b=mjuET/WM14Jv95odNU+86Q9JhJr0u8oQ82q9SwDLjTuDOF4qBmto7rFNsqzwMYY+5SZOTJMW8boxn1mDBPMuGl/MgXZvJWWH8UyLDjbYFA4DzTyxaQAt1SWipT8iz19KMjDGmmsjLf5hNLpYIr9VZUlfjDqPdTb0cguTpddi99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918421; c=relaxed/simple;
	bh=7Xr9pbaOBx9lTURYjUQqLEMeeFpgr7S1BFnP/Ur1YBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcq5Rgu1tbxiPZJYjbyUu5ZvNjK+RSQeMuBKecjWaOyRzSsqRf0TQmqhk6PhnV6DxsqAR3e9QpXPm7bFFeHkieUPZaBMsH6CpL1RBGnKDY00P5yVZ5D/8loXLOeIQhdTsYKjNq1wB6MyAejJRBEIsS51ULqRobGR54RDm16QZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE5vcpz/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b34ed38easo3885921e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 00:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731918417; x=1732523217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xr9pbaOBx9lTURYjUQqLEMeeFpgr7S1BFnP/Ur1YBE=;
        b=BE5vcpz/F5WuRiVzR7DxmzS8FnMIMKENcMGoCpEiKf6KTxJp4tGqJJ89XMTuWkdVht
         A2ldOAb2i+NejVc5215ky/liXFgDap7jlhuYvo30inoE/2GPqVsjsMiFnvhNBW4sEoJM
         rK8mQTxBUl9DvCYG16imIYeMeAyc38yaJiMwXgLOF83Ju4HIJVPEXgbtFEqS7XHxSJIq
         Ws+i5FNRQtlmKSQPzMV/VObk0XvbqxVtcjeVekI34T1LUyASaUw+OzISIa5dP1/Lmx+c
         qj9acbkly1zt3tQAATLyVQukvFdo1DN9+d0rBcacwwKTBvy7VQrRR+xmgYjyo7OlQVJX
         m1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918417; x=1732523217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xr9pbaOBx9lTURYjUQqLEMeeFpgr7S1BFnP/Ur1YBE=;
        b=guoN5piM70edR3PUx/sCNg19O1L1MCPbhJl0Yr4pEQYZOX2IDh2kbinXbGZVf7/+kM
         QqMhnCjFXniIDSpkUgVYcP/rMlY1TUbBxu8lrC+AwqhjgdyQpj+9NOtycyNOD04olxNT
         HnMbgL5ly3TZTudgbPcmJiIpDtwZkg3xUQedgep6OFSg5ONY7P7fDtResiO/9OSORlog
         bfxIOjx3Fh2DxEBcfqtBkkxlScOzkGDOMbEF2VnhVPChShLDfQ/L1Fwz8KakwMzAh0vi
         nJHchArerhiHPjOvl2caqN/tJ6jlzMDiLvJCXF4X+Dybw5kRvoIdbGP0ZK9R6A2Cr2p8
         5sqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaBuZmA/J4k4Y0HzjuWk5Lxfr3a40tSvMoPz8VH3eSj1hqGaJAZxy02xIMb7tk2YGiuo00x/peMP0LrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx135bDYa1gfQt1dtZBs4koTwwfeVRcFYazy0otpVTj9Ej8FytW
	2oNidGJ7FX5PUWZsMt/ibEHhn3buf7YW1/H4hAIwhcwJ3QLXwlr/bL942iNNKq7mzJv90x3plQe
	a0zao4b7Hhbu6zxb1h20qwIU2yhQ=
X-Google-Smtp-Source: AGHT+IGDAWrQD6q5D/iRrDOjnlNyr/sIGrxjQy57RxEUX3eQ7gbesOYtxssnSfOGm745FfQ3rdjPJAzYsu/rvYeSDRI=
X-Received: by 2002:a05:6512:3b82:b0:539:a353:279c with SMTP id
 2adb3069b0e04-53dab2a7044mr4134986e87.28.1731918417203; Mon, 18 Nov 2024
 00:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
 <931d4609-6ad9-4232-a930-4c6866434a10@gmx.com> <770176d3-f1e6-46d5-8025-24610843be81@gmail.com>
 <d808ed2a-d255-429f-823d-ef4e29300a4f@suse.com>
In-Reply-To: <d808ed2a-d255-429f-823d-ef4e29300a4f@suse.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 18 Nov 2024 11:26:45 +0300
Message-ID: <CAA91j0VBG6izG_YzmrmYg=Frgb2=Bd0P2H5=0hek5m385ucwQQ@mail.gmail.com>
Subject: Re: btrfs scrub results in kernel oops does not proceed and cannot be canceled
To: Qu Wenruo <wqu@suse.com>
Cc: Sergio Callegari <sergio.callegari@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 9:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > And to switch off the laptop is a pain with full disk encryption and
> > grub taking ages to unlock the encrypted device...
>
> I regularly shutdown my laptop and accept the cost of LUKS unlock.
> But in my experience, the LUKS unlock only takes seconds...
>

grub is compiled for the most basic x86 CPU (i386) and does not have
any handcrafted assembler code to compute digests, so the time is
spent in PBKDF. The only way to make it faster is to reduce the number
of PBKDF iterations.

> But I'm using systemd-boot with an plaintext ESP partition (with
> kernel/initramfs in it), so the experience may differ.
>

Yes. systemd-boot does not touch LUKS at all, it is unlocked after the
full kernel is booted using all available optimizations.


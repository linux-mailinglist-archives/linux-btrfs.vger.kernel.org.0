Return-Path: <linux-btrfs+bounces-17877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D665BBE2313
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 10:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 783B34EE5E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ABE304BDF;
	Thu, 16 Oct 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEfsEww5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABD2040B6
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604076; cv=none; b=ndeAy2AHNcV+C+v2u57HqkXH+dQi63gRq7GeCE8diZzIJBfXIqBDXE0JWydRXAjtzT5dUMig+oeWGBFd6SHIJeUFX0p+seVrs76tPFfk/Oz1+2kqSeGo1vb3IF9LxEBTXnv8A0vfIjZXQxNqMLLpWeuDjuNwaIbI6PeaJZ0y+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604076; c=relaxed/simple;
	bh=btXTiMsIsAh/v4UCWIrETRspWEWJ9gl3jdaxpP75/Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOC2rXVj0QjZ4rOYOpgq1ICachS27HPY7xFOTMpfwY1tfPwTN5Xrw3G6elrzeLrVELiQxenzWuFnt6SrnOqsbDjZCMK2hmQSFEGDIjo6buVhVRRtBnkySxFyYgkULmkXK5S2mzf9QsBWdNRjHrl6tKMrhemNgi1ysXLiimUUdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEfsEww5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7817c2d90d0so6053347b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760604073; x=1761208873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btXTiMsIsAh/v4UCWIrETRspWEWJ9gl3jdaxpP75/Qw=;
        b=JEfsEww5HMUxYC4Cj2rtIl6LqDNNhzG3nYF2KOaum4xCTHD4Xwj7W4g8bf+uEtpuh+
         4o5CxKo/n7uWHUB8yM63omrISEuObfSREAuR3stdKjeQbgBxR3zaG1fNfq65WKXmSP/I
         4R30nPjidH1wL7BgPoY3YGxlty5PnsDTDyF12ZjiY8+CEJe0d025dcg1H/6TZVfLF0Ax
         cLzHnFci42AmveHR6uEETh70M6fbp5lNByu9oyAIyFOKNEubLAaNeei9iV95M9q2HPiP
         e+0ACz9JzDNW7jLDrPoIopJPZtwgJB9PuKdyNF/Z2DOVXa4QYfVR6lSnNqsV/1NXAhyr
         bOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604073; x=1761208873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btXTiMsIsAh/v4UCWIrETRspWEWJ9gl3jdaxpP75/Qw=;
        b=WWPeRFx3vOKGURqZh6hUYm5TCAG2RTB8d9OXmQ/tMO7HD+R5Hv964ZYbWjdNED3sER
         A/eWMxKqt+JDLdT1oC4GHLgEE7hS0P24XsgxMVLca1F94o5mgCutE0y1Iz90634+Bmq1
         bnXyMUC8cFHDDtceBXnqKdeL8Xf2557XUERDC0nyvmm7MhiQTYoGYUReg6Ffr9pwykOG
         UZD/HRvWgebxUVt+dWQLOi+cvKyMhcTNWio4DINYTEDVLV8+9XRVv8gAPGLaTQDY2/v0
         9I/De+DRrVHZlbiWPp0l26etaCu1iN9TCGzShIkYaMSbLZGVkAL3xd0axDsEMup2wO7Q
         c6FA==
X-Forwarded-Encrypted: i=1; AJvYcCXs2baKg8So5knJCePxknoKok1WW8chrvoiQrVuN1nVwL0LOst/MfUU1iDgWwBNmhXOTq3mdI+duXwWog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxthepjW53mqvRJzQ/Q8fyZkhMBAy+NtCd0HEliHcILt7eDb015
	7t8VZqL/VyoszmrDf899E3o2iCK1VRlIy6zqqOxL/B16wB0cC8D1LBEnzGGbW1Nr82Sjmjzh2jP
	NgsWgzkMlwGSeHaNf2Z5TXJrXS6bTjmHMvhr63MA=
X-Gm-Gg: ASbGncugVz+jxQkzfTwUgBtanpotMXrH//e8FdUXchEtsjHLnOXMmd0p0eXM8DNWMu8
	/pUiBcFuZKRKN/rlE84GiKjBWbZ/9KUEZkOpRV6NQPThupGgecGzVasQGSuXfQ9wtHYjOZ6AP87
	DiCcgIRpf1YBHm1Djl+uhD9MLOaIQ6U9AdQj20gjSSLDRKgbXhOE4B73/hzupgskHkeQrSkhqmG
	g0uFh7xESk1V3n4W96ACMWtS33Nz4QOInX2Np2ntXIcC8nULriqaSkuXlrPzxeyJw==
X-Google-Smtp-Source: AGHT+IFyGFN1oqvHmmmYzjrYbDAyYwcJfE6kvwTJInZsFESzdNU339FCOsozVA+HqgD5XAVSRrUzd0OnyYNV79Kk+y0=
X-Received: by 2002:a53:dcc2:0:b0:636:d3a:30d6 with SMTP id
 956f58d0204a3-63ccb903674mr20622061d50.35.1760604073305; Thu, 16 Oct 2025
 01:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com> <20251015111217.5538-1-safinaskar@gmail.com>
 <5517a3cd-1afa-4db0-bf8b-439f3ba410ed@gmx.com>
In-Reply-To: <5517a3cd-1afa-4db0-bf8b-439f3ba410ed@gmx.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 16 Oct 2025 11:40:31 +0300
X-Gm-Features: AS18NWBmNXMW-QAlwX4insQrzJRZIuFwkUsjMeZ4MxNOhM6GyiV7JvztudEBspE
Message-ID: <CAPnZJGC3Yt5E-+ShxVW2CcmAZAZ8ivbYGRkJ7g0v9O_09OH1Og@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, lists@colorremedies.com, 
	wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:01=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> I guess the difference is in the systemd's handling of user slice.

As well as I understand, systemd first freezes user slice using
cgroup freezer, then performs kernel suspend (which freezes
everything). I'm not even sure that these two terms "freeze" are
the same thing.

> Anyway, mind to test the attached newer patch?

I tested it.

in-win freeze_filesystems=3D0 - suspends instantly
in-win freeze_filesystems=3D1 - suspends instantly
as-a-service freeze_filesystems=3D0 - suspends instantly
as-a-service freeze_filesystems=3D1 - suspends instantly

Also, "btrfs scrub" terminates when it gets INT, TERM, HUP or KILL.

Also, system powers off instantly both when scrub is in a window
and when it is run as a service.

Great patch, thank you!

Tested-By: Askar Safin <safinaskar@gmail.com>

--=20
Askar Safin


Return-Path: <linux-btrfs+bounces-20385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD007D102D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 01:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EDAE301D9D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1141C72;
	Mon, 12 Jan 2026 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze6DwQhN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849F3207
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768177353; cv=none; b=GPyCviKMMx1uJYHoaQZQPBnnmJjbnGiF+lWsaDok4xpLKEokPkOzJnkliE9rPA7CxhA95PK6Td24ASUtgvvjIrv1qtzABzIJaHa6ao7GDyR6J0RI0khVg1AruhGgMlKjVQPi/Nu2eWbv9G1uKIS7q7kJQT+iz6xHYm1prdL5WaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768177353; c=relaxed/simple;
	bh=3w36CpKXgWPcAsZRFV2TXny++USKdmb5nZcg+oiZlo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cwclt7knUGqq6FeT3SAa/w5EmLTuAN0dXyGCy25V8f6nEtTqSWoagAUaLiJs7vJhZhGddH+AsUAx5ZHiYGnk4llg2WrAxbeininywdKrpiSAsuiK9QGyUZC4SaT2ebgT+NQwYoaScLstcDxhI3N1+bAtCbMPws9jEEDZNRyH3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze6DwQhN; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c75fc222c3so3041409a34.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768177351; x=1768782151; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXTlhjnQRg6/yQuQ43Y8rZ1XYQFpcE+NrqVK0PLSZBQ=;
        b=Ze6DwQhNI16C07f7KqHUP7LPuPJHkRMx6282qLDy9/hZXDFFcW7Ev0wtSwa6EZaFxn
         J6XRl/sse/xagjXVOqmaM+U5I73IBlsQGJQ+ITGL324F/XsL1v8clStluibQiDg4+T8f
         vMV3hA3vmsOig28XkFE1D9oftNQRJa9o+0RM9J7Oqc6vJj3XFi2Wdnu9SSd4XRLquGlQ
         HiVL51Xg/4/V9/yIkgO1p8WlZdMhSaxtRoyFRGgAOHFfq8MPEBrq0GRwGSDUEJDCsPOK
         Ew8ZNoagnaKQ8/g0DzAVcv7+fGpsp9foz+AJ95FOEF5jc+lhiYyYQAe8b76sXKEwiY1f
         k/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768177351; x=1768782151;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXTlhjnQRg6/yQuQ43Y8rZ1XYQFpcE+NrqVK0PLSZBQ=;
        b=kXcdfiDmRzLuMe7y4ACJVQW4qeUqAbZvpjt1fTIaj0RJ69Alccp5sEGAYo9lK/dTVn
         b6d3XAWEGNTHTDLVc/MTpnIEFCn3uJVzr0bczt2LUe1mylLE16uftr7vFrdp356jjraE
         y5B5p2XrFWEG+WvEMmRrGjmh0ce2m+mLjP3DFJZfianm8ZvnoECqLSYv9r+quOddWtaY
         ICkPoR+cXA1PFRWWUvkj5fE4VoH5492b3yMEkkjRT79TL1rEAgbbH6pRaLC8VmNExyCH
         bhhyHoVHjCDGB4OzeZb5ZIoREZQIB5CB7sKJrTP7Y31S7+jZQTWwjqo9bA9MIskpHCTV
         gWIw==
X-Gm-Message-State: AOJu0YzcvQR+MKi37gZ3r1x3dBapKr4WjSkGKwMDcFz8zLSD7C9ZmKCt
	bQ1kUS21FXV19eNIbXilxxFCtXuxZKsLMWiSc8OjVX8nlKqIFJUMj7Hu0yq1q/KZcmNoh4rGw/b
	2nnQcCWth/br3NXJQ6vKgO68z3JSYdyPVL2HKGsY45Q==
X-Gm-Gg: AY/fxX6RLwJEa393ILtgi7kuEPe7E6IKbhoGVLntIQRqzgJsf9q/IcHk/U2dkxDI2wK
	cx+MLaOFMIxLBT1M2j/wOc5u91U6LS+8rPQXaDvjb8LFGme1e/ErJ+VUFty5E9Mcrdj+0sLyZGz
	AveQr4HPWDFhAs/UvCRd9O9CuWTEwiNt0sKifcv+Aag08QCcsM/9GFZsz75JFoSBGZ8hPmor+G2
	yZB+gTvFzdRbkhNk1kg+BTjh6RytsSJP/+hE8AKDYdCWm4M7nMkthAvaFRv/0de+BKIOar5lw==
X-Google-Smtp-Source: AGHT+IF2fGLbHZM8ueK1pFFTBGRFmfp7spAU5Mz8mLFL7uJqvZrJ1HGB+jKjr8lExTNIXwIyhwQkomgb1x5CV5dM2gM=
X-Received: by 2002:a05:6830:440c:b0:7c9:5b32:b0cc with SMTP id
 46e09a7af769-7ce509f89e8mr9523893a34.19.1768177350663; Sun, 11 Jan 2026
 16:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsN7SjNjnn9BRPXr6OK_aZUxs89RVWyX5HFi=S+Ri3tadA@mail.gmail.com>
In-Reply-To: <CABXGCsN7SjNjnn9BRPXr6OK_aZUxs89RVWyX5HFi=S+Ri3tadA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 12 Jan 2026 05:22:18 +0500
X-Gm-Features: AZwV_Qgb_L4RiS_AH0kf5XjGVpL3A644_fXWk2YSF8aNtV9QNnCS8FdUgFhVxFc
Message-ID: <CABXGCsP1dXnutvM9pUNyZavJTTRpEeJsVNzzyVJqbVasz0=dXg@mail.gmail.com>
Subject: Re: [BUG] btrfs-progs 6.17.1: btrfs check --repair aborts with ASSERT
 in delete_duplicate_records() due to overlapping metadata extent
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:15=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hello,
>
> btrfs check --repair crashes 100% reproducibly with:
> well this shouldn't happen, extent record overlaps but is metadata?
> [17101544210432, 16384]
>
> The crash is triggered by the ASSERT in delete_duplicate_records() at
> check/main.c:7583:
> ASSERT(!extent_record_is_metadata(rec) || !found_overlap);
>
> Backtrace attached as backtrace.txt
> Full output of "btrfs check --readonly" attached as readonly.log
>
> Environment
> -----------
> btrfs-progs-6.17.1-1.fc44.x86_64
> Filesystem was unmounted
>
> Image
> -----
> http://213.136.82.171/dumps/sda.btrfs-image
> Size: 5.4 GB
> SHA256: cebc3493672d166726c8e05c2492882492cbc9a957be5d1c056dd47b76eaaba9
>  sda.btrfs-image
>
> Superblock + btrfs fi show attached as superblock.txt
>
> Key symptoms
> ------------
> - thousands of transid verification failures (wanted 213059, found 213019=
)
> - hundreds of duplicate extent backrefs in the 17101544xxxxx range
> - multiple inodes in root 5 report "some csum missing"
> - extent tree contains conflicting metadata backrefs
>
> Request
> -------
> Please relax or remove the fatal ASSERT and add a repair path that can
> safely handle/delete overlapping metadata extent records.
>
> The image will stay online at least until the end of February 2026
> (can extend if needed).
>
> Thank you very much!
>

Hello,

Sorry for the gentle ping =E2=80=94 I=E2=80=99m trying to understand my opt=
ions and
don=E2=80=99t want to spam the list.

Right now `btrfs check --repair` aborts (ASSERT in
`delete_duplicate_records()`) due to overlapping metadata extent
records. This filesystem contains a large personal library, so I=E2=80=99m
trying to understand whether there is any realistic recovery path.

Is this ASSERT considered an expected =E2=80=9Cstop here, too risky to
proceed=E2=80=9D situation for `--repair`, or would it make sense to handle=
 it
more gracefully (even if that means skipping something or continuing
in a degraded way)?

If `--repair` is not expected to handle this, what would you recommend
as the best next step:
`btrfs restore`, `rescue` commands, mounting read-only with specific
options, etc.?

The filesystem is unmounted. The btrfs-image and logs/backtrace are
still available at the same location from the original email, and I
can provide additional info or run tests if needed.

Thank you for your time and for maintaining btrfs.

--=20
Best Regards,
Mike Gavrilov.


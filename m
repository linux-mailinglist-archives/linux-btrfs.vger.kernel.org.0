Return-Path: <linux-btrfs+bounces-7106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211494E3D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC2DB21A6A
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C07165EEE;
	Sun, 11 Aug 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b="AYbKxEbd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836215FCE7
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418913; cv=none; b=tNtzwXlmrJoe22ax1nEIZewvU41Z0ZMEHlrBsuxWNPB0hCVxfrQCjTdYA19GcpZE9U4BNQ6YMbDhQMTMHENTQ7Zz60GuQYq7WIlaZDVrHJtAGJERdUGd178k7tBp6QqwYnPlWA8sgsXba1SgiV9s0Yg5Zww6y708u2HdsOi8JeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418913; c=relaxed/simple;
	bh=e2xN/7dIadoRJcsPnWUwLRgXsT/UJDA/2f0HT/8llSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB3JUPLgkrI2fIhn1nfQaCg5DkvKOuMwoquCQWh+ay1P600aBnQuo7/vnQosASUuJRxB04XmLLIVcZ/JVcp1ve1ySf7iiV6GwJDJDH98YNsV6Mt0fouvpgt1zmIDNWK+qIcTzSGLsSk+kvcLDW0xif0BFQttxdW9dwz+WFLdAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe; spf=pass smtp.mailfrom=kota.moe; dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b=AYbKxEbd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kota.moe
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bba6ced3d4so19396566d6.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kota.moe; s=google; t=1723418908; x=1724023708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCZ5fZwC7KhWRYTXvX+QgaO6YJwLeb7/gRk3nkMJa6Q=;
        b=AYbKxEbdtDG0IgrTs69kBO+iIJ4PzCvqdPFwlDOobrbcjnsgMhPebszMvCTdyHe5R8
         Is7ICIdCNSy8HhbFcD9lX/sC5VL8OwGmTCaqct3sfYj7t4JXNrvCk8UowY5LFSnf6QFK
         TWEKSJ0aEG09x8665rnUuyUP8NDsSkiBlMUPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723418908; x=1724023708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCZ5fZwC7KhWRYTXvX+QgaO6YJwLeb7/gRk3nkMJa6Q=;
        b=dxJi9JhrtCudGRxychE01eV8lKGsyC1PJSmX138o6SJCBx5LOEH9HxF1cVHHRraegr
         RrU8lBrqaFbj6oeifqMNtjCSpfUXaKwNgZ5aNAjKV9DTGzar6+cqDZHZEVI/+Y2DJHSE
         UPf7pXeq+kIG/Y6u3h7XyatI6eoBExEmZRJslzCGNzaIBTiSlTPWN2vaNapAg9nNrLWU
         F55/z/0FLEk8/CoPdLnGd5GNXQPyVXO9PAe6jJbZ+IypQAQ37tawj1PzVVPU/VAoPAMx
         68mF5WTLdsxz5vVypD5mX8JEsnA0dBS28sKXEF9tNkLm6V/+tSuwx1cMi1aa3/I2czkT
         Ph+A==
X-Gm-Message-State: AOJu0YzlEGJkz8rQ8vpMfLKjj+W39XeDiLsUOLyebiyy9Z4yZIU+xMj8
	Iv/7GUo8gWmLd6HC0zW15JXhUiPKUe3k1HO8mEJk388rl/qVoWbsxHHuy0lBdVOOuub6CnYwW8K
	4WbLdKmSrHW3RrWXXmMM04Bb06Ui7hrhY5ihuCGwvF4Us1aIMfuE=
X-Google-Smtp-Source: AGHT+IHGHWCAYbdSklS6OK1TR1zhJXCPoSjL2o6zPYuF1CifTvZ6REyZiNfdgwSqD1ACPsX5t88RlHbRImMnA15RHxs=
X-Received: by 2002:a05:6214:4407:b0:6b7:427a:dc35 with SMTP id
 6a1803df08f44-6bd78d1e4f6mr68970056d6.9.1723418908427; Sun, 11 Aug 2024
 16:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
 <5c42a8a3-6571-474a-936b-df13057ff0ea@gmx.com>
In-Reply-To: <5c42a8a3-6571-474a-936b-df13057ff0ea@gmx.com>
From: =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date: Mon, 12 Aug 2024 09:27:52 +1000
Message-ID: <CACsxjPbjbBFV1YBSfMSN07kx6qoNrFihVC6oqZOmrtZgKHYytw@mail.gmail.com>
Subject: Re: "inode mode mismatch with dir" error on dmesg
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 at 09:14, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> The corruption itself looks like a very basic bitflip (0x2 -> 0x0).
>
> Please run a memtest first before doing anything.
> And also please provide the CPU/memory models just in case.

If it was a bitflip, it probably happened on my previous machine
before I switched to ECC memory (~2022)

kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ ls -la
ls: cannot access 'safebrowsing': Structure needs cleaning
total 0
drwx------ 1 kota kota 24 Jun  7  2020 .
drwx------ 1 kota kota 32 Jun  7  2020 ..
?????????? ? ?    ?     ?            ? safebrowsing

But just in case, here's my current CPU and memory:
 - CPU: AMD Ryzen Threadripper 3960X 24-Core Processor
 - Memory: 4=C3=97 Kingston 9965745-020.A00G (32GB DDR4-3200 ECC Unbuffered
DIMM CL22 2Rx8 1.2V Micron E)
(ras-mc-ctl does not show any uncorrectable errors)

And my old machine:
 - CPU: Intel(R) Core(TM) i7-6700
 - Memory: 2=C3=97 Kingston 9905625-036.A00G (16GB DDR4-2133 Unbuffered DIM=
M)

> And for the repair, the current btrfs-check is not able to handle them ye=
t.
>
> I can work on btrfs-progs to provide a fix soon, but that may take
> several days.

Thanks!
And no worries, this isn't urgent (as I haven't even bothered to
report it for the ~years it's existed) :)


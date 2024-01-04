Return-Path: <linux-btrfs+bounces-1253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB5824AF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F51F2304B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB42C878;
	Thu,  4 Jan 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjHWWmgs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04502C861
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a277339dcf4so109403266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jan 2024 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407909; x=1705012709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amkSxiZ5m7CJE6LooWc1dsGW8gx1DGcgP6BP5DLz8t0=;
        b=TjHWWmgs8aPiRa0qyxcrnUTMf+Wfgh/I7ONbukPq1grtGzr1lgdxLYNBjWGTKOHwqV
         ZSN13OHsHh2d+m/mQ8urgZAxgd8owjnv4IkKjOh1KhRS9HAWlrQNV75Rm2WD4gB9N4jQ
         RVa0Da4K9g6mbwQq+9gND/vyQnd58ANdp+fMBBWjmQLJ4sQFQYiq54/i/FI0k6g0iRgo
         I+bdo9gDm6CZ68R6Q2AwowrnAEBt1erfsbro7dO51t5aGa4wKbeBtQR4fP9LKw9WW8Et
         MclznN/BRwIfDZCaHrd9idC/k8ZnHpywK+Ne3TQRpQJn/5aOa31kq/gMyn88cAF5d6+1
         TbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407909; x=1705012709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amkSxiZ5m7CJE6LooWc1dsGW8gx1DGcgP6BP5DLz8t0=;
        b=seDnIfQ10TpXV/uXj6w1VMQ9G9QDFYiY1YD+4LkhuDsQiW6VQ65XiFHJ70ylB/zDh9
         RqHdFpV5gXbQTysqtHX6FwCGvNfKY01HvM/a43V36Z+FmoGERz43mJ0+8fCgnrma3lsI
         Ut3LRH97wE7t+vvH3iTXwDOwher9IrWJn+cZeQgQv5b4QwdPGCgKbyANXF6BE7VJc5P1
         PecFPUq1zbN9M9dsDK7CSwPgGvp2GmBYQEZFoJo+QQBViFf1DMiEN+Sp/jUlTM6+uehR
         IwRnmtrc0DkjNomm0t+FGLhzAFNqFZRvH4/5iAT2dUH7beH1T9wBn1I+gjy8Z8JxE5VR
         EFhg==
X-Gm-Message-State: AOJu0Yxf6BcvRdqcEs1Y0i89FRiHD65tmpIbKa9fr4cCq2CXLMtKDngl
	LXIM/NnGjAmFpZgW8J9u/Df2bf/s7prEp+4cGsM=
X-Google-Smtp-Source: AGHT+IF3Y34RfssiUGISl4vxLnmTfRFcmXtRpJjQS8LHuYCXavWCALmWc/YZ5uQxcEpWMkQqMXQIuDmE+3zsbi1iRPs=
X-Received: by 2002:a17:906:c013:b0:a24:457d:9b31 with SMTP id
 e19-20020a170906c01300b00a24457d9b31mr712120ejz.91.1704407908664; Thu, 04 Jan
 2024 14:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO0vF5EHAiLsVvi=tvERS4gS+AeGSDWHmZxcf-mBQtDaQ+UDBg@mail.gmail.com>
In-Reply-To: <CAO0vF5EHAiLsVvi=tvERS4gS+AeGSDWHmZxcf-mBQtDaQ+UDBg@mail.gmail.com>
From: Matthew Warren <matthewwarren101010@gmail.com>
Date: Thu, 4 Jan 2024 17:38:17 -0500
Message-ID: <CA+H1V9wj+0B-Gs7NBBnj4dG4pLCQ99HVOe3g-tuQicJTLEiw-Q@mail.gmail.com>
Subject: Re: BTRFS Broken, Help
To: Isaac Chang <isaacchang673@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks like one of your drives is dead or not detected. Since your
data was stored using RAID 0, any file larger than a single RAID 0
stripe is unrecoverable (not sure what the size is off the top of my
head). Anything smaller than that is either gone or still accessible.
At the very least you do have the list of all files since metadata was
in RAID 1, so you know what files existed.

Matthew Warren

On Thu, Jan 4, 2024 at 10:45=E2=80=AFAM Isaac Chang <isaacchang673@gmail.co=
m> wrote:
>
> My Server blipped and upon reboot, the Cache Drives (pool of 2 devices RA=
ID 0) are now unmountable. I can mount the lead disk in CLI and peruse the =
files but if I use MV or CP or rsync, I get Input/Output errors. BTRFS rest=
ore also yields Input/Output errors.
> Using the instructions here as this is an UNRAID server:
> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/#comment-5=
43490
>
>  root@Tower:/# uname -a
> Linux Tower 6.1.64-Unraid #1 SMP PREEMPT_DYNAMIC Wed Nov 29 12:48:16 PST =
2023 x86_64 Intel(R) Xeon(R) CPU           L5638  @ 2.00GHz GenuineIntel GN=
U/Linux
> root@Tower:/# btrfs --version
> btrfs-progs v6.3.3
> root@Tower:/# btrfs fi df /temp
> Data, RAID0: total=3D887.40GiB, used=3D606.95GiB
> System, RAID1: total=3D32.00MiB, used=3D96.00KiB
> Metadata, RAID1: total=3D3.00GiB, used=3D1.05GiB
> GlobalReserve, single: total=3D117.83MiB, used=3D0.00B
> root@Tower:/# btrfs fi show
> Label: none  uuid: 15b03357-29bc-43b0-bfbb-b306a3611d8f
>         Total devices 1 FS bytes used 408.00KiB
>         devid    1 size 1.00GiB used 126.38MiB path /dev/loop2
>
> Label: none  uuid: b53ef962-5a9b-4c35-98a3-33ff77ebaac5
>         Total devices 2 FS bytes used 608.00GiB
>         devid    1 size 465.76GiB used 446.73GiB path /dev/sdg1
>         devid    2 size 0 used 0 path  MISSING
>
> ERROR: superblock checksum mismatch
> ERROR: cannot scan /dev/sdf1: Input/output error
>
>
> Attached is the dmesg output.
> Please let me know what I can do.
>
> Thank you!
>
> Isaac Chang


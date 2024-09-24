Return-Path: <linux-btrfs+bounces-8182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C40983B94
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49CB284233
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B803C463;
	Tue, 24 Sep 2024 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzwfDR/H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136938DE0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148551; cv=none; b=YJwvQAYsp+2pWT8k6kXjCz8LKEqvIEqvpPdCkG0We21prYkIs1wsGnH9f/pmmQFj/hm6DsxD4BLpO1xpaTmRg91SCYmiRFVcv93aFVGRtpN412zEkwJiO55Lm7ueBzzLTds3QM8gKT6p7h625F1g3m0C7/NpQJQIA3h+VjyzIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148551; c=relaxed/simple;
	bh=aDOv3Mrx700zGrW5KcHr+Y8xiCP+jEHJHi89YUSmfxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K+6aKn9R07KkjkeJ3JusqdLO6ab2NJn/niSpqM4bo9bF8la3giLzLOOUs+D/nZ/iK63wzs6KdGuEf2tuDM9MkW9u+gRnMj4cad0FPEzqqz0H/iJSb44j5edF/W9arTTOqBBrZ7s1BXTOhiBTQWejVsGGcxVtY6zUnRGOn6QWz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzwfDR/H; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e1b50fea4bso2905449eaf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 20:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727148548; x=1727753348; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm18dXK7jv6FB13lYv1Jv+QK1PR7/hJg0kW/xI3kuwU=;
        b=GzwfDR/HRf9H4mL4/28NFy2U4NwHI6KbuDdfuVWqcZUrf2fRfbSXrR/cINZPd7AMKJ
         o6wd6/dV77F2taQ6V/sS3rTtGJU66MVXESXwanCJjIywJhQRiR+F63yWleiWcOHAQ6rf
         TDMjO6342uZnF6MFuhYA5xgdvVr/lj9ZvMOIL6r6I0V90CzQRa1+eabMyDONmiG8a148
         KrA5edlpBWm8heJmzkvCbX3exOMqDN6v7rZ3Rv63pFKOLRlKszZ6PfWCvzqRSvjiK08w
         2wZyow0zpX6rhe/MzBTyyUxEJWwTyWTJ9GPZ1pbXPnkdmb5YtNMKPTwhmXX9i49v/ntd
         AvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727148548; x=1727753348;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm18dXK7jv6FB13lYv1Jv+QK1PR7/hJg0kW/xI3kuwU=;
        b=MiXxXPt0m++FP/36I8g7GsJob5AOE9HpJ0/5Lkw+67LpQULZ+kqIWMw4UGxFANqSLU
         BsAOyq4nYYNIzmNC1mYHl4zEZr1XkOifOlEuTYnN7O3N9fjXAxuN5XoX/2QjRkDblb4S
         L6RPExA9bA8q/1AsAyYb4D/VDRKHsViquCqbXxup2BYKywcxiFCFWGxSFB4ritI/yQtE
         +UOjSus6+STkRs+olKToHGN9COOWxu9dsAG8H1p7Mw/Vo/Bm6EVxCAoMjMQ4mqfEKBvl
         xjSbkDlwGiXu0u06LtSl/zsRqH2uqkUiEPkyKzbCrBqZHnn5i3zSFJHWyYFOPV3P1hpP
         zGkg==
X-Gm-Message-State: AOJu0Yz2C/YmL6uRUxdclknxdrcjMwBqo7EFMEf/SbAACDI4geDGBzvI
	A14ZaZkiU78Eg166mUTEChITO9nrom0uUocJWUFff+QzWe+nAbehfczZ9bVbj3HvG2ZlautrE4S
	d1OROVj4gTnBn6RLpxoisGsHJ39h5iiG0Mn4=
X-Google-Smtp-Source: AGHT+IGUb6umNyufBP6+I1F1D42czGyfzj456TK0BbAu8+Su+eAjduXBju0LnpLeq5DIcxQEMbgV06WU8LUx+VQoWTE=
X-Received: by 2002:a05:6820:22a6:b0:5e1:ba38:86e7 with SMTP id
 006d021491bc7-5e58d1a45edmr7276112eaf.5.1727148548242; Mon, 23 Sep 2024
 20:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
In-Reply-To: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
From: Dave T <davestechshop@gmail.com>
Date: Mon, 23 Sep 2024 23:28:57 -0400
Message-ID: <CAGdWbB6zrx=dGs4=Q+7NLXxRFOovGcm3xuZEJtAxpfQF2kicwg@mail.gmail.com>
Subject: Re: Filesystem corrupted
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding this to my message:
I'm running Arch Linux Currently on this kernel:
Linux 6.10.8-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 04 Sep 2024 15:16:37
+0000 x86_64 GNU/Linux


On Mon, Sep 23, 2024 at 11:23=E2=80=AFPM Dave T <davestechshop@gmail.com> w=
rote:
>
> Hi. I hope you all are doing great today.
>
> My errors, shown by dmesg, are:
>
>     [  +0.000001] ---[ end trace 0000000000000000 ]---
>     [  +0.000045] BTRFS: error (device dm-3 state A) in
> __btrfs_free_extent:3213: errno=3D-117 Filesystem corrupted
>     [  +0.000040] BTRFS info (device dm-3 state EA): forced readonly
>     [  +0.000006] BTRFS info (device dm-3 state EA): leaf 253860954112
> gen 33587 total ptrs 44 free space 7040 owner 2
>     [  +0.000006]   item 0 key (227177136128 168 4096) itemoff 16165
> itemsize 118
>     [  +0.000004]           extent refs 6 gen 135 flags 1
>     [  +0.000003]           ref#0: extent data backref root 490
> objectid 426314 offset 0 count 1
>     [  +0.000006]           ref#1: shared data backref parent
> 266540040192 count 1
>     [  +0.000004]           ref#2: shared data backref parent
> 266489888768 count 1
>     [  +0.000002]           ref#3: shared data backref parent
> 266355113984 count 1
>     [  +0.000003]           ref#4: shared data backref parent
> 254191386624 count 1
>     [  +0.000003]           ref#5: shared data backref parent
> 253776723968 count 1
>     [  +0.000003]   item 1 key (227177140224 168 4096) itemoff 16047
> itemsize 118
>     [  +0.000003]           extent refs 6 gen 135 flags 1
>     [  +0.000002]           ref#0: extent data backref root 490
> objectid 426315 offset 0 count 1
>
> [ many more lines similar to those ...]
>
> 1
>     [  +0.000001]           ref#1: shared data backref parent
> 267180081152 count 1
>     [  +0.000001]           ref#2: shared data backref parent
> 267147689984 count 1
>     [  +0.000001]           ref#3: shared data backref parent
> 267079172096 count 1
>     [  +0.000001]           ref#4: shared data backref parent
> 266967515136 count 1
>     [  +0.000001]           ref#5: shared data backref parent
> 266640392192 count 1
>     [  +0.000001]           ref#6: shared data backref parent
> 266567483392 count 1
>     [  +0.000001]           ref#7: shared data backref parent
> 266540072960 count 1
>     [  +0.000000]           ref#8: shared data backref parent
> 266504208384 count 1
>     [  +0.000001]           ref#9: shared data backref parent
> 266489937920 count 1
>     [  +0.000001]           ref#10: shared data backref parent
> 266355163136 count 1
>     [  +0.000001]           ref#11: shared data backref parent
> 254357438464 count 1
>     [  +0.000002]           ref#12: shared data backref parent
> 254230626304 count 1
>     [  +0.000001]           ref#13: shared data backref parent
> 254217519104 count 1
>     [  +0.000001]           ref#14: shared data backref parent
> 254191435776 count 1
>     [  +0.000001]           ref#15: shared data backref parent
> 253777051648 count 1
>     [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
> find ref byte nr 227177795584 parent 266504192000 root 490 owner>
>     [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
> delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
>     [  +0.000017] BTRFS: error (device dm-3 state EA) in
> btrfs_run_delayed_refs:2207: errno=3D-2 No such entry
>
> The drive is a Samsung SSD 970 EVO Plus 2TB.
>
> Overall:
>     Device size:                   1.82TiB
>     Device allocated:           300.04GiB
>     Device unallocated:            1.53TiB
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                        299.07GiB
>     Free (estimated):              1.53TiB      (min: 1.53TiB)
>     Free (statfs, df):             1.53TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              398.55MiB      (used: 16.00KiB)
>     Multiple profiles:                  no
>
> Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
>    /dev/mapper/userluks  298.01GiB
>
> Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
>    /dev/mapper/userluks    2.00GiB
>
> System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
>    /dev/mapper/userluks   32.00MiB
>
> What is the recommended course of action given this error?
>
> What other info do I need to share, if any?
>
> Thank you!


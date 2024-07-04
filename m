Return-Path: <linux-btrfs+bounces-6193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAD927461
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873A52823E8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D11AC225;
	Thu,  4 Jul 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLtjorL6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72611AB91A;
	Thu,  4 Jul 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090238; cv=none; b=sJEtDfJ+lH2vL19DRmKLTr0ItRxKJRlW6ujlidEwfouWUYLvFSFHcELzrH8TPfHbuM6daukGrD3pNfS5qfvDi/SL8bZgzcFHjv9+JLd2/Ls2LjYz9Fs/Gq8Du1VI91vDLtk8MW9fKQQ/fe1mGnaufe1ggjSi9zLTMUwDYHH23xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090238; c=relaxed/simple;
	bh=LzvgPwYFjl1MDjfcUuUst3k5dNh3iceb4bK4QJzJpHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxDhcY96her0zxctUyNHx+Q8q+jD0Sob0kDEbxww+HO2dFkdgz5hrrl96/rRCNbiOm8wzmYZvvDx4RtVrrF7H68t2RYGakul6P6Fx7OSIy9HDGtNK//XHX+pfBlaeEIvLyACTlqVtfLXzOLTJ85kHI2H1cgMlXNLbeV3D8CxneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLtjorL6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b57fea1518so145896d6.3;
        Thu, 04 Jul 2024 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720090235; x=1720695035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXhn73RRUDapGKjVhIDQZks7sX47YFwkaiUfPLQi+LU=;
        b=aLtjorL6bA6c9/UYPH1f+bM1bFcA8pDhcemENuiDxQGdsNAMFGVYt5bV10vB/0oD2a
         vPfKOdtt4lsSN0GuJ2ZuOH41mCka0gNb2cvGrWoD0xfHBpudqDZaweA7hEjxoekh77UC
         h3NEWX0TSWmqjXESXGbP19pBidBbovmpnpekA82GZreR4VaZ7w/fokUrEompxtMaxh2N
         Vdm90SNuYr/KQftJ02f5Z87HKadoooOv4fVujWaq6guX/grgn0E4k8eTkju9yDs83OpG
         FScmboSc7re8fjHekjGRiCzSv72RDFqLuDdKywWjKReznVNFtzRhzymm2PfrcLNy685h
         /p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720090235; x=1720695035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXhn73RRUDapGKjVhIDQZks7sX47YFwkaiUfPLQi+LU=;
        b=IExwjKajjrQZudNH6u6/IIJnXrXm+cNrp1EF3r4i2k/y6FvWyuvLdzLTFEtG5YRZQv
         EBFx6vv7/HmhooDIcQygeYsula3it6d+6/Y5ikgT92LlvmhFyb+IIdEUbEKRE2rqODjE
         RWjMeGPKnK9KzSfS1cKraVjO0axsfIwbcBS1x0iT4Cfy3fyhZl/lT3k8F+85TQYaD/QI
         ZeOvGgQkrS96HsI0R8IHAluIACamMopIeJd4Nf7h/4OQH92SfBoF0x0TNRHlfgzGGO2u
         Oj//fdAl+x/yAon5NYiS9QR6nRqdIW4tBG7B2TCg63SPXH+VeJ366nbD912LsMQRPEEy
         9dcw==
X-Forwarded-Encrypted: i=1; AJvYcCWqDLzIEjjti49ZX2t0sG1c32lJzK17tBIi0mZONOqI2q2zLIHpnrzNkKllUHjJmHlPKzjMikmaf90DiAp+9EvUDILvwwSntyaavc430M5U8AdFBdxAYgGSi/BT2IPVqNM+q+a2rR8nqGc=
X-Gm-Message-State: AOJu0YwO7RAOj2ouS9gxHldIiBhcCx8Gn+HtWsc3+aWkUdK01AB3ILDP
	JfIdG6R/P2LcVx8VDu9a31T0ff+eHfWL3vdYW8Vm9c93JLMRHzgXrj1EVGDT3PzYRwr4tRDvbgh
	9bIHIUnOhsw8FeoN4ou2xmDAXhGE=
X-Google-Smtp-Source: AGHT+IEtUOsGI1TnADSbJoqipSkoFyTTrpaJCe39ZwWdA4kT6SzSpuwXn0xDHVu7FzMr9IUdPeE8E3JR4XUWS/ZVhw4=
X-Received: by 2002:a05:6214:4106:b0:6b5:ddc3:f610 with SMTP id
 6a1803df08f44-6b5ed2e2cb2mr11224536d6.6.1720090235325; Thu, 04 Jul 2024
 03:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com> <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 4 Jul 2024 15:50:22 +0500
Message-ID: <CABXGCsO58RJo23-vitp5+XY_nsq+xEA11LUC1-iwgBZYWQKPmw@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: multipart/mixed; boundary="0000000000007581fa061c69b71c"

--0000000000007581fa061c69b71c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:57=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> I wonder if you have bpftrace installed and can run the following
> script while doing the test:
>
> $ cat bpftrace-em-shrinker.sh
> #!/usr/bin/bpftrace
>
> tracepoint:btrfs:btrfs_extent_map_shrinker_scan_enter
> {
> time("%H:%M:%S ");
> @start_em_scan[tid] =3D nsecs;
> printf("%s enter shrinker scan %ld nr %ld root %llu ino %llu\n",
>        comm, args->nr_to_scan, args->nr, args->last_root_id, args->last_i=
no);
> }
>
> tracepoint:btrfs:btrfs_extent_map_shrinker_scan_exit
> /@start_em_scan[tid]/
> {
> time("%H:%M:%S ");
> $dur =3D (nsecs - @start_em_scan[tid]) / 1000;
> delete(@start_em_scan[tid]);
> printf("%s exit shrinker drop %ld nr %ld root %llu ino %llu | %llu us\n",
>        comm, args->nr_dropped, args->nr, args->last_root_id,
> args->last_ino, $dur);
> }
>
> END
> {
> clear(@start_em_scan);
> }
>
> The run it like:
>
> $ ./bpftrace-em-shrinker.sh 2>&1 | tee em_shrinker_log.txt
>
> And provide the log file.

I applied all four patches and still not seen any improvements:
6.10.0-0.rc6.53.fc41.x86_64+debug with patch (1-4)
up  1:02
root         269 27.9  0.0      0     0 ?        R    10:00  17:29 [kswapd0=
]
up  2:00
root         269 43.7  0.0      0     0 ?        R    10:00  52:47 [kswapd0=
]
up  3:00
root         269 40.5  0.0      0     0 ?        R    10:00  73:22 [kswapd0=
]
up  4:00
root         269 43.9  0.0      0     0 ?        R    10:00 105:30 [kswapd0=
]
up  5:00
root         269 48.7  0.0      0     0 ?        R    10:00 146:22 [kswapd0=
]

Also, I attached em_shrinker_log.txt in the archive.

--=20
Best Regards,
Mike Gavrilov.

--0000000000007581fa061c69b71c
Content-Type: application/zip; name="em_shrinker_log.zip"
Content-Disposition: attachment; filename="em_shrinker_log.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_ly755bty0>
X-Attachment-Id: f_ly755bty0

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
ARR9hmZQSwUGAAAAAAEAAQBZAAAA6AUAAAAA
--0000000000007581fa061c69b71c--


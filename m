Return-Path: <linux-btrfs+bounces-12171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5555DA5B5E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 02:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337D6171585
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F31DF977;
	Tue, 11 Mar 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4qQe+t/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F85258
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656885; cv=none; b=IJYtI/Joiv+f1ceD/KUE9cwIgj5NiKi3rZMTIcNYmjyyCKVXjKGEKuc6g2s0dtFKd9SF+8yck1s50+De5sP4pzVJ2eu0ALTulJIfr36wbLPHKiU7h+QN3Hlkv4Q4Xw9OklLgO4Z2Lk39yQP+TLbByXM8bldRO/4JSwW5klt4OfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656885; c=relaxed/simple;
	bh=X81dBr9K8rb8dgHiH+CemlErbZie0FubBiuPY6C3BHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxAT+KswMSS1/dofN/nirwTMdO8ODOJenJH/NBYOlgxqVbf4qOYaisP1DqERwVpR5FnYa22rgmPXuGNnwE/gg8GbZDD5Be2ShNCeraQczdQ6RS684gExW+XI5jB46KNpS8qm3A8OfQzl5LFrIkhfp9oGOhTd5TBS6bs7LWRbSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4qQe+t/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso28498015e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 18:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741656882; x=1742261682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM4KkEf/P5NxSo/MUyS42qVxhLKKfLwn29NIgfvBYQc=;
        b=V4qQe+t/qn2V90f+6cUWhFWaA04f7M4lRf3ogTx5AA+Nn7l4cuwvyV9DdRULu+iRUF
         Xs3BpRcfRNtkGaxlnXD7MSsM+u8k6UpxoONOG+QReuTqH1Eb6QUsL31B0iTw5PlJx47q
         q2qqyOoNEGlC86qzDMlNuAgE377dEAmyRcZITnVjShEszpHbxTWtBbT4lGYg1O99YW41
         6MMnBYQlwDGMHJ4mK2VipAAFxrVZTxQkqVzTKe74iWqKYsBkUQB8wfIjviOyshpSY7Z/
         3gf80KCa1nLyhAMbM/JyJm5uGl2x8Bd+3tsc9UGa6dWNlJqvsUlk2tySS2GnKcLG0TTJ
         Zt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741656882; x=1742261682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM4KkEf/P5NxSo/MUyS42qVxhLKKfLwn29NIgfvBYQc=;
        b=Nw/DxRIxq8KVNQq6Rq1q1ezTGrEgD+5fTZ47jJcw9jC4X0uF38eCiZxJEADQakTA/s
         Erwvl/U/gykmtA5vvv+BENdkNoZDfJZm+3TSC1zD7StbTnTAraJiQ4MSS/qrw850gBjw
         1xI1cmgOvUL9W2VUed8PxM3CLVxogHYNfgvA49cXk22t59/88XqYSNDt3dfvAY+fCm84
         Q8ibrP3a5b7l9Wvj21OrhU/E9YubTiKBTRDhYkXiE58qPsCLgZ8ERQ7JZQuuzW6HQEpf
         t3D66Ay6p2rpFMArYtHCHXNnJruwepc4IOSKTJfS7Pnfvzg15ZNcUuZqqxgkzidQ8/y6
         VPRw==
X-Gm-Message-State: AOJu0YxqOrTjcX95qqqlnSy3bNjmOQRnkNNVP4MC+LL/jULAJlMWn7Wv
	UMg/mYhQf4ti2bxPV0gCML7IN6q2M2StbGxcilhUTW0ifVaA1+tvAsu9tj9EBSpHWcAup6d+9tO
	OQx5JYKPHot9vX9+QlVLn4I8f+hc=
X-Gm-Gg: ASbGnctR0ftVMpjMpi2+ntcm1NlNSuVWkFVQy79GL9sCOIKaLBEMabaMIJu6OrNldao
	P3T7hH1zdBpq7+uqSeFxF8SlWsnPmBPhXZIPOK4VkKl+lrx3JI6OkqVzNUQHE7/vHstKrCIzCAW
	bCpKIV4tFISttabWOUtVC+1A==
X-Google-Smtp-Source: AGHT+IGWJxEvpuaOXiMle1+xLHbvGrKebbMbJ8CcaYzH6jqiHeM4eEjwRXKsvOcUL1UHB43fqc/FyYnFW2km6R0p8eg=
X-Received: by 2002:a05:600c:1c81:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-43cfffc7af8mr33890305e9.19.1741656882003; Mon, 10 Mar 2025
 18:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
In-Reply-To: <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Date: Tue, 11 Mar 2025 09:34:29 +0800
X-Gm-Features: AQ5f1JrIhBzeTDL2tx82yJ2N54_4Xrkpa-XeOVhxPiCiaHy6z1wBKM7C1jHRKB8
Message-ID: <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	WenRuo Qu <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B43=E6=
=9C=8810=E6=97=A5=E5=91=A8=E4=B8=80 23:47=E5=86=99=E9=81=93=EF=BC=9A
> OK I need some help reproducing this bug report. My current reproducer is=
:

The disk was setup to receive incremental snapshots from different
sources, and the second disk was added recently. The first disk has
encountered serveral power loss incidents before, so the zone pointer
issue might be the consequences for that?

Another special observation I want to mention is following:
$ sudo btrfs fi us /media/cold
Overall:
    Device size:                  36.38TiB
    Device allocated:             11.20TiB
    Device unallocated:           25.18TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Device zone unusable:        429.67GiB
    Device zone size:            256.00MiB
    Used:                         10.63TiB
    Free (estimated):             25.45TiB      (min: 12.86TiB)
    Free (statfs, df):            25.45TiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 32.00KiB)
    Multiple profiles:                  no

Data,single: Size:10.84TiB, Used:10.58TiB (97.54%)
   /dev/sdc        9.42TiB
   /dev/sdg        1.42TiB

Metadata,DUP: Size:183.25GiB, Used:25.54GiB (13.93%)
   /dev/sdc        6.00GiB
   /dev/sdg      360.50GiB

System,DUP: Size:256.00MiB, Used:4.95MiB (1.93%)
   /dev/sdg      512.00MiB

Unallocated:
   /dev/sdc        8.76TiB
   /dev/sdg       16.41TiB

I am having very low metadata allocator effiency, and
$ cat /sys/fs/btrfs/23b68b38-a625-4d90-a56b-5d07d93c8ffb/allocation/metadat=
a/bytes_zone_unusable
151356981248

151356981248/1024^3 \approx 140 GB >> 25.54GiB, I am expecting that
the reclaim process should have already kicked in to compact the
metadata but it has not (due to fragmentation of metadata?).

And the numbers I got is after deleting some unneeded snapshots and
after several balances with musage=3D10, before (when I encountered the
null deref issue) the number of bytes_zone_unusable would be more
extreme.

>
> As far as I see this is a stock Fedora 41 kernel, is it?

Yes it is.


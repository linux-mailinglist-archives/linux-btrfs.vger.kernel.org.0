Return-Path: <linux-btrfs+bounces-2451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D97857CC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 13:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4047289460
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10595128818;
	Fri, 16 Feb 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOGZfcMm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6D2E641
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087070; cv=none; b=sJxYvs1/ibWY6Nkq8AjjtjtPw8YhwrBficHZgCXFzd6s/SIKHsu4MKN9wf4EllSiAni42Kdszi4XFQcw3V16nfYOneIOzXE6L0s0d0alEkrpvRd5WY27lQOmHUPqxQLcL38TqVZbYPZq8vYSdXJol1dt529bCPUlws7bSQ/k9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087070; c=relaxed/simple;
	bh=b3NTqNDIp3J5NlehUvcFVblgWrO8DwPA0h4fVBpXwpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnsVmi7QWJkRXePj+ry4FH9BZ8QhWGEWKQpwdGWm8bJrD4/ui0ZTmJ6/rRL6ruLewnSfxANd6pymImZJBvy0RlkIpMiQQ7xseaJaWlZ1kaI9xlKfzx24AuqfQSRlmP99hGKjyG6aZyeZYD3X//8aDAhvw5qU0Z/LgBCrz0L1VWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOGZfcMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0630C433F1
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708087069;
	bh=b3NTqNDIp3J5NlehUvcFVblgWrO8DwPA0h4fVBpXwpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dOGZfcMmekMTP5pBGGuhfQCHQFEgZRy7q9Czm4dKpQRLz/BHgupKG5HKda+BOcQAL
	 Ies+AituLaVbr5dW3WAOs9UFQkgwlHNRdhWZt1wi4uSbf7eQ/wUeluy+z4u3BFz8NV
	 q/9vuxFa9+5UmJTs1C/BPLQd0Au4XkuXIiLNxCrQ9Kn2JKPiYeuu5PIQqTq2Vs0Qzq
	 K1w7GKmJZKuVGtHO8v1qROh6hZiLP341eVobgQoQvt2978GpizDY4KOXEvO2xcOczB
	 OY3jLKqrxAERRbTwJ2Pv242Ljhtc6qPwnbnD/ElXi4lfMIorCQqVmrcs3nuZ9tQrde
	 yMouW+J+hHUFg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso200797766b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 04:37:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yxm91Y0V/8hfBR8os2oiz0Sao76gqy2FiiLPb4ivYjPyx3jYJu3
	sVy998uHJnGoVSaeoIgS7kjRB5RYfH1GCCleAJi/yLAJGQrvEkeG2EoECVsBktkEaG7CobXvZ+/
	Fl9mTJeVPaq104y8TJTE0b+tapwI=
X-Google-Smtp-Source: AGHT+IEy4zD2itTm6zsZTAdZ491bhFPbElcqrwYqJ0ad4UkarPEYT6y3Nvt2hRCDi9UFXI+AoAJ58rOG8F7uep8cR8k=
X-Received: by 2002:a17:906:d8b4:b0:a3d:7d6b:612e with SMTP id
 qc20-20020a170906d8b400b00a3d7d6b612emr3370157ejb.23.1708087068198; Fri, 16
 Feb 2024 04:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
In-Reply-To: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Feb 2024 12:37:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
Message-ID: <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
To: Dorai Ashok S A <dash.btrfs@inix.me>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:30=E2=80=AFAM Dorai Ashok S A <dash.btrfs@inix.m=
e> wrote:
>
> Hello All,
>
> In a scenario where btrfs send is used to incrementally backup a thinly
> provisioned disk file, with fstrim used to discard unused blocks on the
> file, every change seems to cause the btrfs send stream to be about the
> total size of the file. This is only if fstrim was ever done.
>
> I am able to reproduce this consistently, but I am not sure if I am
> missing something here.
>
> # Create Disk
> truncate -s +3G thin-disk && mkfs.btrfs thin-disk >& /dev/null
> mkdir thin-mount && mount thin-disk thin-mount/
>
> # Run fstrim
> fstrim thin-mount
>
> # Create Snapshots
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 1.s
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 2.s
> seq 10000000 > thin-mount/76mb.file
> btrfs filesystem sync thin-mount/
> btrfs subvolume snapshot -r $(stat --format=3D%m .) 3.s
>
> Output:-
>
> # btrfs send 1.s | wc -c | numfmt --to=3Diec
> At subvol 1.s
> 1.3M
>
> # btrfs send 2.s | wc -c | numfmt --to=3Diec
> At subvol 2.s
> 1.3M
>
> # btrfs send 3.s | wc -c | numfmt --to=3Diec
> At subvol 3.s
> 77M
>
> # btrfs send -p 1.s 2.s | wc -c | numfmt --to=3Diec
> At subvol 2.s
> 178
>
> # btrfs send -p 2.s 3.s | wc -c | numfmt --to=3Diec
> At subvol 3.s
> 2.5G
>
> Any idea why the last incremental stream from 2.s to 3.sis 2.5GB, is
> this expected behavior?
>
> The above test was run on debian 12 (kernel 6.1.0-18 &
> btrfs-progs-6.2-1). I am also able to reproduce it on fedora 39 (kernel
> 6.7.3-200 & btrfs-progs-6.7-1)

Well, I'm unable to reproduce that on a 6.8-rc4 kernel, but nothing
changed since 6.7 regarding send,
and using a thin provisioned disk or fsstrim is irrelevant from a send
perspective.

I turned your reproducer into this script:

$ cat test.sh
#!/bin/bash

truncate -s +3G thin-disk
mkfs.btrfs thin-disk >& /dev/null
mkdir thin-mount
mount thin-disk thin-mount/

fstrim thin-mount

cd thin-mount/

btrfs subvolume snapshot -r $(stat --format=3D%m .) 1.s
btrfs subvolume snapshot -r $(stat --format=3D%m .) 2.s
seq 10000000 > 76mb.file
btrfs filesystem sync .
btrfs subvolume snapshot -r $(stat --format=3D%m .) 3.s

btrfs send 1.s | wc -c | numfmt --to=3Diec

btrfs send 2.s | wc -c | numfmt --to=3Diec

btrfs send 3.s | wc -c | numfmt --to=3Diec

btrfs send -p 1.s 2.s | wc -c | numfmt --to=3Diec

btrfs send -p 2.s 3.s | wc -c | numfmt --to=3Diec

cd ..
umount thin-mount
rm -f thin-disk
rmdir thin-mount

Running it:

$ cd /mnt
$ ./test.sh
Create a readonly snapshot of '/mnt/thin-mount' in './1.s'
Create a readonly snapshot of '/mnt/thin-mount' in './2.s'
Create a readonly snapshot of '/mnt/thin-mount' in './3.s'
At subvol 1.s
202
At subvol 2.s
202
At subvol 3.s
76M
At subvol 2.s
170
At subvol 3.s
76M

There's something missing to create such a huge incremental send stream.

Thanks.

>
> Regards,
> -Ashok.
>
>
>
>


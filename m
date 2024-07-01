Return-Path: <linux-btrfs+bounces-6059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADE91DB46
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBEBB26C6F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415C58287D;
	Mon,  1 Jul 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai4adtgF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5825622;
	Mon,  1 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825389; cv=none; b=STot3QGyK7CQUnB9NmLnmLl2oebYx9AKdzT1wIHuzYh2UhrurbMpM/Zbe5FUi4tx5j+4hMHWXUga03f6sOqsl2EgeCFrKijtgZKIfnsqZXlnbJtG5syMcipC6FAfOuitC4rlTNtp3zY1yswIsYJwpMHKwGnubkqI8a1MLdXFEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825389; c=relaxed/simple;
	bh=JIWQbpwS5vsrNoQWpGLqPCDVQG0MUkC/rInBh/h5nZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCvJWvZy0M86noGl4hZCV+0GT3VYA7jpwDQM0GKUcvWusSLxuLxL8wqkWKH6sVp4vxgpCJnADiUbtOHDrUsUAQLhvxXnwgVTP/My8+qcjc6KxqlJzyUnvdBbZjeBaRVQZMwz1tcvSszy0ix5OVbLtd07rTqfzT7u96HcfBWLQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai4adtgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC51AC4AF0A;
	Mon,  1 Jul 2024 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825388;
	bh=JIWQbpwS5vsrNoQWpGLqPCDVQG0MUkC/rInBh/h5nZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ai4adtgFf1MTVFcme57HftOB2BU36JPP46TxEuxe9pK6JmMfMJZWqWZUWC3Y0LW9/
	 6H+hmpcMObGYVtD4ztJ9kH05EygmMK0d8LqmX658WJBx4Fi+1Ms1PUgcqw7nNmo/O8
	 1KSaPWAmZ5ryzvrG3C3bjuosTTB+p2sYGOtEtNa26MmH6J9GCQ+5lJwNTJC5iThkWk
	 beUPb2eX7ynl5PpyRiblp3W1nZycEalHQLB6pXofDCTwfxXsB0o9Dh37dtGS8LpAPY
	 hne4Ove7FfnZvErQezliMG1U+SJFOSKv4AAujJ0AWyqxju7RZ9t1B7GsUBKNoZRBuY
	 XCYYeFq3Wd3nw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a70c0349b64so345668566b.1;
        Mon, 01 Jul 2024 02:16:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm+XCkq2bmPckEsAak4fJZ8b+CtnTd5yfiwww7LbvkbyhAiqemuJka1DEtzlsbbYO++CpPCe/jSZizQ4IIEcfLA6RmNubTEA==
X-Gm-Message-State: AOJu0Yww3DoTZOk3ZaGhlkYmBU9L0PH6Pod7r+OYDabShFBbYbmeDy9o
	pMv3YjKIo3WlkfVCjC+BGDKFqWAFN77w3DDqF8JJHjZ7IdJaW8GXZpOX2N6t5Mr3fkH4Olfj6Pa
	scnHfDVdzmm1F1DxAuHuK8gSIQqc=
X-Google-Smtp-Source: AGHT+IH7+dfaFCA960jyaBrV6lj8dN5ksAsa92O+vBJ5MUHpTLvpsa619y/QIREsjikSZyCTO8eukpINjg4RSn6GU60=
X-Received: by 2002:a17:906:3ac9:b0:a75:fb2:8b99 with SMTP id
 a640c23a62f3a-a751441f023mr264106466b.31.1719825387388; Mon, 01 Jul 2024
 02:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701080109.20673-1-jth@kernel.org>
In-Reply-To: <20240701080109.20673-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 1 Jul 2024 10:15:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77MhmqDo6VzQsYo7gMvN_KeGr1nKZR5aXi2OxRacDXrA@mail.gmail.com>
Message-ID: <CAL3q7H77MhmqDo6VzQsYo7gMvN_KeGr1nKZR5aXi2OxRacDXrA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: update golden output of RST test cases
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>, 
	Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:01=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Starting with kernel patch "btrfs: remove raid-stripe-tree
> encoding field from stripe_extent" and btrfs-progs commit
> 7c549b5f7cc0 ("btrfs-progs: remove raid stripe encoding"), the on-disk
> format of the raid stripe tree got changed.
>
> As the feature is still experimental and not to be used in production, it
> is OK to do a on-disk format change.
>
> Update the golden output of the RAID stripe tree test cases after the
> on-disk format and print format changes.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

> ---
>
> Changes to v1:
> - Mention the kernel and btrfs-progs changes mandating this change.
>
>
>  tests/btrfs/304.out |  9 +++------
>  tests/btrfs/305.out | 24 ++++++++----------------
>  tests/btrfs/306.out | 18 ++++++------------
>  tests/btrfs/307.out | 15 +++++----------
>  tests/btrfs/308.out | 39 +++++++++++++--------------------------
>  5 files changed, 35 insertions(+), 70 deletions(-)
>
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> index 39f56f32274d..97ec27455b01 100644
> --- a/tests/btrfs/304.out
> +++ b/tests/btrfs/304.out
> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
> index 7090626c3036..02642c904b1e 100644
> --- a/tests/btrfs/305.out
> +++ b/tests/btrfs/305.out
> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
> index 25065674c77b..954567db7623 100644
> --- a/tests/btrfs/306.out
> +++ b/tests/btrfs/306.out
> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
> index 2815d17d7f03..e2f1d3d84a68 100644
> --- a/tests/btrfs/307.out
> +++ b/tests/btrfs/307.out
> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
> index 23b31dd32959..75e010d54252 100644
> --- a/tests/btrfs/308.out
> +++ b/tests/btrfs/308.out
> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> --
> 2.43.0
>
>


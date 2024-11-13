Return-Path: <linux-btrfs+bounces-9591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F19C6E27
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E2A1F237EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9E2003C9;
	Wed, 13 Nov 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrIRHlPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A031BD9DC;
	Wed, 13 Nov 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498625; cv=none; b=JlIMyW+OuyXxOO7Dl34iCabZymNe2c+sJAoK/xwLX+4tktc+UN6Stfc10oj06Ai5fM2CMig1X8sSBFqE7rHrAmYpLuDRk7gOGyLASqCVZu0GxfQIqpyeo6fpJdGQppw5VQlZtkEOCnUsxHvbY9iqjtva3gykaAFC7vUdN7r9A9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498625; c=relaxed/simple;
	bh=iIxORHdA9/T0CLei1Kcpm+ui/8tV7XWR1wE+jgn5Skc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw5syInwc+wn7XTtv726k5aBwpIKhRvYQiBNMQnlf98t0/03JKclYAh6oINhVOuzrc2ZK9v7huQF5a9ohZ8xPOQ4wRPFxGfPGFTdVt5rTcbJYeF8d0+q0EWG2l0fTas6NlDvjSYZcXpHfSHEPAyLnccB1Vaea/p+jYzlfPyi8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrIRHlPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE76C4CECD;
	Wed, 13 Nov 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731498625;
	bh=iIxORHdA9/T0CLei1Kcpm+ui/8tV7XWR1wE+jgn5Skc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hrIRHlPpMVFXRdJ0UyvJAQ0Ss6WUYryWeL41Qj2sCcMXzx2cs19wzl6E9zFNGcDb+
	 o2xnUnLABUc3j+u0n5ph93RadezT320EYIrukrQjgGikPj7DjNR4shc5wmoGM0yaQE
	 omz4TVafh8IOE1NLphCMDjiLv0twkg87rkhCHUwavIrdgP9GOe0N/nilyXb7RjIT0h
	 egMj4JjZ9RE5B7nciYdPD91bNeHmbe7h3q1R1FwidLX+rfZP1EAigm0ohhkuOhGuYS
	 kpySkLgjYdjNIi2mehlYJbezdcEkE1OEJAwESc6hZdZtUyE0rIopHHYgpO42yuE/jZ
	 5wzN7DSpUc6FA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so10584242e87.2;
        Wed, 13 Nov 2024 03:50:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl7fOWizpUohnA5P2aJDjBMyg+keJmYR6yGKd6f6B61A/nuoZoI4VebGKg9iD99ADlRlbA0o8A@vger.kernel.org
X-Gm-Message-State: AOJu0YzStVKrtCem1EwO87RVPzTLRjk0Eq0Sj9Jytfz7TuBiDcMxvdBN
	/d9fECpa2QsmtHc0e+nuLtSLXKp4H+G+LPDkyRLQUrsZ8xRPIkB4si8JTMxEtx7imL3HVJJXfi6
	Vv5jEkEmkpitjLaxvfcDsBHmz+gQ=
X-Google-Smtp-Source: AGHT+IG9nQRRSIhzfRb58iTAVhHqeKFFAyeCgjhy31UIWPFUO5xXkl5oQe8SOWKJahTL8wK5Gwz8PqhbOTWp8feaJTU=
X-Received: by 2002:a05:6512:33d5:b0:53d:a34d:70a0 with SMTP id
 2adb3069b0e04-53da34d719emr541518e87.44.1731498623349; Wed, 13 Nov 2024
 03:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113092838.302247-1-wqu@suse.com>
In-Reply-To: <20241113092838.302247-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Nov 2024 11:49:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4iSqihk_EQ3Y0R4F+xAc0eNrXQCAT7phV2A=P-ikirbw@mail.gmail.com>
Message-ID: <CAL3q7H4iSqihk_EQ3Y0R4F+xAc0eNrXQCAT7phV2A=P-ikirbw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/321: make the filter to handle older btrfs-progs
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, 
	Long An <lan@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 9:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [FALSE ALERT]
> With much older distros like SLE12SP5, which is using btrfs-progs 4.5.3,
> test case btrfs/321 fails like this:
>
>  btrfs/321       QA output created by 321
>  unable to locate the last csum tree leaf
>  (see /opt/xfstests/results//btrfs/321.full for details)
>  [failed, exit status 1]- output mismatch (see /opt/xfstests/results//btr=
fs/321.out.bad)
>      --- tests/btrfs/321.out    2024-10-28 07:03:54.000000000 -0400
>      +++ /opt/xfstests/results//btrfs/321.out.bad       2024-11-07 09:33:=
58.238442033 -0500
>      @@ -1,2 +1,3 @@
>       QA output created by 321
>      -Silence is golden
>      +unable to locate the last csum tree leaf
>      +(see /opt/xfstests/results//btrfs/321.full for details)
>      ...
>      (Run diff -u /opt/xfstests/tests/btrfs/321.out /opt/xfstests/results=
//btrfs/321.out.bad  to see the entire diff)
>
> [CAUSE]
> The full output shows the regular csum tree as usual:
>
>  btrfs-progs v4.5.3+20160729
>  checksum tree key (CSUM_TREE ROOT_ITEM 0)
>  node 4247552 level 1 items 9 free 112 generation 7 owner 7
>  fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
>  chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
>         key (EXTENT_CSUM EXTENT_CSUM 20971520) block 4243456 (1036) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 25006080) block 4251648 (1038) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 29040640) block 4255744 (1039) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 33075200) block 4259840 (1040) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 37109760) block 4263936 (1041) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 41144320) block 4268032 (1042) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 45178880) block 4272128 (1043) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 49213440) block 4276224 (1044) gen 7
>         key (EXTENT_CSUM EXTENT_CSUM 53248000) block 4280320 (1045) gen 7
>  leaf 4243456 items 1 free space 30 generation 7 owner 7
>  fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
>  chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 20971520) itemoff 55 itemsize=
 3940
>                 extent csum item
>  [...]
>  leaf 4280320 items 1 free space 2722 generation 7 owner 7
>  fs uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
>  chunk uuid 0af5a7bd-d2d8-4146-ada8-444f2a2f5351
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 53248000) itemoff 2747 itemsi=
ze 1248
>                 extent csum item
>  total bytes 25768755200
>  bytes used 34213888
>  uuid 5623d533-ff79-4ddf-b9a1-7d359fa97c48
>
> But notice the header for each leaf, there is no flags for the leaf.
> On newer btrfs-progs, the leaf header lines looks like this:
>
>  leaf 5423104 items 1 free space 2918 generation 7 owner CSUM_TREE
>  leaf 5423104 flags 0x1(WRITTEN) backref revision 1
>
> It's two lines, not the old one line output.
> The new behavior is introduced in btrfs-progs commit 9cc9c9ab3220
> ("btrfs-progs: print the eb flags for nodes as well"), included by v5.10
> release.
>
> So the test case doesn't handle older output format and failed to locate
> the target leaf.
>
> [FIX]
> Instead of relying on the leaf flags line, use the much older
> "leaf <bytenr> items" line as the filter target, so we can support much
> older distros.
>
> Reported-by: Long An <lan@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1233303
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/321 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/321 b/tests/btrfs/321
> index c13ccc1e..35caade6 100755
> --- a/tests/btrfs/321
> +++ b/tests/btrfs/321
> @@ -43,7 +43,7 @@ _scratch_unmount
>
>  # Search for the last leaf of the csum tree, that will be the target to =
destroy.
>  $BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV >> $seqres=
.full
> -target_bytenr=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRA=
TCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
> +target_bytenr=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRA=
TCH_DEV | grep "^leaf.*items" | sort | tail -n1 | cut -f2 -d\ )
>
>  if [ -z "$target_bytenr" ]; then
>         _fail "unable to locate the last csum tree leaf"
> --
> 2.46.0
>
>


Return-Path: <linux-btrfs+bounces-2426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A0785631C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C61F23693
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A112C53E;
	Thu, 15 Feb 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMIRmixu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6012BF00;
	Thu, 15 Feb 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000076; cv=none; b=R9T03dhIZ1IPTdOU9n2skGh4dhpjqEXLd3k1uCIQgTE2bbzjIXtxkjLZWmfpEHhpJB0luvBu3Ta2NhucnnIy2LJn7+83mgqgfjVX2QAkbT3UqJZZGjXB6OsulsWmoWVZEY9R3CeyDmssTNdezoEp0LzLAPvvNcdS6sdIns4yZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000076; c=relaxed/simple;
	bh=Ehh5l6ptIFt1JNAel/ZQcpD5jiiww5fP21j8t4jpUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8b0IBhphcyEzeyU0WQyJAFIqestucy+HZfC/aV0pnUVnlMO36dbsczbc9oUCU2T7OjlWDJpShA02Sz0HtO8oM8tXV6a2WGVWSITqY2HWs5GOFQ6MzgINnYjxurfKZIk9BrvFjvOx5cJYGVvTL/wVysgKwHYcXfJNiRxA+gzsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMIRmixu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB35C43390;
	Thu, 15 Feb 2024 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000076;
	bh=Ehh5l6ptIFt1JNAel/ZQcpD5jiiww5fP21j8t4jpUzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rMIRmixuIbnnRnXRibbBt6vQ3kSWcodqkf0x5i/obGTm/h1aAel0zzNt7zwZgksWU
	 WwLnRfwl4yT8rcszTUrC+Mlk2yEwzJjpKJJPr4qRzFMfBd7fMEKOAPj5wbzsFLv9Ki
	 MuduJHRW+ogYEl9QhwYNhB8xIqAc/F9QH6HSGxKTK8pX+dI9mFmdur3dVdEA5G5nZF
	 Dpg01haLUuslUg9mHA/163io/9ITuXi60ZnKYpAMEUzppJ/T6XcyznH6kChY4B5vHD
	 Val68Nkjd1Epw0RCJ13reoaeoG9exmu4+Ku4S6jJIz3F71ermAQ012p/054SCakgZy
	 +4o3URUiLfgUw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b540163so1293674e87.1;
        Thu, 15 Feb 2024 04:27:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwjbUhel5EP7OS5lVMNO2InLj+ZzqUkemG4YOInSPpIrhWsyqIueEAQhw0KlnYb21p593AorEfEnOtvaOmos5Odml4wFCHlWUeO3c=
X-Gm-Message-State: AOJu0Yw63Tct3NcEaSJuYjqekcCoB5Z4Wd4op74g6czahBGJrUwYwpd6
	uMmipD+q3/hx2nAwQvXRD7nexKPbv48QthfnKKl1+uzFMlcUdsEFEc4+5W8CUZ3zR8NZ0az70us
	CqS/Vp/uvvk4c4vs/qe6OwQuBkIQ=
X-Google-Smtp-Source: AGHT+IHIwTPK9OXQANAVXGFMzFzpjr3usCdkzCSDoYPdxWWnc++W67jb7YnXSLKyAY6Jp6R7AltI+DqrLkrLHbYB3+s=
X-Received: by 2002:a19:8c4a:0:b0:512:871e:12bb with SMTP id
 i10-20020a198c4a000000b00512871e12bbmr1110599lfj.53.1708000074234; Thu, 15
 Feb 2024 04:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <8a9a66bdd309ea6ea81c3586674922517c3460be.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <8a9a66bdd309ea6ea81c3586674922517c3460be.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:27:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7SW8u=nxZAPtbYyiJ_3KRudzjDKxwghQixsFoPUUzSBA@mail.gmail.com>
Message-ID: <CAL3q7H7SW8u=nxZAPtbYyiJ_3KRudzjDKxwghQixsFoPUUzSBA@mail.gmail.com>
Subject: Re: [PATCH 06/12] create a helper to clone devices
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> The function create_cloned_devices() takes two devices, creates
> a filesystem using mkfs, and clones the content from one device
> to another using device dump.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 5cba9b16b4de..61d5812d49d9 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -826,3 +826,25 @@ check_fsid()
>         echo -e -n "Tempfsid status:\t"
>         cat /sys/fs/btrfs/$tempfsid/temp_fsid
>  }
> +
> +create_cloned_devices()
> +{
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       [[ -z $dev1 || -z $dev2 ]] && \
> +               _fail "BUGGY code, create_cloned_devices needs arg1 arg3"

arg3 should be arg2.

But rather than such a cryptic message, I would for something more
clear and informative such as:

"create_cloned_devices() requires two devices as arguments"

> +
> +       echo -n Creating cloned device...
> +       _mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
> +
> +       _mount $dev1 $SCRATCH_MNT
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                               _filter_x=
fs_io
> +       umount $SCRATCH_MNT

$UMOUNT_PROG

So we have a generic function that is named create_cloned_devices()
that is too specific for
a single test. The whole thing of creating exactly a 300M fs and with
a single file, it's anything but generic.

Really as it's only used in a single test case and given its
specificity, it should not be made generic by having it in
common/btrfs.
I'd rather have it in the test case that is using it.

Thanks.

> +       # device dump of $dev1 to $dev2
> +       dd if=3D$dev1 of=3D$dev2 bs=3D300M count=3D1 conv=3Dfsync status=
=3Dnone || \
> +                                                       _fail "dd failed:=
 $?"
> +       echo done
> +}
> --
> 2.39.3
>
>


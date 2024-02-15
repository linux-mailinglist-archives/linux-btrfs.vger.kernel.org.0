Return-Path: <linux-btrfs+bounces-2416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D4856290
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DB5B306CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63C12AAF4;
	Thu, 15 Feb 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRmRxHof"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534E66B2D;
	Thu, 15 Feb 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997559; cv=none; b=T+5efCUixhIDJg9ICrh9N1wYXbX110N70oT4EAHMZR70rOkOvWam+xYk5W7/M6h1E/YymJbxSjiUHbDPi/ivxtJhzKRETFUWtWSccGWTnzLob7dDqsbaYN7Q+VQY/uzQwMnRd9PS05ey8x9dss5Bz6yq1ehVFLUIkAnijla9pP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997559; c=relaxed/simple;
	bh=v0j7C7qJaW7H9bREfMvItEw422Ux9GdVJtiokZEa96k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IabvmubNwisgDfyFv85gYIt0A0eR+N/bxr1NNWyt0MoIxsYicR4XV2PIdg/EGbDK0DXK9lEVAizub5QDG0vT6RBJqhH81kRMGx2VOeYtJ/niDn+CpSJeGdoJ8j1IzRGSkIdkUcfSH/Mf33TeAVWdBTT6vbvcKU23U6ZKHHXYHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRmRxHof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC91C433C7;
	Thu, 15 Feb 2024 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997558;
	bh=v0j7C7qJaW7H9bREfMvItEw422Ux9GdVJtiokZEa96k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fRmRxHofR+Q7XvGiAnJS6wfZQAPIv9ie/DLvFvQ9bR8Osd8ib9fKS2cDuRDXE0d0E
	 fPBScQ/VwrA7IPz5sfZTiTgVoinsvtVSmnga3QZtlHBEQMSYzN3W4zkcY7e5jmgWsq
	 f6VDfv8sYDlznmjBIqZwegPXrU/fVp3GlOTiE6VwRF2yT0uiZh0i5HAbU2MOlOtYgb
	 VPjU675+pLmxZUO9cA4s/XpMEoMODiJkmXtOCMsGJD39l6Y3DpLozGyUllgkLfeogl
	 8penUK9iUW1CqRgemamCftp0I1tqS0s9O5NTRYN7WpHjqEs5KArDezKKEsAbzYdaBj
	 8yvW5dLtf6KdA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso853014a12.1;
        Thu, 15 Feb 2024 03:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJZ0/54Rd7eqbGKvfO0vvi9x1U1fOPg6NsWOW1CAu9Xg4slNtnHdeVAyAkb9oNlN3r6LyfHSTU4M3xxMG0McQmkIwCi6aEkju6BLk=
X-Gm-Message-State: AOJu0Yxq5RUdv7Cuy8JLe3MsYcnvL4ognOQ/2Z8dzQnlpeXaxaIc7Fl8
	cdZ8qh8vYTG1/o0ekgZAPdRZpgTfP1IH6nOlx0nEHRuz97041ra9fEI33ywJDnoPrnDOsMJ5676
	PPphFizIMcPhadNMO2naGSVt0NeI=
X-Google-Smtp-Source: AGHT+IF/Gl9Ef0hZFmTWd8T4GXRuspCDiciSH1h5vjxyef5HNk0bK5pWRqixfDFMTVvTZvWFtcQ4b8Q+EYW2o+UHK+k=
X-Received: by 2002:a17:906:759:b0:a3d:632e:7ab4 with SMTP id
 z25-20020a170906075900b00a3d632e7ab4mr1142295ejb.42.1707997557344; Thu, 15
 Feb 2024 03:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <578579505765ce6bb5ee8b1cc0e1703221fd9acc.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <578579505765ce6bb5ee8b1cc0e1703221fd9acc.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 11:45:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7BMOc_OYW2yjjJX535QdCxxm0K9JXNtwM+Hi2Pdq-4zg@mail.gmail.com>
Message-ID: <CAL3q7H7BMOc_OYW2yjjJX535QdCxxm0K9JXNtwM+Hi2Pdq-4zg@mail.gmail.com>
Subject: Re: [PATCH 01/12] add t_reflink_read_race to .gitignore file
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:34=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Please always add a changelog...

Also, you need to update your local checkout...
This was already fixed before:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-next=
&id=3Dacff198213e3d874e76f6a133a816c8dee5e128d

It's also odd to include this in a patchset for the tempfsid feature,
as it's completely unrelated, it should go as a separate patch.

Thanks.

> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 5cc3a5e4ae57..d930b9cc8404 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -204,6 +204,7 @@ tags
>  /src/vfs/mount-idmapped
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
> +/src/t_reflink_read_race
>
>  # Symlinked files
>  /tests/generic/035.out
> --
> 2.39.3
>
>


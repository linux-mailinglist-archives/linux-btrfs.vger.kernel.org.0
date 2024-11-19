Return-Path: <linux-btrfs+bounces-9751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75519D1C2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 01:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD72B227F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D499E57D;
	Tue, 19 Nov 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbH+GZWP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305CA93D;
	Tue, 19 Nov 2024 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975515; cv=none; b=cNaQekFwzXRcgEFEMzO17UwKJQQy+Toh77c+wIdhzkRTSxadC4g26XkFX3MMc4vHaQ+GG2Q3+dU3Os4OGU/Mj2slvTyw7Di+90rCv/HFmmMQcmEWCmJc90kAPW2VZbvFcol98ydkm29ndGPbkdGZyZpiNxp8n8khS/j7ZxFJoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975515; c=relaxed/simple;
	bh=XHHxZ0ucKPRvt22e6LaWbIRj0y8yT+1SIPYfhR+W/u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5a7UhEUrl6dTVGUkIM0/JshW+en+bpX87qL+vEg9YAqnpWguM4ARxU6duyQasDoHD1PkRkbvy/bqOPd7Vi6Tv9KO4k8BloGNNTG9U6GWfJ2/EOLxHwog2vSFf4vYM4YHh96EuvjYs/CgdBWa8MVbwst9B/Nn4zfiad6r2G9j+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbH+GZWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178FC4CECC;
	Tue, 19 Nov 2024 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731975515;
	bh=XHHxZ0ucKPRvt22e6LaWbIRj0y8yT+1SIPYfhR+W/u8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BbH+GZWPvBUOijBslXFUzoeEpLqMkOJSzBOmpCNw+9PWAtmJ7S/HVyIUXG4ByHwG5
	 Pn6R1yXc3LiM/LWvocwa6qK8190lyO3ezERVnGNnAUDs51nKtu5Eye8Me1GVXqSOtR
	 Y6KHEd5XIfVX7nO0AsJXc21l0mpgqXSiBkhRxA+Fh0aTdldu9awcaxIeVNS1eKJ9Bz
	 D3t1Kfg2/auWXpqGdVdUyy5euTuCEQyaCDc7PuaGGHqOunUtpBrq9GPrCZ8i+iVzno
	 Dwg1RtNGhtfsPpL+MY6L9XBxudMYdp+Il0s63Shb0wgDdOwXzkaZUyGzMo1ZlQ1VT3
	 hpUrB+ykucaOw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff92b14so443232e87.1;
        Mon, 18 Nov 2024 16:18:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVV6NxapOCXns+NtMbAVItvG9GGNPQXBml3978I1UPInie/KS2Z4ST9NLexHAnEUiisj1083vXa9SoOcI=@vger.kernel.org, AJvYcCWbgMJ6j9g5y/1ciObYcIBnqJIOGT+btrOA5JUduxBWkic0aVhGWx4c8LBSaF4nccFHrJ47jbfd@vger.kernel.org, AJvYcCXk7HerdXWTYtWDTBGSK87fHelVoktV6ySHT6Ng3jJm4GXJyEm49lKvJdW+dudXhVyFV2uCBg/NiXF9@vger.kernel.org
X-Gm-Message-State: AOJu0YxodJFX8VPKCKkpQ/ktznFEOTZAM/WGlSZys29R2+r7YSc1qXqk
	+HeNa6j2O/XGdf1iRnopSxKhp/TlRoO/PLOkgXwuQ4C2bsUSKYN59qa9Vmp2Ol2whWx2+MegjOs
	kL5wZaL5JwdZr/71eX4CHOTem0Tc=
X-Google-Smtp-Source: AGHT+IHfNe9nu0WjKacJS2H+bOdIVqrZgrRuaVvkgqtQeCJmQs1PxMlLs5F9y2GLvfCGbA7PaT7wsl77anldHnofmxk=
X-Received: by 2002:a05:6512:3a88:b0:52f:d0f0:e37e with SMTP id
 2adb3069b0e04-53dab3b17eemr6068236e87.42.1731975513384; Mon, 18 Nov 2024
 16:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173197064408.904310.6784273927814845381.stgit@frogsfrogsfrogs> <173197064501.904310.1505759730439532159.stgit@frogsfrogsfrogs>
In-Reply-To: <173197064501.904310.1505759730439532159.stgit@frogsfrogsfrogs>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 19 Nov 2024 00:17:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5KjvXsXzt4n0XP1FTUt=A5cKom7p+dGD6GG-iL7CyDXQ@mail.gmail.com>
Message-ID: <CAL3q7H5KjvXsXzt4n0XP1FTUt=A5cKom7p+dGD6GG-iL7CyDXQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] generic/562: handle ENOSPC while cloning gracefully
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, linux-xfs@vger.kernel.org, fstests@vger.kernel.org, 
	linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> This test creates a couple of patterned files on a tiny filesystem,
> fragments the free space, clones one patterned file to the other, and
> checks that the entire file was cloned.
>
> However, this test doesn't work on a 64k fsblock filesystem because
> we've used up all the free space reservation for the rmapbt, and that
> causes the FICLONE to error out with ENOSPC partway through.  Hence we
> need to detect the ENOSPC and _notrun the test.
>
> That said, it turns out that XFS has been silently dropping error codes
> if we managed to make some progress cloning extents.  That's ok if the
> operation has REMAP_FILE_CAN_SHORTEN like copy_file_range does, but
> FICLONE/FICLONERANGE do not permit partial results, so the dropped error
> codes is actually an error.
>
> Therefore, this testcase now becomes a regression test for the patch to
> fix that.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/562 |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
>
> diff --git a/tests/generic/562 b/tests/generic/562
> index 91360c4154a6a2..62899945003513 100755
> --- a/tests/generic/562
> +++ b/tests/generic/562
> @@ -15,6 +15,9 @@ _begin_fstest auto clone punch
>  . ./common/filter
>  . ./common/reflink
>
> +test "$FSTYP" =3D "xfs" && \
> +       _fixed_by_kernel_commit XXXXXXXXXX "xfs: don't drop errno values =
when we fail to ficlone the entire range"
> +
>  _require_scratch_reflink
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "fpunch"
> @@ -48,8 +51,11 @@ while true; do
>  done
>
>  # Now clone file bar into file foo. This is supposed to succeed and not =
fail
> -# with ENOSPC for example.
> -_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full
> +# with ENOSPC for example.  However, XFS will sometimes run out of space=
.
> +_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full 2> $tmp.err
> +cat $tmp.err
> +grep -q 'No space left on device' $tmp.err && \
> +       _notrun "ran out of space while cloning"

This defeats the original purpose of the test, which was to verify
btrfs didn't fail with -ENOSPC (or any other error).

If XFS has an ENOSPC issue in some cases, and it's not fixable, why
not make it _notrun only if it's XFS that is being tested?

Thanks.


>
>  # Unmount and mount the filesystem again to verify the operation was dur=
ably
>  # persisted.
>
>


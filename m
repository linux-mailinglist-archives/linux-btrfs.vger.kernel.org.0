Return-Path: <linux-btrfs+bounces-15852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED124B1B26F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6438A7AC0BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4D212B1E;
	Tue,  5 Aug 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH6oWJyN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A921ABAA
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392328; cv=none; b=SYY0T37A1SddPlmRaF95J5683Y1qX0COIBUUp5pzznWKEI658d3gaACN7JNwMO2X4nZ6eG22homPSgR/C7t8vo+v9DGs6r0p13MAvVwAzWCK5NqiOqsQYBN9inopgKVrytffUTBgG2nfxxcT6NayOohARusApvXFb+x9rs76kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392328; c=relaxed/simple;
	bh=+iqH6FWRy48WWbdhb1tE8H+MyCXNthQ2JrT+9ZswPEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6VQQDMvC3Zvg98TseFNmsw6ua8/RJ0bnLh0oAm2FCj3zEISZIp/SrAQqxAF6PTwJSn3K550/RShxeWQhJx0ErAELaujaf55LovmhERoJU9oTCpDXmHHsrOkrhpxiht7aE4aQTyVNpsIanXdgPadE57VNK4nYtZ7xwYFIbrcg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH6oWJyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8C3C4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754392327;
	bh=+iqH6FWRy48WWbdhb1tE8H+MyCXNthQ2JrT+9ZswPEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YH6oWJyNt6i5EUqPtISKHZzDQexXWnGoAIQxa3I9QxdajAJcLjnZR22+YGEoCHTce
	 gTPODhjZ9hBY/bEG5xUlqiaG1OlQsczomFFLaXmruaNmlQHRtO/l+Q9RPjoV+rSbd0
	 gWft0KbE0ZFber+bZyPJCcgKx8+3MOiHaVWtpu7+Z3yg88XAPcpuEzcRhNs1wrJs2r
	 z8teaSQaL/lJz1DJwwhqx8bJL2K98Rz1nRMe5w/7UQm0SkEEPySF/DOIDFaSsgGxrf
	 GKQPConUrJ3YNKrvSulsErxL/sqW4mtg7MoNyBHN5WGsRk5inFz/MmkBDKBUMuK+YO
	 AvBrro8rFVFoQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so1103135366b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 04:12:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxy0tauCIk5DcQ8Ks0f1SGdMChmJ08Jf2pXIErDd7Xf4vLAiAQA
	wzOKROaK2p7t2k4m/cpIOnhmfqCMRG6T9cMCpLrFzK+VyBb/EX5KB/vdRlq65GKrPrYHpfsl9BW
	S1tOS1uaRKcoKQgp8j9DSoh7jIItKRXc=
X-Google-Smtp-Source: AGHT+IEF6VaLOw1JLl5POCfHe0owYGVNA6rIwZnkWEAhpSy7jat9D/jXBaCzQYsuqLIEz545nGVxZPeJdBTXmJ894uY=
X-Received: by 2002:a17:907:948c:b0:ade:9b52:4cc0 with SMTP id
 a640c23a62f3a-af94007889dmr1331819266b.26.1754392326031; Tue, 05 Aug 2025
 04:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753781242.git.wqu@suse.com> <0d5c6540fef2b1ebd96e332c20adcd694ea23b4d.1753781242.git.wqu@suse.com>
In-Reply-To: <0d5c6540fef2b1ebd96e332c20adcd694ea23b4d.1753781242.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Aug 2025 12:11:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5BN+O8Pu14n0KHNsQiHaYXoko09aLXzKLX6+1CDw6Rig@mail.gmail.com>
X-Gm-Features: Ac12FXzS3QYEsigeZMBDQurHZ0FnoMLaJUqmp-QFnZMLN7ShgkD4WmZUBjHlB1U
Message-ID: <CAL3q7H5BN+O8Pu14n0KHNsQiHaYXoko09aLXzKLX6+1CDw6Rig@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: clear block dirty if btrfs_writepage_cow_fixup()
 failed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If btrfs_writepage_cow_fixup() failed (return value not 0 nor -EGAIN),

EGAIN > EAGAIN

> the block will be kept dirty, but with their corresponding range finished
> in the ordered extent.
>
> Currently the only error pattern is only possible for experimental
> builds, which places extra check to ensure we shouldn't hit an dirty

an dirty -> a dirty

Otherwise it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> block without a corresponding ordered extent.
>
> This means if later a writeback happens again, we can hit the following
> problems:
>
> - ASSERT(block_start !=3D EXTENT_MAP_HOLE) in submit_one_sector()
>   If the original extent map is a hole, then we can hit this case, as
>   the new ordered extent failed, we will drop the new extent map and
>   re-read one from the disk.
>
> - DEBUG_WARN() in btrfs_writepage_cow_fixup()
>   This is because we no longer have an ordered extent for those dirty
>   blocks. The original for them is already finished with error.
>
> [CAUSE]
> The function btrfs_writepage_cow_fixup() is not following the regular
> error handling of writeback.
> The common practice is to clear the folio dirty, start and finish the
> writeback for the block.
>
> This is normally done by extent_clear_unlock_delalloc() with
> PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
> run_delalloc_range().
>
> So if we keep those failed blocks dirty, they will stay in the page
> cache and wait for the next writeback.
>
> And since the original ordered extent is already finished and removed,
> depending on the original extent map, we either hit the ASSERT() inside
> submit_one_sector(), or hit the DEBUG_WARN() in
> btrfs_writepage_cow_fixup() again (and very ironic).
>
> [FIX]
> Follow the regular error handling to clear the dirty flag for the block
> range, start and finish writeback for that block range instead.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f6765ddab4a7..b2ff2a445b80 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1656,8 +1656,12 @@ static noinline_for_stack int extent_writepage_io(=
struct btrfs_inode *inode,
>                 folio_unlock(folio);
>                 return 1;
>         }
> -       if (ret < 0)
> +       if (ret < 0) {
> +               btrfs_folio_clear_dirty(fs_info, folio, start, len);
> +               btrfs_folio_set_writeback(fs_info, folio, start, len);
> +               btrfs_folio_clear_writeback(fs_info, folio, start, len);
>                 return ret;
> +       }
>
>         for (cur =3D start; cur < start + len; cur +=3D fs_info->sectorsi=
ze)
>                 set_bit((cur - folio_start) >> fs_info->sectorsize_bits, =
&range_bitmap);
> --
> 2.50.1
>
>


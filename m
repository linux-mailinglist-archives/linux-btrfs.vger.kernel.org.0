Return-Path: <linux-btrfs+bounces-19469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A92C9CC03
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366133A8878
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96B2DC333;
	Tue,  2 Dec 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MES2Vj2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286D270557
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703305; cv=none; b=AbTkiX52yN9+s4tr9PVWMD+KNEIaqEeFz3Jgu5S1K9RhnA9WcepePPTEX/D8RkSnmYv/O15Uijt9MEtPN64NiZWZEyIVqn6piT/vypmaS9NTdykiOJ8XgkNsjKVjEhxVYG1U2DkU2io1K2BPs+12M0dtzmBaXFBzOopIfezSLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703305; c=relaxed/simple;
	bh=TeHRf3Yne8qQF2mjkZ6TBwRuBZNSMPGPhL5llCFqcAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENgx+dtF8voVR29d7lfBQa8cVXMGdxOGB9f6CehUny63GBLigYUue7Xr/gH+f5dyXCnspF3S21unIDMoSUmODz35z6I5tyzRd2RgrBHIsGcD9ZBA8XhoKve8bleGWfXSj+E6J+WeOcUh6nDsSwXAy/SutAkIjGWP1L/pbfaRMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MES2Vj2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428FCC19421
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703305;
	bh=TeHRf3Yne8qQF2mjkZ6TBwRuBZNSMPGPhL5llCFqcAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MES2Vj2LL6+f17VWGy7w9Y+51jf14Oqsa3YhRxDWCF+d/gwAspJpb/X0Np++ntnYp
	 rRzbtsv8ZadDIt0HQbiUIoMXcGz567ml3Vn61fiDtsFEsj2ZPmGRqoZuub/0mQlO2K
	 BknXcAEqwq4XkYnu+epiVQPk5QIa8L5fA+4n9yxKzk35U0ZRqeY500/xwc9UIxisW2
	 mA6cnmTVnh0OR4C8oLDp6uyrj/v6MxsgdTrKevRA8QQ5LgP8OxyNUrUle6Vol1uVLC
	 HxlJ+bvpBFEIF5ro3UbqC8jngNYLdncmRviMFKaeGW0PScrSTuo+pkOUmCXQq7bZQM
	 QfTKX0bU2U7/w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b735ce67d1dso939922866b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 11:21:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiQts/iVDkcgiq3/bxltwS0mjGCDY2yTzggVNo91s9am1b1HHUqmTarQudoGo2Xk2CH6ykFlEMgtT3RA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5apdRpD0FJRM/tG5u2tEXbjCUH2NLVCuXIALxYD4C9j4MXBp
	I0kxWoIF1qEJBdDsAXz9ayaI8oATLceezphZsjwKlbWKLfGgdXhYYN99LGAquZW5HI1mYMIpz0q
	NYGyL9Tqzd9cA6HkbQOXGtfOMmiNHYWk=
X-Google-Smtp-Source: AGHT+IHtWlzm9oEsDs2oHrqXRP/rIlSRMR5GGT1OiU12tuD6daiu1aiYYUW5JJ+4knoQgtXIzwLilCwJL791woCpO8g=
X-Received: by 2002:a17:907:9625:b0:b73:6b24:14ba with SMTP id
 a640c23a62f3a-b76c5352f1cmr3033311166b.8.1764703303822; Tue, 02 Dec 2025
 11:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aS8jaaOK/JB5sAnZ@gcabiddu-mobl.ger.corp.intel.com>
In-Reply-To: <aS8jaaOK/JB5sAnZ@gcabiddu-mobl.ger.corp.intel.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Dec 2025 19:21:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7tEb=Sd3rnPTYLKTvkxfk2B1KkZ9AHmPh2cU=uBBvThQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnZOKgRbfLKLTprI8_3qNcs08SL6rQeQPqIHXtrbWghx6ACPbXUG-SLw4Y
Message-ID: <CAL3q7H7tEb=Sd3rnPTYLKTvkxfk2B1KkZ9AHmPh2cU=uBBvThQ@mail.gmail.com>
Subject: Re: [BUG REPORT] possible use-after-free in btrfs_get_delayed_node()?
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 5:35=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
>
> While developing this set [1] I got the following issue which seems
> unrelated to the set:
>
>     refcount_t: saturated; leaking memory.
>     refcount_t: addition on 0; use-after-free.
>     ...
>     WARNING: CPU: 67 PID: 3156316 at lib/refcount.c:22 refcount_warn_satu=
rate+0x55/0x110
>     RIP: 0010:refcount_warn_saturate+0x55/0x110
>     CPU: 77 UID: 0 PID: 3002837 Comm: kworker/u1153:6
>     Workqueue: btrfs-endio-write btrfs_work_helper
>     Call Trace:
>      <TASK>
>      btrfs_get_delayed_node.isra.0+0xe9/0x1b0
>      btrfs_get_or_create_delayed_node.isra.0+0x134/0x1b0
>      btrfs_delayed_update_inode+0x28/0x1e0
>      btrfs_update_inode+0x59/0xc0
>      btrfs_finish_one_ordered+0x5c6/0xa90
>      btrfs_work_helper+0xc4/0x190
>      process_one_work+0x192/0x350
>      worker_thread+0x25a/0x3a0
>      kthread+0xfc/0x240
>      ret_from_fork+0xf4/0x110
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>
> Could this be a race between btrfs_get_delayed_node() and
> btrfs_remove_delayed_node() where btrfs_get_delayed_node() reads
> btrfs_inode->delayed_node and calls refcount_inc() without checking if
> the node is already being freed?

Already reported before, see:

https://lore.kernel.org/linux-btrfs/202511262228.6dda231e-lkp@intel.com/

Thanks.

>
>     btrfs_get_delayed_node()
>     ...
>         node =3D READ_ONCE(btrfs_inode->delayed_node);
>         if (node) {
>             refcount_inc(&node->refs);  // node may already be freed?
>             ...
>         }
>
> Thanks,
>
> [1] https://lore.kernel.org/all/20251128191531.1703018-1-giovanni.cabiddu=
@intel.com/
>
> --
> Giovanni
>


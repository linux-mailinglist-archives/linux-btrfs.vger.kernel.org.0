Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D2355174
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbhDFLAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 07:00:20 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:33880 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbhDFLAP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 07:00:15 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id D374B46ED11;
        Tue,  6 Apr 2021 14:00:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617706805; bh=H9FwXXph2t6EDZ5BRP/6l/iJ9oM/fv4XqIntQ+IfafU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=EpxdA8F2QXLKKFQ36njaO8bi15edy3z5VMVt2oO55ByX2EKRBpF2HgD3J3Io96UFP
         r5/6PcoouhGcBEMMyq2wfmrbux33WIEzeyFB+3n9M6s33qhQsn2qqNNmtyTMbCpGKf
         f8nKYmIiES1w3chb96ep44iDIe9AfgarEzZ0MoW4=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C2C2C46ED10;
        Tue,  6 Apr 2021 14:00:05 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id WTvbAp4udf3a; Tue,  6 Apr 2021 14:00:05 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 5EF2E46ED09;
        Tue,  6 Apr 2021 14:00:05 +0300 (EEST)
Received: from nas (unknown [45.87.95.33])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 5C9AA1BE0E20;
        Tue,  6 Apr 2021 14:00:01 +0300 (EEST)
References: <cover.1617694997.git.naohiro.aota@wdc.com>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs-progs: refactor and generalize
 chunk/dev_extent allocation
Date:   Tue, 06 Apr 2021 18:54:37 +0800
In-reply-to: <cover.1617694997.git.naohiro.aota@wdc.com>
Message-ID: <35w3d6gz.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBk3XhyTBXxmtCAUr1kpEWOj78+Ck2RhHn3jmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 06 Apr 2021 at 16:05, Naohiro Aota <naohiro.aota@wdc.com>=20
wrote:

> This is the userland counterpart of the following series.
>
> https://lore.kernel.org/linux-btrfs/20200225035626.1049501-1-naohiro.aota=
@wdc.com/
>
> This series refactors chunk allocation and device_extent=20
> allocation
> functions and make them generalized to be able to implement=20
> other
> allocation policy easily.
>
> On top of this series, we can simplify userland side of the=20
> zoned series as
> adding a new type of chunk allocator and extent allocator for=20
> zoned block
> devices. Furthermore, we will be able to implement and test some=20
> other
> allocator in the idea page of the wiki e.g. SSD caching,=20
> dedicated metadata
> drive, chunk allocation groups, and so on.
>
> This series also fixes a bug of calculating the stripe size in=20
> DUP profile,
> and cleans up the code.
>
> * Refactoring chunk/dev_extent allocator
>
> Two functions are separated from find_free_dev_extent_start().
> dev_extent_search_start() decides the starting position of the=20
> search.
> dev_extent_hole_check() checks if a hole found is suitable for=20
> device
> extent allocation.
>
> Split some parts of btrfs_alloc_chunk() into three functions.
> init_alloc_chunk_policy() initializes the parameters of an=20
> allocation.
> decide_stripe_size() decides the size of chunk and=20
> device_extent. And,
> create_chunk() creates a chunk and device extents.
>
> * Patch organization
>
> Patches 1 and 2 refactor find_free_dev_extent_start().
>
> Patches 3 to 6 refactor btrfs_alloc_chunk() by moving the code=20
> into three
> other functions.
>
> Patch 7 uses create_chunk() to simplify=20
> btrfs_alloc_data_chunk().
>
> Patch 8 fixes a bug of calculating stripe size in DUP profile.
>
> Patches 9 to 12 clean up btrfs_alloc_chunk() code by dropping=20
> unnecessary
> parameters, and using better macro/variable name to clarify the=20
> meaning.
>
>
gcc10 complains following warnings:
kernel-shared/volumes.c: In function =E2=80=98decide_stripe_size=E2=80=99:
kernel-shared/volumes.c:1119:1: warning: control reaches end of=20
non-void function [-Wreturn-type]
 1119 | }
      | ^
kernel-shared/volumes.c: In function =E2=80=98dev_extent_search_start=E2=80=
=99:
kernel-shared/volumes.c:465:1: warning: control reaches end of=20
non-void function [-Wreturn-type]
  465 | }
      | ^

Looked at locations just two nits about 'switch'. Care to fix?

--
Su
> Naohiro Aota (12):
>   btrfs-progs: introduce chunk allocation policy
>   btrfs-progs: refactor find_free_dev_extent_start()
>   btrfs-progs: convert type of alloc_chunk_ctl::type
>   btrfs-progs: consolidate parameter initialization of regular=20
>   allocator
>   btrfs-progs: factor out decide_stripe_size()
>   btrfs-progs: factor out create_chunk()
>   btrfs-progs: rewrite btrfs_alloc_data_chunk() using=20
>   create_chunk()
>   btrfs-progs: fix to use half the available space for DUP=20
>   profile
>   btrfs-progs: use round_down for allocation calcs
>   btrfs-progs: drop alloc_chunk_ctl::stripe_len
>   btrfs-progs: simplify arguments of chunk_bytes_by_type()
>   btrfs-progs: rename calc_size to stripe_size
>
>  kernel-shared/volumes.c | 514=20
>  +++++++++++++++++++++-------------------
>  kernel-shared/volumes.h |   6 +
>  2 files changed, 274 insertions(+), 246 deletions(-)


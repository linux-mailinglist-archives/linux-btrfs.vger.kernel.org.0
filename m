Return-Path: <linux-btrfs+bounces-17507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36FBC12FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96521883F5F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007B2DEA96;
	Tue,  7 Oct 2025 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnw5iAmz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3162DE6F8
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835977; cv=none; b=OrTmN9F/tiyaoAQ4qum3/wBWEQ1SZ0pwILxhv3tCCycvaPKcHKfVw/N2DqbwD0gdi97aWpbRu3ZChipWk1ozkgopsSiqJ3M+UOLJ0Ivm9N+0xnF16q+7zY9hpncVBpdnvFlf0wPr5rkJ1Li3ESnT9UCYdwHpz4Pa6/g3FeSDMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835977; c=relaxed/simple;
	bh=aXhwcHEV2p0AawwkQ1JFxXbLvBUS2g7aMCYMFuJFqUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPF9bpWoqxa+/7Zq3wVlyST2SaiDZlHlKchECnTB/s3v8OmS4Dhs4ENi5YWFKfSpAqn+CvyX2qLVlTlO9yaItWzNdam7hvs+vAcecGYgFrMSEugquyA3oHv0A/x7lF+bfdIUWtWD3ojF2sQtCBhsmwjZPP/8+aYB2KkmYYgNi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnw5iAmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C624C116C6
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759835977;
	bh=aXhwcHEV2p0AawwkQ1JFxXbLvBUS2g7aMCYMFuJFqUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mnw5iAmzCoW5NuiJQBwWmnJx6rYdJyzef8MREPJBVlUflDCkSsBEhtGw/oSrMrNK9
	 eVBeAZPQYv2p6vPDJgmAPk6PibLS1P61ITqYwXIkfCKCmWEJdAlCOrchRDLBBJ6+iR
	 FN3hBFmlC6UOMbZdw3d+Xgy3Pz35E+OTpDAyI7SlxhiaZOGApcebDxSZS5SuT9xtQa
	 E744e4uRPPkQl14qMVp0v9o7RUX5qp2co8QiFIq52WprvjVuK1sBe/sRQR/xmbssDx
	 i7Yw9XDBDTvsVnU7OnpMCm9dOXwWX3od1xLbPEXgbxpPB0OPlo4OK6EBTldSl3JjPk
	 nIg4rGZjWY5QQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b50645ecfbbso10836666b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 04:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb3lCvUyfB6txynYB9prR0EJ7C4875oCqzRbRIxcZLgl0bNHLIbbkVDAeVrM1F/be1Ehh8nwvbAr3vbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtSdG+Srwvp3k8xGOr+g5aC8JHqxmxYvzE/zzcHu5HBuh7Yim
	WoPIRo1GNCpT7QePtVqxVJef19bL+d+qkmwtTmgofDpXTrxwX6uC44HHORrDYsM6nclshIU/Iol
	cxsVfuQzmD9kI8hxh5ZI2lrDpHfTEMao=
X-Google-Smtp-Source: AGHT+IElEqgW2NAsHJn/Q/Ojw60YdjjFxrWcdvmubteLbwvla4VsU0jXo2wzYgprfkapj0S8f9W8Poln9sRxwUGnkJI=
X-Received: by 2002:a17:907:94c5:b0:b46:dbe3:e732 with SMTP id
 a640c23a62f3a-b49c3f7dbb1mr2177210066b.48.1759835975497; Tue, 07 Oct 2025
 04:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926165421.k7n3m6o2nuscarkq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <86b3c5c5-82ec-4083-9f1c-ac3fc11b0d57@gmail.com>
In-Reply-To: <86b3c5c5-82ec-4083-9f1c-ac3fc11b0d57@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 7 Oct 2025 12:18:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5keL6SJt0PpsV7wtDrf8sg0xgVy5piOv5WycCynbmrgg@mail.gmail.com>
X-Gm-Features: AS18NWDz2Pq4izoHYOkeexbJYZzDrpunJiIEnX7R8mjRU4VCw4i3wwbUAe2vJn0
Message-ID: <CAL3q7H5keL6SJt0PpsV7wtDrf8sg0xgVy5piOv5WycCynbmrgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] generic/562: Make test compatible with block sizes
 till 64k
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, ritesh.list@gmail.com, 
	ojaswin@linux.ibm.com, djwong@kernel.org, quwenruo.btrfs@gmx.com, 
	zlang@kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:29=E2=80=AFAM Nirjhar Roy (IBM)
<nirjhar.roy.lists@gmail.com> wrote:
>
>
> On 9/26/25 22:24, Zorro Lang wrote:
> > On Tue, Sep 16, 2025 at 03:30:10PM +0000, Nirjhar Roy (IBM) wrote:
> >> This test fails with 64k sector size in btrfs. The reason for
> >> this is the need for additional space because of COW. When
> >> the reflink/clone of file bar into file foo is done, there
> >> is no additional space left for COW - the reason is that the
> >> metadata space usage is much higher with 64k node size.
> >> In order to verify this, I instrumented the test script and
> >> disabled COW for file foo and bar and the test passes in 64k
> >> (and runs faster too).
> >>
> >> With 64k sector and node size (COW enabled)
> >> After pwriting foo and bar and before filling up the fs
> >> Filesystem      Size  Used Avail Use% Mounted on
> >> /dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
> >> After filling up the fs
> >> Filesystem      Size  Used Avail Use% Mounted on
> >> /dev/loop1      512M  441M  3.0M 100% /mnt1/scratch
> >>
> >> With 64k sector and node size (COW disabled)
> >> After pwriting foo and bar and before filling up the fs
> >> Filesystem      Size  Used Avail Use% Mounted on
> >> /dev/loop1      512M  224M  231M  50% /mnt1/scratch
> >> After filling up the fs
> >> Filesystem      Size  Used Avail Use% Mounted on
> >> /dev/loop1      512M  424M   31M  94% /mnt1/scratch
> >>
> >> As we can see, with COW, the fs is completely full after
> >> filling up the fs but with COW disabled, we have some
> >> space left.
> >>
> >> Fix this by increasing the fs size to 590M so that even with
> >> 64k node size and COW enabled, reflink has enough space to
> >> continue.
> >>
> >> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> >> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> >> ---
> >>   tests/generic/562 | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tests/generic/562 b/tests/generic/562
> >> index 03a66ff2..b9562730 100755
> >> --- a/tests/generic/562
> >> +++ b/tests/generic/562
> >> @@ -22,7 +22,7 @@ _require_scratch_reflink
> >>   _require_test_program "punch-alternating"
> >>   _require_xfs_io_command "fpunch"
> >>
> >> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> >> +_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1
> > Filipe is the author of this test case, if he can help to make sure
> > the 512MiB fs size isn't the necessary condition to reproduce the
> > original bug he tried to uncover, I'm good to have this change, even
> > change to bigger size :)
>
> Okay, I will wait for Filipe's comment on this change. Thank you.

This is probably ok.
This test was to exercise a bug fixed in 2019, commit 690a5dbfc513
("Btrfs: fix ENOSPC errors, leading to transaction aborts, when
cloning extents").
It's hard to confirm nowadays since the fix landed in kernel 5.4,
trying a revert of that commit is not practical since there are tons
of changes done on top of it, the alternative would be to test a 5.3
kernel or older.

The while loop below should ensure we try to fill all metadata space
with files that have only inline extents, so in theory it should be ok
for any fs size.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Btw, when you do a patchset that modifies btrfs tests, or even generic
tests that were motivated by btrfs bugs, please cc the btrfs mailing
list... I haven't noticed this before because the list was not cc'ed.


>
> --NR
>
> >
> > Thanks,
> > Zorro
> >
> >>   _scratch_mount
> >>
> >>   file_size=3D$(( 200 * 1024 * 1024 )) # 200Mb
> >> --
> >> 2.34.1
> >>
> >>
> --
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
>


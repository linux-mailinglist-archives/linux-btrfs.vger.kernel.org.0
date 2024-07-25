Return-Path: <linux-btrfs+bounces-6691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E593BFCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705B5B21CCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149A198A29;
	Thu, 25 Jul 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGdBTfgx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2A1741F0
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902794; cv=none; b=jddsgmDQsMpcwRd6Q8j21wf8gXuFMrfJPm/VQtJlg9hm+8IHRckiDiN8PrcaiZOFiYaXw++HzYP+eczZ/KKSNSxOYGQkIsCiCo3UqSDZNGw1MTiw8txmJcDAO1EqlA66j0Dg7SzT8tB+EDGozUHY4Vj4r+7r26eLfdxEWsF05x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902794; c=relaxed/simple;
	bh=X6+stTqx4zqt7z5ykqQq4M5y8zbCCx55GUVyHR5BVcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRCes0v65RCNyXl0xX2WuxQfX6rTOiyOAs3kwgmz2X06MHaBAWuy4vWNWPIHEhKvPdzrZYdlMs/TvqbdX6ZaWsrcb8o0qx46tDoS95/HIfxPRLTART/2/f5VTKBmqN85OBHofQ8zrMCQxOt/9QX4OGHwKHB8lg6xQqtGMtPmX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGdBTfgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF8C4AF0A
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721902793;
	bh=X6+stTqx4zqt7z5ykqQq4M5y8zbCCx55GUVyHR5BVcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CGdBTfgx5FiP4aBmIRC5zNMs0kj9Uep5JI+X4UDOJIxrQr05M5ld46udv+nVyzprD
	 iFP+GSRXJZnzAQHtSg/CJgIgpx3MMoBrZp+n+MYoGeZsK3D8KTH0Kc5xSoe+eVdhC7
	 RgRzwi/lWOCcPn/6C9dcnmwGnUMmKpimc9vAkSwrnOODvQw2XBRyIFP4Hrivz3hqR5
	 ob1+kR8HQtRx+uvaP7/qqhlDojM2VU97bqjbP22CkPdwCQk2sCaSYBuVIn1SYq6Bc/
	 w6a/i01nVsj1TKYfvEs0HttxQcWx+s6V8ggg6dm+RJek/ItKpxMCcKUAgyidV6rXMX
	 V1e62IFzFC1Fg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so960560a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 03:19:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrDiORXTEXfUlYONy4HW6jnWcUP+axebD0uCHd1n9QgpCELqAW
	A3LYSpHvxauur2Z9VU+M056KkuxfsNO5kLU4EWYJbcN6T81CQiXnY5OR8RSpIZixD5IGBTUr4Yr
	+udbw14zolWka0n07vWp63RGr4yY=
X-Google-Smtp-Source: AGHT+IEJO/Jgqq2Zr+rFJNIS+ORiv2Tyrc/sqaPl9H6wA/p7SdxyhNpiDcVB39s93rDCIXEv1kic+ki6hCAfI94N6jk=
X-Received: by 2002:a17:907:368c:b0:a72:5598:f03d with SMTP id
 a640c23a62f3a-a7ac506f336mr168640766b.59.1721902792092; Thu, 25 Jul 2024
 03:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
In-Reply-To: <0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Jul 2024 11:19:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com>
Message-ID: <CAL3q7H5VoYb6BAXYR+VZbAWirnfYRf++raT752j8nVa-0xJ7hw@mail.gmail.com>
Subject: Re: Appending from unpopulated page creates hole
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Filipe Manana <fdmanana@suse.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:16=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com>=
 wrote:
>
> Hi,
>
> I=E2=80=99ve noticed that appending to a file on btrfs will create a hole=
 before the appended data under certain circumstances:
>
> - Appending means O_APPEND or RWF_APPEND,
> - Writing is done in direct mode, i.e. O_DIRECT, and
> - The source buffer is not present in the page tables (what mmap() calls =
=E2=80=9Cunpopulated=E2=80=9D).
>
> The hole seems to generally have the size of the data being written (i.e.=
 a 64k write will create a 64k hole, followed by the 64k of data we actuall=
y wanted to write), but I assume this is true only up to a specific size (d=
epending on how the request is split in the kernel).
>
> I=E2=80=99ve appended a reproducer.
>
> We encounter this problem with virtio-fs (sharing of directories between =
a virtual machine host and guest), where writing is done by virtiofsd, a pr=
ocess external to the VMM (e.g. qemu), but the buffer comes from the VM gue=
st.  Memory is shared between virtiofsd and the VMM, so virtiofsd often wri=
tes data from shared memory without having accessed it itself, so it isn=E2=
=80=99t present in virtiofsd=E2=80=99s page tables.
>
> Stefano Garzarella (CC-ed) has tested some Fedora kernels, and has confir=
med that this bug does not appear in 6.0.7-301.fc37.x86_64, but does appear=
 in 6.0.9-300.fc37.x86_64.
>
> While I don=E2=80=99t know anything about btrfs code, I looked into it, a=
nd I believe the changes made by commit 8184620ae21213d51eaf2e0bd4186baacb9=
28172 (btrfs: fix lost file sync on direct IO write with nowait and dsync i=
ocb) may have caused this.  Specifically, it changed the `goto again` on EF=
AULT to `goto relock`, a much earlier label, which causes btrfs_direct_writ=
e() to call generic_write_checks() again after the first btrfs_dio_write() =
attempt.
>
> btrfs_dio_write() will have already allocated extents for the data and up=
dated the file length before trying to actually write the data (which gener=
ates the EFAULT), so this second generic_write_checks() call will update th=
e I/O position to this new file length, exactly at the end of the area to w=
here the data was supposed to be written.

Yes.

>
> To test this hypothesis, I=E2=80=99ve tried skipping the generic_write_ch=
ecks() call after reaching this specific goto, and that does make the bug d=
isappear.

Yes that confirms it, but it's not the correct fix but the inode was
unlocked and relocked and a lot of things may have changed between
those steps.

I'll work on a fix and let you know when it's ready in case you want
to test/review.

Thanks.

>
>
> Hanna


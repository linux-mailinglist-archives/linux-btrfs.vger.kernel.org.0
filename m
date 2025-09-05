Return-Path: <linux-btrfs+bounces-16638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDAAB4541F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 12:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315443B9BCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DD2C0293;
	Fri,  5 Sep 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eA7bbsEy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFF225409
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066834; cv=none; b=GxsJ6Ah/a9rQTBy4AvnU/bgy4f9l/REF2NMiQs85tqvElOWkNhmE7ql0JTzQxI9F3Pk3HJ6z6YNCoPohAVx31h14aSac/Gs6fCZaOiWdTAEUxQ3/5Es3QJ4qn91bRBqPTAN9QdtBuMEdBBmKtwCvqCV2TrUzEk3fsaPDEmEZSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066834; c=relaxed/simple;
	bh=PXVPvfNOaZt+jNohaf3/aZHBNw5Oi4Ea1/0dYtFiAXw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFjJhS6vtc55LYlxI3O8ay4CL72IKckof9rmzLY2zMVpvbqc2lAva1oSYSHshOBgsoz+FI1vn1Ly+mFuM5uulNJlFdnKoRbCsH19P7fJELEKhAMeNZBh4rpifc9Wrt6qfTkEddCS+QNctAozHq4YVcYZLVUZpzbAKixN9p8LI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eA7bbsEy; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jesihcc4nzhbnj5dseenai724u.protonmail; t=1757066830; x=1757326030;
	bh=DMSx2yhwc8g6k4ANbrPMngL4CnBxD/9O03MuF8dAyEA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eA7bbsEyJW/Ip/FZ3bcFwlyAfSRApb4c2Se+ENlpmmAbu1CzYhGesIxkmXTTnHS10
	 gTv/17CDoSqx6YnlH8VW452al9+7aHpwKTgmv9koUj/iaL+fCRYWSBra4wnixFV6ct
	 9gUKEKL2sx/P4l3+Vql36G5H7xFN5tTwq+NWTBW9CLkSNtH/KBG7TKrchVwhOQ/yio
	 12oHEx/7g9uMG7C0XSEF69OxqnNDMSglCMhSbN8Nv4H8pG2lDYgUXxlPt8kzapDlAl
	 s8lJJXA5TdHcFSiZ/qe7UlgQ/qZTUIAgS0lvtuAr7bDK30RAQN80ok3TiX9KAe+6U1
	 DFjUWgXNy6bhA==
Date: Fri, 05 Sep 2025 10:07:04 +0000
To: Andrei Borzenkov <arvidjaar@gmail.com>
From: jonas.timothy@proton.me
Cc: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs RAID 1 mounting as R/O
Message-ID: <FYhGZxh5nnQMdJcNArmNusJquGeOHsc75KFcFCSSGZlHN-2E7yaBouXiQ0NXQFwFYJ8NT0MpJ1z1xEbeIP0iWKG8IAyQnvivS436I6a3B70=@proton.me>
In-Reply-To: <CAA91j0XXP4+2RACLuiO46VMG9nr=CgGjEpFtAJ1SA4thSQHJ8A@mail.gmail.com>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me> <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com> <CAA91j0XXP4+2RACLuiO46VMG9nr=CgGjEpFtAJ1SA4thSQHJ8A@mail.gmail.com>
Feedback-ID: 94251912:user:proton
X-Pm-Message-ID: d57e7c542220c9155e99f94690f066ccc8ed5f1c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Sent with Proton Mail secure email.

On Friday, September 5th, 2025 at 3:28 AM, Andrei Borzenkov <arvidjaar@gmai=
l.com> wrote:

> On Fri, Sep 5, 2025 at 8:38=E2=80=AFAM Qu Wenruo wqu@suse.com wrote:
>=20
> ...
>=20
> > > [Sep 5 02:22] BTRFS error (device sdb1): parent transid verify failed=
 on logical 54114557984768 mirror 2 wanted 1250553 found 1250557
> > > [ +0.023579] BTRFS error (device sdb1): parent transid verify failed =
on logical 54114557984768 mirror 1 wanted 1250553 found 1250557
> >=20
> > COW, the most critical part of btrfs metadata protection is broken.
> > This is already permanent damage to your fs, thus every time extent tre=
e
> > operations touches that part, the fs will flips RO.
> >=20
> > The damage itself should haven been done in the past.
> >=20
> > And this looks like FLUSH command not properly handled.
> >=20
> > Considering you're running btrfs on a raw partition, either it's btrfs
> > not doing metadata write correctly, or the disk itself is faking FLUSH
> > handling.
>=20
>=20
> ...
>=20
> > > Write cache is: Enabled
> >=20
> > You may want to disable the write cache so that the firmware has less
> > chance to cheat.
>=20
> ...
>=20
> > > SATA Phy Event Counters (GP Log 0x11)
> > > ID Size Value Description
> > > 0x000a 2 7 Device-to-host register FISes sent due to a COMRESET
> >=20
> > /dev/sda has been reset several times by the controller.
>=20
>=20
> Disk reset will likely flush any pending IO request in the disk cache
> which may explain transid mismatch.

NOTE: resending because I used regular reply.  Sorry.  I just woke up.

Does this mean I have to redo my RAID again?

I forgot to add: here's my fstab

UUID=3D8641eeeb-ddf0-47af-8ed0-254327dcc050       /mnt/disks/disk-12TB    b=
trfs   defaults,compress=3Dzstd:3,noatime,space_cache=3Dv2 0       2
UUID=3D8641eeeb-ddf0-47af-8ed0-254327dcc050       /mnt/nextcloud  btrfs   d=
efaults,subvol=3D@nextcloud,compress=3Dzstd:3,noatime,autodefrag,space_cach=
e=3Dv2    0       2
UUID=3D8641eeeb-ddf0-47af-8ed0-254327dcc050       /mnt/jellycloud.2       b=
trfs   defaults,subvol=3D@media,compress=3Dzstd:3,noatime,space_cache=3Dv2 =
  0       2
UUID=3D8641eeeb-ddf0-47af-8ed0-254327dcc050       /mnt/downloads  btrfs   d=
efaults,subvol=3D@downloads,compress=3Dzstd:3,noatime,autodefrag,space_cach=
e=3Dv2    0       2
UUID=3D8641eeeb-ddf0-47af-8ed0-254327dcc050       /mnt/shared/data        b=
trfs   defaults,subvol=3D@shared,compress=3Dzstd:3,noatime,autodefrag,space=
_cache=3Dv2       0       2

## 20TB
UUID=3D3f883c84-7646-4b29-86b0-0fa581396405       /mnt/disks/disk-20TB    b=
trfs   defaults,compress=3Dzstd:3,noatime,space_cache=3Dv2 0       2
UUID=3D3f883c84-7646-4b29-86b0-0fa581396405       /mnt/jellycloud btrfs   d=
efaults,subvol=3D@media,compress=3Dzstd:3,noatime,space_cache=3Dv2   0     =
  2

I also replaced my RAM as the 64GB pair my have memory issues.


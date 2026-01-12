Return-Path: <linux-btrfs+bounces-20392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43FD11CC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB23A30587B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE452C08C8;
	Mon, 12 Jan 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgwop1/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE082C0279
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213070; cv=none; b=gMZc3Nzv+Hl1gPFwLnekOlts8bYOuUrG5Was+1LxPia+SGRH5HXj0Hgvv+5Ao8Od2DyLERj8VHdskcCq11Ao3AG0A96jO2B5GdmF9ySiYLVwI9E+9eZZ7FVFVz6O7t3b3cmfQNCZ/BbL60k/e7mlQy9MXU2BGMOjHXfVCU75W6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213070; c=relaxed/simple;
	bh=S5zA9trMytrRFHIzE6BfZ+xY1cX2cQqO4IXyLY42koo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHU+7LQi6k1GYjtvPAghkQUzdQbeGGLdiUliCXJbk9UPj6qyuXEE6Mn4H2hPDViEUoPuGN7mQjaNCHS58me/npTpBdIOkidu7h6KE4TCzHCW+lNy1iBgyQcrh1AgVcH7KFXzKw61CMkWw7amb54MiKBlgcM8SG+/yjtdHLjCTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgwop1/G; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6d13986f8so4118198a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768213067; x=1768817867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5zA9trMytrRFHIzE6BfZ+xY1cX2cQqO4IXyLY42koo=;
        b=Vgwop1/G8X7C8yC1C1FWkPOtbTRPoP0/2VxEOcLA/pwQ3ZbcNeSzBWhX9BVxYuokLi
         gJufZ4LyOL+QL3CXejySc/0S+IJGISnYfaVtQQVKxQCDKULQjLZdHuWwJUF/c9ZRqdAP
         64S7zDX9a/PHcuC98dqrCNetiMkJ3ZcTjRKzYeY0k6r9lcqksa/FfhYppST9vivx9Cv7
         3dxSxLKxan7uyvigH5KsiI8ELglTfmlXl63ilIeXMptA+2jdO5FBjCOXvwVpixgZwxKU
         AgB9NfpxTJTZNeH67M58unvJmSmIzabBFBvcRSc9j5bggkXNeBRemi21Fk3TNd3dQbhz
         3hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768213067; x=1768817867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S5zA9trMytrRFHIzE6BfZ+xY1cX2cQqO4IXyLY42koo=;
        b=npOl75GQ+SNja2In4qznNluzt3MQChcKhdV0RGm+OekC3w0Tm1/43DCVb2xf8Sad9V
         FyyVuSOhBQEWdoJ+p/Am2eRygqSTEjSSuSSMVNUFQtx6a9jAAZNgndvoE1ptnRgrqoU0
         7aHMUXpXm2pcJAnIPvdQdWmlcJNxOfpte0giBK3In2xc7Qiyz00h09H9S2gSPTOEzrmO
         kUI9v7cx+pjn2btqwlZBhfwZHDkdpIBojKjysQlJsR4oxRysbZV1RkfooYj0l1qMaO+n
         gWLubCMG+WTy9ahCL5l/NUhIKdzqz4W+GenOgh+/lEJnNU/8KoPCrRpqLZVWgl9x+riw
         T+3A==
X-Gm-Message-State: AOJu0YwkIhswVMqoVA5TugrJbj1/7VFUMSFvRWQTDzMsKMMpTaMUXSKv
	dBssnvwzNaIXbq8gN+AwNIfETcYElBnbe9pMsrxU6Yyr3QUoWMErG69FfJtNcsITI/cx8XWWXeM
	isu53v94xQSXro3HWyaWaJ+tNYv3t/+CSIcoT7D1cvw==
X-Gm-Gg: AY/fxX79CiOtvTA69htKw95As/lOD0NrpBrGhRcpqeCqfy0awUCh9Vx/lInae4kga4/
	0GdA82R2Ij0q466p8UzcsL24Cm61uualF6554Bq9q6q6tXL18U2IZ1bOV1abz+EHV4xKHxserfT
	Kr0ojiNaZJjrp9oDMU+wa11LT2xbgoQgk4cZsqaM9MPxeNFPI0YnKht49MU4NqHCoIl9+ySrQCh
	s2DUaxlUnXKE0YxRieDPxE2mDl+aqL/wKPWCGxSA0VK5AF9NE4KuGrhMXVu3lZVvy7uz/elONwz
	Io3psJA=
X-Google-Smtp-Source: AGHT+IFM5nnOMWq2Wk179p2nQQWKolW/CjGp5IHtEg2U/jDGtH/4AQdbHR3fWwzxXEbSocmixvYCljm17TLQEswuE3o=
X-Received: by 2002:a05:6830:4389:b0:750:69c2:365a with SMTP id
 46e09a7af769-7ce50a26f8emr10479023a34.4.1768213067474; Mon, 12 Jan 2026
 02:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsN7SjNjnn9BRPXr6OK_aZUxs89RVWyX5HFi=S+Ri3tadA@mail.gmail.com>
 <CABXGCsP1dXnutvM9pUNyZavJTTRpEeJsVNzzyVJqbVasz0=dXg@mail.gmail.com> <f6bb03fa-ed85-41ff-b8d9-f89013469e3a@gmx.com>
In-Reply-To: <f6bb03fa-ed85-41ff-b8d9-f89013469e3a@gmx.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 12 Jan 2026 15:17:34 +0500
X-Gm-Features: AZwV_QhFombpCpxWOYwP_QnHHZwj1kW2H1uVdARVztqcJnEnTBnJcuEkJWhck1Y
Message-ID: <CABXGCsOTTGrMFo08H6xQ5EU0WzbJyOnEqNq46mUPRd5K6KYcjw@mail.gmail.com>
Subject: Re: [BUG] btrfs-progs 6.17.1: btrfs check --repair aborts with ASSERT
 in delete_duplicate_records() due to overlapping metadata extent
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:10=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
> This is already a very critical error.
>
> Normally I won't recommend to do any write operation (including repair)
> on it already.
>
> >> - hundreds of duplicate extent backrefs in the 17101544xxxxx range
> >> - multiple inodes in root 5 report "some csum missing"
>
> If that's the only problem reported from the subvolume trees, at least
> you can grab most (if not all) of your data by a "ro,rescue=3Dall" mount.
>
> >> - extent tree contains conflicting metadata backrefs
> >>
> >> Request
> >> -------
> >> Please relax or remove the fatal ASSERT and add a repair path that can
> >> safely handle/delete overlapping metadata extent records.
>
> I'd say it's not that easy, or it will already have been done.
>
> The biggest problem of repair is, we have too many factors all combined
> together so that any seemingly simple operation can even further corrupt
> the fs.
>
> E.g. if extent/free space tree is corrupted, a simple metadata COW may
> overwrite some existing metadata, further corrupting the fs, even
> causing more corruptions.
>
> That's why current btrfs check --repair is only designed to handle a
> single error at a time, not really several different ones combined.
>
> And unfortunately for your case, it's multiple ones combined.
>
>
> Furthermore, if your system doesn't have ECC memories, it's strongly
> recommended to run a memtest first to rule out bad memories.
>
> Hardware memories has its life limit, especially for DDR4 ones that
> lacks any kind of ECC, and due to their ages some are already causing
> problems.
>
> My estimation is around one bitflip related report per month on the
> mailing list, thus it's always recommended to do such check especially
> when your fs is hitting very bad corruptions.
>
> Thanks,
> Qu

Hi Qu, hi all,

Thanks a lot for your reply and the explanation.
I re-tested the issue with the latest btrfs-progs from git (devel
HEAD) and the behavior is unchanged: btrfs check --repair still aborts
with SIGABRT in delete_duplicate_records() after reporting an
overlapping metadata extent record.
Reproducer (filesystem unmounted):
- btrfs check --repair /dev/sda
It reaches the extents phase, then prints:
- well this shouldn't happen, extent record overlaps but is metadata?
[17101544210432, 16384]
and aborts. Under gdb the abort is in delete_duplicate_records()
(check/main.c), same as in my original report.

I fully understand (and agree) with the general recommendation that
--repair should avoid risky write operations, because a wrong repair
can make things worse.

However, I=E2=80=99d like to describe my specific use case, because it=E2=
=80=99s
somewhat different:
- This filesystem is basically a large Steam library / cache. The data
is not =E2=80=9Cunique=E2=80=9D (can be re-downloaded), but internet bandwi=
dth is the
bottleneck and re-downloading everything would take a very long time.
- My practical goal is not perfect data preservation. The goal is to
get the filesystem back to a writable state even if that implies
losing (or deleting) a significant amount of corrupted files/metadata.
Steam can re-fetch missing/corrupted data afterwards.

So I wanted to ask:
1. Is there any existing =E2=80=9Cbest-effort to become writable=E2=80=9D p=
ath you
would recommend for a case where data loss is acceptable (e.g. any
rescue/repair sequence other than btrfs restore / ro,rescue=3Dall)?
2. Would it make sense to consider an explicit =E2=80=9CI accept data loss=
=E2=80=9D
mode for btrfs check --repair (e.g. --force / --repair --force), that
would try to continue past cases like overlapping/conflicting metadata
extent records by dropping the problematic records/inodes, with very
loud warnings and an explicit confirmation prompt?

I realize this is dangerous and absolutely not suitable as a default.
I=E2=80=99m only suggesting it as an explicitly opt-in mode for situations
like mine where formatting is already an acceptable outcome, and the
only reason to try is to save time/bandwidth by keeping whatever
remains readable.

The btrfs-image and logs/backtrace are still available at the same
location referenced in the original email, and I can provide any
additional debugging output if needed.

Thanks again for your time and for maintaining btrfs.

--=20
Best Regards,
Mike Gavrilov.


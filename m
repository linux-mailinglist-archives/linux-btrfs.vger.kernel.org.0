Return-Path: <linux-btrfs+bounces-10960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D8A0FE51
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB0116996F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D8230242;
	Tue, 14 Jan 2025 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0QeG/ge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F901C54A7
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 01:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819560; cv=none; b=WfkfRGE59wj+5idwLnhmGJLJo7spuoDzs77VZ38aUMOX2xgnSnKSs/mPt0x8YrQssXo9zBzaPtbBG173whkN3Lo+hY4AJ37aF21QMgpb3iRK6gDUmGCATpzPh+rKkrUccJfWwYX7G6qxdraoCHM9ZjQiNCBMrpEQe7qSIrWTEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819560; c=relaxed/simple;
	bh=RCWkw6UOGHAzXJEqj/najQoGHUQ3y1QcwYaLCWhmMWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oY4il3LAyT4dRbvyDtzATa/CPVwQS4jFp4I9lc0CJzDQ3JZBfeb9l5xEpFpWTd29xbzRQ+4BkD3Lu2coX/3dl3XF3E8Y+hwA3vYy7pf8Ov6nKfSzBPJ0l7UpHTaTUOny8ugQNRAQADpMXxWJ3xRVYSUy2iSa7YzO8mgRgyWDORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0QeG/ge; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f0afda3fso515649785a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 17:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736819558; x=1737424358; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C45/pIn4dRnW66bpbGq85fhUFrusJaMQabU/WxUEQ14=;
        b=K0QeG/geq+klUnGtaokJbgAUnVFUBfusH0uI67axW+blP/ljVUhcqIVMBcSknqKFK1
         g+tIH2xICTY+CylLZxVel6wKXE12hX6IaI8jNGFSu3MzrtB0sosuae0Kg/uilYf/4PlC
         51SOFpBPJchd3RsztY0Vd47o60+Bra6tLB6QenJzLMhg9dvZ/Udn9vQYciDr3EHHLvga
         EyXhdCjl7WO3Li+1wgjZXkiDEQi1w+N5HphuE9r/Y7kaziUXfZRJinM5iRvDiBvkpsko
         9YcDVDGc7BmCe27Ieu27aDCN66vTSNbTi+dt2jFf5QF9IfAFlsFWJEykOQGDXMr3ytso
         3/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736819558; x=1737424358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C45/pIn4dRnW66bpbGq85fhUFrusJaMQabU/WxUEQ14=;
        b=kcP18gidGwt2pQAwMzAOUfq8bNYPPGGN+5aw9gnWCm0veeipa2zizuFPV827t00+Ab
         OTMNHpxoGQMyR4iiTPbrW0obTuqrmTWBoKhBogWxrrE15lDfv/4S7EjgCrf3vg3zNnDe
         zcNNiDOaPSGTVTmwOlLcVJDfXAjd4NHOMSTEwZKrKSp35eMLnRkpF5ZA8TVPw+H7XTDy
         B/8UTJtRPLasg8BMhpZl4lpVZkGtWYYwAYJui9LBdM2XYSHdFJ+E6+HZIElYTJymjKz+
         tLwXDaXZMoiNZHFKykn02O4lTSRRm4LgwXJR6GEMPK8krA6R5pH/shn5iyy809DOu56j
         BHtQ==
X-Gm-Message-State: AOJu0Yw8KdoJA9WLCkXBVGnUeZ5SXdg7AjbBFr/HwFwXGoxWJCBKV3rs
	p4IkY9eJdp7EYUighlt8Iuxx6eRDPg3QvsvxomMAYFn/j1sr+owmdCyPQZpq
X-Gm-Gg: ASbGncsNrsP9N96FQ/MxqJ3zQE1SOPsd8/RfcblMQJsX31mPjAnZOvPHvJUSx1R/emw
	9HQYfoU+qO2fndmWPthqLukY8S+Ld0D7spLpRa1QlJF6Dm81TwjuwvrmQQrEwPVeeLblz82E2O0
	dd35pIm6oDpasblphbImwoVYqsAlkrsfFtqr/C0bnJQT1ZIBcY8B2RWawaQCbWGxmm8ZRDBFotT
	rluqIqk9BH1liswPbskX0V9T53+nXNnTEWXZZx3VaYK7PbJLg6uZLvp6rz37Bdkg7tTIyYvUtid
	BaJ0gbjT8ezO5f5dXUNSd0dJXsnkPywu
X-Google-Smtp-Source: AGHT+IHpA8Ws20kE8UM/WatPFZd8UQE5u0yTHU90aAuMfJtpAHzFgcA8Jc+cA2v1uSW5sJwGXpIptA==
X-Received: by 2002:a05:620a:4115:b0:7b6:d643:599c with SMTP id af79cd13be357-7bcd975a013mr3684887585a.43.1736819557837;
        Mon, 13 Jan 2025 17:52:37 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:9f5c:fed4:18fb:8679? ([2600:4041:5b0d:f100:9f5c:fed4:18fb:8679])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce32482d0sm553578885a.38.2025.01.13.17.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:52:37 -0800 (PST)
Message-ID: <41deb494a3e661d78cc5f2427356457fa5ab36c8.camel@gmail.com>
Subject: Re: write time tree block corruption detected, forced readonly
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Date: Mon, 13 Jan 2025 20:52:36 -0500
In-Reply-To: <cd42beff-741d-4b9c-b78d-4244df06d0c3@gmx.com>
References: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
	 <cd42beff-741d-4b9c-b78d-4244df06d0c3@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 07:24 +1030, Qu Wenruo wrote:
> =E5=9C=A8 2025/1/14 07:00, Jared Van Bortel =E5=86=99=E9=81=93:
> > Hi all,
> >=20
> > I am using Arch Linux with the latest linux-zen kernel (6.12.9-zen1-
> > 1-
> > zen). I saw the below error in dmesg today, and my filesystem went
> > read-
> > only. I haven't rebooted the computer yet. This is my root
> > filesystem.
> > What should by next steps be in order to get this computer up and
> > running again?
>=20
> In your particular case, it's a very strong indicator of bad hardware
> RAM (bitflip).
>=20
> Thankfully the corrupted metadata is rejected before writing to the
> disk, so your fs should still be fine.
>=20
> So your next step should be run memtest, either memtest86+ as UEFI
> payload (preferred), or memtester inside Linux (with minimal other
> program running).
>=20
> After fixing the bad hardware RAM, then I'd recommend to run a "btrfs
> check --readonly" to verify there is no other problem in the fs.
> Although tree-checker is doing a very good job, it's impossible to
> catch
> all bitflips.

Thanks for the suggestion. I ran memtest86+ and it found an error fairly
quickly. I switched to some known good RAM for the time being, and btrfs
check --readonly reported no errors.

> > Would it be OK to just reboot and attempt to use it again? Should I
> > run
> > any particular commands to further check the integrity of the fs? Or
> > would it be best to attempt to rebuild the whole fs from backups?
> >=20
> > Not sure if it's relevant, but IIRC this filesystem was created by
> > doing
> > a btrfs-send of each subvolume from my previous btrfs disaster
> > (subject:
> > "system drive corruption, btrfs check failure") to a new set of
> > SSDs.
> > Could that have caused an issue? Is it better to use rsync and lose
> > reflinks, birth times, etc. than to use btrfs-send to recover from a
> > corrupted fs?
> >=20
> > Also, I have the usual question of whether this is most likely to be
> > a
> > kernel bug, faulty hardware, or user error. And how I might be able
> > to
> > identify which file(s) is/are corrupted based on the output.
>=20
> It looks more like hardware problem (unless there is some other kernel
> bug randomly flipping memory bits).
>=20
> No file is corrupted (at least for this incident). The bad metadata
> write is rejected by the kernel so no damage is done (by this
> incident).

Yep, looks like BTRFS saved me from faulty hardware in this case. I
wasn't even aware that it could protect against this sort of thing.
Nice!

> > Thanks,
> > Jared
> [...]
> > [=C2=A0 +0.000001]=C2=A0	item 66 key (3148007481344 168 8192) itemoff 1=
3022
> > itemsize 53
> > [=C2=A0 +0.000001]=C2=A0		extent refs 1 gen 380990 flags 1
> > [=C2=A0 +0.000001]=C2=A0		ref#0: extent data backref root 260
> > objectid 68965 offset 407224320 count 513
>=20
> This is the offending bad extent item.
>=20
> Firstly it shows the extent item should have only 1 ref ("extent refs
> 1").
> But the inlined one has ref count 513, completely beyond the expected
> 1 ref.
>=20
> hex(513) =3D 0x201
> hex(1)=C2=A0=C2=A0 =3D 0x001
>=20
> Very obvious bitflip.
>=20
> Thanks,
> Qu
>=20
> [...]
> >=20
>=20

Thanks,
Jared


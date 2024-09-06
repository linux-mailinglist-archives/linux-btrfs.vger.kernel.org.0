Return-Path: <linux-btrfs+bounces-7879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8E96FB60
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C081F22ABF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC814A4D6;
	Fri,  6 Sep 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THwKipZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB591B85CA
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648168; cv=none; b=EedG2tr6katHxAk7+8cGA6qGszCSOx951lfpNQEYr7hP2cDF1B9JmV8qP/qvNhp4GSgcQ+N04jZViHPEdKCmQ7y3zN4rG+k8DWy1pdb7dq97KpCUUeqxVYEXN01wh/g0duVaFCnzVjQnlPIvPEuGtJSLlnB69EVkCVNT5PpjBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648168; c=relaxed/simple;
	bh=hMc2JncvsaWTT5+UozWOwVEhWGfXy+GjmZHsHyo1RZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzPdsYAB/1KahSTzZXcJ0gya4Vq3hmlqkclwglvETF9e0HhCW+HZBOiSemlJp5ZQOpZgOdF+/eoQv3dJ9pKn8RJpBRAde/UIXFbPAhCWOrvRGlNBdUPQQQftEznvnUc1hTZNBlTvJ7YGsciufNS4+hXhzyfwgl3vl0h0pYHImIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THwKipZU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso70766566b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2024 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725648165; x=1726252965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHZd5LmEr+YeevZxCpH4bpBYGQbvhkMhdnGX75a+ZFM=;
        b=THwKipZUd6R5sTChim9b1yb3YuMZrbVQEymlNzakADrxFmTF1MC8pHYIcS9sK+UIkd
         l0zJCzSQsRVO33eDjL5JsRaeutHNTSuO2m9SFec+1aJJwG0H0B90EceQ2VlXVBWxfVji
         EE6siusAT59ciHoneCUm/fx3udA1tEqPNKiuc0KZsFWuunWY13EYqleaTd+1Ule72PVq
         5yybdQRAg9I+Pwqvnf8JNZigORh3HtQoucROgPBDL/Q2Di46gomXRw7beL+KTVt0Dvab
         HuM2Iw8WaG01DAOi6ieGzs/mMJiHp0DmcxMg6KWVks9bOpJMFf69vdzpGkHxEVhaoN+x
         J2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725648165; x=1726252965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHZd5LmEr+YeevZxCpH4bpBYGQbvhkMhdnGX75a+ZFM=;
        b=tIrlAzArJrSSyLPG1N9rtUzZ86uqjsX4tlGGosQSmbdL4+NdvQbElH9SEKbDczahAB
         hEjYXivKrA+Jrh2/CSWcVVaqkKXdDerYLoT5YgPa2scFa/Cx15egMVCMQDSxMjE6cK7c
         TlzeqXyj49xdbReX9rVoZlfuwOGdw9ZQoizLw7D/xODV2U9JLsbAIQICaWmN+dir41HX
         4Gvkhj7Karn1TcyU0FjbN6qLnlmtKYOybu3g4UBoQOLneqD5L2FYYjxhKiPkqGa8XgMD
         NsxBsEpeoN3cRpVwEI7enFtf6f8D72ed+0duqUzzyOSHmbKCdmzKYjWOoslPR69jCuiC
         nhUg==
X-Gm-Message-State: AOJu0YxJfi9zn4YnDGAu48ynMXx15f036tSzH/Mp5QkK6mKOusil2Zyd
	2SDUI/eH4d82IN9ZkrKJ2HqM6FT3MP8q0Z1UtbrWBDOaeXRbZdFzFPwkZ2yAHZ2Y3BvXyZMaBtm
	3SHzR8YuLxQHnPG1DeqW9vzqdMqLeHwEs
X-Google-Smtp-Source: AGHT+IHIp9fTFnMyRYNHY7Cq96sKHCi2pe5jU0WHxhTYtIqlA0wIQ4thDLG74JpevbohBYVVTah/J5sxr4kBNKnTHO8=
X-Received: by 2002:a17:907:7f22:b0:a86:9e84:dddc with SMTP id
 a640c23a62f3a-a8d1cd6a3ecmr9556866b.61.1725648165008; Fri, 06 Sep 2024
 11:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
 <57d77231-4d07-4773-93c4-0f27bd9a851c@gmx.com>
In-Reply-To: <57d77231-4d07-4773-93c4-0f27bd9a851c@gmx.com>
From: Brent Bartlett <brent.bartlett1@gmail.com>
Date: Fri, 6 Sep 2024 18:42:33 +0000
Message-ID: <CACSb8p+PLVhF8iKDjxr_jD+q8tAuG99NdF7Z2EQ5UZQqt9aJ4Q@mail.gmail.com>
Subject: Re: SSD stuck in read-only mode with call trace and itemoff /
 itemsize errors
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here's the output from btrfs check --mode=3Dlowmem <device>

Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
[1/7] checking root items
[2/7] checking extents
ERROR: extent [228558536704 16384] lost referencer (owner: 1281, level: 0)
ERROR: extent[335642972160, 4096] referencer count mismatch (root:
257, owner: 9223372036856479121, offset: 305790976) wanted: 1, have: 0
ERROR: file extent[1703313 305790976] root 257 owner 257 backref lost
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 771521245184 bytes used, error(s) found
total csum bytes: 750323744
total tree bytes: 2901278720
total fs tree bytes: 1938309120
total extent tree bytes: 166903808
btree space waste bytes: 365206037
file data blocks allocated: 857740091392
referenced 855826853888

and here's the output from btrfs check <device>

Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 12e7a361-f58a-4611-81ff-ed8303782bcb
[1/7] checking root items
[2/7] checking extents
tree extent[228558536704, 16384] root 257 has no backref item in extent tre=
e
tree extent[228558536704, 16384] root 1281 has no tree block found
incorrect global backref count on 228558536704 found 2 wanted 1
backpointer mismatch on [228558536704 16384]
data extent[335642972160, 4096] referencer count mismatch (root 257
owner 1703313 offset 305790976) wanted 0 have 1
data extent[335642972160, 4096] bytenr mimsmatch, extent item bytenr
335642972160 file item bytenr 0
data extent[335642972160, 4096] referencer count mismatch (root 257
owner 9223372036856479121 offset 305790976) wanted 1 have 0
backpointer mismatch on [335642972160 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 771521236992 bytes used, error(s) found
total csum bytes: 750323744
total tree bytes: 2901278720
total fs tree bytes: 1938309120
total extent tree bytes: 166903808
btree space waste bytes: 365206037
file data blocks allocated: 857740091392
referenced 855826853888

Thank you

On Fri, Sep 6, 2024 at 1:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/9/6 10:29, Brent Bartlett =E5=86=99=E9=81=93:
> > I have an SSD drive that was mounted by the system as read-only due to
> > errors. I have posted my full dmesg here:
> > https://pastebin.com/BDQ9eUVc
>
> Great you have posted the full output:
>
> [   36.195752]  item 123 key (228558536704 169 0) itemoff 12191 itemsize =
33
> [   36.195754]          extent refs 1 gen 101460 flags 2
> [   36.195754]          ref#0: tree block backref root 1281
>
> This is the offending backref item for the tree block.
>
> But what your fs is expecting is:
>
> [   36.195988] BTRFS critical (device nvme0n1p2 state EA): unable to
> find ref byte nr 228558536704 parent 0 root 257 owner 0 offset 0 slot 124
>
> hex(1281) =3D 0x501
> hex(257)  =3D 0x101
>
> Another bitflip.
>
> I'm pretty sure "btrfs check" will just give the same error.
>
> And this really looks like something wrong with your hardware memory.
>
> >
> > Please let me know if you need any other information. How should I proc=
eed?
> >
>
> It's strongly recommend to run a full memtest before doing anything.
>
> I'd say your previous RO flips may also be caused by your faulty
> hardware memory too.
>
> Other than that, please provide the following output on another system:
> (The lowmem mode output is a little more human readable)
>
> # btrfs check --mode=3Dlowmem <device>
> # btrfs check <device>
>
> To make sure if that's the only corruption, and we can determine what to
> do next.
>
> Thanks,
> Qu


Return-Path: <linux-btrfs+bounces-16633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B2FB44E81
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A05A35CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32392D3A80;
	Fri,  5 Sep 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AABBVlMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E402D24AB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055586; cv=none; b=cYNHSwnZXjOHFnxgNWESkZLVdnwcdnsCTITFge3zCrgerH09YmC1K/rSXnvNM55W2CHGQ6PLHCLVFqjKAsRO+ayyVKwHXA4UBqU1L93yToh1OiR89dczkXlTpYmZdDlfIU6jqAs6EjMOla8SWkF8Ts2OMzHmfwNgYzaO/hOuGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055586; c=relaxed/simple;
	bh=IsvD7bNyaSCv7wFn+8A+b63v2M1Rct803dUU0ekVXWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSCicntwN14gb2GAe3/LY+GW+Nkuwb237s/6c1TnvTj7V7k9oyWDPtmCeGX7pgZdiOnN4u0R2X5pBLkTOAKIxC1dLfeqm6K1lxEstqWcMnl3NR9mzsUORRI+1vlB9vlYx51ugxqKecv8Nt/WY3XrvUT4AwS1pyYBJXYIA8FR9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AABBVlMN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77246079bc9so2205836b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Sep 2025 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757055584; x=1757660384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vtlt+jyJCmMbSmtYsQWlCXfkb05JgJ1sCk9WLuFpnM=;
        b=AABBVlMN7TKFLFyQnlPMTF++G37gTKEpRYpgQLaZrPUPEo/BqM6Q67Rooom5EJ1NeR
         juZwWNeu8sp//AAWUxex2mXdvoccni9goUutALciwT862c7EqN/UlxeMvxQWXn92/jXP
         uS2NcuEhVRiPYyc80kY0yqrbep68Km4Gbjze7fmk2UOWFTQKxjKBg2G3fuERbd9X3i+Y
         bRKBHqp6JnLQHsfl70Q+k7iFMIqpVhyWua67a5AbBJ5LU2t09gzZLGs58BASPD3NNpqI
         Eexf5cWyIMT8fpJ/dvnMq6WABVlFC5G9qbpDxx+0JFl2dYO+lo4TsGF4zVmpbUh93giK
         sLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757055584; x=1757660384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vtlt+jyJCmMbSmtYsQWlCXfkb05JgJ1sCk9WLuFpnM=;
        b=gnXW7UmffX2MDNvFOq4LtZ6eEF0SnYyCfNwWbSzZBaFgWK0ThOhf8aqaBdqSVAvBeG
         66IPhjpk8nqklIANpDTYffNPnb+DzCN9KnxOZ+UZJUhcdGS6Pq5Iq53YWV8m5mln2M2r
         gCLAN7arL/38EzYddzpznh8MqBtUaGrgYNHkgrLvJbG2NU4TkJmy9iwpjHxSZeiPgUN8
         2yYAYAW0mGL8Q4tqyMBZqF1wGaJw+CJQu/+7peBzc6Tyr0TApgDvHDy9IO7726q7T2Mc
         UVTy70sI1BxPGImkFGTvficwHp0L39jQE8QGsLrcFF/EX7dp069/FiXweS4jxDumapce
         0gNg==
X-Forwarded-Encrypted: i=1; AJvYcCW6wijQQphqkkVF4O8bRsy2pOFXN0vSJV98bLa8X5IjZjGvkUKsoUFpA4kjXv8C7ZHZF5TzAmG8thDeLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1d2/ySStnS6n/gWUwbDNqCJEhqw937JgTNJN5E8CqInks+K1
	7T9Kr60g80wZsi0Da/mNG1diDxomPqC3WzD9hFJpi3O/GWBmBE0FnRcohQ4P5vpCnCpGVHeo2Yl
	Va1prFNTIsewovRUjg627zwK61HNqQlfioA==
X-Gm-Gg: ASbGncvbfbRq+KgNlvA093VBoJQKMa6HJf+t8dy6Ayo0vCiIITmMEQubzC7cE/HG93L
	YuawT6E9N2VoXHQF87wzCXsU4SrNfNgYYk7xeFC9RXg9pL8+AuNuuyiZDff+4xDxomhnH4a48fI
	cItPZ0yNmKhTRL1Hv9ipNoBLfpKhv44LqOqbV6Gdrn0mup7EY4ZK5u+O594RAL+ywr2J6E15TeA
	CS1sI0hOHg5jzx2Ag==
X-Google-Smtp-Source: AGHT+IEjb/cpRxnNznvLhgwwdDgD6c/u9Rha4wGbMJOrC6AMSAL5kq2zeCujO3NszkFne3uFjGv2UBLvLosbWbbEFpE=
X-Received: by 2002:a05:6a20:4324:b0:250:f80d:b32d with SMTP id
 adf61e73a8af0-250f80db875mr263272637.0.1757055583866; Thu, 04 Sep 2025
 23:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
 <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
In-Reply-To: <ac473f81-506a-4f7b-b182-a3a53db2f6c9@suse.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 5 Sep 2025 09:59:32 +0300
X-Gm-Features: Ac12FXyC4_3Izt42kgStwm1BoYBL4K-8lyhWFkV1YtBcukFQU7YflTEOx9KcFWU
Message-ID: <CAA91j0XXP4+2RACLuiO46VMG9nr=CgGjEpFtAJ1SA4thSQHJ8A@mail.gmail.com>
Subject: Re: Btrfs RAID 1 mounting as R/O
To: Qu Wenruo <wqu@suse.com>
Cc: jonas.timothy@proton.me, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:38=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
...
> > [Sep 5 02:22] BTRFS error (device sdb1): parent transid verify failed o=
n logical 54114557984768 mirror 2 wanted 1250553 found 1250557
> > [  +0.023579] BTRFS error (device sdb1): parent transid verify failed o=
n logical 54114557984768 mirror 1 wanted 1250553 found 1250557
>
> COW, the most critical part of btrfs metadata protection is broken.
> This is already permanent damage to your fs, thus every time extent tree
> operations touches that part, the fs will flips RO.
>
> The damage itself should haven been done in the past.
>
> And this looks like FLUSH command not properly handled.
>
> Considering you're running btrfs on a raw partition, either it's btrfs
> not doing metadata write correctly, or the disk itself is faking FLUSH
> handling.
>
>

...
> > Write cache is:   Enabled
>
> You may want to disable the write cache so that the firmware has less
> chance to cheat.
>
...
> >
> > SATA Phy Event Counters (GP Log 0x11)
> > ID      Size     Value  Description
> > 0x000a  2            7  Device-to-host register FISes sent due to a COM=
RESET
>
> /dev/sda has been reset several times by the controller.
>

Disk reset will likely flush any pending IO request in the disk cache
which may explain transid mismatch.


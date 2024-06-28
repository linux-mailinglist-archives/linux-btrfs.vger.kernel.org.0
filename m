Return-Path: <linux-btrfs+bounces-6027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57791B497
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE171C213E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD8F111AA;
	Fri, 28 Jun 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWgic5/H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C70191;
	Fri, 28 Jun 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537721; cv=none; b=QjVccQmE1v3hA89ndtXO9Nz3m8RYJk9eLiwV2suvJ2tHl+eIzxVA3MEMYZOoFiY023WrYZsnIu7GZ3QxiFO1lCkKR/dfKNPYyWtsTvx7nZkqW5oqiEdnyKu/1F1WT/Ju7xhciQ2Uf4j1arKMq8F6XdLNI9bq2bkzQH9MfBbPxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537721; c=relaxed/simple;
	bh=k5WgK1Um4NS0xQbGCZvshAg+9awOSpLz9xinrQPVb7M=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=aO1gmA4K5q5yGCQL1Av2ZTi95lfMc6zNQqVhhWVY2bgYBcR4EzQLEWmwTtHNwvxHJTPQN2OjSQXNWEi4aDSdd83owjUO8PQaR8L9HMmBfCcalsdQk7dmeTUIvqPReRsNro2ebu5FEFdf5IZLJPJwoM/Yt/cPSU+5BRb+EC3085E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWgic5/H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa2782a8ccso251145ad.2;
        Thu, 27 Jun 2024 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719537720; x=1720142520; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5WgK1Um4NS0xQbGCZvshAg+9awOSpLz9xinrQPVb7M=;
        b=cWgic5/HrN7crEUoRe70+DOaYWB42jAKMHCOjNvPnGZ51Xx9Yar7DwDWigyLoedrIM
         nKviyiYsMyJJyhmmmM/ww+8QC4hdy9GxTqtiDDWzBtM0mWNG/36ZopW41iDqIy6xwBtd
         2ZXEg//rDvaasX4LmbSa+DrI1RTflrK3/e3BJtyHnyKSiNCAhBRSlmZQeXbMgAJ3G7eU
         I+Y2n8RZIGPhvOmE9zw8wGVSCw8fMawJA/2ZkOmFOAvwmeo1TEHDjZqIDuAVhCDfo/bn
         sPnr6MJWlUMNT2fzysfR0ZZQiLfrnRTqtHWZx8M+NcZ1BmpZPQ7qiOzhlvCmv83ZmWeD
         d9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719537720; x=1720142520;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5WgK1Um4NS0xQbGCZvshAg+9awOSpLz9xinrQPVb7M=;
        b=wyLafvaWBACNbT8OcKAtktCBSV2Wxji9kW4mgqeQnnwZUEaTspVJCxuGBgdrgq3ZUz
         FMKkUOcI7qxKLxNe0neogvbWJnEkAbYC+jsxZLpI1SGNtR6z0PK4hRHK2/42qILfHeAP
         WDP8I3/vxHluVtcNUBO2WZ2VvOXjtQ4UYHl/tydbj6Js/zZiihIXQOvWOqgpPVL/Dmya
         9IYjOiborEPkmX6hX5O6h1+2m9dCNkbzZCZBideHeS1LeYJ+N/yARis1FdSDHLZmhvlt
         cL1ZaBboDICHggEMr8xbQFI6i+TDc50hha6EBp2RV4YKtJVrWQT1aRkF4FAIbqjvo9jt
         PGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhphP61c19GQ3scBQqmkvmX0W8Ji7OgR36bmyXhjESlqJg7mngFyAjUYw5Hs9exMoPPssdhM0xAtKv+dXalax6+OzOCI9NLyB4gO5C83T3sXh0dugrPAY6Lug5nxnd9chhRlcvjqoZ2TI=
X-Gm-Message-State: AOJu0YwNkK6mjQevIidyq9WLrhWH/+EgFUVxlZZUksYz6TeTBFDP1ks7
	+kRnnFsL4QJZpFi+BvyWtiIt1qEJ4s/fwvWrURl66aSPbFsaXo66
X-Google-Smtp-Source: AGHT+IF6NlNhpXndECX1Jmjy4LSq1bgMeAoRjenW68Afdto/xMcBppYmuIa5kisF6r3F/ok6YmlbhQ==
X-Received: by 2002:a17:903:41cd:b0:1fa:2083:51bc with SMTP id d9443c01a7336-1fa23ecb5aemr135419795ad.20.1719537719731;
        Thu, 27 Jun 2024 18:21:59 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a809:eceb:bd02:cb72:6ee8:4792])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2cc5sm4153255ad.80.2024.06.27.18.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 18:21:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] btrfs: qgroup: fix slab-out-of-bounds in btrfs_qgroup_inherit
Date: Fri, 28 Jun 2024 10:21:47 +0900
Message-Id: <3C7EC608-7AD1-441E-9781-9135F6C352F7@gmail.com>
References: <40fbcb1c-e35f-4310-a2d9-9932570cb245@gmx.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com, fdmanana@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
In-Reply-To: <40fbcb1c-e35f-4310-a2d9-9932570cb245@gmx.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: iPhone Mail (21F90)


> 2024. 6. 24. =EC=98=A4=ED=9B=84 3:41, Qu Wenruo <quwenruo.btrfs@gmx.com> =EC=
=9E=91=EC=84=B1:
> =EF=BB=BF
>=20
>> =E5=9C=A8 2024/6/24 15:59, Jeongjun Park =E5=86=99=E9=81=93:
>> While debugging, I also found that a problem
>> occurred in btrfs_qgroup_check_inherit().
>> While debugging, I also found that a problem
>> occurred in btrfs_qgroup_check_inherit().
>>=20
>> I think out-of-bounds can be prevented
>> more effectively if the inspection logic
>> containing btrfs_qgroup_enabled() is
>> moved a little lower.
>>=20
>> If possible, we will send you the v2 patch.
>> I think out-of-bounds can be prevented
>> more effectively if the inspection logic
>> containing btrfs_qgroup_enabled() is
>> moved a little lower.
>>=20
>> I will send you the v2 patch later after work.
>=20
> Mind to check my v2 patch?
>=20
> https://lore.kernel.org/linux-btrfs/47d3dd33f637b70f230fa31f98dbf9ff066b58=
bb.1719207446.git.wqu@suse.com/T/#u
>=20
> I believe this would be enough to prevent the bug from happening, with
> all the existing checks in-place.
>=20
> Thanks,
> Qu

Perfact Thanks.

Jeongjun Park=


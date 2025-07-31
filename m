Return-Path: <linux-btrfs+bounces-15783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271CB17313
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C56583F8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CE145FE8;
	Thu, 31 Jul 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX/1Jw4t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841412F24
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971552; cv=none; b=cVxMYflqCH0oBXYy1rVzM4R4MsFpvjJAmtHaWZB61dfKoK5Ex0DvgeKlYy7p1FgRyBvfohWd7vI6bx36EXHhgAcOHrPvA4hri9T6+POWxDv0UGMKkqtbhq3cU0uv9iRQOHBI+TPV7e4gDZBbqEVcqSl2BD7+CyPIwI5rP0IUAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971552; c=relaxed/simple;
	bh=kjvUdB4+2Jz7VDykLWDbv56UTx45rs5I4sgKd36erk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIAHKeutg8+/Du7bjjTDtChPkxrUSxCN5tV1IV9HOoyuwuhmKOUHbcO27Aw+AL5iVxZXA2GqByoYJXj9WpsClmLreoPfgzLCpgOdOKCiTsW6Wu9RakOhtUedHUMoKxA2dIoKmBedOeijpDIshWiCbeTevrXFZUgIQp2CnvA3t8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX/1Jw4t; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso140772a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753971551; x=1754576351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M15JgzKmsCIBnKU2AHQLmeYMDSZ7RZajm1iNuy8yu4s=;
        b=LX/1Jw4tdzqo5iUQjtPX5IR9fAgEaxxMkYzY6lEeaBSISbg/Z5yNtaiWTirot4IOe2
         QS7DwxI+dmM3jbfb8+vBdnFsGE0DEK57qKs2esIh36ZOMTZddyBncNmlfkP2WecdF9OF
         J6KOF1MoUK8VtDMxuDfYIvnoLXNx99W8cIPUQWv+hEqKaXjVye2GSWiFvymi6EJZPsJh
         LBp5o1H71ARu5HvkwkkJ7fTFUGIPj5bgkPAw+TfWlAH4tkpfhZFvs8m5EGT2FRc4UzH1
         7TQ+FbiPSggQJebpZ1BOJHfWYhc6LDwYgPs9w+Z5MzmWhrYnw7a1Q36EjxjGqiHPAoLZ
         vP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971551; x=1754576351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M15JgzKmsCIBnKU2AHQLmeYMDSZ7RZajm1iNuy8yu4s=;
        b=EowwSwmfnuKtkqWkbycSr9v/LaNQc14pe03Tw6LNrmQBqFdb1FOdL0ANSvmxwoi7RD
         kQx+cPr8iSllZ1AEd67KmlRan/SvvtePZ+jZgCp2t0hIB4gxIDDqD2xSWjJ+yQADkgjK
         bgLYWue9rJYNpNxFt6jyQWII+Xv80YhhlV97NdHpnQmJQ8qyrLeIx2ZnPjOTOo7gK/eq
         09eKtzgjwSxBkDOpaosHpfUplPdW0yz8PoLa14YJQ59IVkhuCuFannWupRbNh8NPCggA
         YpoyLAe9kns9a3TUM6fAca2tQiRdZI/Yka9e7ic9Es7wDyC18Ih4fuMcGR4INmx0Fmno
         QDTg==
X-Gm-Message-State: AOJu0Yzs2feZJTUjgm533cF7nAws24EofDUGFPmwhVgZwsQuThEGJT6O
	2VEODySMCTPSs1w693IfYrCJ+snMxUU3ZNefCt9a0yIG3LKVS7k89FLD
X-Gm-Gg: ASbGncvY+r6kHAMYHB2tgtYXLivc7W5wqqEEu5WASfes3ivnF7vBnZOQ1/tBn+iVrxA
	WBUXp4+6jTbOzVgZLX32IUWEe0r1wj1YHZjfhGu8n1tfquBeCtpPVTkVS4Cae9k/fY07eUVulf0
	zlvoSWy7hS+hFzauqt9PgGzXf53PVlKwqyV3vB3LnL5YvBs10JdIjo0YKJFmB63O5sA99o3vZL1
	3F0xYYVIJKn2o5wi4PJxugMqsZ3oA2sfhFjgfKM15nbaf3C0i8LHwFUY7ViRqWE1AraibEo1hMs
	camkwnQy43sYYknAJm97Z2+lmuyID0WBf+hdXFERzzLBaC/5SLDuNApN0T5+q/YYTvoJhIFkRib
	gRMtWhcJcCV9aAe0lHN4J25jOy7jBQT3IrMbIUo72WxjvQgl384nw094=
X-Google-Smtp-Source: AGHT+IElxYs7s8JQzNKxl5xs/mqGsTI0gkXePs/b0hEU5Pp98jB7K4U+KVN6/HI0PKLy/5dV9fO50A==
X-Received: by 2002:a17:90b:1a8a:b0:31e:a421:4de1 with SMTP id 98e67ed59e1d1-31f5de6b9bdmr4665232a91.5.1753971550665;
        Thu, 31 Jul 2025 07:19:10 -0700 (PDT)
Received: from saltykitkat.localnet ([152.69.226.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32063358cb4sm2168743a91.0.2025.07.31.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:19:09 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH] btrfs: replace manual next item search with
 btrfs_get_next_valid_item()
Date: Thu, 31 Jul 2025 22:19:03 +0800
Message-ID: <2231888.irdbgypaU6@saltykitkat>
In-Reply-To: <fd555c60-a492-44b2-a47d-b17f239e3a2c@suse.com>
References:
 <20250730145327.22373-1-sunk67188@gmail.com>
 <fd555c60-a492-44b2-a47d-b17f239e3a2c@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> =E5=9C=A8 2025/7/31 00:23, Sun YangKai =E5=86=99=E9=81=93:
> > The function btrfs_get_next_valid_item() was introduced in
> > commit 62142be363ae9("btrfs: introduce btrfs_for_each_slot iterator
> > macro")
> > and has never been used in other places other than
> > the btrfs_for_each_slot macro.
>=20
> That's because the function name is not that straight-forward.
>=20
> The name btrfs_get_"next"_valid_item() implies it would move to the next
> slot, but it's not the case.
>=20
> Thus this can lead to quite some confusion and we're not that excited to
> use it.

Great point, and I also find the name is kind of confusing. Maybe we can ha=
ve a=20
better name like btrfs_ensure_valid_item() or something similar.

> One example inlined below:
>=20
> [...]
>=20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index fa7a929a0461..70e73cbf6b16 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1723,18 +1723,13 @@ static int find_free_dev_extent(struct
> > btrfs_device *device, u64 num_bytes,>=20
> >   		goto out;
> >   =09
> >   	while (search_start < search_end) {
> >=20
> > +		ret =3D btrfs_get_next_valid_item(root, &key, path);
> > +		if (ret < 0)
> > +			goto out;
> > +		if (ret > 0)
> > +			break;
>=20
> Here just by the name, it looks like it will move to the next slot thus
> can be problematic (as it will skip the current slot).
>=20
> But it's not the case, as if the current slot is not beyond the current
> leaf, we just return with the current item key stored into @key.
>=20
>=20
> Another thing is, we may not need to bother the @key, or the caller will
> manually check the item key anyway. Compared to the confusing name, this
> is just a minor problem though.
>=20
> But still it modifies the @key, which may or may not be what we want.

If I recall correctly, there's only one case that we don't want to bother w=
ith=20
the @key in this patch, and I'll discard that change in the future versions=
 =20
if necessary. In all other cases,  we just read the key according to the pa=
th,=20
which is part of the pattern I want to replace with this helper.

> That's why we are not excited to use the new helper.
>=20
> Thanks,
> Qu
>=20
> >   		l =3D path->nodes[0];
> >   		slot =3D path->slots[0];
> >=20
> > -		if (slot >=3D btrfs_header_nritems(l)) {
> > -			ret =3D btrfs_next_leaf(root, path);
> > -			if (ret =3D=3D 0)
> > -				continue;
> > -			if (ret < 0)
> > -				goto out;
> > -
> > -			break;
> > -		}
> > -		btrfs_item_key_to_cpu(l, &key, slot);
> >=20
> >   		if (key.objectid < device->devid)
> >   	=09
> >   			goto next;
> >=20

Thanks,
YangKai




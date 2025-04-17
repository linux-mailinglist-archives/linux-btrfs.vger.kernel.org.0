Return-Path: <linux-btrfs+bounces-13143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B66A91FD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB29119E3D97
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CFD251786;
	Thu, 17 Apr 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rev5po77"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548D199EB2;
	Thu, 17 Apr 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900616; cv=none; b=qqK4xS+BBV/dpEURgkKhQVUrQclCBdUM2bLDImwdy/Rp7KifoBGEjh1bWVSiGRlQunPJrNjbcPJUfKDa2mfKmcQHtUANglKJDmJlJDcdrRr++BucaFl8VfSMzRRCtYSC3jEsojmPj31OtNmrVTkF6hLZrqCtmmjcDdbCDGt/zuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900616; c=relaxed/simple;
	bh=ChbnK3WT4TGSwcQFlZkIsls2YByZZiYcWQDsvQTKTVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD+CUCPnhbznIEyqxKVSBAPk1kqoNEUXCpeKzaXGtWzGuOMkfZQff7Zzz/WeV9IkgwicaXwq2xWAs1y532vNkLmJzZbT95hSHw+7Ivqdwn58waNMs9p1c4EzY7oPOMrNXrDsELdMhxnuwzs58dPdeedW5XzaeyiddsG9k+PuwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rev5po77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63665C4CEEA;
	Thu, 17 Apr 2025 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900615;
	bh=ChbnK3WT4TGSwcQFlZkIsls2YByZZiYcWQDsvQTKTVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rev5po77Ie4Itl+gL7azAYhNem7XNqklvtNV8VPQq2DdJjCSKuFSoyMM2YsaxONj7
	 IBqPczIiAISPi1UI0U95D8t7acCg98c19hMK5GtgiaL0gSJB8ReLEiB5tuB9CP0Mfz
	 NIqft1Vn+Ci9ZE/oLDr6758yTMeCkpj8uBwy3d1xOrP/M0/dqP/9KEC3bd19ZXepqg
	 OGsbj0Tqhewf1liyjXXiDlRNaxZYBv28PbBvkaqIvKTGs6+ozedD16HJQdMDVQQS5/
	 TQn3Ol4Z/Hy2kYsqYof0iIBiHOi8mW0vBtX6Q+aEn2Ol1HG6xHgxJ3PHTF40akVSLj
	 J2R1IIZn8h/7Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso171686166b.0;
        Thu, 17 Apr 2025 07:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3Y2Dh8njIu2cFykVexf/QEY6048Tzrl9FKjidS1lMr/DcsJi70pLlv/r9kY/sWkWuCmQC4KHdbqRQ3YhH@vger.kernel.org, AJvYcCWFNnvf1hPQRqzC5kcRAi8onk6k36IyYn+Rug6+F/kz1pRKUhjWTvVNtQjKg1KRBjuoRNrDHcdAfH4AYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaE2PrW+0j+e+48q0twFN1vce/Qy3FZ1KPlXtddOwm25b9sWze
	Ri0WWNIIlxn3a0JHQMHuk8aY6SrYBvdUwPfregvlGtz9QPB5dfLp8wpDlQAHicYllid3CYgiseH
	E6VNyy2AY7eImoPYv+7L58k/rhf8=
X-Google-Smtp-Source: AGHT+IFnzmheV7SDUriinOYFXLSaAJqlo+Hqhsh9hQkPavCKZe2xYfRnNRKTFaN2e6IgCwhMZ2jptXE8IHhdwok6txs=
X-Received: by 2002:a17:906:26d8:b0:acb:5070:dd19 with SMTP id
 a640c23a62f3a-acb5070de08mr294485566b.61.1744900613988; Thu, 17 Apr 2025
 07:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415033854.848776-1-frank.li@vivo.com> <3353953.aeNJFYEL58@saltykitkat>
 <20250415155637.GG16750@suse.cz> <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
 <20250416191111.GC13877@suse.cz> <CAL3q7H4_vNoKokn213rY2Q0MNkDLWSk7XRBqJLxfiw1ikRGM7Q@mail.gmail.com>
 <SEZPR06MB5269D8348566FC049107053FE8BC2@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB5269D8348566FC049107053FE8BC2@SEZPR06MB5269.apcprd06.prod.outlook.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 17 Apr 2025 15:36:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H54GbT5+bnN87U6i2EUOiYUpQt5m98fxPEPC=N+ALOUCw@mail.gmail.com>
X-Gm-Features: ATxdqUFD_W9tJconbeHbk_JMG3TdzYBXCPRjyaPAQR-HlM9Qm-Lj5x3K74yWX4c
Message-ID: <CAL3q7H54GbT5+bnN87U6i2EUOiYUpQt5m98fxPEPC=N+ALOUCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: get rid of path allocation in btrfs_del_inode_extref()
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>, 
	"dsterba@suse.com" <dsterba@suse.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "neelx@suse.com" <neelx@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:15=E2=80=AFPM =E6=9D=8E=E6=89=AC=E9=9F=AC <frank.=
li@vivo.com> wrote:
>
> > Honestly I don't like adding yet another function to do such "reset" th=
ing.
> >
> > Leaving path->skip_release_on_error is perfectly fine in this scenario.
> > If that bothers anyone so much, just set path->skip_release_on_error to=
 0 after calling btrfs_release_path() and before passing the path to btrfs_=
insert_inode_extref().
> >
> > This is the sort of optimization that is not worth spending this much t=
ime and adding new APIs - freeing and allocating a path shortly after is al=
most always fast as we're using a slab, plus this is a rarely hit use case =
- having to use extrefs, meaning we have a very large number of inode refs.
>
> I am fine to add btrfs_reset_path or just clear path->skip_release_on_err=
or.

For god's sake, just keep it simple - either do nothing or set
path->skip_release_on_error to 0.

>
> David, what do you think?
>
> Thx,
> Yangtao


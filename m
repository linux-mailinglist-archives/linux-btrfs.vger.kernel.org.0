Return-Path: <linux-btrfs+bounces-15850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D23B1B23D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16E2189C994
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1B23F40C;
	Tue,  5 Aug 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph2+R6dU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AB1E832A;
	Tue,  5 Aug 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390883; cv=none; b=B4M11fnpJFcF65OpzX6BTA0padeZRIy6BZ1EscejsSmioFpb5PFBtDd0ZKtF8nywAU1b0bJO7YRUYLUiH6ylIDE1r98UbNENemCgEqzEzh2F9b96eFKKSeAbChmBd/KfVHTeJIRVUtwKqsh2pUt8QmH1FHWa6zX197dBS24tAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390883; c=relaxed/simple;
	bh=VvLzssUwnJ0LojnML2MIFfOIQR72ocw0T6nX950f9Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NACQWVMcHaI+H2cppFt8mtCLiNliDp0hWogz4Nl4dEskF4Rz+7zMnD8XQpeJUzq/KjmfRgtfaRnpNoNDXxaxxYuJGMztMS9LkpfL5c0dmkJiTFKMgNMXc0pSwlsPLs5xPxv4RpNXIc8TeDAidaeTAXV5FqzsVwTzDZgWModAfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph2+R6dU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395B5C4AF09;
	Tue,  5 Aug 2025 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754390883;
	bh=VvLzssUwnJ0LojnML2MIFfOIQR72ocw0T6nX950f9Do=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ph2+R6dUFOAF7VAl7MvgT7CLW4mQqELwp3T8yXDofo9EXatdo4cV0zggGhk7C1rx5
	 7qaAswMAeNjMWY44p2r9Gy8+4BE/qSLyC+P3pG1gMX+17EAvUx7+Q5i1tJ300NZz/v
	 ME585opfPZeFUhKZoeXaT0WT9CAgRqQ7cXl0WMRCtGuPuhRC9aoIdTAUS7HZZF0fhM
	 0r5llaEBAQTNDZQrtIvi9xd65n4nnv2nNytoLveV3MMVPDTrYbIcPuC93/Xgw46III
	 GEXytm5KLdITFuO73zzJVszPcGcf/+LyGwZFI+/KS3lc6Qvm9jxww1C1znz2OzUmyD
	 BDCKkGIVnaStg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so9871494a12.1;
        Tue, 05 Aug 2025 03:48:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWpMIK+SXpqj23GbnY5uMTzpxNmeZPmSZND2iZOchZSz4Oqcnx894O5QrsCm1CW2RzRbrtWUZR@vger.kernel.org, AJvYcCV65QnNcOC8ktzbp8x5hm3zMycI5g2o+nenxm74mRZ3gXZnbTlSZFzePyPlcZZgMWnVlYeu0Qteo/kr6Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHakdQDW3IeWoRBl1a47tK1IvNUKG5SjIVql4QFKLVhpELaWy
	8kCmgFy07SJSLI4lRk5GIVhCXwnhVtqbJXnFqRTU/GOY3XbyhjtVPdH7vy71oIvYLbMGOv504VT
	dcIBjyO9n9R959J5KbziF9eoIaKU1ZS4=
X-Google-Smtp-Source: AGHT+IFpDykoIsE4AG0J8j+W2Gl7yVvAN2U5Qe/A4RvNNDVzjdcMtBoLrfT39WtPS0SSipqudcAOqMcXtHAKZ/oltTA=
X-Received: by 2002:a17:907:3fa5:b0:ae2:3544:8121 with SMTP id
 a640c23a62f3a-af97d2a1360mr312475766b.9.1754390881786; Tue, 05 Aug 2025
 03:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com> <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
In-Reply-To: <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Aug 2025 11:47:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6BoyZYkacZvMas8jCtrXykoj0G7s8rxaXjL2x6Z9OkGw@mail.gmail.com>
X-Gm-Features: Ac12FXy_dHkEbRbXM6fZkkedNz1IFSJIWkbHOeGZsrYAKPy7mkTBwsP_oCmLcLo
Message-ID: <CAL3q7H6BoyZYkacZvMas8jCtrXykoj0G7s8rxaXjL2x6Z9OkGw@mail.gmail.com>
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org, 
	zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:41=E2=80=AFAM Ojaswin Mujoo <ojaswin@linux.ibm.co=
m> wrote:
>
> On Mon, Aug 04, 2025 at 01:28:24PM +0930, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> > > For large blocksizes like 64k on powerpc with 64k pagesize
> > > it failed simply because this test was written with 4k
> > > block size in mind.
> > > The first few lines of the error logs are as follows:
> > >
> > >       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> > >
> > >       File snap1/foo fiemap results in the original filesystem:
> > >      -0: [0..7]: data
> > >      +0: [0..127]: data
> > >
> > >       File snap1/bar fiemap results in the original filesystem:
> > >      ...
> > >
> > > Fix this by making the test choose offsets based on
> > > the blocksize.
> >
> > I'm wondering, why not just use a fixed 64K block size?
>
> Hi Qu,
>
> It will definitely be simpler to just use 64k io size but I feel it
> might be better to not hard code it for future proofing the tests. I
> know right now we don't have bs > ps in btrfs but maybe we get it in the
> future and we might start seeing funky block sizes > 64k.
>
> Same goes for not hardcoding block mappings in the golden output.

Please keep it simple and use fixed 64K aligned sizes and offsets.
It's very unlikely we will support sector sizes larger than 64K, so
keeping fixed sizes is a lot simpler to understand, maintain and debug
tests.

Thanks.

>
> Regards,
> ojaswin
>


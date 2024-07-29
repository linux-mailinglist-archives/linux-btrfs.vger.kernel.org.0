Return-Path: <linux-btrfs+bounces-6846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E660593FC82
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B22B22175
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E117107D;
	Mon, 29 Jul 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW67B+bU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB501607A1;
	Mon, 29 Jul 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274586; cv=none; b=DbKoY8mCkQMiLGRzzKMsnPxdjKJbkfUAJBAKtmNC3yaWlUyKoJeoKHRePgiSUYLP8WYhaJch5NnWmIzgNtLE+R+h8W64lFHGEyORCHgeP9o/hq+Yjp0JF0LngzdQWUlotP5mpKOec5i5ALBqOGtTF82qCL0gsxxenL+qiQiSEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274586; c=relaxed/simple;
	bh=5xT9tAqmcRvLr0qI0qUW3G90s26LY+lgMsedQWGAjVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7vw7OeH5Ay/MTU7s+6itDTUfco/VedcWF6N6+kc/5TRptjzwjWqfR4AC82ACBl34BMol8v09akiQF+zD3s6Ew8MsUzf9Hs00keOEUANQpbg2Zp+qIm5zEFZkJJeTDrMM3KRmAoaIN7e37zHbBVH5+f/RyfnxTmkUqbaiPxwksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW67B+bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50A8C4AF10;
	Mon, 29 Jul 2024 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722274585;
	bh=5xT9tAqmcRvLr0qI0qUW3G90s26LY+lgMsedQWGAjVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TW67B+bU2XlTx7i1JGDz+/eyR7TpukddAA4r6xfvWnekfHmpKtGqwVMkVwXXpQo8N
	 iAUxW2mBIeUPn4FwaQx3XvVlHKN0AORAmowUBdoAew0kPVY6M7cl2hFEndSjuv5ft7
	 aj7ZMVU+bdKqY7mmcDxj1OH7vCB/CJsb55809pUNY5/pCeU7cIxY/xySO4FUoNDMY1
	 qFhVtVlKMG8oskNxgzZKPWPxww3O+0hEWJVZCCdPM5pEChsSMCpdbtzyftAVKBlceX
	 g/dhskXebSAAPRR8jxShthRIO7Nfd50P35A70wqlcyUW3kXHjjw542d25g4BTf+Vob
	 1MxoExbcBAopg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4777641a12.0;
        Mon, 29 Jul 2024 10:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzdq3vit4RrcEZKg/sTgyieZRMUnsO3nJ0wdh3FdZcYlC4HssXh+NmPiTdTVFfr0BObZqJr95vUdOxguxH1vuWBa+NEsW4VNATM35A7rJGvBA+z7epp3OEAed7FiInNAk7HtUL
X-Gm-Message-State: AOJu0Yz86nGCwYrMM1sps5GLUT3tVAZLNKz5JDU7jk5MEzf9Amc1lB9A
	PzbySGkWPwlUnxEkDfx7UhAdlGNEQxYUOyYQcSOJOMpm6qK4lHWZnFBv5uw/Syy7FQye26V/3ND
	WKDGtKm5Hyrws0D4UFPl/ZydtszE=
X-Google-Smtp-Source: AGHT+IFkd0cxvi4mhifoRErMl4CexeZm1lQ5tfDvBz302Qa6/ALonrwbpKU1DbsgWs2YPWPJttFBURgdDyKFAY2xLiQ=
X-Received: by 2002:a17:907:7244:b0:a7a:b839:8583 with SMTP id
 a640c23a62f3a-a7d4013de15mr626022366b.66.1722274584238; Mon, 29 Jul 2024
 10:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com> <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
 <418B7A4D-30D7-44B4-B3F3-5BE97C04BACE@oracle.com>
In-Reply-To: <418B7A4D-30D7-44B4-B3F3-5BE97C04BACE@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jul 2024 18:35:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5px9sFpZFbp2bn8PytJq8yMFdzm_WEi+nQwWgUy0ghJA@mail.gmail.com>
Message-ID: <CAL3q7H5px9sFpZFbp2bn8PytJq8yMFdzm_WEi+nQwWgUy0ghJA@mail.gmail.com>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: yangerkun <yangerkun@huawei.com>, Christoph Hellwig <hch@infradead.org>, 
	"zlang@kernel.org" <zlang@kernel.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hughd@google.com" <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:30=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jul 29, 2024, at 9:53=E2=80=AFAM, yangerkun <yangerkun@huawei.com> w=
rote:
> >
> > Hi,
> >
> > =E5=9C=A8 2024/7/24 21:30, yangerkun =E5=86=99=E9=81=93:
> >> Hi, All,
> >> Sorry for the delay relay(something happened, and cannot use pc
> >> before...).
> >> =E5=9C=A8 2024/7/21 1:26, Filipe Manana =E5=86=99=E9=81=93:
> >>> On Sat, Jul 20, 2024 at 9:38=E2=80=AFAM Yang Erkun <yangerkun@huawei.=
com> wrote:
> >>>>
> >>>> We use offset_readdir for tmpfs, and every we call rename, the offse=
t
> >>>> for the parent dir will increase by 1. So for tmpfs we will always
> >>>> fail since the infinite readdir.
> >>>
> >>> Having an infinite readdir sounds like a bug, or at least an
> >>> inconvenience and surprising for users.
> >>> We had that problem in btrfs which affected users/applications, see:
> >>>
> >>> https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778=
c35@landley.net/
> >>>
> >>> which was surprising for them since every other filesystem they
> >>> used/tested didn't have that problem.
> >>> Why not fix tmpfs?
> >> Thanks for all your advise, I will give a detail analysis first(maybe
> >> until last week I can do it), and after we give a conclusion about doe=
s
> >> this behavior a bug or something expected to occur, I will choose the
> >> next step!
> >
> > The case generic/736 do something like below:
> >
> > 1. create 5000 files(1 2 3 ...) under one dir(testdir)
> > 2. call readdir(man 3 readdir) once, and get entry
> > 3. rename(entry, "TEMPFILE"), then rename("TMPFILE", entry)
> > 4. loop 2~3, until readdir return nothing of we loop too many times(150=
00)
> >
> > For tmpfs before a2e459555c5f("shmem: stable directory offsets"), every=
 rename called, the new dentry will insert to d_subdirs *head* of parent de=
ntry, and dcache_readdir won't reenter this dentry if we have already enter=
 the dentry, so in step 4 we will break the test since readdir return nothi=
ng  (I have try to change __d_move the insert to the "tail" of d_sub_dirs, =
problem can still happend).
> >
> > But after commit a2e459555c5f("shmem: stable directory offsets"), simpl=
e_offset_rename will just add the new dentry to the maple tree of &SHMEM_I(=
inode)->dir_offsets->mt with the key always inc by 1(since simple_offset_ad=
d we will find free entry start with octx->newx_offset, so the entry freed =
in simple_offset_remove won't be found). And the same case upper will be br=
eak since we loop too many times(we can fall into infinite readdir without =
this break).
> >
> > I prefer this is really a bug, and for the way to fix it, I think we ca=
n just use the same logic what 9b378f6ad48cf("btrfs: fix infinite directory=
 reads") has did, introduce a last_index when we open the dir, and then rea=
ddir will not return the entry which index greater than the last index.
> >
> > Looking forward to your comments!
>
> Is this the same bug as https://bugzilla.kernel.org/show_bug.cgi?id=3D219=
094 ?

Yes, my last comment there explicitly points to this thread.

>
>
> > Thanks,
> > Erkun.
> >
> >
> >
> >> Thanks again for all your advise!
> >>>
> >>> Thanks.
> >>>
> >>>>
> >>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> >>>> ---
> >>>>   tests/generic/736 | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tests/generic/736 b/tests/generic/736
> >>>> index d2432a82..9fafa8df 100755
> >>>> --- a/tests/generic/736
> >>>> +++ b/tests/generic/736
> >>>> @@ -18,7 +18,7 @@ _cleanup()
> >>>>          rm -fr $target_dir
> >>>>   }
> >>>>
> >>>> -_supported_fs generic
> >>>> +_supported_fs generic ^tmpfs
> >>>>   _require_test
> >>>>   _require_test_program readdir-while-renames
> >>>>
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>>
>
> --
> Chuck Lever
>
>


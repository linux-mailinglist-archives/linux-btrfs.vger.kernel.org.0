Return-Path: <linux-btrfs+bounces-1167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD3C81FF87
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 14:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1711F229FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2169111B8;
	Fri, 29 Dec 2023 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSveBtS+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD4111A1;
	Fri, 29 Dec 2023 13:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A35C433C9;
	Fri, 29 Dec 2023 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703854822;
	bh=xbcjHyBgFl0Uu19d0nBtST12wEzqBZU16iWMiZz9CHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JSveBtS+F5RrV+cYEc4ywkFWqRdb3jqQyJlNYBGd7zPvfgXoDjSQ4W5IIyUEdXlPJ
	 psw4ESWd9nUnFz7gwz61MdCLcNa6kBmQSCMmwu4VqBdoF9uIgCmRBdod1ew+bbln4s
	 VMjbKlpFm2ULSg66slCX9+mL4ASNJR/feKjAk4D7mqO+eQafO3jI4tchHoX2IiSA2f
	 ly/Qp74gDGjQ3+RAy4CBErXDzzaksHaX+uhoMQwJ4rtoL4EkFvM3pmnO5nrhCF8vZh
	 dTBG1cdxNhXGpStVZHPppUPeQOyawHxcsOXlwAb7J1AL37XOcC/66K0PBkHBt7I5BF
	 bvpH05jZbPrjg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a271a28aeb4so302135566b.2;
        Fri, 29 Dec 2023 05:00:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxGhy2V49Ym1dyRb2w/5TEfIKXCpq2mERlzm7hTbZI4/JyCWvYS
	Bw/Gzoq/L0s5v+mrqrcGb/5YI6AbqKNO0swf+hM=
X-Google-Smtp-Source: AGHT+IGcgQX7+WUrot6sgsjDlFeKL8E8OCG0eU8GMFNteYHncAAj6YYBVXvQnsoHCyA6JTNrJDLNWVvwiffSxBLa/RU=
X-Received: by 2002:a17:907:2cf3:b0:a27:53fe:a6e8 with SMTP id
 hz19-20020a1709072cf300b00a2753fea6e8mr1842247ejc.127.1703854821082; Fri, 29
 Dec 2023 05:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>
 <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 29 Dec 2023 12:59:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>
Message-ID: <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/303: add git commit ID to _fixed_by_kernel_commit
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 4:41=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Dec 06, 2023 at 10:24:44AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The kernel patch for this test was merged into 6.7-rc4, so replace the
> > "xxxxxxxxxxxx" stub with the commit id.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>

What happened to this patch? It was not merged in the last 2 for-next
branch updates.

Thanks.

>
> >  tests/btrfs/303 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > index b9d6c61d..521d49d0 100755
> > --- a/tests/btrfs/303
> > +++ b/tests/btrfs/303
> > @@ -15,7 +15,7 @@ _begin_fstest auto quick snapshot subvol qgroup
> >  _supported_fs btrfs
> >  _require_scratch
> >
> > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +_fixed_by_kernel_commit 8049ba5d0a28 \
> >       "btrfs: do not abort transaction if there is already an existing =
qgroup"
> >
> >  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > --
> > 2.40.1
> >
> >
>


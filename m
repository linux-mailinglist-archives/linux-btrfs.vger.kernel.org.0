Return-Path: <linux-btrfs+bounces-3369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E496287F10A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8251A1F24077
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF35733D;
	Mon, 18 Mar 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvnd/xpk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2D2E3F2
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710793047; cv=none; b=BZqvnc75HsZZ2AiseO5qoXaDXBNaNVSvERidbxVfXolxNxHQ7SeSwIoYPvKcyF0SOVak1XFsWMsfN1BWL7fH3cxN5+QCude/59JorAnv0yWy7RMqbsH11ccZtwsGFBrxsQHK1ypt862UhH/KuxCLQDdh66Hh9g93M6jnovSzL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710793047; c=relaxed/simple;
	bh=66pEMw52ttM9j9Pv2/l+jGZnAdStB7Au29jbo2p3ZJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lim24Xx03XKZF0I7bUmpdtl5xEF3zw7TL1S5wolBy0tp9wvAhzCul6/9ZdK7jENdiisVGYUQT6MfrDL7EHf9TK8P61nDszM8EiKpmcl3Nwj7U2jy7B/XpU6TiLCLCMY5rtMdY6X5QjSdHQHPsagLSrHCuC5H3cnbzEYRtiFZJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvnd/xpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA47AC433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 20:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710793046;
	bh=66pEMw52ttM9j9Pv2/l+jGZnAdStB7Au29jbo2p3ZJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hvnd/xpkq7azWwoOXGFLinrIz7vZkuFc+cvhk+sOGZPrtkHdTF8iK2k0sYoipn6CP
	 1zEPniOpCX826Kyy79EKgV8zH4iDkVGlbFKZo8doA1RGCxiGkWEQQqbO8yplEZxVsd
	 POhUpEp7UWyZ1H+vf6gr+0HNWRbQuwtZakJd0bNlF1Io7vuLW9ZAA/77LrDsYR12nI
	 C6nOKSApfrc6fkN6Csmi1js9sRY7jitADHvx7X9iUMBwcMlervDGrHiTVuqCTEUS4D
	 m2lfHGbtCi+xLC04+xDOCl3Scde8SH+bxJtvqz7Za9YSoeaSgl3K3I4o0sbH0XW+O+
	 IOCbuiHO5vgTQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso466967366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 13:17:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVAgGvauegIg5XuHLKc10TxnkH+WWz+3D5mF/TkdUOM9UIM9+A
	AtOrJnZ+pczjaEgXT4OhksqiPrsthLjiBO/1PEdsEOpjKkT5ZR8xRisORMHu02a3CzYhvu3Cu53
	zjtR+bnjgiqvNfYP/fkWss2mpaRI=
X-Google-Smtp-Source: AGHT+IFetfutNYrg9eJhzJZX6301+z0uDK9E6EoKGIeu4CqWfRLDDCM/qETanOAzBq0lXaOND2wvM/H591EJvNLbmrY=
X-Received: by 2002:a17:906:7198:b0:a46:2b4d:e3f8 with SMTP id
 h24-20020a170906719800b00a462b4de3f8mr8354166ejk.19.1710793045557; Mon, 18
 Mar 2024 13:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710763611.git.fdmanana@suse.com> <5a8d9a84-8eaa-4c6f-aba5-209a94c7b02b@gmx.com>
In-Reply-To: <5a8d9a84-8eaa-4c6f-aba5-209a94c7b02b@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 18 Mar 2024 20:16:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6rAMf8B27wVnCE51yyf+ipaQj+UG-X-Lg29pVHwnwJqg@mail.gmail.com>
Message-ID: <CAL3q7H6rAMf8B27wVnCE51yyf+ipaQj+UG-X-Lg29pVHwnwJqg@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/18 22:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Trivial stuff, details in the change logs.
>
> I guess it's just exposed by some random code reading?

Yes, by reading.

>
> No automatic tools to expose such single line wrapper?

Not that I know of. Maybe some coccinelle script could do it, dunno.

>
> >
> > Filipe Manana (2):
> >    btrfs: remove pointless readahead callback wrapper
> >    btrfs: remove pointless writepages callback wrapper
>
> Anyway looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
> >
> >   fs/btrfs/extent_io.c |  5 ++---
> >   fs/btrfs/extent_io.h |  5 ++---
> >   fs/btrfs/inode.c     | 11 -----------
> >   3 files changed, 4 insertions(+), 17 deletions(-)
> >


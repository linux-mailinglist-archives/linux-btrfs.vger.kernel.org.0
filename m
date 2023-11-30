Return-Path: <linux-btrfs+bounces-452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB77FEEC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB832820CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B078B4644E;
	Thu, 30 Nov 2023 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CElVPEvA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BC9A
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 04:20:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bbfad8758so1186004e87.3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701346800; x=1701951600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7mjrVNsEaLNwOvVK2FD2j2SAWjTzyJkz2BgJ8NxeYA=;
        b=CElVPEvACow32SCCC0mNzlP5CDLqesOjPL3fF0jcyaBipg6P4o23yoREr8gco9Qf1G
         abSRyTXt361cVxSIJFewc6+GBOAqDvEJA3Qm+DYypAmFTzPTbquk/+n82QRsIc9DyGgB
         gDbQGfiZDl4d+jJdvoAe9U+bT//PnEsmOQs+vwSPMS6KVT0GTy6skDk8LP1Rpm98CqFi
         5O4kELyo1oZ4EHarf4wrgOD16jqSKk4KP5AnNhJxndoU1vdpZTQ/OFgWBXdhskZegHR8
         dyCeleIYDX5CTReieQekgBvHu/8CVQzrmH6scZS1DaRlCKEY/f63II9x5790vZAzmmdN
         Jjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346800; x=1701951600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7mjrVNsEaLNwOvVK2FD2j2SAWjTzyJkz2BgJ8NxeYA=;
        b=pbS6aaKy6d/C5/ezQSRI6OuWjBNeKUrMachS/6/+HY2Bzb72/zuEsw2olAbieAko3N
         bVzmU8AbnnWPUH3lUbLcrd8IqCRqNgfzedaUh9BOpcuvWmLpa1IGncwj2QTEqjf144is
         7FvFPNkpHVO5qsiHFtDc/VvFko9f3aeIixIePC9IFyutH3eravreFIuh9pBWj9T3F4c0
         YWCFUuBSYtLGR7sMaKTF0Ifjl2g63fS7H7zw4Fs3RSDz4udSgy5Q21fFRPPXB3U9p8vz
         mw5Qrnv5eXxkp2WSFu2WFnnBT2fsWGqpVlypjd3wdS4sMc5tK1zWr9tOeMFNREVISCDR
         ttsQ==
X-Gm-Message-State: AOJu0YzWzxRNlOrF/i0dkarMLpk9jt1FYvPgBth416TDaRt8R14JgmP6
	SA/qkO8BuY6GHY1PYsHPZahb8DFPziL8LeVByHU=
X-Google-Smtp-Source: AGHT+IFIsxynxyoQO42ZSOJIf+uX0nz95adJI1nHIwI6euD02dxx3exCnc7BpFSItnkPZ39o+RwdItdALCXTA4r9Ghg=
X-Received: by 2002:ac2:495b:0:b0:50b:c13f:744f with SMTP id
 o27-20020ac2495b000000b0050bc13f744fmr4486639lfi.59.1701346799345; Thu, 30
 Nov 2023 04:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231127163236.GF2366036@perftesting> <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
 <20231129160217.GT18929@twin.jikos.cz> <9e8ba9d7-34b2-4918-a4e9-2aaa3464d9ee@gmx.com>
In-Reply-To: <9e8ba9d7-34b2-4918-a4e9-2aaa3464d9ee@gmx.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Thu, 30 Nov 2023 07:19:22 -0500
Message-ID: <CAEg-Je_jRXoYY60Prf87S45Pzt4q6zDz53JaHT8XyPoG7OSMPg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 1:56=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/11/30 02:32, David Sterba wrote:
> > On Tue, Nov 28, 2023 at 08:47:33AM +1030, Qu Wenruo wrote:
> >>
> >>
> >> On 2023/11/28 03:02, Josef Bacik wrote:
> >>> On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
> >>>> For now extent_buffer::pages[] are still only accept single page
> >>>> pointer, thus we can migrate to folios pretty easily.
> >>>>
> >>>> As for single page, page and folio are 1:1 mapped.
> >>>>
> >>>> This patch would just do the conversion from struct page to struct
> >>>> folio, providing the first step to higher order folio in the future.
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>
> >>> This doesn't apply to misc-next cleanly, so I can't do my normal revi=
ew, but
> >>> just swapping us over to the folio stuff in name everywhere is a valu=
able first
> >>> start.  I'd like to see this run through our testing infrastructure t=
o make sure
> >>> nothing got missed.  Once you can get it to apply cleanly somewhere a=
nd validate
> >>> nothing weird got broken you can add
> >>>
> >>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >>
> >> Thanks, the failed apply is due to the fact that this relies on anothe=
r
> >> patch: "btrfs: refactor alloc_extent_buffer() to allocate-then-attach
> >> method".
> >
> > V3 of the patch has a comment from Josef, please send an update so I ca=
n
> > apply both patches and we can start testing the folio conversion.
> >
>
> For the folio conversion, I'd like to add more cleanups, mostly related
> to bio_add_page() -> bio_add_folio() and page flags conversion.
>
> Those are pretty safe as long as we're only using order 0 pages.
>
> But the more conversion I have done in this patch, the less I need to do
> in the final patch introducing the higher order folios.
>

With higher order folio support, will we be able to support blocksize
> pagesize?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


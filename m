Return-Path: <linux-btrfs+bounces-227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE47F2D38
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A21C21507
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D251C28;
	Tue, 21 Nov 2023 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdHfRVrR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F183
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 04:31:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aafe59afaso422203e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700569910; x=1701174710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVNDZncszMhges+AuqaIVFxpNhhzVoghQE/rD9R/w1Y=;
        b=JdHfRVrRkhYDFQeeB5hAz3j369gQkSnFWPm5SUPcxha/YFHPcpOALSMv0ehG13uO4p
         fTFfYFpF5njSqnl/ZA8GLkkH6Zjgi6IWLpOWtPgW2ov6qO/8L/IizZFmDnCpNK1RKEFt
         +oa5bACKacMXgGZpzYj+ONeFm1z087E50YEj67gIvTg7zDJA5TntkwCQk02mBcCeq2uX
         hisVcsHVhh4U/GAnXqp0nOZKrhu4UUyT8NoyIbTrRX6CqBt/1BwS7fgKrJxAsQY1mbum
         36f5I14SN/e3KygVsS4cQKzo6gcvk9UmdYHOXWP0yyKGvlBC5N7YlJYwQe5hFRGybffW
         jOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700569910; x=1701174710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVNDZncszMhges+AuqaIVFxpNhhzVoghQE/rD9R/w1Y=;
        b=w3gao8+/1ztFuIcc2pSXFW7kdxHTVbM9SyQlGWUFey+zqnbihCLYKy+cJ34BA11bgt
         4i9PD+OnBH1OTWrgqNNeI+P3SFLkvF2awGmewhJrcXpF6ZXiLcG37mNQOR8Xd3gCRd7m
         lIELhCWn2YKBlW0jfFRdTMSHLqJ0UOc+hhvhlQvrnrmQRDFVCJ55rFqluyVDrGFw1kvJ
         YeMwBN4BkPxcxYs0cYHPbFBpmWe7VEuNcsHjvTh+Te3zGQsyPXzFE9w9zPN3Tpq6C2DV
         KN1BrC0oKzb50CdX1xb2qJZgM6DKIqw62XDfkHggkzSBjkfybo57dtSfvXvuyRCTAtZM
         +f0g==
X-Gm-Message-State: AOJu0YywdIBMUMAFsFCujWXuq/6nr0xYuSToKb0TjAZpBgw++76Dfwl1
	aZvTxOgzSsgfKLZHrv7zLZLH8DxIcTseI4Iav/YM8L7X
X-Google-Smtp-Source: AGHT+IGJxRAcTXugV2BFSrRerMKx+CilAODBaftjrzG6MVwluGxWFGqw/Ag1i7JAaptwn9BdU2Xa4EqlKR3FnDC40WY=
X-Received: by 2002:ac2:4552:0:b0:502:9b86:7112 with SMTP id
 j18-20020ac24552000000b005029b867112mr6390752lfm.2.1700569910100; Tue, 21 Nov
 2023 04:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com> <87ttpgz3qp.fsf@vps.thesusis.net>
 <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
In-Reply-To: <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 21 Nov 2023 15:31:37 +0300
Message-ID: <CAA91j0WK8XoZnZVhfJJP7akUMorvEJ9yunpgJDSTivah_VmPiQ@mail.gmail.com>
Subject: Re: checksum errors but files are readable and no disk errors
To: kreijack@inwind.it
Cc: Phillip Susi <phill@thesusis.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:24=E2=80=AFPM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 20/11/2023 19.19, Phillip Susi wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
> >
> >> For the cause of the error, the most common one is page modification
> >> during writeback, which is super common doing DirectIO while modify th=
e
> >> page half way.
> >> (Which I guess is common for some VM workload? As I have seen several
> >> reports like this)
> >
> > How is it common for applications to modify the page during directIO,
> > which is explicitly NOT ALLOWED and will result in bad things happening
> > no matter what FS you are using or if you are using md.
>
> Could you elaborate why is it "NOT ALLOWED" ?
>
> My understanding is that when the write are not sync (i.e. the program
> doesn't wait until the data are on the platter and the metadata are
> sync-ed), there is a race between the kernel that write the data
> and the user program that may modify the data. And it is possible that th=
e
> data are a mix of the old and the new.
>

One wonders whether there is a kernel API to lock buffers to prevent
uncontrolled write-out and to release them telling the kernel "now I'm
done with it".

> Now the problem here is *not* that the data are a mix between the old
> and new (if you want O_DIRECT, this is a price to pay); this is an
> un-avoidable cost of updating the data before checking that these
> are on the disk without using a intermediate buffer.
>
> The problem is that the csum are not aligned with the data.
> This is a specific issue of BTRFS [1], only because the other fs don't
> have the data checksummed.
>
>
>
> [1] ZFS until the last revision didn't support the directio.
> bcachefs is new, but I expected suffer of the same problem if
> it doesn't use a buffer, defeating the purpose of directio.
>
> BR
> GB
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
>


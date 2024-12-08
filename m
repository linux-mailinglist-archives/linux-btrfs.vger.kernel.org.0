Return-Path: <linux-btrfs+bounces-10127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210C9E8673
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CE31884CB7
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDA15990C;
	Sun,  8 Dec 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="dmZA4G1O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E647BB1D
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675501; cv=none; b=RwqNt11v2mUIYTA8ynpxgGDn16tbu9CAfjSLG0SP4ia6zh7FTIRLS6cvupWfj2N83jenf43vkVj65xczGq6y6nJrd+qoHBB+ZTg/acziAtumZObsITwRKxHlvCS26akIcMF8B2V5DtObNu57NBsd2AI9lmnusm6zmk/WpqKkfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675501; c=relaxed/simple;
	bh=/3IqBLF5+082VftQzBDe5np6ZHdM0hU8MhttezCt58Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUTp/aOoW+4f+GQQHpxyfuyMb9fq2/kE/JPrpmkqgXEOxNUcGIDlaBz7+ZyryfkFrefvgJTv2GANcDpZ3rSIldRlHSL8w9TVCPWMC3DFhtawAzD4ghivJMqoxYpdq8ep+Cjvi8R5TGaSJ33EY3NfFThjiOpK5wAQ5zUh7Jsjr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=dmZA4G1O; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eecc0fe3afso2813867b3.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1733675498; x=1734280298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3IqBLF5+082VftQzBDe5np6ZHdM0hU8MhttezCt58Y=;
        b=dmZA4G1Om0S4XCihg8aYdNjPnUZG2YH2QxslI8HyfQFtAG/Tr5xgd08IB+Npl3x9cf
         xrIVm5P4VrlyHDh9Rb6WJ1Hbis/kpJc4F8X7cpTJNSWFGuf9G8pUeLYH7jUMK4ERo7BI
         sihBugXaoxoqhbcRYmNteTnykDCplbozFVf4dt1pyoqi894dgv9e5B3o/XrOaoz/grmO
         J4cmNzWGQ9jck8B+xpy9cHzPYi96lXAXeha5nJI61L9c4evi2nqsOENZ1i4t5zmvlnAZ
         5zpOw5v7jDA6Wrkaf4EiMUjAN4yaWMX0VgZ5RxpxWthFOOGoQKJNGXuKvnyhmpGq9M2k
         G1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675498; x=1734280298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3IqBLF5+082VftQzBDe5np6ZHdM0hU8MhttezCt58Y=;
        b=xHkog7VXgqjTQf4wqbo6hLY7flk8Zw/e8+2nJ2GPM9YbN72Ulkf4s3JzU3YLdL8RkQ
         deOY3kTf0JpPOBu9KR9qRFF5M9aPwUgmItxIJNHoxhoen+neIWefDmShPPMERukRtLCv
         R/BqGJuzqNXWl35Fib9oJhdpnSemcvThEt4FHhQAM2QvkJkjRGPlnOmmq53atPvKLRg3
         ae+a33eEqN6i/733eDAHUt4TB3aQDV7QikFHLT+OWnDPSCseTOQubm5BvL13dA/Nwf2N
         UKfzC3VoM4Mh4mo3XcvLBhRvMRB1OvSJxlbfQfNcQVb2Vm1qfNM7zEMIki36mXL6RK8g
         8DDw==
X-Forwarded-Encrypted: i=1; AJvYcCUqztwKKziOIydZ9bVQx4xq0cmjtES+Ij1+vRj6iiTwbEdAg88nDlQMpKgL5qow6WK084tZ82fOANmWnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3LcdA4c4J9VdxjYGXRNYTAtOnWjb3EyunpLz1iMQzggIlD9j
	OOJWLDGHob7mkWOw3YySgWJCAij/MSppUJu0F2wrrFfjV5n3YMlr52Frx6Yx2e9q3smw93IezWr
	dyfukFIUDTIvByCgEaXZBlojBR6uI28/uweCPsgBPZdV04BOn
X-Gm-Gg: ASbGncvPI5ihSl7dbCzGq7Z4deG8xHVA8va49HnfL85uARjJDH51T/wpARyRBA60jNL
	g3qG2LPxufwDE9ew72G1uv6lhjFdgcQ==
X-Google-Smtp-Source: AGHT+IH3HRUDPc/rSSkW12dS+YIWQ7oncA1ik1EzklMAuhI6+aj8k06O3fniuSNnOtUuGslv084lIIhwTPStQPhq/2A=
X-Received: by 2002:a05:690c:2c8b:b0:6ee:b726:62cd with SMTP id
 00721157ae682-6efe3cc01efmr29763747b3.9.1733675498187; Sun, 08 Dec 2024
 08:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com> <CAFMvigdQPC_cV5td1j0e2CR=qPT=W0Lp=+n74_UrSzahayMJWA@mail.gmail.com>
 <d6907ccb-70cd-4066-9bf7-2ead902f0974@gmx.com>
In-Reply-To: <d6907ccb-70cd-4066-9bf7-2ead902f0974@gmx.com>
From: Jonah Sabean <jonah@jse.io>
Date: Sun, 8 Dec 2024 12:31:02 -0400
Message-ID: <CAFMvigdfVLrPJsYq0xyuye5-_pAL5ByHQDS-RZ5T6de8EZWspQ@mail.gmail.com>
Subject: Re: Using btrfs raid5/6
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 4:48=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/12/6 12:33, Jonah Sabean =E5=86=99=E9=81=93:
> > On Wed, Dec 4, 2024 at 12:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
> >>> I'm looking to deploy btfs raid5/6 and have read some of the previous
> >>> posts here about doing so "successfully." I want to make sure I
> >>> understand the limitations correctly. I'm looking to replace an md+ex=
t4
> >>> setup. The data on these drives is replaceable but obviously ideally =
I
> >>> don't want to have to replace it.
> >>
> >> 0) Use kernel newer than 6.5 at least.
> >>
> >> That version introduced a more comprehensive check for any RAID56 RMW,
> >> so that it will always verify the checksum and rebuild when necessary.
> >>
> >> This should mostly solve the write hole problem, and we even have some
> >> test cases in the fstests already verifying the behavior.
> >>
> >>>
> >>> 1) use space_cache=3Dv2
> >>>
> >>> 2) don't use raid5/6 for metadata
> >>>
> >>> 3) run scrubs 1 drive at a time
> >>
> >> That's should also no longer be the case.
> >>
> >> Although it will waste some IO, but should not be that bad.
> >
> > When was this fixed? Last I tested it took a month or more to complete
> > a scrub on an 8 disk raid5 system with 8tb disks mostly full at the
> > rate it was going. It was the only thing that kept me from using it.
>
> IIRC it's 6.6 for the scrub speed fix.
>
> Although it still doesn't fully address the extra read (twice of the
> data) nor the random read triggered by parity scrub from other devices.
>
> A root fix will need a completely new way to do the scrub (my previous
> scrub_fs attempt), but that interface will not handle other profiles
> well (can not skip large amount of unused space).
>
> So if your last attempt is using some recent kernel version or the
> latest LTS, then I guess the random read is still breaking the performanc=
e.

Thanks for the update! Will your scrub_fs be rebased for raid5/6 in
the near future? Would be nice to be rid of the 2x reads. I suspect
then raid6 results in 3x reads still then?


>
> Thanks,
> Qu
>
> >
> >>
> >>>
> >>> 4) don't expect to use the system in degraded mode
> >>
> >> You can still, thanks to the extra verification in 0).
> >>
> >> But after the missing device come back, always do a scrub on that
> >> device, to be extra safe.
> >>
> >>>
> >>> 5) there are times where raid5 will make corruption permanent instead=
 of
> >>> fixing it - does this matter? As I understand it md+ext4 can't detect=
 or
> >>> fix corruption either so it's not a loss
> >>
> >> With non-RAID56 metadata, and data checksum, it should not cause probl=
em.
> >>
> >> But for no-data checksum/ no COW cases, it will cause permanent corrup=
tion.
> >>
> >>>
> >>> 6) the write hole exists - As I understand it md has that same proble=
m
> >>> anyway
> >>
> >> The same as 5).
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Are there any other ways I could lose my data? Again the data IS
> >>> replaceable, I'm just trying to understand if there are any major
> >>> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't c=
are
> >>> about downtime during degraded mode. Additionally the posts I'm looki=
ng
> >>> at are from 2020, has any of the above changed since then?
> >>>
> >>> Thanks!
> >>>
> >>>
> >>
> >>
> >
>


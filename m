Return-Path: <linux-btrfs+bounces-10780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96212A043B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E79E7A2197
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D451F37A4;
	Tue,  7 Jan 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BuK/brj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6E1F1909
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Jan 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262265; cv=none; b=QJGuAkKbZO01uLfRtC5htGW3y+VRcsOF6OmrJaAqSQTr0Zo+B0/L2PyXvHWowUy69EaHIZRkZ/gSd01AVKcaJbi1XSeH3yBF0oYqXC4yvj0/7jwYugCe0mZR+r2dVxRfq9BlMToVFaK6J3V2xVaNAF6Ik+OUvtjqjtDVvNjWmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262265; c=relaxed/simple;
	bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6d/P79uuquaF/oQhbSFIO9fUWTf8YRa22ICzd8jrPo8J25mhptb9LXsXzDKYwXV2N+FivV171aSMQDll7S2bljDan3eo2HwraE5hqfhidUu8LOJd5oAg23hVvcF9foKS5mxIw2OYqfvvj+y6g+QvvC+nIYm2Eqiz4W9C5TXCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BuK/brj0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf60d85238so1053218666b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2025 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736262259; x=1736867059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
        b=BuK/brj0GCttSMvwkSmcGnbVwe+4PzvpCBCfjCzkINnAE7E6jxsJ5JLUlL5UgOtMwI
         W9q+F6MYJjoeXFF42rFpgxNsVuNB6NdMVGzsFzWD3G7me3cFimjwi9SJsJp/u3PD77xv
         ZnHndZBaCSiaRtusCFaO84bwMPIV90cM+d1KvbxtU3/h8Fe81DvhhRufJff1lwRM10Md
         /7/EONXg80dXEM2cEozCHLgQe1YKMWQXTzLU2P7spbWDiHF7uhfa6YHWeGQgyrzlawBX
         MWd7HMbmUteCdVxlRjH/6/SVxjgfqQ14Q6YtFXGOd3dl2uP3ZH+qjXW3SU3eSYQ1dxwJ
         yiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736262259; x=1736867059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zLSbbxbVmZkkCVuDfrtTMuFWiMDOzvUE9K2ecGKmls=;
        b=fjp8msKq17OtEY5tgO2uN7c8DTpz1gIxNMPXPxdzgkLXuKrDA7NM0AQUwiAeRgYy7o
         ka+iwukIDVBirMlpoUIIWdzK85feQl/tV7V44uosU6VPGXXHcy984E2V1LqCR6jIgdGj
         aFTSikYPHK6eIE+OxeMLsEjdpFcjUDKFU1ye8+3iruaf19PrPQETAYzRKEM8VHkUVuBy
         z3m85PTP1xgoYENW/KAdq6E4BsYmmD8UFRCdonqVV3WEJIrz6q6NEtKer0toE5uC7vsT
         eUWO4AYGrql65RzYNRJ4G3W9u/Yr3hLsKghtOUZKQ+EmJTdki82ELSItU0faBLtCqeUn
         tPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV41mvKM+iayOdZaghmxNfK7Tz0nOz0CUi4SqPcYLqedzq/sFz0s9Rmir7rRybzaU5d1jpCBbQa+hgriA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLPtaTEVe2t+tuQiaCdTvQ9S2vW8vkWLfYkY7NHujAQBUeZpd
	COrP8T1gEmooB24ujmqdMbjDM47jzTMrWn6I2gS0nFUV8GLk87UYQudaR4UuUP/fFMMHILKl3Tg
	MFCuSrmqyeW0uxCOMV9ql61+9YtBfd34/20dLQQ==
X-Gm-Gg: ASbGnctJhHVZCDFb/BndPk7hCAi1iSYOODamNMeeeBDgtt/HdMnBynFQvLIijUyPRkK
	Spd971q5BGozGoLof29BExCVXwaGuEYDVeEsSNTwBMjnezKBF4GGJC3oBUtnKfFOO2mFyWeU=
X-Google-Smtp-Source: AGHT+IGmTCd5YHsFph8t/UWhoGaC2Q/1DgFp4D1LmOF+O85L7z0mW1Q+UNHB289bpUXaUg8KNqd8OFE/AuRY9NS0TR0=
X-Received: by 2002:a17:907:86a5:b0:aa6:423c:850e with SMTP id
 a640c23a62f3a-aac334bc14amr5638224166b.27.1736262258818; Tue, 07 Jan 2025
 07:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com> <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner> <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
 <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com> <1d0788af-bbac-44e6-8954-af7810fbb101@suse.com>
In-Reply-To: <1d0788af-bbac-44e6-8954-af7810fbb101@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 7 Jan 2025 16:04:07 +0100
Message-ID: <CAPjX3FcbhvB=qzeJjNkW+XdS3_Xrxn_K6e7vyzMqS0WLbXFgNg@mail.gmail.com>
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jan 2025 at 23:00, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/1/7 08:20, Daniel Vacek =E5=86=99=E9=81=93:
> > On Sat, 4 Jan 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
> >> =E5=9C=A8 2025/1/4 21:56, Christian Brauner =E5=86=99=E9=81=93:
> >>> Can you please try and reproduce this with
> >>> commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
> >>> from the vfs-6.14.mount branch in
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
> >>>
> >>
> >> After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount
> >> failure due to remount races") cherry picked, or it won't pass that te=
st
> >> case), there is no crash nor warning so far.
> >>
> >> It's already the best run so far, but I'll keep it running for another
> >> day or so just to be extra safe.
> >>
> >> So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of
> >> mounts in an rbtree")?
> >
> > This one was merged in v6.8 - why would it cause crashes only now?
>
> Because in v6.8 btrfs also migrated to the new mount API, which caused
> the ro/rw mount race which can fail the mount.
>
> That's exactly why the test case is introduced.
>
> Before the recent ro/rw mount fix, the test case won't go that far but
> error out early so we don't have enough loops to trigger the bug.

So the bug has been there since v6.8, IIUC. In that case I think
211364bef430 ("fs: kill MNT_ONRB") should add Fixes: 2eea9ce4310d
("mounts: keep list of mounts in an rbtree") and CC stable?

--nX


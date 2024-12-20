Return-Path: <linux-btrfs+bounces-10620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA69F8E08
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3161895067
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856B1A3BD7;
	Fri, 20 Dec 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbSSAC8C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926D4A08
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683640; cv=none; b=XQrMSFUagrNa2rKiQJswybqkaR5ZMKWGkNAEyP+SnEjmw7JApsNVZ45fdx7ZLpZW+Tsb9p9Ahkey/phnUX/J/+u6eeQXyjit2rmuhSJl8H7fRC1GniXQfJh7F+BIpR6duI3gt9wgfkrpVvQWfUCSATOjO9yGzIhwxiBWsZDSidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683640; c=relaxed/simple;
	bh=pH10uFBXFaGjPWJY4pfu66ZCD9c9pceX2JBiatbOrpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fwc8c1hZ24Rmds93tzJEhSq4+XRp2dD6NJ2UervHbp5QaI3jDKAkSbSIMAgmBjsTX/5d1izUNnkTnybuuF7YRgVRnZgE+nlJfr2fPLhnUuXYfHbDDNAOGTPCorpkNe5Dfhi/QugnUp07yUAMu/uJ7vGbf1Zm+mZXMIS7jCaGzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbSSAC8C; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef0ef11aafso14916647b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2024 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734683638; x=1735288438; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pH10uFBXFaGjPWJY4pfu66ZCD9c9pceX2JBiatbOrpE=;
        b=KbSSAC8CQEEb0wuXEknYBar+UQf2GjEgHLzFw0eNAh8vclMqqgAU5s92ZogTmkxgHx
         x6Nx613GRF1OUYYFbHCZVDldiekF5PxvOeaiwR5cOsU+iiMN5uwCLcwIj8HiYBW0yTOc
         zrarMGBzNdgZNp9/dHm1HbUlqyt7NtU65J3xvBr95GrX6WVOR5ycisKWbFqpCBpGdLat
         0PO1HlE+Mr358yLNtglZHGF7r3evutdntCpTrWt0XMx9TkiHHeeKwjEIlttRMjSPR0Ba
         hgxT3ir/stxf6FMCPzy272qVMorvkTU8Y9i+fRxWwbSkNBFp3hwRpjPAqFQVJAc4zOtA
         6RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734683638; x=1735288438;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pH10uFBXFaGjPWJY4pfu66ZCD9c9pceX2JBiatbOrpE=;
        b=mPWlKi+7BjY+AQNVtt9sQ9aiM7uxGqBQC6benq+qbVE7MQXitjPexWzHQ4pwkddckV
         4OgomzRQtkS18RzmQiRopgcgCKdmTVteouEWI4TDMMau0PXvp0KEBItVnIednS905x80
         a9+2d5r1/32qNcy7BvLEknz5x3uvcNruWuUyumBGLCwZoLE38jDDf2fWo7fKpfuuBMQM
         4w91K/WWyjch5amODyHSnarTvUQfMUODYC41UPMe4dVyssuw/MAfBKwbwBAJxfy+ouGx
         E6YyqtUWrP3hueDymqAPkeRs9HcSnLMeGTRjKPPEB7AQVCWQQRZJgCCngs/xXUnxV3qt
         RiQw==
X-Gm-Message-State: AOJu0Yy1EIYdlCgcX2oYzIoZsrkT4k1l9OEuxbRGkXRCkWotKoiz7KQd
	S6b0oOSJJXOAX7coyoWJZUYPei8agU0OxN3WH5YNruQMvEMxZz/j+9Pm7C563l4pjo6b+IkY4Ym
	Fv1RbtYtrMWVsRxxQPWJn3vIynKMjKH+y
X-Gm-Gg: ASbGncvURMiFAsEcDTElSFFw4qVjLms0l6S9EoxneYdWisCIuixwRYCBFhX6K4fg+Cj
	UMDWGdjgWaiVk0zqmL5aSy62cS8kbNK2Bl4LDkg==
X-Google-Smtp-Source: AGHT+IFEBImboMQaVZ05qQ7/mLtGj7fvYls8ogHXs2TzpRpO/JYzCbsn9vLMCMO72IZcpHwBZzeRBVI3WgOIZ0BEXG0=
X-Received: by 2002:a05:690c:9991:b0:6e5:a431:af41 with SMTP id
 00721157ae682-6f3f823f1edmr12707077b3.38.1734683637826; Fri, 20 Dec 2024
 00:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYTmpGK3w_07RinTWXzgsnkLr5TA4me40mi-evYqgkBQZg@mail.gmail.com>
 <77fd84f1-9012-482e-8f72-5d7de752d5c1@gmx.com>
In-Reply-To: <77fd84f1-9012-482e-8f72-5d7de752d5c1@gmx.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Fri, 20 Dec 2024 09:33:46 +0100
Message-ID: <CAFvQSYQVS7TJDQ19JAHm5Dw_Qonq_qZuevuGPwDnVay8-kUFew@mail.gmail.com>
Subject: Re: btrfs check reports backpointer mismatch / owner ref check failed
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qu,

Thanks (again!) for taking a look at this.

> Full output please, along with "btrfs check --mode=lowmem" output.

Quite strange things happen - all I did was to execute my sync-scripts
a few more times and now the original errors are gone.
Instead another error class showed up "shared extent lost its parent"
- interestingly the same applies to both the internal and the external
usb drive.
Excluding the possibility these errors can propagate via send/receive,
I don't its hardware related - two different disks which were almost
exclusivly used in different systems - the only commonality they share
is both have been kept been kept in sync via send/receive via the same
sequence of commands. However, if those errors can propagate via
send/receive the previous conclusion does not hold.
Memtest ran on both systems over night without any errors.

btrfs check --mode=lowmem output of external usb drive:
https://pastebin.com/w5hWYCnL
scrub result of external usb drive: https://pastebin.com/aYEXM1ps

btrfs check --mode=lowmem output of internal nvme drive:
https://pastebin.com/NcQvgMpr
scrub result of internal nvme drive: https://pastebin.com/0qDWxA5e

Currently I am on kernel 6.11.11-300.fc41.x86_64.

Both partitions (on usb and nvme) are encrypted via luks with
discard/trim disabled.
They haven't given me a single issue over the last year of use, I also
don't remember any errors/warnings in kernel logs regarding devices or
FS.

Best regards, Clemens

PS:
All the sync-scripts do is to create/delete snapshots and perform
send/receive between them (in this case extern/usb is synced to
internal drive):

btrfs sub snap -r extern/root-rw extern/root-ro-new
btrfs send -p extern/root-ro extern/root-ro-new | btrfs receive intern/
btrfs sub del extern/root-ro-new
btrfs sub del extern/root-rw
btrfs send -p intern/root-ro intern/root-ro-new | btrfs receive extern/
btrfs sub del extern/root-ro
mv extern/root-ro-new extern/root-ro
btrfs sub del intern/root-ro
mv intern/root-ro-new intern/root-ro
btrfs sub snap intern/root-ro intern/root-rw



>
>
> Nowadays as a usual precautious step, please run memtest (memtester in
> user space, or memtest86+ as UEFI payload) just in case, after taking
> the lowmem check output.
>
> Extent tree is the hardest tree to verify, and since it involves a lot
> of cross-references, tree-checker is not really able to catch all those
> problems, especially when hardware memory is faulty.
>
> >
> > Should I be worried?
>
> Yes. Although these problems should be able to be fixed by "btrfs check
> --repair", it's still recommended to start backing up your important
> data on the fs.
>
> Thanks,
> Qu
>
> > Those file systems have never given me any
> > trouble, I was quite suprised to see all those errors when checking.
> > Could this be some bug triggered by all those snapshotting? What kind
> > of additional information would be helpful to pinpoint this?
> >
> > Thanks & best regards, Clemens
> >
>


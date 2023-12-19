Return-Path: <linux-btrfs+bounces-1053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD381833D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 09:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02B0281F23
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885FE11712;
	Tue, 19 Dec 2023 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAoGQNGy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDE11700
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e40b43798so363480e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702974142; x=1703578942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iWXOiH62qqTI5Y24aPBZ/SDKwVcT2ILbC0Z4Rfy4Yk=;
        b=LAoGQNGyhKQSS2YvbjrF0t3OhLzhVwQi/H8pkVvwrZys9OW0+Bsgg+ho++S+4bLyIr
         /7h5B4xA0mMRn6A3GKZFRmoMjh0yGhe/XG4dDpTTWIx3WPVvxPlGtSltOraMB1r8aSv3
         N/jViI6hArZiDAO6gDCKPuLl4IK36VJkCEjmYD4cEiO73ezkcjRMwAZVO4VUYKEMnY6g
         NaQGvKXgGvct7Bze3cCblcxJ8eqYzHnbvUSy13MgvwV2atFagUKtym385hCeEgYFGQMY
         KnTz64K0mvW5jijLd2RkwFeN4zHCoVvVegRTvJC1trkgS+tLmG5WzFGj1MK0xQZRCXm7
         ZYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974142; x=1703578942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iWXOiH62qqTI5Y24aPBZ/SDKwVcT2ILbC0Z4Rfy4Yk=;
        b=p2favJ6FU6M28ddZZmZtqN7lW5QTLI+PLqiCL+6aeW+Ska67vVQ7e8vO58T1IhEU2L
         WUZX2i4MVBBivKETnMmRYQeVYcwyh6hXO1JR7fPlG01kU4fepwoXeEdF/C7YQN3fX+0u
         Bu2LG+hpBB6dEvAJBOxAgucOW+90qBSChy+TGvocTc2mA8Jc1qH3IK3iE5UrQtGtiZxE
         HbFPD0FcAu5S4Q0RWCmMPaaeWFCeF2mjYWvKKzGfRO+bLJfgX1Xn8zMOwOOqJP2fAutO
         eEGtMBN0hglWbJxKuGemollfweEaOG0fJv6f84doMPhN4rTGy5xp7Og8BNSGVuvoX261
         sUHw==
X-Gm-Message-State: AOJu0Ywp1VDnmMez8tVvrmnw2Ahqr3kccL3I4/nb1n4jX32uOHptA9Cr
	iBb4sWqy74J8k5Jg4Yp7R7+uYPZdRgCzf5+Ax1heQiBaNpg=
X-Google-Smtp-Source: AGHT+IHHaaXUCz0ZSyqENW9bjuzgBjtp8+3MXWqcqLvQ3m2TuMxbK3XxKLGeClnCMs16H2EDUPw0N4gTH+jzBVimPCE=
X-Received: by 2002:a05:6512:b84:b0:50e:3df2:c7bf with SMTP id
 b4-20020a0565120b8400b0050e3df2c7bfmr2798298lfv.1.1702974141926; Tue, 19 Dec
 2023 00:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com> <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com> <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com> <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com> <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com> <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it> <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
In-Reply-To: <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Tue, 19 Dec 2023 11:22:10 +0300
Message-ID: <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:00=E2=80=AFAM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> Hey.
>
> On Mon, 2023-12-18 at 20:18 +0100, Goffredo Baroncelli wrote:
> > Being only 309 files, I suggest to find one file as test case and
> > start to inspect what is happening.
>
...
>
> I've also attached the output of:
> # find /data/main -type f -exec sh -c 'echo "$1"; compsize "$1"' '' {} \;=
 > compsize.log
> in case it helps anyone.
>

/data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      256M         256M          15M
none       100%      256M         256M          15M

I would try to find out whether this single extent is shared, where
the data is located inside this extent. Could it be that file was
truncated or the hole was punched in it?


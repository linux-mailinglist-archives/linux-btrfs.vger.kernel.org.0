Return-Path: <linux-btrfs+bounces-16937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CCB862DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E9F166D86
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9771C3314;
	Thu, 18 Sep 2025 17:16:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F030202F65
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215794; cv=none; b=olQil8JUxEKzQ+0klN3Hnres4N0d8iBbrGJe3to1xRZFgvfI+iEB3Lw1tpoiuGSx4RjnjMsOoyuaTFZxBvxfvmknfqknTK1eX7YDVDABjQkR59BCWQ88HTLW/xdJqr/4HJgeQVsS1FHEqVR7PK8SY1wWOtkJMtYsTtAbDgjVCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215794; c=relaxed/simple;
	bh=EkifGiWVCQfFYy2RLpR0UqqQlQXDCyIcoPQ6A1w0XKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMkdk1QcUABz75nRyq58G9VMHwCmZ/sKgUNBIO1/UnXQLbfjqs+T6ZEommQGTHQ+2jH0qppG2Mb96Agkr4k6wdS6zhXoBpmzsy2NLU9A+0xNPuG83V6IfLjV5nwmYfIF0xpyHvVGwdTrHhkBqm1aZ5GLzh1oN6BJ4FlJ0nAcqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042cc3954fso239461366b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215790; x=1758820590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZrzq2UFCkB+iJ+VCPkh40NaV8VlgpHQDjMB5lp4n2s=;
        b=T85HyXS/Sk1AdLSZIbhZm+0xeYP2XGrpocyqwgr2xxMumXFr4q9AkVSymcPxCkjex0
         28tZfkaWb1AvchnjrxqeGzS0O1Lbn3IXjNN4Z1+WqJlWo7NT7V0OwJhYlCgwhW4esVe5
         niRqo4yNERodBe/D4unmhfQzfNLisdZ5rYjWVBYY0zmSYT0YyPqkPP33TVodGRYOyJwP
         GRzavrAqB447Mz1AZ5aGTDPFv+jjoy0tE5Farpetaat9Qrw9JLWpBXJu9QzotcxXD/Ru
         EoFkzh4S6YITeeT3OvR1OJfi2TQmmRvRSCHMUZkqdlZ20BKz0EQnCpCzTuJWvDZVW+8c
         IRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMnT25EohIZzkTPVvFm6ZwQDC9J6tEdNrPjCR/HnmWA7GV3Py5k+fcFcg1rAPszgAJZ+nPtOy23S7SsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eQZ1mQBte0sqfhk2wb8IEQqbWafsq2uibcyai7boeFJ+LiBC
	qtIAMRl9lJnlJy6Hsv7wu+6UQSNhIgAAx8Ode9A2LXSGHHjuIS6WzsSXeV3WCRn4
X-Gm-Gg: ASbGnctKiNTKAZadSRb9PXpKkEHi8vFwZUafKNLeFFqUNmM4eymSQMARu1fT5qFxh6f
	Spx7P0L8r9tvj4ulg2EG8Uw5OvQijuex7es7ZYVKO5Y6U3zPC3qn/+JpZg3Av5ra24r8FDcwX3z
	R16zQimva0TTrIwAAF4TgHJV7AxmPQbaTW7d/injpclQ2f5LA48fdmS06FEIj+k1Jc5MibQaxDZ
	V0HXxAO0ymQ48pyhcsweaGRa6QdP+ZIPln7jzoadn4zmQgb3xPUA8jvMlM2NoT2+ydXak1a/MzT
	kgn/0qq3I8g9oNE2JYJahwUF5dWT/xyqyzCr/L+Q5s4thFJ3xXzEi+eIOlcBxkeEhhjdiGovOe3
	RS36L0eJgzUEvv5NzZQu7nDks4G+7cG1pK+HKweOGss0BeTfYVUanrubaH6fZ0tY0dUcVf3wLkn
	x+3NpG9T8QE+adbto6mH8W0O505tk=
X-Google-Smtp-Source: AGHT+IEAR4B5ALb+IDXgYGnbsDOYaB3Yif+8E3kRYz4bZYD9/ruhE7yFtswxBVRQs/64r7GRPgUXhw==
X-Received: by 2002:a17:907:97cb:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b1bb9737ba8mr714709666b.64.1758215790149;
        Thu, 18 Sep 2025 10:16:30 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc74af9b9sm239433966b.44.2025.09.18.10.16.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:16:29 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b042eb09948so224605166b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:16:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVa9pvDtbMN0+0T4IsW9YepN+z2Q871H4agFCKazqbnyWw+PJNY+rSVVporCtp/Tymr/B5mRfCb0IVgwg==@vger.kernel.org
X-Received: by 2002:a17:907:d8b:b0:b04:a1ec:d081 with SMTP id
 a640c23a62f3a-b1bb6802dc1mr790556766b.30.1758215789615; Thu, 18 Sep 2025
 10:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758148804.git.anand.jain@oracle.com>
In-Reply-To: <cover.1758148804.git.anand.jain@oracle.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 18 Sep 2025 13:15:52 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8iXwtdPfhPJSorxhPDe8v_stUURskgji0-Lq1_s+E6hQ@mail.gmail.com>
X-Gm-Features: AS18NWCRwa0LU36c6pi7i3hVz3lUvFq57s2bH2-WY1Rl1K6Q7jLi9gbC4VjJyJo
Message-ID: <CAEg-Je8iXwtdPfhPJSorxhPDe8v_stUURskgji0-Lq1_s+E6hQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fstests: test device reappearance with new maj:min
To: Anand Jain <anajain.sg@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:33=E2=80=AFPM Anand Jain <anajain.sg@gmail.com> w=
rote:
>
> From: Anand Jain <anand.jain@oracle.com>
>
> Tests filesystem behavior when a device reappears with a different
> MAJ:MIN after a block layer transport failure.
>
> Anand Jain (2):
>   common/rc: helper functions to handle block devices via sysfs
>   generic: test case for reappearing device
>
>  common/rc             | 26 ++++++++++++++++
>  tests/generic/809     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/809.out |  2 ++
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/generic/809
>  create mode 100644 tests/generic/809.out
>
> --
> 2.51.0
>

This series looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


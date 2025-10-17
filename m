Return-Path: <linux-btrfs+bounces-17957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D3FBE81AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0E19A7F75
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F043191B5;
	Fri, 17 Oct 2025 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ/FQqW3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBB31691F
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698028; cv=none; b=tZtkBdd81b14O5WkXpJR73Bxb5bN3/0k/OkMwqr8G6QqN88+iRETi5uPd52shw9DMMU8d4yvQq7QS9m+xOOCm9I5Ua6HdCPq4Hl/QR1+mEjGAAPh1LvBlVI9CcNzk0fZXFkdrVE42pzHLIE+Qt4iLcUAhX8PMiK+5N/Lv5krHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698028; c=relaxed/simple;
	bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifgQcMfxkMevkmva65PY/v6gDzu0FrHlQeAoCC2Bm+Bv1KyfdvqpBXHajiGCfS+oKfsLjeWY5BJTHZUSYdp8AGhwduIdMNMIJtk4BnJj7ecV99L36GcLE0wrlMCPDF1c5SBGMcpi3MncgtXhFl98RKigRds0YELCTxOcQFUywDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ/FQqW3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1554262a91.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698027; x=1761302827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
        b=LJ/FQqW33oj93oq8RVNzMsAbirzsAgrNeoDq4/Bw28678gZF4GfMMa8zubfw6JnE8k
         HWPLOUqC6xC769dAqT/oeb0Gmcp6DvRUFHR6JKDH6eLmxukMwOG501pD1x7zvPCZtJf8
         jkXhp/oaKcn5f4OOFczdUBjzZLUE7hMT9pas+S29jZhxSykevkBQWShtj9eS4rZCAdsx
         aYOlQ5PXYnh22hopebyUTkRwdihD3xAVtjnAQbvH9GyIJYUS4f3iLScj5QOik9NqHIXT
         Ncz7fcHO1lFxk6LdMQBLsu5r/uwi2KWTlPnPgU7eTaiRoGbOTQwB9QY+uIYHVdZLpDQM
         x3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698027; x=1761302827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQdBXifothhDj3AZBdraQdix2GJ9g/CASsBOkm8pgKU=;
        b=vzYn5YCgEXoPEprqZXV5Vr9xYo/Cu6hcJZ6iS/05U1PBcvpsOLgORXB6ZL0ci8RS37
         ojwpJ8nkTz0cWitoioZwDdL0UiW/PQH/p2D1F9CioRnjhHxpPnPDVQtfTvcWgZSOcXSr
         r9aZEMocNzRpRzJUeoiWqWm7Wl2rtUkPaX4sEW6e8QLoUMReoHEHwkT8+OUBmliH9br1
         rvrLJGYmPGpphHxPA4/K7Hdr4HXWc+xnt6F798PKrfiKFPoEK3p1q3KZ30x2nSlf/HOv
         lqleMZAyZoFk2iiyTr0pESi1dk2brNxMQhIjGE+M32jcSjTqiW6s39o/rLA3wMpHGpPN
         ufYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEtiRVZuXZ/NksFfy7MbWADoQy9iY01SyiUDZOSi0RKbywZXa+0MFeRNuwWl3yBaD3Jtul5JFED8tH3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EgCpchckZLQHBN3Bnzo1JEwb0Xp2kLFv2JkddbIX3+u8RmIt
	uGT0OWsMlDxLU2b4SjbSSlNWJcXG47o4DWSl3MIDC6cLsja0rRyi8L4J+bdmgspYyxwh0y6aUFl
	NzhyE75LfOMm35poT4NMHd1xiwGNUWiU=
X-Gm-Gg: ASbGnctDSPQkS+rWmMqqWL/M6IyxYC87EEal8y2JLmIfvZLvuUDJSkOqrONVIILEXmg
	s0jmCD5/F/T8CLJLWp1JC7HuKyQ8jXxy3ZULoTXv4bfMS49Y6ipcS9fziMp6fwCaLMQdBPe8MQ6
	DOk4I8+xiVhftJrVMaAFP+NXDVUh++vbuHDlmz58HuXAtcEA/A9i2xE/osxjpXaid/YnPqfj3lD
	TuofHjnKx2AqFhiCEDDqpRJBusN0dRCHnX4kKEJsevh7sBAlkXuqnuQ5y9OFOOJYPtuE1c=
X-Google-Smtp-Source: AGHT+IEEaE+tui0U0I0TXcNlTG5xIeJC0VF+DfPTztKKUffqSeF/bX7woXzKAAvsXsqypwGxql2E1Dy8XFNfh8zeo8I=
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id
 98e67ed59e1d1-33bcf8f78c4mr4046515a91.20.1760698026680; Fri, 17 Oct 2025
 03:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com> <20251017103932.1176085-1-safinaskar@gmail.com>
 <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
In-Reply-To: <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Fri, 17 Oct 2025 13:46:55 +0300
X-Gm-Features: AS18NWBEgDk56WydgN45udggPPH9iWh3lIq14nwoPRXvon1_-ri3PlcNoWOSlMY
Message-ID: <CAA91j0XHt30mqDhgzWnvjbE-iGi3nS1BB1rgZy0Z6mSOT64Abg@mail.gmail.com>
Subject: Re: Long running ioctl and pm, which should have higher priority?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:43=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/10/17 21:09, Askar Safin =E5=86=99=E9=81=93:
> > Qu Wenruo <quwenruo.btrfs@gmx.com>:
> >> But there is a question concerning me, which should have the higher
> >> priority? The long running ioctl or pm?
> >
> > Of course, pm.
> >
> > I have a huge btrfs fs on a laptop.
> >
> > I don't want scrub to prevent suspend, even if that suspend is happenin=
g
> > automatically.
> >
> >> Furthermore the interruption may be indistinguishable between pm and
> >> real user signals (SIGINT etc).
> >
> > If we interrupted because of signal, ioctl should return EINTR. This is
> > what all other syscalls do.
> >
> > If we were cancelled, we should return ECANCELED.
> >
> > If we interrupted because of process freeze or fs freeze, then... I
> > don't know what we should do in this case, but definitely not ECANCELED
> > (because we are not cancelled). EINTR will go, or maybe something else
> > (EAGAIN?).
> >
> > Then, userspace program "btrfs scrub" can resume process if it
> > got EINTR. (But this is totally unimportant for me.)
>
> The problem is, dev-replace can not be resumed, but start again from the
> very beginning.

What happens if there is a power failure? We are left with two devices
that are part of btrfs. How does btrfs decide which one is good and
which one is not?

> As the interrupted dev-replace will remove the to-be-added device.
>

In case of power failure it has no chance to remove anything.

> Scrub it self is more or less fine, just need some extra parameters to
> tell scrub to start from certain bytenr.
>
> Thanks,
> Qu
>
> >
> > Also, please CC me when sending any emails about this scrub/trim bug.
> >
>
>


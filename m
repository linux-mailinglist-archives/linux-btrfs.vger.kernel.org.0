Return-Path: <linux-btrfs+bounces-17135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73320B9AADF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E974A5AFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447D313D48;
	Wed, 24 Sep 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="yanrmOQ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076913115BB
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727964; cv=none; b=AF4EUBN0U7/xpE9zoihmuVVp3L3nem7Udm3//TiqTOhryfkw+J9RUyYXJjEG1u5/95B/tH0zqS0HQ94B6VR7gNYUQUZ9t7U4+KG837HHHmZgCr2TZLnJtr2JFF05/kkbZHHZdLX5n8BIfHmsFRtOY/LYb1f3pM5IsRh6R04T4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727964; c=relaxed/simple;
	bh=t4GAOLefdJxX3ufZjP5Ea7V5uPehWdKDTtJn/tupM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ju1v7Sho2B2Gdv9JOF9OIpYvrJXXXpmV95Cux3z4RGN8vlzRS6SzZe+bpOfhlR3Uwz3xREiNRLIcs9sYKp4UGg7xY/JvuSEk4akmHMsodGZAX/4Ho30eGpcRIzXmUyhtsNsSNd+vXhosl9/4sS4ylSn1tOO0xz5EY7Qdiy4379Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=yanrmOQ4; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5bbb3efc6so1020434276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1758727961; x=1759332761; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0DufMxkRIM7Rttanr88lGKCsFqkZUfV1fjh1wdQupc=;
        b=yanrmOQ40RK+cQSaRN5piDqcplGv07r4nL8anN1sSn2HFvuvO2MBb11c9aTEKGVwVD
         deXihjLYoSx6+FUpgqgncjb/tcHMJQVC098D87nzSSu5FfbRJYdr8X0ewpWySNqxO2D9
         lNa/Jqwd++L+4CMubpV/3aSIktX6mAhr8w4v99QtTqkVQ0rz4iFVaSpt0pGbDhxeXFs0
         opFqPxIlh6fCq9Jq5lqTdVN+gUXQHfbJ8Eob31vbKQBqthLebujx+Iq/9YzdA1PqfZ+U
         vwuSpQWkojJHiDv6XsPGJIB/Nn30DaWFlzBQqFMB35TOL+mvmpoXK8B415YzK+IaGfOz
         aglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727961; x=1759332761;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0DufMxkRIM7Rttanr88lGKCsFqkZUfV1fjh1wdQupc=;
        b=qCz3sWAIOeAbugBj9Mra2iD5TiEyiN7obZKMevY/Jn6AEa/v3c1KE1q4J3eae6lbTH
         PUdSBnlMo13vnaw8IRrw95vlX/o09OrARDr3MgfLsWifWGk95QbhN3ffmckgfG0jUoAH
         /yqRQ/hpViXjSHvd9lQDshE8S4smPWlJj/3mKOKVmeVMc4ENkKkqI4fDansaB2Yd8ozG
         b7aebSEFY4hlnDRDFOCMaH8JT7eyu/Xr+lkQyDid3mdwhu8tFx+zGTWtZDeCJQUQfZC0
         xYUlGY++rVK3KzUM3rCXplXL+Sd0g/0E4ARstZ9cYSaHK5b+kN+PmOEOHNid85+uKlJr
         xcTA==
X-Gm-Message-State: AOJu0YzUkTJbhEiEnlGU1RlDjf2//lCKYCsKHgEDTuXyq4nYQQRkwddr
	fcbedUVN0fpORJhILDaslz0exCQXFHPyG5JDieepbEV0V6xKGiOV5VT8Js0Sp1RLvyrzUoHkxaf
	mCezE/+94yHSpLLWJDO9LUXIyuhTzCJWdAG2Ca4w/0Qp5IlHQM4bGfUE=
X-Gm-Gg: ASbGncuD17yw/dEsXcuJLET1ZHY+C7JsbmLnXFXJNC2tk44VnTvsO+zm7QE6qqKK5/T
	nTcJ7lhbJ2imMU6HkRY7kaJRuk07F9FklleJ21RxDibrK/RxsFqwVD9rcy05m6EqSIfuK3yirDe
	9Zt610acfUAwNYyIlHm0l4TQgt9akNax4wbR/28dQhZvu1ZPbcPIy48GTiune4cb/1vDHrup5xQ
	vMLsYo=
X-Google-Smtp-Source: AGHT+IHiBn9HngbmdsHVaHzNz71AyFFON5MXvTeGVDEANyp0P+ad/ih5AFYj1IhsH/e8TOA3mV9ROV7IB+2ED1B0d3M=
X-Received: by 2002:a05:690c:a0ae:10b0:71b:f7ac:1371 with SMTP id
 00721157ae682-76403422fbamr1335107b3.4.1758727960438; Wed, 24 Sep 2025
 08:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922071748.GB2624931@tik.uni-stuttgart.de>
In-Reply-To: <20250922071748.GB2624931@tik.uni-stuttgart.de>
From: Jonah Sabean <jonah@jse.io>
Date: Wed, 24 Sep 2025 12:32:03 -0300
X-Gm-Features: AS18NWA23zB8EOREq2hphsEESOahf4RE5WskdZXU-bjklvzUoet4Qd0zG1dRywY
Message-ID: <CAFMvigdN7F20FiX0yVn1mcFp709Y8W6USyMBPDw-Db-mfJgcVw@mail.gmail.com>
Subject: Re: btrfsmaintenance?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:18=E2=80=AFAM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> In Ubuntu btrfsmaintenance is an optional package, whereas SLES has it
> default installed (at least last time I have checked it).
>
> Is it suggestive/recommendable to install btrfsmaintenance on every syste=
m?
I don't personally use it, but to each their own. It's really up to
you and your use case. I use btrfs to store media files, so read heavy
workload not much writing. I don't run balance at all unless I need to
which I'm comfortable with just doing manually, and I schedule my own
scrub jobs.
>
>
> --
> Ullrich Horlacher              Server und Virtualisierung
> Rechenzentrum TIK
> Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
> Allmandring 30a                Tel:    ++49-711-68565868
> 70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
> REF:<20250922071748.GB2624931@tik.uni-stuttgart.de>
>


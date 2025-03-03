Return-Path: <linux-btrfs+bounces-11978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F72A4C015
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF5A3AC159
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6C20E33A;
	Mon,  3 Mar 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOEC8dml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139C1F3BAF
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004275; cv=none; b=uhOEZwSqzwnSsqzHS+gRx3myggy0gNazK550x8frYaaTMjJ75dSb1KJtUgDGYvxJCLObmf8Nd7UoG6BB1+tiP4g9+LLunCwh+g+Lqaksh8g+R6YIL84iwcw9jShUMoSaaHNcalCpxgJ2Z2VrzPjAN4w5oWtzfDwS/QgtkXtfdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004275; c=relaxed/simple;
	bh=xvRkKNlGVIZ1SBfiqSHXhVg9K4uArKrEStM6IMbH0Kk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QXzlei8Dy51y1LcE6ORQ0VsCseluwSjQl4lqeds4urUTG/2Xj4JvJP9fdIf/TtVVHfw0GQHrDMMpcnmTArb+s8ERKaWNKTMHNXizGpejep0lkGgRQu5sI3sODpA3TYV/XGyWaD134GfH44ATw3yOlfxnHWO3JN1AYbFNbK2HONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOEC8dml; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4c2eaeddeso465197a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Mar 2025 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004272; x=1741609072; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xvRkKNlGVIZ1SBfiqSHXhVg9K4uArKrEStM6IMbH0Kk=;
        b=EOEC8dmlkk50gFAisdKgEsDysX61I4/3Ad/oyeqGlhkPrcXe06w8zf5eHdlHMOtsNN
         xcupw+j5jQ2CDYOZ5z4uQPnbwvAmqKUKsyuSs98MvunQatZU9Hr1p1PJL3t8FxWam8Rb
         iFGdpWUMR/C0Oie9SPhcEZkirx0GQjHQx/rM9qLkH8Vjgxofd3ylbBGfxV9D7bKEHwPN
         EeLs0EVmhU1QoiNPei+Rjky03WewF5mbKq0DY2q9HCUMJZx0hgQm+8eDbW6Ii9kY3odv
         1CKq7rkW9iDOiKkxnqjBdFB4CNHttkyTG6NSJg2BNOphqB25pEaw+RBNVYouBsV2B/Q7
         M3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004272; x=1741609072;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvRkKNlGVIZ1SBfiqSHXhVg9K4uArKrEStM6IMbH0Kk=;
        b=WrXW+E4EzGcoq9f+hgmuMOAFuJdot44L0xF27nukQakn8aoVYgrzQO/Rz9rNQZxuQi
         B+AGhiPLGZFtmYbNb5c5rv/KI+U3uTNRzuw0cgKhdaDSvSLoBTF9IqhKIvz8reoF/fCq
         n30BAvIvzQsnVSeUru103EowBJhPl0Nu9yGgajTv0GYpmqJfE9Y44MIdaMZDSYvoJ5PK
         Jasv+4X+cSa1e9TCOQIUfycRTxY6GlP8/UuInVsF0NWOmmmxxy/RRd4GM35YYCgnU6lZ
         BZkIZNRw2/dJWiPlKVPmDHN2QW0vlKsM5ei9sYK22MKnZIl/flNWR9enQKvvoOojYEyC
         yeRg==
X-Gm-Message-State: AOJu0YxQOEixZ/TsXHbnJC9qzsZVU4ZeJS0y4DHLx8UK5oVeewmn520q
	tJ7HBwjiLiZdbgrNNwmXYkvT1miSvyNDMXIhAdil/D4fY34b42JJgJUmHOyW1skNtn8bk9LMiUr
	61dXmGCE52RI4eFCQ3J0Bp6b7uowgCfmy
X-Gm-Gg: ASbGncsjjSW+g8025R4QFssurMMHMzVhCeU/7TExmkvnSncD6UCOGTWZtIqfMRqM4Hb
	rA378MY+enJuicdmm9Q6cxGMPOJHs46vQR04C0Ov451U8QVw8vlaZXMOsZXseFdplU39/SEY1Bn
	kA1SxGdAcM52/J1QlFlyXfZVgd3zL40qEjZgj3r0xlv/w4q7rOJztQ8d1Y
X-Google-Smtp-Source: AGHT+IEv72M9aUutie+YOFd8Bq0swINq6JrAFAZqQCZXBNauI+pQLYw4BdNDLzhIM2qoknliTptuzIX1Ezmv+LDxLGk=
X-Received: by 2002:a17:906:c10b:b0:abf:7a26:c489 with SMTP id
 a640c23a62f3a-abf7a26c674mr135040266b.9.1741004271840; Mon, 03 Mar 2025
 04:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Panos Polychronis <panospolychronis@gmail.com>
Date: Mon, 3 Mar 2025 14:17:40 +0200
X-Gm-Features: AQ5f1JpCGmfxMx8ssf6mCjHF7nFBS1bgQJ_EDWlI8KxmxFiQNcXna7rr1I7IfAQ
Message-ID: <CAEFpDz+R3rLW8iujSd2m4jHOCmHMCxe7OYDpohv16r=JJwbHSA@mail.gmail.com>
Subject: Question about donating to Btrfs development.
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Btrfs developers,

I am a long-time Btrfs user and greatly appreciate the work that has
gone into making this filesystem robust and feature-rich.
I would like to support Btrfs development financially, but I couldn=E2=80=
=99t
find an official way to donate.
Some projects accept donations via the Linux Foundation, SPI, or
direct sponsorships. Are there any ways to contribute financially to
Btrfs development?
If not, would it be possible to set up a donation system to help fund
specific improvements?
Personally, I am particularly interested in improvements to RAID 5/6,
native encryption (AES and ChaCha20), and general performance
optimizations.
Thanks for your time and all your work on Btrfs!

Best regards,
Panos


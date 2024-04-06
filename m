Return-Path: <linux-btrfs+bounces-3994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860389A841
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 03:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BAB1C20D20
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33017C8B;
	Sat,  6 Apr 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMYO4Hok"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169B1798F
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712367266; cv=none; b=ubohkDDInMQteuLsTKRJLJpNYdntvgfdlUnkOBWlFztEnkD2u//7cayhPahTAf45U4iw2cVhYZAcS4kIcpGI8w0FAAVVwEPhdQDfKgNNWTr6DDv+WSBrsXZ8ypNGYqq0bKRNd4rDLZH01OdujCaoN5Nj5ZR7QXJmPkjyLmQ0ilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712367266; c=relaxed/simple;
	bh=FuyTfp8jSGUJjwuT3z/3xS0BYxqaORGKl5cAYoOYsBg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OP+eHOZxVe3THlBaHE1x3DMWXUl+wpPpUB/9eGv8wAHrOoyiTgtV1h0jiD/uYg/+ab3aXrhOrMn2FfrxHgw8QaRXnKE39jMbcQqaAsijiBHU8jAiNh+DoY6b8O6mzXA1CTBzAtRbtEqFZOKG/QJlPLwLmBpHUUpmJmzzsIAapEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMYO4Hok; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430c4b1a439so15846031cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712367263; x=1712972063; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FuyTfp8jSGUJjwuT3z/3xS0BYxqaORGKl5cAYoOYsBg=;
        b=BMYO4HokYzNoiCgy2ppBlm2MCCM2g4dhRUneDQTKu7w2Fu92z2963YoaC12jNT/Kxd
         yd8bb9kj9MEz5bFa7uKsZgYRvyYA5tnp8ndYttRp7J8pDf4UCzU3lVBM6WVc6JxwK2ku
         qAzXyAIcyyhM8fKm/Ik1v84cJEpcbnJ4qgo95I91uD6V1ZZ6fAHOX+qxn5NQr2t9IJ1C
         1Lauivw7tYzPpxxvMqzGeN5i6JVRa9HUMNxwYvxvs1ZdzNrMtZnJ9n+l037CY021zsqG
         vTjIB6M2ZMU27AuTsL7/tpr7dZ9JE1PLFj/e+Ai3pGZLKfCeJXnbTWcyokfwdHNFerOM
         o8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712367263; x=1712972063;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuyTfp8jSGUJjwuT3z/3xS0BYxqaORGKl5cAYoOYsBg=;
        b=l0rJGg0WwDvCfhn5/z+vgXEaW3xIB0o1uZMwQxzD/x3AqtTazGLuBM+gzc3cFHYLiV
         r6IkODqHEGMV7uSrdOCkeRnw9uquHDkqGgRUiTAVY4RdWMZJ2Ehpg+VP/VjAH1EjfpMw
         CqBRqUcgVw2pWOm0pkUIfOAR01wZ4pg2MdJDkJdEQy+AdhEHqumIKEKFRVZ9c6c/KVOU
         X2E+Mxaskiutv1tbiPoe1OfTEAmLPl9gAwL7Nz6+JEaLlzthWWhLtuCzDsTkojn8ghym
         qdfuLt/pLxCg2O3GelhY6nzBTiIh5W8/4Sh1M8c3rel0BT6teWxJAoce4xWUIN68+Sda
         jmew==
X-Gm-Message-State: AOJu0Yx6U34maAepqrl5m+zeSfPxW2ZHeUmFhcmuTujNXGG+vgABeOQ4
	5Bd5LYC0YXjXss40fhAY6MC2vDeiTx0sJQvUnMgRM/qxZbJHXWePCXLU0MXhOeOQ9CM67JjIyka
	fSUqvkj73n/nWBR9jnoNy1uHA0+90uBur
X-Google-Smtp-Source: AGHT+IHmEoFpZlHtwzChFzAUHuEX21Lz2pfRfSbmw2H16FpdWoEWB0PKkd0bSXUV5c/dEdRoDRZPAmeJoU6n3unUCX8=
X-Received: by 2002:a05:622a:5b8a:b0:434:6fe6:17d4 with SMTP id
 ec10-20020a05622a5b8a00b004346fe617d4mr380705qtb.63.1712367263189; Fri, 05
 Apr 2024 18:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "David F." <df7729@gmail.com>
Date: Fri, 5 Apr 2024 18:34:12 -0700
Message-ID: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
Subject: Preconfigured BTRFS Virtual Drives for testing?
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I wonder if there are preconfigured BTRFS virtual hard drives setup
with all the various conditions BTRFS metadata can be in (leaf only,
max nodes, new format, full drive, etc..) for testing purposes?

If so, where can they be downloaded?

Thanks.


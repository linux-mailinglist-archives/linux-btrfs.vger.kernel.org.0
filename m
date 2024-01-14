Return-Path: <linux-btrfs+bounces-1440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9C82D168
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2705281ECF
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jan 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214F5243;
	Sun, 14 Jan 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPbuRlvd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB977E
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33678156e27so6831470f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jan 2024 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705249033; x=1705853833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJURNptZ9zA2sHXMhCLcjlx+1zdO2zRQHkb8PifniGw=;
        b=GPbuRlvdGeof6tDgIKMCY+JRNBIzqUTXZhhEafswtwLeO3QIPDAdrIL7HFsUsZEqA9
         wi7ElUeIFxXoCOIDOtqVNyxpvJbaBqmigJUPRwhskEyGyP16ht5cn5qkDW8wFONTJeKf
         FWtXwX4EZGJiJToFme7Er+xr9ZCz8rzxNXLFiditD+oPhUlar1r1Xc79ID8u/85+V/95
         0TNN7ntR5+Qi32yX2hTa17Sp1mV13RgNiFKqkC20hJqmQlZaJACH2rah4w70o4/Nv5vk
         60Jp/+kFYjaaC0L4BC8rmuOfGqzNQaCddiKk6aF5Ui556YCbtypqcSAD814di0CRoKSg
         hXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705249033; x=1705853833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJURNptZ9zA2sHXMhCLcjlx+1zdO2zRQHkb8PifniGw=;
        b=YBVJcR1Blg7p/mTvmywfyr8mVDybPqWWJnKBekAyyo/pijOPUOdQVdeSN8G4uXsdHv
         YzKXV3WOu3FK2Z5pUgdPfSm/15r2HSyMaN5hGWxuiG2czG1R2GF/qPMqMMA0XnUGH8BB
         voYRgPP+SzEQVY3hMjDWYNgcI8a80Qb6Q1ESKBuB+ydaB0eg7DusnwuxXaye0F72fwIr
         f+2uqs/cVWTGSfwosmqKIPHOAkXv8QW7QbH2QJkURIeTBnCqNRGZM4zoZ+sZAuEaAuUk
         wLfjiNxHvKH+LrJGYqHWh3mVItFvqveHZ1LC7nU0SqpLKKnIWsX7yAzMBHeEms+fTwd4
         mgkw==
X-Gm-Message-State: AOJu0YyqlIP+9917mvFuBA5Zr2oTWeCorNs9IiqQPn0k+QnXAZMNOhMy
	FlMl27fcdVLwp4U9gtZ3uDtwx+UIE+of35dXinw=
X-Google-Smtp-Source: AGHT+IGt0DWqzwO1mfj04M942UMdWRQrCrO42Fz0/AIJ/7k2YmhSRqyv1IV+VsIBMAwE6sVlcawepYULKLD1XKfZeeI=
X-Received: by 2002:adf:8b92:0:b0:337:6948:1309 with SMTP id
 o18-20020adf8b92000000b0033769481309mr2093194wra.38.1705249033083; Sun, 14
 Jan 2024 08:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
 <882254fa-47b8-44b3-91b5-20378aaa0778@gmx.com>
In-Reply-To: <882254fa-47b8-44b3-91b5-20378aaa0778@gmx.com>
From: Chung-Chiang Cheng <shepjeng@gmail.com>
Date: Mon, 15 Jan 2024 00:17:01 +0800
Message-ID: <CAHuHWtmwsTB3H9ALAq2O+uuGBiP3PvNU4b+K06FRLEkxvju-Pg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: fix iref size in error messages
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"

> > The error message should accurately reflect the size rather than the
> > size.
> I guess the second "size" mean inline type?

Yes. I mistyped. It should be "type".

Thanks,
Cheng


Return-Path: <linux-btrfs+bounces-1389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCD82A80C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 08:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE9B26ACF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F2D268;
	Thu, 11 Jan 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfWr4bCH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0ACA64
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ce4512d308so2355918241.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704957085; x=1705561885; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=deDJBbHmnqyvuNLsekvkRnBJXUbgEsh38zOq9BMzwnM=;
        b=nfWr4bCHv66/sKvIV8Oz6N5KoboZNznZOiFZlxHG+fQQfFl5Gq2zU2PUvi8UVug9n+
         CCWO+fa5HIAp7jD4WdEUWgeL4qIZVEkq15Y8xNqaqfuIC9yXf20Lm6lNeGbSJ2zlVaEV
         EKXWz8zGMVqsysDEHNWhMcmfCeLT9WcNrQU3p+LSSW9dIvG7xTTtmz2UaX4ajTbWPaR2
         yOJSO5Xg0SxXvJlWdiBnOkHgvec/SCViFOY4BEE6jixIw5lFLc9qP6JBpaFbhzMffJ6n
         HWHLFABNaL44jJFuMqUHQHp4ySFU/WVcTIHSYSx+c2k3H3juPhbhkpXE0/OoC8TxzbUM
         ey/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957085; x=1705561885;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deDJBbHmnqyvuNLsekvkRnBJXUbgEsh38zOq9BMzwnM=;
        b=jKiqUHbkMzQJK14CETMO9lvpZuUHPCZHOEeFW6LOt9LDvXypIYIZCWsT4bOeyI0DSW
         AcAqpgLfA9puFzEKdmLW03eQhlxP4ygV0y/Ecoa9Q+e9n3h2KaQ7qSB4tCsy/708N9NW
         rWz+sAeGWMCAP4tT4ex8T3sQRZIRVo0VufblEwj8uCV/Tmn/pBwRvwkhd8R2TnjsC4Al
         eXBlCDPYEjk021OhRfd64efE8o3gV0PqV3CoEcyy/jmjeFz3q77t9jWlp3Rk/hqMBMdm
         5TYcvkyERZZX/KT3Kn+kO6q0YKcP30S0btgOsN3iFYXL0QRz9nttt7RRUq1X58mEXC1Q
         hAUQ==
X-Gm-Message-State: AOJu0Yz8XgHPVBhw+m3tic+rLTilPL/sj9eVnJI7yC8Vvpu8Co7un+w0
	e+3Cs0uAkaSknQEsMOvcNo0zplQTDirClQHCvY5ZJT7e
X-Google-Smtp-Source: AGHT+IE+1aa91ad3PRxa2Jj/caarKAXu07wId4orkmGOY0PHFigsENI4jwX1BDM8kkJlJOcC8bHK6UtVYj/wIO0qRtw=
X-Received: by 2002:a67:f84f:0:b0:467:ff2d:cba with SMTP id
 b15-20020a67f84f000000b00467ff2d0cbamr56253vsp.27.1704957085210; Wed, 10 Jan
 2024 23:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYSWH2mJbnh0A16TXppm71PsYF1E9pnTw7Vi751hgpKufg@mail.gmail.com>
 <1606644.1704646551@sss.pgh.pa.us>
In-Reply-To: <1606644.1704646551@sss.pgh.pa.us>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Thu, 11 Jan 2024 08:11:13 +0100
Message-ID: <CAFvQSYSBEybShVhL49LJLwXa-K+RFWVgs56hgT0WEHij70sXPw@mail.gmail.com>
Subject: Re: Selection not "pushed down into" CTE
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tom,

Thanks for the detailed explanation what is preventing the
optimization and the view behind the scenes.

Best regards, Clemens


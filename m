Return-Path: <linux-btrfs+bounces-10652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569249FE014
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E65161D98
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73E198A17;
	Sun, 29 Dec 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IZjIdXqx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931D18CC15
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735494090; cv=none; b=ZXutWhxOKOpzJyGhmOIzFwBJqmyZhBcCoRxPNCwKtmTgAbTIsGe0n0ev2yQaOyh4LPeEF32xFRVBGUD8efEqsLeVmm+Wh11u1prVm9IS0FyBdJ7R8l6ytitmj7ApYcizcXYIiSgepULBOfvFAFmoelx/UVqRy1HgUlFmEIprGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735494090; c=relaxed/simple;
	bh=41Iy7md4BcJSLyuZmPq4HuRRcl6/JQgK+Ki/GS88/TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki/n9+3mnX9Lw9fTpup1jcQKeOGPViUHOX1hwZkUqQV/yP2ny8W8FVJNzTib5K/CEAdtUx5NXTp0pzBOMJOKrFxwXMPeusfp5cALn0a4YrjPheZeagw3wfGUi5xHYNzcQJrqo4IokyW/rJcPff+PtbqdxwLBkEpIzfYAKPryY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IZjIdXqx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaedd529ba1so720116866b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2024 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735494086; x=1736098886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nolazxxp7b6Zr3FK5kXVhg3LGs3WjnDcDtTtdsyNvzM=;
        b=IZjIdXqxh3fP9MIhEQ6/l4Q3OlciVagdx+kQrFIxewq3qASFE2wsOOdbAq3LohsV86
         DTaXqE1GXNjZeHfo5tZ7DB2gvEy446af9sv4W2yK3/d/Xj0RnUx9jDuYJy58M1i7fAj7
         tiCOhWN4BrAjX8+UAhByRUI9BakaXCm1fU/EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735494086; x=1736098886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nolazxxp7b6Zr3FK5kXVhg3LGs3WjnDcDtTtdsyNvzM=;
        b=XZfCwtxawXHNBRu0Svos2TJUiJJJ0oh1NjDx2gGlx8KKwipqDWV1KH8sDs4FK8qu9l
         20c4CxgUvcgTw5NZATbkivAIXm6CyKi4EhjF37SqCU53ZeGW2vpD5zagWHH340gBhc/q
         hDf19DmriMLWfV7G41wpIaSxfs1XWlmQv8SAwneMavNvduALZzDiMpIwDm3P1uNO2LgA
         zZa9xQ6OqdEH+LrFPl4HxVG350gqCWN5RQOe/0masr/UFEJ/NWeZGPiEx1FCq00UQOei
         6MrRjsQ5yHg0yaR+fF/styulXVUy5ic7a8cfVylaptXPw+FGGXFXD1b2amatloTBfeOL
         xWJA==
X-Gm-Message-State: AOJu0YwgEmjkrW0PfEXrdS0yJvylA6FTABjZlTbty3uVQbp6IazbaGc5
	XkAbj0WBKiOLGF60yxuPtNm6yald6nwmSmfKUKXkD52u70r4O4FkIWFaWItjNsyBS6rAX0OUfia
	edCk=
X-Gm-Gg: ASbGncv1MJf7n8w22W1k01cSpfOvT8sOr3WcUHkGnQA77JvE83x/J0v+2T7EUlz6k9/
	7hUjr3PSJlcN4AhjMgDTEwg6SEL4tL2FUh4v0xyHlcjOTftKd58O8lwrbi6LYkaAmmEQsF0tcWS
	8+pvzHRzFoEF2aXdo2QsgXx5l8VR2k1yRfSLTc5QPN6vCJUHNxywABXqSqXu86PVt8YjtzOMyqp
	6bKOv23/802u4jVZPrM+O8jLcDHv2lad2J1XClZTzfL9zCLiGhnORbucgO67o+vi+PR25JQNlxE
	PoMYHnVBkRUxKuIJB86QV+rKeVDvsT8=
X-Google-Smtp-Source: AGHT+IGokgBVOl24pyctkZVyuApDeer+njvuaqdkKS/RtYaO8S9gNmFOXyrXYA2cT4MVir5tnKOqlg==
X-Received: by 2002:a05:6402:4405:b0:5d2:7199:ac2 with SMTP id 4fb4d7f45d1cf-5d81dd83e12mr78032458a12.2.1735494086355;
        Sun, 29 Dec 2024 09:41:26 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8dbsm13577400a12.40.2024.12.29.09.41.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 09:41:26 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso12166497a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2024 09:41:25 -0800 (PST)
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d81ddc09abmr78244470a12.18.1735494085046; Sun, 29 Dec 2024
 09:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735454878.git.dsterba@suse.com>
In-Reply-To: <cover.1735454878.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Dec 2024 09:41:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>
Message-ID: <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc5
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Dec 2024 at 23:40, David Sterba <dsterba@suse.com> wrote:
>
> - print various sizes in sysfs with correct endianity

"endianity"?

More commonly called "endianness".

I left it around, but I really don't think that's a word.

              Linus


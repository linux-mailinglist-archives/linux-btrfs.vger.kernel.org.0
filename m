Return-Path: <linux-btrfs+bounces-1373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD3829F44
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E0C1F297DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A44D106;
	Wed, 10 Jan 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZxlPX0uB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B84CDFE
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso491323066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704908086; x=1705512886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/49oXKnbPjZF5ZGzYE7U5F6wOvnnpExXGG3oQotPgWM=;
        b=ZxlPX0uBFLqfUVhPHvPB16d9tub5EwmOi8SEPACcteE6p1eu1yMgdwQxPAWtxuQa12
         HRsBRDpt28Y2rfx+c6jzjJiNqxVy4zjoz1sHhnk9gtR1VSPwntsdzuOMysWfBbiKkilq
         h/B3+bzPnZOIBx7i/eBCH7O++fbu72kiKkFBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908086; x=1705512886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/49oXKnbPjZF5ZGzYE7U5F6wOvnnpExXGG3oQotPgWM=;
        b=V1nL+JFXP0phbylbGT0azZLn23HSd7uEBLii5J9/gcOdI5gBT5mRuXD75GJLN0IDUI
         EV94PJuJC7sBGz68Cp2HjXK2hTJgC+KXNUji1y2pVpl4jer001TWBIR34nkkqysnUXVc
         8ZLfEH2TbTSSrIfFGgCP71PPmWI4tai8PGaoW+Wwvznswh8mE/T0KlSqrhiuKCUhJHWi
         oWSz7TEiH3XWmKN/Q/6wpdBL8Fw1B+Qwa7hx1xopVpP0VEsH4XM1rzuqJu+EGYyEeRrW
         g2hbwnrAixGS3NQLKvA+t++yQFjgXI5F6bu8nFgYMHntkgVcORmSafsxB84qo+C34Bj3
         WMjA==
X-Gm-Message-State: AOJu0YzoLzGz1vPF7wdKxFHh6zya6lnzc2hKvEtcWjzvGQjIjfXBpItL
	hvwvPZF7oM8IhRvtUmBSVNdYSm9i6qJYRPqBZochsq1QkWXddg==
X-Google-Smtp-Source: AGHT+IFkeDCj8hFETNvGybtPvLkThJyUtKigw3WI9l+8kkPxdb04x7n6yg8364eoe7PvfKs9F3RkPg==
X-Received: by 2002:a17:907:2689:b0:a28:177a:cf0a with SMTP id bn9-20020a170907268900b00a28177acf0amr1126424ejc.82.1704908086443;
        Wed, 10 Jan 2024 09:34:46 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ko1-20020a170907986100b00a2714f1ba8asm2268439ejc.160.2024.01.10.09.34.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:34:45 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2a225e9449so472110266b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:34:45 -0800 (PST)
X-Received: by 2002:a17:907:31ce:b0:a26:98a1:9e89 with SMTP id
 xf14-20020a17090731ce00b00a2698a19e89mr1099695ejb.41.1704908085231; Wed, 10
 Jan 2024 09:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704481157.git.dsterba@suse.com>
In-Reply-To: <cover.1704481157.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 09:34:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
Message-ID: <CAHk-=wjju0S87C+pdF=0i0hVky+HeMj1xVFwUdV867YoLheL5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.8
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 11:04, David Sterba <dsterba@suse.com> wrote:
>
> There are possible minor merge conflicts reported by linux-next.

Bah. The block open mode changes were ugly. I did my best to make the
end result legible.

You may want to note the btrfs_open_mode() helper I added and possibly
do it differently.

                    Linus


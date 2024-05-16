Return-Path: <linux-btrfs+bounces-5050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587298C79A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134002847F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5214D458;
	Thu, 16 May 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YCZ862VA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B741DFD6
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874492; cv=none; b=TjYonAXIGzaL+oIMJqeBc1AzLDBPv6oaIf6JaZkcG8q6HP2We1ezUiYDrStNpoEKHOxHqhcFMN+76qxbHIRerFZ6A0Ya13LkdPfhgiWiaSk7UA7NTcm/Jr1XTjrkn0eeUTHW77UUu9FcV99WYe5EAHZgUZeyqy+F/tY5aOg1jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874492; c=relaxed/simple;
	bh=RZiPgzca9nwRTHTXn6EH2+cSL8F1AcH3O8sQBRT+8O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCq6zNzbD7fE9r/eB06oaSgbVQpWFB3x9R2cFTaOzlqwSrhAaopuDN4MzRi+gE++ftxjk2CoCpIymfeJPRPoUxh8tZlwv+tsWlLxJpAy1HZfyStBNF4E+sOWeC4RXhIWr0YzU0AbEURD0sRlXqhJ+8oI0tXFZ6buXCrIqxpTLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YCZ862VA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b178b75bso278968466b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715874489; x=1716479289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BftxJmB2CreY3+o2q0X3TymOit6faQaIr4Dqh2PnWeg=;
        b=YCZ862VAMeLFnCRZoBg65Mw8ks76lTYZJy+uZwFNJquNeby15EV2i1Q/NA5MiBOeIJ
         9RmgfdABPjxTNv+dPpcK8pzkxMPEIvO+qkAQMpf2pQxgiYeoNVlpoNmuU75M6Yo2NQoF
         IcAgrbXgmlw9uk1eexdXgRVZ9UNjrV3nvJ8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874489; x=1716479289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BftxJmB2CreY3+o2q0X3TymOit6faQaIr4Dqh2PnWeg=;
        b=MY8Us1/dTBu35yUzWXbAkceRdUmw7BnuYZtld0zPrlnjrpZtO1vQy645FulXduuT6X
         hyapkddTVoN7RWpC74IWsAsKIUPY/X1qX+yUx+lhpaMeutXBDtDRYm4dN16dySUUYIh+
         LHPonxeEjF5JVix/KJRODQ7dgQUIYhe6ULQybuxYUtFiDxVMgzBDYS0gsKweozBhCZbJ
         Lj/gBHx3zaT5fD8kqhZHJxy1ARAvyEGWh16nMVsHXVcZkEF0GAaiFbo4IX5A1ULKZUNM
         KONjimAmr+ruc7A7pQwa/u/oiElUnETA/9cZouQU3OacqJFYAQSDH9KRdmJaK3k0pkvB
         jgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJjxkSLcXVpLZwiZ7VkR/zF4T6BiwK10Iq4dUinSIR17Lx5qzwOQyyKHLZpdvbTB3BeVMFAt/sXf4mkp5ifrtLnPnYNKrQABPdAI=
X-Gm-Message-State: AOJu0Yw4yMukSlo25wMnTeqHnY4ojcpQXZDnrWTrPNGW4yl7D0/e5og0
	H+3F3VUD7L1jNaJj4+6NdbdaluarnRtkL8G9PudRpGy5SMBS13VUoUtKh9sxU6YLntUPepiEPpj
	D5AiYyw==
X-Google-Smtp-Source: AGHT+IHsvqkjfIMxeiFVe7WuH18sgNB9vMu8bawkQ8A1Bezvb7JEjltp7hMx6LDQjxDBNYSFf9a2pg==
X-Received: by 2002:a17:906:7f13:b0:a59:e4cc:1c88 with SMTP id a640c23a62f3a-a5a2d5eebe9mr1357881866b.38.1715874489021;
        Thu, 16 May 2024 08:48:09 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01472sm993812266b.159.2024.05.16.08.48.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:48:08 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so3219874a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 08:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2ZkVlJyLrXabA5LS7se21sZya38ebW7rjE4eCMv6ix3JLiAasdp3AKbIkXSMMBeiUv4lLjGW+A4SQmPUNgQ1fLxde0vyP0kDzUuI=
X-Received: by 2002:a17:906:2708:b0:a5a:84c8:7710 with SMTP id
 a640c23a62f3a-a5a84c8b9eamr575885166b.55.1715874488199; Thu, 16 May 2024
 08:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715616501.git.dsterba@suse.com> <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
 <32730052-b40e-4262-a1c4-0d45a9b6de53@gmx.com>
In-Reply-To: <32730052-b40e-4262-a1c4-0d45a9b6de53@gmx.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2024 08:47:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKp4Scs_9zE0a5Bh=tFYuzaaE7q9ZJ8X1n6RsLcZYX6A@mail.gmail.com>
Message-ID: <CAHk-=wjKp4Scs_9zE0a5Bh=tFYuzaaE7q9ZJ8X1n6RsLcZYX6A@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.10
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 02:02, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Considering aarch64 is going more and more common, is the workstation
> also an aarch64 platform? (the Ampere one?)

No, this happened on my regular old AMD Threadripper.

                   Linus


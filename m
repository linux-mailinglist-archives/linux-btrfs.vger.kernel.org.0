Return-Path: <linux-btrfs+bounces-1735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD283B22D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 20:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFF228D72B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0C132C34;
	Wed, 24 Jan 2024 19:19:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC424131749
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123961; cv=none; b=Un0Cyy6BYxAnTqxu6gUWODn6G19vZA6B89Pz7eMk6LoHL5v72kODvB6xaWkr5GGHo9kOh3KlmUmhV+8aBvxWTDgj0ZppA/KNAWWT5A1QXNDBpsVOkcZ/jyXja2ytw8tG2c/p7WKUOfPBE3T/MLoTUaXTHUFE2fHN9EbEWdQlTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123961; c=relaxed/simple;
	bh=FpyoHUfgdG07j5WJnIH47NGhSrb5TU1PVKyz+0Hslu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja7WlMLuDDxZp61SLEqZ6mTCX6K9dPdN3oYBhtjCbhBzku8JyqOFoL+wCspX/0lI2fjyMFppKhfR52aokAweIPqM11qp3KuUM3HS883a/qhl4P2zQlvAYTik5QCcDW9fQ88/zUKsFzNEfUGLd5RTaheRBgnTPMQ33X+MAQhecEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a45a453eeso7574988a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 11:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706123957; x=1706728757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZn7NrEg6WObcCMQAtWnAqObSHnMRvMqMrwD0XTBr14=;
        b=F9sDOJH50YwsKN6KW3etNnu0joShrfY2fgimzaOr8eR9CO9QGPPQbks/39KXldB0io
         uvBMsbGIH6AsMiq4CrlrNUUkpHEH1MwTA5YXwwmWIJbKH2PgIGPP+Udc4LoKyGsavkxb
         x6PGcNe27uPa4FE0kGVr9+P+Tl37mR+KSgAIsdglHqVEJXzk1g6Dqb4tMjOHxxZPNx1S
         ZcX11q7EBFJW7UqPl2sRRT6hICjvFXy5t2BBE5F/jnJjSTs7x9pj2AfeNLExJZBEx94F
         ujMeGesAeKnka2wDxschRX4C22MsgbSd7ymfBiJPr92HOrttCfHs+DgeETKZX8EfPS7b
         ohTw==
X-Gm-Message-State: AOJu0Yx02OpYm54YRQlzU1UOjV1NueZl3sWAxjKAp5DrjgHF5+H7aXfZ
	u1Pp/UktWfGHfTMaYG1m5M5CuO1nStVdZQfpEmPjh8zHUO/QeCuGmX27rzB2r8zW3Q==
X-Google-Smtp-Source: AGHT+IGEBKGp/1AP5oLxWDLVn93yaNmLzgAZSOrdDfd4kei/GQJYEwpJbnJp3sSkAi6qhmT+oCXhqg==
X-Received: by 2002:a17:906:3e53:b0:a2d:79b6:bbeb with SMTP id t19-20020a1709063e5300b00a2d79b6bbebmr1152021eji.66.1706123957216;
        Wed, 24 Jan 2024 11:19:17 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ex16-20020a170907955000b00a2cbbebedc1sm187152ejc.53.2024.01.24.11.19.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:19:17 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a539d205aso6543038a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 11:19:17 -0800 (PST)
X-Received: by 2002:a05:6402:2811:b0:55c:9c81:9a36 with SMTP id
 h17-20020a056402281100b0055c9c819a36mr1661915ede.68.1706123956936; Wed, 24
 Jan 2024 11:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706116485.git.josef@toxicpanda.com>
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 24 Jan 2024 14:18:40 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8E9HMZKeSxPY35qjTsq0rZNx3fSq1Rzi-fD+U+3oOZWA@mail.gmail.com>
Message-ID: <CAEg-Je8E9HMZKeSxPY35qjTsq0rZNx3fSq1Rzi-fD+U+3oOZWA@mail.gmail.com>
Subject: Re: [PATCH v5 00/52] btrfs: add fscrypt support
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:19=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Hello,
>
> This is based on
>
> https://github.com/btrfs/linux.git for-next
>
> which has the recent pull from the fscrypt tree.
>
> I've reworked a lot of this to incorporate Eric's suggestions.  There are=
 a few
> more patches because of bugs I've found in testing, and I've disabled a f=
ew
> features, namely RAID5/6 and send, as they will require more work to supp=
ort
> with encryption and that can be done after the core work is merged.
>
> Thanks,
>
> Josef
>
> v4->v5:
> - Addressed all the comments from Eric and then reworked the rest of the =
code to
>   handle the various changes.
> - Fixed read repair.
> - Fixed log replay.
> - Disabled send for encrypted file systems.
> - Disabled turning on encryption on RAID5/6 file systems.
>

As long as we get these features back soon after this is merged, I'm
fine with this. It's important from the Fedora perspective to at least
have the ability to do blind replication, so I hope it follows shortly
after.

With regards to the RAID 5/6 modes, I'm somewhat okay on sitting that
out while the rework to use the raid-stripe-tree stuff is in progress.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


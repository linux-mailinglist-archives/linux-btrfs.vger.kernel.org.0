Return-Path: <linux-btrfs+bounces-2804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AF867B14
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3172C28B681
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7B12C528;
	Mon, 26 Feb 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="cL4BLjjy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871B127B4D
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963452; cv=none; b=N1b/lF8TUt4gksX/2ExJ0FHBV2lhjWc3LLwaD3k3Vqdoobz17mjmzTprTlQao57dsF0AzOkXARXoe4qZGFluM9+VHfMShk4mlTlV/EE+E/q/9VLQWOK1RorwgO37VuhJ6bk4sCYEecWzkuKzmZtQ5HxalKlzop3lUSD3Cm8j9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963452; c=relaxed/simple;
	bh=BnvjbNnWQ7UjFwNG4TsSY2AebliOt8uAlscZ2bD3Crc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0NUW4geZ2c12qy/MpXuEtId3RVjyDcM/XJEJr3cG6+eDjsRDroj596Y3mvEAZaieoOZTwpbf2Z1+0Qr7CxfesLCSCCOIlj8bYYWSCF7xHInBvLsvwzdjtJqnVRuhtVgz06lMzACckr2GcOJZW6ODZYRByAXN8nidwHVvU4THtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=cL4BLjjy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6901a6dca63so752456d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1708963449; x=1709568249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuMI9kyxL9VCGo8QTqJIWUqrn9iGHxzKXHhxhPVqan4=;
        b=cL4BLjjyMJZv6wAxlSoezlFVBUgZrsTJKkk/7NraPiqA4jL+c9VI0D+08mIogYc5KA
         CJTv/jTmEdAIsCZPfCJorLzoF8rJ5lDvU7T7Nmk0ru7tjZGA4Bwp/Md9tLgFTbjpVND9
         CbQkBTNoi7PED9m1U9tbrndISqvmCZMGueVb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963449; x=1709568249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuMI9kyxL9VCGo8QTqJIWUqrn9iGHxzKXHhxhPVqan4=;
        b=QUnSDc/UpjlxPuZrZNk1ObV6yz7Fo3BCRKc3EO7Ldf0/S2MMLoNG5pLWkaZhmwsQ+R
         jBB4QKvvy+4oY3pevfzxR1YfPbLmHlzz6b/g6q15/NDn83f7uUN/deaE8tNKbkAfx4o6
         BT9JNlcjwmsvMFlUSyS9bpNt5Zh789c4rddkndYCasfYPoCN4GtxkeMZbPLxGZ6Ksvkz
         gafdKBIyr/CqPXNZuLA5UtQnmmsQ6rvDZKBy1KZLxsUHiZYwQhE0VfYA3EhLE8boXsR3
         AQEZ9XzVUdEVxo8zBepdjplxo8Qegf2We02xvlsFTv2gCXMVKozzstJQivjrnFhTmbOb
         sE0A==
X-Gm-Message-State: AOJu0Yxr7jqbGE8b4xfyPvgwjqOvxVNcLf2uRcjFc1VyGIHAcneX3jGE
	CQpuAdNa9Ls4Y5wTYFlXLvq+D8aBWn778yhHOjx8iYkuCPbkrxr6LViBFQOiUQzLjQSD0p7G5UN
	Sp0VkLhYZuQJPuUxv7CSxZ42mfcU=
X-Google-Smtp-Source: AGHT+IFpt5Kyq29CaATzr5N319BqyNYn3W/ba1yPf0oS8/HK1hYpD0XD6AkPek7btMHq9AGn9NkLRBr/IhBKPptaFHI=
X-Received: by 2002:a0c:f504:0:b0:68f:ff2f:6a8d with SMTP id
 j4-20020a0cf504000000b0068fff2f6a8dmr3611467qvm.19.1708963449260; Mon, 26 Feb
 2024 08:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
 <20240226155301.GF17966@twin.jikos.cz>
In-Reply-To: <20240226155301.GF17966@twin.jikos.cz>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Mon, 26 Feb 2024 11:03:58 -0500
Message-ID: <CABg4E-kf+Ofh8bBBeJXt40o=sd0zXq0GQ0JZMKVS9=b3DXvxgw@mail.gmail.com>
Subject: Re: Corruption while bisecting (was: [PATCH] btrfs: tree-checker:
 dump the page status if hit something wrong)
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:53=E2=80=AFAM David Sterba <dsterba@suse.cz> wro=
te:
> On Sun, Feb 25, 2024 at 02:30:22PM -0500, Tavian Barnes wrote:
> > Well, bad news: I started bisecting from v6.0 and after a couple
> > rounds, my root fs is really corrupted:
>
> The span of releases where you can reproduce it quite wide, 6.0 until
> 6.7. I think there's a possibility that you hit the new bug in 6.7 and
> the error propagated to the filesystem so that now it's detectable on
> any lower version too.

To be clear I didn't reproduce the bug on v6.0.  I did still see it on
v6.5.  At the point just before this corruption happened, I had marked
v6.4-rc[something] as good in the bisect and was rebuilding the next
version when everything started dying to SIGBUS.

> We have only indirect evidence here, 2 reports of the page reference
> counts and all in a short window after 6.7. The lack of other reports
> would point out to either one time damage or some other factor like
> hardware problems.

--=20
Tavian Barnes


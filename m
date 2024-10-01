Return-Path: <linux-btrfs+bounces-8399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D898C43D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8178D1C21867
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D81CBE85;
	Tue,  1 Oct 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iait9Eic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D511C9EB7
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802636; cv=none; b=JrKdBACDXfDTj00KrfceQYQajrjeLR7FvUbHVadNMYy2dzeep+2AGX/Kl1vuNBEyeM0rkcdPT/b2GM1w24bzlD3Vvo3ByYQB9WNPkSZ8s1aN2E9SD1Wd6xrb1/c6tg3fqICDnrVF3DaWiz6PmMr4VWq6XwsP6g/NODRMdcRSyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802636; c=relaxed/simple;
	bh=u006EqI/YE+KIWfIZ/tOqLIstUkwxM9g3AX13A4I4K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCIr1vL894sFI+7dMbWjP4Ew6ZLpnanqShNR0tWZbQVGbG+cPBBOZDW7YnLQEwr3i3F3oZtSVQyFkTGvSCFidKTkIkZEmrXtH3Yukp0C7RnRiUaiMVnz7wwUJNQgOETJgp+PNcKvQzHpkwRXISMjaTT2LtXyTW/eGLJCopWRsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iait9Eic; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf40737eso26391561fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802633; x=1728407433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoefjqvRzu0POcUNry8HhXJXw+eIv2EOgog23QL7O64=;
        b=Iait9EicfZBfVl3B+lpuSCY1kgAeYd74LCLrnGDhLqGPAOmbsvcoehaTdld2yb9llO
         0Z6TP6RyBbltYFndEwdZw+MKNYJp1ZWDLHbM6MqIw7eO0lWd559VQQARHcGtB/wW6jcu
         fMmZrxMoDJOoqKzZvpiON5I4YM3B/QWVVJtQyJqp+qovMopmcvfQ+/Rosedwp7qMOdPi
         yHC+qoYQKVEIuv1msfB0x0Qdkc2pfm00JwXH8kvVdKrcA6+QzRXzn73h41+rkoDiWWPo
         PfkcnIuo10tB91rGXCVvZQ9fftor+EObXLRQjhm33j7Wbt+a0+L+nIEl/Msd+IyA95md
         CtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802633; x=1728407433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoefjqvRzu0POcUNry8HhXJXw+eIv2EOgog23QL7O64=;
        b=vxJLDsAP0qMdLJqza92cCjTW+WBk5EdCydwOhb0NGFDzDVntBUbJ6W2v3sQD4vZkaM
         7j01RmAQuZp/U3ISecN3p8Ng0tPJH4Md0izSUmhQCWQEYBArqHUchR4A/QrG3VSyhcmG
         480yur47V5DBagU2jVXqdC+RptcxlDnNejoBfZM1Pra9RGZ3xU7SB81BIakd84HJ4p4u
         U1fC8zi2MMo7u/8/f7+6RFC6bbso3A8VUKZjsffh7yq4vj2kKL2E6M032y6bxkWooW1f
         3q18597Fc5J6wDJAvrh2LUt78XHfY3O4rS2+eStp4Zwc+Pa8ui59ggfMgFqtSwx5FFYw
         mhkw==
X-Gm-Message-State: AOJu0YzWyEypVLiq1PfSwJFvW2ieoMJS37FsmEhDArf5hK+BtwMr+UC9
	28qrbQZ9sORs2H/qumiOeC3ZxUiEpv4X7mQa6DgQ87AlfcrU7SG5oxmGAeKY/hXnB2HpH83H2r7
	g5aaPAcmAXxZurnE09/q9HT7tqOBF96zZJrY=
X-Google-Smtp-Source: AGHT+IHvD61F9br9ze/8JXjxD9RbvWIkttp1G/A2HHC7NINR9d57OG1Tmq/zVrP4GRIa7dubgIn5EAEfLqjTy3KLing=
X-Received: by 2002:a2e:6111:0:b0:2f3:b8dc:7d24 with SMTP id
 38308e7fff4ca-2fae1045621mr2762521fa.17.1727802632368; Tue, 01 Oct 2024
 10:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
 <20241001150941.GB28777@twin.jikos.cz>
In-Reply-To: <20241001150941.GB28777@twin.jikos.cz>
From: Peter Volkov <peter.volkov@gmail.com>
Date: Tue, 1 Oct 2024 17:10:19 +0000
Message-ID: <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:09=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
> On Tue, Oct 01, 2024 at 02:15:51PM +0000, Peter Volkov wrote:
> > Hi! I've been using this system with this kernel (6.10.10) for a few
> > months already and today out of nowhere btrfs broke with this error
> > message:
> >
> > [53923.816740] page dumped because: eb page dump
> > [53923.816743] BTRFS critical (device dm-0): corrupt node: root=3D256
> > block=3D1035372494848 slot=3D364, bad key order, current (8796143471049
> > 108 0) next (50450969 1 0)
>
> Quite obvious memory bitflip:
>
> 8796143471049 =3D 0x8000301c9c9
>      50450969 =3D 0x301d219
>
> The first one should probably be 0x301c9c9, but it's impossible to tell
> how many other data/metadata could have been hit by this or another
> memory bitflip so check can detect the things but not fix.

Thank you David! Is my understanding correct, that btrfs catches
memory problems,
so this bitflip most probably means that my drive is failing?

--
Peter.


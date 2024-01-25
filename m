Return-Path: <linux-btrfs+bounces-1765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CA83B856
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB412854C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 03:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E257475;
	Thu, 25 Jan 2024 03:33:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6A6FCB
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153616; cv=none; b=Jh+HOfjTHa4y4rDMzbjsUOG7kh/PbOdidu9dOvYUVb9XLwtUv82xJZoLsmz8kbVpMsstKGyDS1w0OIuFZp6IO9ARXa6JGvoCvuiMxN/n6UO0Z1GwV7BWlC5KNymtQFB26D4vwCUZ2P6pfvAIrEu1wLbYCS2BT/i/38IFq+YwXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153616; c=relaxed/simple;
	bh=0A1Sh+41bYfAI2KHIhZTf5XhMD2ekPaMO6nCd2OrL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTZzXDrX7R5trMTC9EjpXfvHDK0+9qlQqHhzZCl3RwJZ3TwnYwbK5RhN7iGnPtZqrwBIbagRC3TyS14cH9g4G62s4qyfXhCo7lZwGeDjrQVAeELwcZyhyZkAvbOhmTHWVzhfvkXT01Hx/+g6D29/QdD8LuN50lFrH99guUEdixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so66941311fa.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153612; x=1706758412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A1Sh+41bYfAI2KHIhZTf5XhMD2ekPaMO6nCd2OrL7M=;
        b=hRyY/fitTnVm62tHufY+ISDwrfX3ZSv8XUD3pzeOyINu9fp0C4S9ALGIgntpTk7bsE
         qpcXJ+3gptKSPsJp2+7dOcAhF6lYYxPSEyjRf67W010369oabj6ltwUHA5QqkEEKmXpH
         c/hfNNrlRr3z2QUtJBS3SNSrmD9MZQmTjkUsKJH8j9AO96Vf6+CdrQ89C92lIdWMouB5
         QVrHH7FxYvKiVDQN1qI212p0xvZMkbexPNueyQtP6G0o3y4Hvnswql9T5v4MG8SWFuky
         6QXE9tu4El1Kh+JvPwEGj0BcX7NW6dOR3w0VuKLQOjCscKxahXevvEf47WzhzAW8LAK+
         Z9PA==
X-Gm-Message-State: AOJu0Yy+nEfjmNVgRADV9jSh9f0F8qwXt465VjjG50RMQV9mHV58+bJu
	5vkZhf8F3kUaf43pLypmnWo108GMcnCvCcq1nqi5ET56K2C/WHVxc7kBK72zA+DqKA==
X-Google-Smtp-Source: AGHT+IFEtSiMrTaTWgtnPyBNjgX14cYTPJgCIgQwmjeErAkKF1ulsLrZ6eXYGwNkPMTXYdP+5/ccGA==
X-Received: by 2002:a2e:80d6:0:b0:2cc:df53:5322 with SMTP id r22-20020a2e80d6000000b002ccdf535322mr130874ljg.61.1706153611969;
        Wed, 24 Jan 2024 19:33:31 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402151000b0055c0167eb9fsm5257473edw.51.2024.01.24.19.33.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 19:33:31 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55d050d935cso29601a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 19:33:31 -0800 (PST)
X-Received: by 2002:a05:6402:3418:b0:55c:c9f1:c797 with SMTP id
 k24-20020a056402341800b0055cc9f1c797mr182400edc.32.1706153611519; Wed, 24 Jan
 2024 19:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705711967.git.boris@bur.io> <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
 <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com> <20240124163649.GL31555@twin.jikos.cz>
In-Reply-To: <20240124163649.GL31555@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 24 Jan 2024 22:32:54 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8tyVCw5CnMiPfWC9td0FaOKTkRxVg4wQyk8TiLT2SPwA@mail.gmail.com>
Message-ID: <CAEg-Je8tyVCw5CnMiPfWC9td0FaOKTkRxVg4wQyk8TiLT2SPwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:37=E2=80=AFAM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Wed, Jan 24, 2024 at 07:52:28AM -0500, Neal Gompa wrote:
> > On Fri, Jan 19, 2024 at 7:55=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > This leads to various races and it isn't helpful, because you can't
> > > specify a subvol id when creating a subvol, so you can't be sure it
> > > will be the right one. Any requirements on the automatic subvol can
> > > be gratified by using a higher level qgroup and the inheritance
> > > parameters of subvol creation.
> >
> > Hold up, does this mean that qgroups can't be used *at all* on Fedora,
> > where we use subvolumes for both the root and user home directory
> > hierarchies?
>
> How do you imply that from the patch? This is about preventing creating
> the subvolume qgroups, i.e. with the level 0 and referred to as 0/1234
> where 1234 is a subvolume id. Such qgroups are supposed to be created
> only at the time the subvolume is created.
>

Because I don't really understand what the description of this patch
implies. It is not clear to me what is actually changing here, that's
why I'm asking.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


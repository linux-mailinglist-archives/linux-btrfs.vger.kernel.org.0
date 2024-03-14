Return-Path: <linux-btrfs+bounces-3307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8743787C2ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 19:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95FB1C20AFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1D76023;
	Thu, 14 Mar 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="NY4rehAp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D374BF6
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441760; cv=none; b=b32iY3KdBPP2KJnxzmpxOMMgC8aBcXOp7xiFAnBFpB91WFHhE3ZjzVL08X2co0gMWh7enMjsYBhib2HgxraC8nFActRuYPPvm7QKiXpRmEr+TxBxtaKNRCi6l6ti3Ip2AVOmnCOv2eu7EA04j5HND9A004c7a898Aga58x7VBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441760; c=relaxed/simple;
	bh=+wvb+UNzpRiufiJpUrI2SQFUmH98d+826qjiGCqM8vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp9a5AdyXRWFGhRPhjsUWySDDpOr/W8usnVh4U4tzrJnGV0ljo6P7tUg0yPDYvZ9JY8Cwt4loo6S18uM+7pk1wH8dM9ZJFGCCOlW27V41d3yeGCA/QFRm+rEq64evpjsArxOijlK/lko6JJqAzQCMR2ckmfC2MPe7ipLuNZucrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=NY4rehAp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1e6c32a55so693623b6e.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1710441758; x=1711046558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkkoNL9GMnGnY3KYiUbME4aDmbRU8HEVbg3lppUytIk=;
        b=NY4rehApxnobsbw9D8zakpRBBC9o3/PjvUbb5G730m4Ck1GXxGtRTb8yh4xG58ltDe
         wl9UOUOERFujW9BMvyHqQMwxDX/7Sz81fkjTMbyQHih5G/mt2qI1w/z18psIx74zVRG7
         FjQvAUwRi7C6fDn5k6Di/AXDxLcyeSEepyIlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441758; x=1711046558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkkoNL9GMnGnY3KYiUbME4aDmbRU8HEVbg3lppUytIk=;
        b=jKzMx/sHAzQbHUleseMDgED6x7xxiUss6DPdhLqddYPwqTBnJoAl7RjkOPTc2Gu/6w
         syT5QeBKqnTH6NgYZU3lHlQOGbq3fScNLT0UN53BVR0uWUwddccfhtE2C1i/QNQmh/FG
         c1xGgQssRMaEVvhjpX3jJc9/3c+vx696by+xd7NRwtpjQsPnljb88xAnFdAlp/WwL3v1
         4sf0DmDnU0e3DOcvTgFJGaYkan3nOI5+k6qCioPPBBl6QyDHAIBs5sSnXv6Bqfu4gxTt
         GRGe3PlIsPFQ/DP2vTpTFzKGHgbUpqTlPYp/o5JeaRaBfK3wlR0VYmqnjEKKuzeNajjT
         J7dQ==
X-Gm-Message-State: AOJu0YzsnLvaBTmHlhH4vNwkssxukuiKft+OKVktFSHHSCuvbE8mojYa
	jWgaGI1yX6EbvbYSq50zS1fWV8D5lnaLYbHdpyio6ZVYVK0tnwVvl8OLKMDSZtDxKf4h9h3AiTv
	1gu/x/dXBRZhlkv7lW4CguBd0G/xNyKELp6U=
X-Google-Smtp-Source: AGHT+IH097K2NL7eSDN4+pON6iqI47eiAb4AH/td7OVmjQSsJS+Zn7bZK0diJYB0gXBkvRTVXkSNMrZ3NpSjj4S/qCk=
X-Received: by 2002:a05:6808:1490:b0:3c3:595a:e561 with SMTP id
 e16-20020a056808149000b003c3595ae561mr2694074oiw.10.1710441757403; Thu, 14
 Mar 2024 11:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com> <CABg4E-=y_rCMSsA8=T7zXzfHJwNLMROGpVbKOW68jzLqLcTLGw@mail.gmail.com>
In-Reply-To: <CABg4E-=y_rCMSsA8=T7zXzfHJwNLMROGpVbKOW68jzLqLcTLGw@mail.gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Thu, 14 Mar 2024 14:42:26 -0400
Message-ID: <CABg4E-nJ8MDOdBDEpJFhZtjUPtqGTmRPieGSg-NMceJ7EZCD-A@mail.gmail.com>
Subject: Re: About the weird tree block corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:44=E2=80=AFPM Tavian Barnes <tavianator@tavianato=
r.com> wrote:
> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
> > Hi Tavian,
> >
> > Thanks for all the awesome help debugging the weird tree block corrupti=
on.
> > And sorry for the late reply.
>
> No worries, thanks for your help!
>
> > Unfortunately I still failed to reproduce the bug, so I can only craft =
a
> > debug patchset for you to test.
>
> Good news: I also failed to reproduce the bug on the latest
> btrfs/for-next branch (ec616f34eba1 "btrfs: do not skip
> re-registration for the mounted device").  It was still reproducing
> the last time I pulled btrfs/for-next (09e6cef19c9f "btrfs: refactor
> alloc_extent_buffer() to allocate-then-attach method").
>
> This is a much smaller range of commits.  I didn't actually bisect
> them, but I skimmed through the log and saw
>
> commit 0a9bab391e336489169b95cb0d4553d921302189
> Author: Mikulas Patocka <mpatocka@redhat.com>
> Date:   Wed Jan 31 21:57:27 2024 +0100
>
>    dm-crypt, dm-verity: disable tasklets

Well, I suppose this can't be the relevant fix, because I reproduced
the "corrupted node" bug on 6.7.9 which includes a backport of that
commit.  I'll try to bisect when I get more time.

--=20
Tavian Barnes


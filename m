Return-Path: <linux-btrfs+bounces-12194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29AA5C3E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E14B3B4C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851CE1BB6BA;
	Tue, 11 Mar 2025 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4TLOOnN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABC78F47
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703687; cv=none; b=VVm6BYfUBrFQ+An2ZtBq/yzmbJG2dXvS4SMVnEU/j63vJh08V75lOZ+R+944NsW7G68MvPNDDgj2IYMlv99P1v9oJ3dnvQWsSVcawMgAeUPhb6IwErzd56ZO22cXX7YEtCBGHoGnIKLsdjPheUaSipTMJXL+1VmdMD5uTY+CHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703687; c=relaxed/simple;
	bh=uyKevI7F7LiQn1cOyt+NLp8A8t/XT6984hxJ6lTMsaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=farhDhYJTQSOvD7wsLstoqd+A4e3uLgp54WPN1w1jl9OvJiIkrAhAF6/aHCdQclrVjoUmVwy/luLJlZE+0izT+t82Fjn+52nlyPO1OxIMeAH3iN1eCFIDbCQKdnDF9Qy9pcqwt+dBYWyirVrQIMBUXxWDi62xxVfxSL6F2hPvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4TLOOnN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so33107095e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703684; x=1742308484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyKevI7F7LiQn1cOyt+NLp8A8t/XT6984hxJ6lTMsaI=;
        b=d4TLOOnNvKD13gqA3tIdYpy3KUdt5LQUKnIb/erMHmLq72PGi19sQfQevSAT26rFqC
         qSAKeZFk2C7UbSN4Oeb6XmL+hgQ4ut8SGABivoGQgHPv9X9Pu6Lk5U/Rp6hOnxIXL+6n
         suql0yHvBBRdhBCB5knpyYlUwlixsAkWxIsJ3r1Me9Hymb81tZyckp2wKqoksM9/oDvJ
         UIkzNyc9RXJpTV4dPz1vsu/IDgqF2J+lCYvN4apYObJBpJvrPr0l5owlVfPSUM+dEUkJ
         aL1+FnPMc6+OXj2VKoNm0ESXEilPi5aPJgYhucGNGtSntXpz44SRy04yenLE24zbow/m
         3ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703684; x=1742308484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyKevI7F7LiQn1cOyt+NLp8A8t/XT6984hxJ6lTMsaI=;
        b=bDfhaWomEcWA6yWAr8AaeYkIJrd//BUKHnNYCaSNKCkFYRTiR1/FMM9XpO+QivcxkG
         7pX4BzGZ1ded9R/M2bOz0V5a26lVRlXQTPQ5CdV3sm8Ri9ma80izCjrmUTh2gdzFIRAG
         wqA6jOxv5/kTwGoUH53scCPxXXjLbEz5Tbh1Rc35FnRLvKme5CB8d2Zz6VRsknL09vsS
         3CBP6BnpyNCIBfepEhGmSKvVnQyjAj7IrqDtli2/lNbPSRR99DH7JtcuZqrg0FiidNyS
         42EUtZSHuWy5jthvrbmljZNI62V6BfE+fXJveUHp0BK8BC7EvIlZPDkeLqZU5MWSk0pm
         8m3w==
X-Gm-Message-State: AOJu0Yz3zq9KyoXBzzGKV6XdRxXfLNtkDdtk5HNSxMe2tvFWpNxxU1HR
	MelFNH/doUwhHjV+FuKc6RVvHB2ZKP/Ik4z8ZerqeSVwSUNkIYsTicaiQAZ0UY0FoF+LrSsC1Wu
	kBNKY2ejMk2Bk5dkjqPbcEEYOgFk00mKC+Ws=
X-Gm-Gg: ASbGncsRVGVyrR/zZykWVU9AfrSvPIkdT5xdGBLb1RCrqnlTPm1GPloOOQOWer7Y+yh
	WDxUOAJB2npSkwrxKlTuDDdldcKexheIB/n+3HcuTGRRxH2B+RzSq3cglfFg54eZ7ZG5Eip7RZr
	QXitPWAu24Rmbptr1NvHAIag==
X-Google-Smtp-Source: AGHT+IGcZpBmAl4yUfeobqYFf3ZT+1JrxfTYZbdufQtD9xw10J64HmtIFDYTJZGHAiHcmzb+7QON05c36yy2Dwzb+MU=
X-Received: by 2002:a05:600c:3b93:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-43ce70d47damr92793405e9.19.1741703684189; Tue, 11 Mar 2025
 07:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com> <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com> <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
In-Reply-To: <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Date: Tue, 11 Mar 2025 22:34:32 +0800
X-Gm-Features: AQ5f1JpL411GCP-VONugcRDOnu3IERt6NNIp2pd2y9orkMmGsW6Hpl47EAOysVs
Message-ID: <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	WenRuo Qu <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2025=E5=B9=B43=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=8C 19:59=E5=86=99=E9=81=93=EF=BC=9A
> Not finding a metadata space_info is just broken. Even not having the
> ->space_info pointer not set in a block_group is a big red warning sign
> that cannot happen.
>
> As per the code you quoted above, there's even an ASSERT() catching if
> the space_info is NULL (but CONFIG_BTRFS_ASSERT usually is not enabled
> in release configurations).

No, I mean that btrfs_add_new_free_space is called before:
cache->space_info =3D btrfs_find_space_info(fs_info, cache->flags);
in btrfs_make_block_group()

And the stack trace for the null deref contains

? __btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
btrfs_add_free_space_async_trimmed+0x34/0x40
btrfs_add_new_free_space+0x107/0x120 <- Notice this call
btrfs_make_block_group+0x104/0x2b0

In __btrfs_add_free_space_zoned, cache->space_info is accessed, which
appears to happen before it is initialized by btrfs_find_space_info().
Unless there is another code path that allocates and then deallocates
cache->space_info, this seems to be the direct cause of the null
pointer dereference.

The open question is why this issue doesn=E2=80=99t occur on other systems.
Possible reasons could be:
 - I have missed other places where cache->space_info is set.
 - The condition if (!initial) in __btrfs_add_free_space_zoned might
be difficult to satisfy.


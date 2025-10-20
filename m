Return-Path: <linux-btrfs+bounces-18053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0711FBF1705
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 15:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10C454F732F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148662F999F;
	Mon, 20 Oct 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc66UnMh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF122F7AC0
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965536; cv=none; b=EAFn8Laj5pNsWfry40P/zhT+ni7UYBoXGZhhPV52kTr3eB2/D9RL/qKOE8uSM1wqYVvM1F+vr8HZ5Z6ceGzuC9OwYq0XSTtQl7qAo9OvdqlMD9jCS2K0JECutSBg8VSw8fU9S7fgQN7jIvG6UMgNVbSFAgZQjWZZeZx/1LlnylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965536; c=relaxed/simple;
	bh=/UtWSY7X2GVN3/i9RstzPVBgqiZNs8bLGb4OvTd+UA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mo4O4wlfnEYuoa7NJk4eShj3MyxGxGFlQZVfG1J7ovh5jprnBTpiebZewwOcGqvr54wjLvtxPdV1X7g2fGNuIj/apUHH467eV5w3n+raYbWID5CazqMCksLxHEC0VYkf7dzukKXjxP9SjtM+3u0RIhPTx6LmBFQpYFmqC7vOLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc66UnMh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781010ff051so3241277b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760965534; x=1761570334; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UtWSY7X2GVN3/i9RstzPVBgqiZNs8bLGb4OvTd+UA8=;
        b=gc66UnMhZHIyYQxDpSZK2HSvKv8V18Y7QFArppmr3eDZN4BoA8Pe1fiImksWUZVJL+
         lGIVW0V5wshPn+8wCFlz5m1xY5As/991G7OnL4cBH/TtxhB4gqtUZq5oUM3ZuLg3QK1z
         2i2DF2VpAkoG00v+wpjoTi78yxcErB8IXA+9DU6uGeWL8+4F11v8ILotQvd7MKP1Rc4s
         bSvOFK2SodaFJjWMDqt8O1GfbdmAiMtfKjYWp3uwxcOEGQ/V+CbG+w+IqMucBYwYHGAa
         +3g3Dm0UirCLqsJ9bT/2JhSsjj8iquw1kegckfU1O+7Es0gZBk1Wf533BmTbKsk92tLD
         XX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965534; x=1761570334;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UtWSY7X2GVN3/i9RstzPVBgqiZNs8bLGb4OvTd+UA8=;
        b=qzbFjTUKBswcv5hWkuV/4SrxVog9fUc457dkxetzSyQiIDccOs3cEZHbf0J2nlm5ym
         xAQinso1webOGx42Ws2RrmOKfiRYtqwTTFo6Iemp4Ljt7eX5IXpvuR/S/MpCM1N7Rvdq
         cAEL2rDWR9LVgAyU0rhumqRIkxzNs/LXgQkQxUcGg7hBUiyNy1fS5ah3INc4s4XyPfij
         tHL2AqTtnERfvoK9MVAw+r7jtI5/sds+LAUnq2oKE7pstPL2mjptWKnrh2dwzRwcnrJl
         gDdKA7+nOZc5bkNSniXGBIbh3L60N5u5ahaYNoI+rP2v5AMah62nMKI2CnVt181AOMKG
         a4ig==
X-Gm-Message-State: AOJu0YwG6GfwUM7Dfq5L3yl8iDLJgvckPqj6H83GyR562AGOa7q5HD0t
	HmHCX5ZxtqfPUwsE7tcGf4rtNEjsLUgjktmBXdihNxDQBGJnMLf6jk2ZBphLX07gL9r3oWVQL7f
	gkFvnrxBxiM0R5jAlvu9/VWJwi+F4rPE3xMdY
X-Gm-Gg: ASbGncsyrfyVVK1doprHfe1msuFXp57Psu03AnCBwM4ZYCJk5nh6McfPNxp8xfulpLa
	19DjoC0ACDNUsLqo0sMlLP8q7T8fxNzTD1sdUjE12thKb7TJ004Y17ARPIyo8G0Ps5y6YmmKMo8
	M7Vku2lHT0A0L0Ny97+XnUfNDHp4ARxB61Mn5AzF07mnVX/GRfvnRt3btycHkPxvQTeFDzFb3t+
	Qle54KRJzFbziB9ljYa8sCebaW2+kvaFpixhPzw8M2vpaG4cqMsSqzsZXx3
X-Google-Smtp-Source: AGHT+IGMzkFV1gQ33i0ZFQGcVkBqgWGgiZEwJNeS0a9z5FfgscUwwP3UcYG9rfkQLzsQAoZuKFLDPP9Jm8qN030XUgI=
X-Received: by 2002:a17:90b:2883:b0:338:3789:2e89 with SMTP id
 98e67ed59e1d1-33bcf88010emr16822749a91.10.1760965533611; Mon, 20 Oct 2025
 06:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020122115.GA1461277@tik.uni-stuttgart.de>
In-Reply-To: <20251020122115.GA1461277@tik.uni-stuttgart.de>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 20 Oct 2025 16:05:22 +0300
X-Gm-Features: AS18NWDZb6uptbggn_Z-1VJuUga0sIPYNSN6BakbVFt1J1Ct8xROFKXardORVog
Message-ID: <CAA91j0Wfg2uZptchB-aeaB44C+=igPMP-mZg6ovidmLs_dW4hg@mail.gmail.com>
Subject: Re: RAID1 vs RAID10
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:23=E2=80=AFPM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
>
> I have just discovered, that RAID1 is possible with more than 2 devices:
>
> https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html#profiles
>
> What is the difference to RAID10?
>

In RAID1 each chunk (copy) is located on a single disk. In RAID10 each
chunk (copy) is striped across multiple disks.

https://lore.kernel.org/linux-btrfs/87v8qokryt.fsf@vps.thesusis.net/T/


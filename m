Return-Path: <linux-btrfs+bounces-3136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF1876C7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA28B2197A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A145FB8F;
	Fri,  8 Mar 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3157iZM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26965D471
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934403; cv=none; b=DafxlbtIL0omFcfFeZ/hSu57VKy3LCQrVMqqtq3GsvnlYrMwbygkx8K/tfRvTe3K/R7SVLhi1f6bwfWtQbrQMdI6SHaXsKunsSCnrDxqtSlxGA2Qk6/x+mIgd4IuZBvKuZSzFbWHUEGoq9p16LaVBIBbGk/M2eJi0kJnxZz60Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934403; c=relaxed/simple;
	bh=zXTQXzHxnyJpcwa3u17Mqa6kH0jbArdyId7YE1uHggU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc9uBNBBdPaHZFycBEKckUsWiJ0bfYtXs3lB62EClpgU2dbbQLcazbvqZ4gEoMGexWXdnpH12p3PdezopNPs58fpfE7c39zLBERzYaKEJmaJwqpI0tvE+eAqVZaSDkurqFFsWwcXLTw5SXx8yf+zW0U3eG9kW7uDotPlsLiNrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3157iZM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso1588054a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 13:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709934400; x=1710539200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXTQXzHxnyJpcwa3u17Mqa6kH0jbArdyId7YE1uHggU=;
        b=Q3157iZMaW3dNLl14f78lRVUTWWZUSTJY1Q85qMTH+lIfp+0grnEe9zqZK01o20t98
         9DkVcrF/mBrrK0lKIN0Xrro3wMQz9MjhwUPTEvNuNHDCy24rjGs9hd6yDm8aIZqvutHW
         omUo3EkP/tgtuAOhOesQjnvr2HufzgScEykAZEJQg1wGwZTP8H8baJ5jH8zjD21nXlRx
         F12PJ5FtbFTvqI3i5CY8U2aQkememOX2jL2SWqTMI2TSztpSern+4OJCp+O9Fiauhh3j
         aVjq0oJsgrxfOEbBymvs34iP5TLa8n+GUSX6OJoYERL+WUjE3RZmwT9WXmcRTsw+Hlr6
         vjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709934400; x=1710539200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXTQXzHxnyJpcwa3u17Mqa6kH0jbArdyId7YE1uHggU=;
        b=f8HD6Sf0gQ7by1cfRmQGCThRfuAOl+FCLgqAtsbKdehvz68FyWrof+uJ9LPuZYr0xb
         BxVr7vVKCL9GR2sdcrIShXjhzLUc6bNnvImfkPZO9YR86L+yf54vMkGzFBNsG/TupyDq
         vKCGq7F2D6fkDPPDeXGj9YjdJniEI9PqVcomEg7LNHGcb31Sb6zP/WmEG/bW6v77pm2d
         4pzad1RQgGLtdHW0pe4BBO3oaAwXqNJ6sJai0V4peIebiaZIs0hsNS2MsqyeYHqZfcFQ
         Gvju3En4BlpA4XQCTo3PHKdPVsy+x86BPkLXx16t9VX58s3sOW25WvM2NHqWPhFonf96
         iUwA==
X-Gm-Message-State: AOJu0Yxwwm5gK/657+fiRpNEFp3qDP1h7SODG3qxNlhmo8GbBcV+OvY8
	jiZDzBnr+rR5CtpLGyscEW4Wi1kp2FYhUHTOlFU+FzpjFFj8Itihkc5CwdZdyxhiNbzq6YsVYpv
	jBSVVIsWYHkCPH775wVOfRXzZDQA=
X-Google-Smtp-Source: AGHT+IGquSfkLqkLWP6lXlf1aYlGwCvEI0Z7aczkXO0WOGKvaemN9jRGuRgS2JKVJBbT0uCtWSHUNw77coH3JoRNebo=
X-Received: by 2002:a50:f61e:0:b0:566:4654:4fac with SMTP id
 c30-20020a50f61e000000b0056646544facmr332284edn.5.1709934399829; Fri, 08 Mar
 2024 13:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
In-Reply-To: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
From: Matthew Warren <matthewwarren101010@gmail.com>
Date: Fri, 8 Mar 2024 16:46:28 -0500
Message-ID: <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.edu>=
 wrote:
>
> Greetings,
>
> I've read some conflicting info online about the best way to have a
> raid1 btrfs root device.
>
> I've got two disks, with identical partitioning and I tried the
> following scenario (call it scenario 1):
>
> partition 1: EFI
> partition 2: btrfs RAID1 (/)
>
> There are some docs that claim that the above is possible...

This is definitely possible. I use it on both my server and desktop with GR=
UB.

Matthew Warren


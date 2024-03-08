Return-Path: <linux-btrfs+bounces-3138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCDE876C91
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 22:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D4AB21965
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A55FB90;
	Fri,  8 Mar 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b="cW5xr0+t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82A5D746
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.84.196.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935061; cv=none; b=cU3tar/Zpp+mxuL/FwDYtzVaddCk/v2u4xbX4G9IUfM3S+4RruM+AAzj1ioUUyOVvp3JwEfD4rKmaX8ml2XoCBwhj1jJ6AY8Ak0KpDQygnxAqUT3ybX6BUesnVjOSKkEAX1PIUO13rKT5154wVYtmNj7y72NpmMIiJLGx5P42/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935061; c=relaxed/simple;
	bh=jjNC9p1Nb1Fx7+sBb+DNOZWjZuDNAp4fGVuubePEAkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oqf49urPezeeC6bpXftcbynM6vj7DdCLwwjbOAW/OvNZpOTqT6cIyvB49HjTirjtxR//bQ3v+TCGeATQS7/FM3b2dN5pMKNs187IaQgtGPYidLI375uARVXmD/eI1uAae7Aa4G7p2tURHA+JG3PRMEc/yheb9kTzGyfo4n76qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu; spf=pass smtp.mailfrom=d.umn.edu; dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b=cW5xr0+t; arc=none smtp.client-ip=134.84.196.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d.umn.edu
Received: from localhost (unknown [127.0.0.1])
	by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4Ts0Cr36Qrz9vpvC
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
	by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlTFe_sXiX_Q for <linux-btrfs@vger.kernel.org>;
	Fri,  8 Mar 2024 15:48:24 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4Ts0Cr0n1Mz9vpvG
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 15:48:24 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4Ts0Cr0n1Mz9vpvG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4Ts0Cr0n1Mz9vpvG
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so1921905a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 13:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1709934503; x=1710539303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjNC9p1Nb1Fx7+sBb+DNOZWjZuDNAp4fGVuubePEAkk=;
        b=cW5xr0+tN+A/WfcPkU1gr/HZi7aWvOf1sYvcgftJ+pB9H8F2SwCra48SZo6/BNQj+c
         JGwESdIHAlqzP9sXHiuQF7nYmHsRV03w2tyfvUiCyIeo+7s8ZkzPN4ZX7qX9SS7ggqZg
         JyYUFLfOha1G9gjeLpnTa0SiYj2ENhIxv9RVZocQs8gAiT4CDIFZPAFuWvGNe8uraj/U
         aZBEE+PVVUzjpsFQ50rda7JHAJVdK7UfxWWwLv2FC81+avCfgNFxxXSAvELHvZg71z7K
         vkum4pFpvYy11oM9tuCZ8v6ySnyv+EuXGiXaYJHXl7yCIwgO0ZZPl2QRDNR+jpgMXMc2
         XGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709934503; x=1710539303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjNC9p1Nb1Fx7+sBb+DNOZWjZuDNAp4fGVuubePEAkk=;
        b=J4Gn6CRofvhqyr3+Weapco+iOSbZ8pKlma4+WMxDpvTD3rGrD31/oNfofcD4AaL7K9
         CXhBhm6hDQzENoaHfFqo65sKohuFYZ1V0WyrnCi3cqojK5+/dpOTPMoPO80kq2TSLoZ9
         ET798igBAPsNeKYJ54jkasH14O3R1SmOBwf0tO5K7lTCcwOO/nyDNPcNtgqC8kY4k+sO
         hfFbaIyLTqsNy2MTInbh347DJuRuy5QWZliUaVg9O1Nl4Ex5ItcuJo5cf6jXjXfyAuVm
         wcse0KHOhEwbqPKijhkXH90orK7rpKMdoFuqth5fmd/wo1QtIc2kSLSVRJ5GSaF8N/U6
         h45Q==
X-Gm-Message-State: AOJu0YzlhZ/tPoQIuIWrBzu/WUIEhjjAk0vUok+eJqRtWB25NalpkIRq
	RqvCCYGBIhBtjc1z2qlaqj4+gC7SVb2DV4Z4zw8tUnltdO+wE1NkUNiCAaz4/MU1UaOAQvS9OHe
	tWwfkgUeJ6mNDczwfFLaW822us4PBOXIA9QCTQp9IGJ+/7cNJoyP2/jDe6RYi1miPQif8fC8jqs
	pWxltsdlniGEXZpYTTbCbSFUOwX41yxXjbwLut/G+SiwXVUg==
X-Received: by 2002:a17:90a:f609:b0:29b:b478:b8fd with SMTP id bw9-20020a17090af60900b0029bb478b8fdmr425507pjb.35.1709934503127;
        Fri, 08 Mar 2024 13:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHLTFsp5ND180v5v/dhJOQooubNrgsDWhSzjzTx0ja1yG5Wrbhw9lhJqyfvcsYSmfU3dLRi93sPtsree0Udp4=
X-Received: by 2002:a17:90a:f609:b0:29b:b478:b8fd with SMTP id
 bw9-20020a17090af60900b0029bb478b8fdmr425498pjb.35.1709934502848; Fri, 08 Mar
 2024 13:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
In-Reply-To: <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
From: Matt Zagrabelny <mzagrabe@d.umn.edu>
Date: Fri, 8 Mar 2024 15:48:11 -0600
Message-ID: <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Matthew Warren <matthewwarren101010@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qu and Matthew,

On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.ed=
u> wrote:
> >
> > Greetings,
> >
> > I've read some conflicting info online about the best way to have a
> > raid1 btrfs root device.
> >
> > I've got two disks, with identical partitioning and I tried the
> > following scenario (call it scenario 1):
> >
> > partition 1: EFI
> > partition 2: btrfs RAID1 (/)
> >
> > There are some docs that claim that the above is possible...
>
> This is definitely possible. I use it on both my server and desktop with =
GRUB.

Are there any docs you follow for this setup?

Thanks for the info!

-m


Return-Path: <linux-btrfs+bounces-6196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7C927736
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1131EB227A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0A1AED33;
	Thu,  4 Jul 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFLkUHj8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAE28373;
	Thu,  4 Jul 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100029; cv=none; b=oI38M6VhfwpgsJVDf6l6zndPtglyUruWcd5+iOECExcuc7ykkhJUrqVPnfCJdNtUKityxZ0w9OhKqDtqySI3buExnnc7367jRCUdwQRHgKrbrIoK3UF4zC1W/DDAZ0qRhZX4BoxaEeGqLC45cEwiC7Rh/zr3VnJ9VM29/8/F+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100029; c=relaxed/simple;
	bh=YTpdR8BWwbMhfLGFsScSQ+dfvCM1UcGB7JaHRWuCLtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDc28cwVvFems9+9f8O1kIcORmDDclOYoLA/LrunUGpskGSPCO60SNOjx37JbsEVulbn5cXhA72LmqFaPxD3pn/Zs9H5Xi/meNdIfCpFcKL6WYLMcXcnaF2KYPZMhEhSsU66MIyh/Mkzbu9TLmOHJnXw+S0hYsM1sdQHL9oZVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFLkUHj8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64e81cd12cdso5324877b3.0;
        Thu, 04 Jul 2024 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720100027; x=1720704827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTpdR8BWwbMhfLGFsScSQ+dfvCM1UcGB7JaHRWuCLtg=;
        b=iFLkUHj8kYHnbUUkvb9T7d3m5BYtIcclHHIpID1xMx98j7l9uKwpH0agcy/0awLYfX
         xCOtmR+hnaD2lDUaZ1VR2dLWy3QUoY1EzwDyB4hSk8oHqbpOo7nFPEIqghkFZ9NGmor5
         kwWStsIp8whvANAIYljtIl+lVlEvRZtYsqBmkJvtsbI3tVEL5zWo+odu0EjzR91SUuIM
         jtpPB9y58FAlXbYGDwtk+Fo1Yjx9WsIm/c5TNaSzjQhCMu5ctOBlMa7ERym7lfLfSmXn
         qkno/a6g3y3+qvf8jqecUyAt8phCKtC86tVoMyyzjuEkMDVYC6g0l/O9d7DCb1BRmARW
         R1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100027; x=1720704827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTpdR8BWwbMhfLGFsScSQ+dfvCM1UcGB7JaHRWuCLtg=;
        b=RbgKJ5GpvIsPFl3iGxC9Cc0axnb1RmYecTALYXxMupUIKu44Ww6KaHBvVD8ybEePzx
         Bk5kSUv/9PYaRJ1MfzS8lwYMveZzXc5eslpdorRjKqLBzTOaIOCo7lsQrduUYULjEh/v
         D+4/sYRo7Ygi9KaG9/PSpUixY6jZ0D2SExIu1EN0PI4bS0Ek1yvkB0ZHxibTm0PYcxM0
         n0Txmc8U4LG4wFKWiSdf3HUffowAbYCXdEsDk+Ut1N8GsPrJXLH791lLvJ9FwJ+DoOSl
         tarhN0H5AbPXFN4OAHvfprTS3tqhvGlAV5KrT30n6+1aqTN790Gr5gx/nojSL1hS2wHw
         60uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIwUJyGJBKaYo/c10brc1C8Q0Im4D1spUMlMDwzJt0Efn1zY1DSZwDvS56Nbha9NMostSTlSKrfJmUpvVulonCep3gOVWDt6TldvDWwGHPys5ra39NvPXU3R/jlOsPfIhYxom6qvPD1uY=
X-Gm-Message-State: AOJu0YyirdbAXn+7ObyWx91UKrGVjgqqilxDeQB5E0hglkCVzV7XvMPp
	bVdm0QYCYYQTTCAy/+sfC/X2qWdVu1UEkGLkRlJ05a4QORLdJ+d9eGeocABy7mKkV/drABPZO7W
	jDITI/kSW8DpQSUl8RcMCrVG7FHk=
X-Google-Smtp-Source: AGHT+IEnPiXYKGoZAEcWbV0vplxMesyCar7SVTa8AM31q8atEL/J3INWycW/KyiHzI5JnUxFQ7SXn4y6RT/9fhMRiCM=
X-Received: by 2002:a05:690c:ec4:b0:651:4b29:403c with SMTP id
 00721157ae682-652f5778b8dmr10432037b3.2.1720100026775; Thu, 04 Jul 2024
 06:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com> <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Thu, 4 Jul 2024 15:33:30 +0200
Message-ID: <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 11:57 Filipe Manana
<fdmanana@kernel.org> ha scritto:
> I wonder if you have bpftrace installed and can run the following
> script while doing the test:

Yeap, no problem. It worked. I mean, recorded on external usb stick... But...
On my laptop I have kernel 6.6.36 and rc6+branch...
Uhm... Yesterday I switched back to 6.6.36 after wrote the email,
well, not exactly, I usually work with 6.6.36 and yesterday rebooted
with rc6 to test the branch patches (so the sluggish issue weeks ago,
so I didn't move from 6.6.36).
Anyway, after wrote you the report while watching the "live action", I
rebooted 6.6.36.

Anyway, tried right now with bpftrace and I can't replicate it. Kernel
exactly the same. No recompilo or so on...

I just can think about a few LibreOffice git subvolume deleted
(~215000 files), and a few created.
A few tens of giga deleted of files (mp4 and mkv). Uhm... dunno if it
could be related or something changed on BTRFS layout.

Well, I have the nighlty snapshot (well, it's not on every subvolume
of the fs). I ran tar on that, and we see.

I tell you in a few hours. In the meanwhile I keep running rc6+ and
see if something happens.


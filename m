Return-Path: <linux-btrfs+bounces-6222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5192821F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A661C22EC4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC913B78F;
	Fri,  5 Jul 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzXTkml6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315E143C75;
	Fri,  5 Jul 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161049; cv=none; b=PF0vxgBo53Q1yPbX+ylhUCtPDk7mYeVaya6hydksEIYg3DqJRtk4DlFJmnQBTGsbGxss/dBzYq79vRtfgVmbau/1x8n9yQxsHyMqEA7R372VKxX3RSRV8aBJsn+PbN851lZ0QtZxv9m9Ky565EPk3jjADElRwawXkV/vK+yu5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161049; c=relaxed/simple;
	bh=3y1kYHHnYGzeD6Wz0nY/wCVLnjXbc4LLizc2QWYCsb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPV3CxccwKAHPadFeyMiw95U1AwB23jdVEHdt2EpnvvZn7jp9ueOfY8uDn+whQdFUxHvhrEOdaE7yvdXYVUeUqacwbSIWZOhgM8cdv5V///IobXSuo9yNdtMLwL4ynlWmfcXoUQ7fssC7r1g6xifLihqanhkHiN8HFeWj5/J8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzXTkml6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64f4fd64773so14528217b3.0;
        Thu, 04 Jul 2024 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720161047; x=1720765847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQbhl45iOUg0QGUWvg2xNxmieezt2A1bnLf0za/XLZY=;
        b=UzXTkml6U5AX+Noheu83kZ037zujHa3W75ZQoxr1ysdzDNul9qDxvtG6LnXeUEAc18
         AGd0FuX2X6nORsd84lihreTFA0U2JSyaxHL0iYRF0tnQavS2eWCla1HN5ySx88TqPNxP
         pjmAq7F5Q8Y2CTlijTFl+Vqubb+Uwb4FNfghEBRZQSCaGDzHJJNXn4IAQXyOGG/5IVqO
         G2/ZkUYvMzzE80oQfjmSCk8iKcLspn1jIe1WeliH10LfzpQ5ij1RM20nvnE4DBamB9ty
         pJkHhD4rRzVU4EXaB0j/ZgG6T0SDL6DpcDr8KRRUcL/hs78Q40FHs+IAJgUNSP1+hz0D
         SEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161047; x=1720765847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQbhl45iOUg0QGUWvg2xNxmieezt2A1bnLf0za/XLZY=;
        b=ff1esDXeRXVqVJtdMiKYDvQQa7/tUXVuN59cfk/iaJmG0Wh3hmJpKaU+PioAKv/wBf
         6Q/oTAczQET6zqcBecmh7r5J2wEL+OpIOaIc/EecPVxzOjHOwBhjIWZY7/YwkhL/cxoV
         xaVhajrR/tQYwWI8THbsroD54J3a59OYC6avFjIbmtRHnN5wOXjwth2Uk4rV3CyuRkDU
         BRVcibFwAOcvGNw9srSK6zq0JNq6J13m3rt5jcYGbc0V985hxKnBz5VHS5bnb0nw/Czx
         fXL/RE1P1/IKS3FgTUBACmIBc+73rTTkxB+4YLC7EGlMLBhcIvR5MSKGlIiAE3mS28v4
         AW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUucihKmKpSZWM+H0G2cX1aIuFeLDiM6nz45U5HwACfJBI4rD6Ds/1aglhKtaKFE6E3YBuaH6bvD00qeB94Z4ztQ7HLmxazWx0gSZFEnqPHZXLurEWeJgbg22I20HOh8zbrUcn6BvBXTzg=
X-Gm-Message-State: AOJu0YxSq+C85B9FpdQ4bOL5xwGgQXMCZZWeUmK4ep2a5O8dDDhvvWgy
	0lul0WGgzLrn4Ia3RK7IKmijHPmyXFV6jEcyvwfMaVns11ywC8gC82pA8zI5ulz2JZ8AOOvtHAW
	Opvv+gAhStJagAr9dgg1jH7r3QH0=
X-Google-Smtp-Source: AGHT+IEb2d4TYFx4dcPUM/2H6DuAxz2Xagt477hoH4hD4d6CeTKaXtpWV6ii11wwbYejeouG4e95xSVT7l9Y54yfW1k=
X-Received: by 2002:a05:690c:3382:b0:627:d92a:bdc0 with SMTP id
 00721157ae682-652d7683982mr46295877b3.36.1720161047227; Thu, 04 Jul 2024
 23:30:47 -0700 (PDT)
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
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com> <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
In-Reply-To: <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Fri, 5 Jul 2024 08:30:31 +0200
Message-ID: <CAK-xaQYwgOKkeD4HvMtNqNqqchW4aS2gtvzGJ-yKwfE6uaUYng@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 19:25 Filipe Manana
<fdmanana@kernel.org> ha scritto:
> 1) First let's check that the problem is really a consequence of the shrinker.
>     Try this patch:
>
>     https://gist.githubusercontent.com/fdmanana/b44abaade0000d28ba0e1e1ae3ac4fee/raw/5c9bf0beb5aa156b893be2837c9244d035962c74/gistfile1.txt
>
>     This disables the shrinker. This is just to confirm if I'm looking
> in the right direction, if your problem is the same as Mikhail's and
> double check his bisection.

Ok, so, I confirm. With this change, just a little bit of PSI memory
sometime (<3%), but no skyrocket. Also, tar at full speed.

Now, I'm going to prepare the btrfs image to send you.

The other steps later.


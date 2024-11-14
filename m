Return-Path: <linux-btrfs+bounces-9665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EB9C90ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2287C282D7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7918C022;
	Thu, 14 Nov 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUwsdTLT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8518BB9F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605913; cv=none; b=XCc3iHS7DhXXdXGjHHQHsefDP2c8CbkuuYvA+c/O1+HMM2xd01stSE475RbLqutwapD/VooMkrsOFLjvcPX5pFj4cqS4xnDvlrbQuQ3l6szE8vOhB4pxk/3Pu5HUUojuXA+LEsj3TUGksrWOcP1+qLdUfmEjbT0yOSpVAhoUfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605913; c=relaxed/simple;
	bh=Mu/lYvCwce3YsJFXxC6i4tB7GeX27NNP4UDQVzE2Koc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=BjOkBH8DrvgFb6p6RAQ0jKRg5p0HDSmA2A2tG0I1WzwcKJ7y3ioWt9OVDgrtrjC3DlbX0OknRE9SwG0VHaR8PRJ0L49aqzN1o8i6enDrQF1LvqbcDFCZZYgSNZpjveCavZ4HaaFVVVjV5yA9UBa8uxDlQvLYNaJ2IiRQGDjXyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUwsdTLT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso15703641fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731605910; x=1732210710; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAOh3Ih2DlH9IWG8wA2+N4nZ05uTLuR2Ne7wVI28ud4=;
        b=AUwsdTLTaS8N8165CIiMph6E9Pau6mfyZt0pLsKQoDiC6MjEelJ23ShpMITz3Hnb2W
         BBwHma6w83YDk0mVpr/dMff6nDSk5C8z18dxi8nXo+3+5CuqPacoJVw2n6kySa266k3I
         EiIypGXVKHfuV5Ia8Xwa7fpOZ/wWnjYuT62hVCCaDfBrLt3mG9xctbOTrOO50ecrPvwP
         H6ASQDS7FB8DYC+PsvDKJkM6uVzOKJH2xQIL4QrYAc0gFXmKw1b7gXUeSF6Cvm7QKj7g
         nUQlE+gUc4PvmslRIxExSvLfSA4v9TLgi+cYZp1B3pO7ofjAU0hyimzQylBdmeTHK6sI
         x0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605910; x=1732210710;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DAOh3Ih2DlH9IWG8wA2+N4nZ05uTLuR2Ne7wVI28ud4=;
        b=UsRtC8QtY8lmzsXjIyBN+Naw0Eu+aM0UFt910B/Li8uoYAVL19ANlIC9FtWYu1TXz4
         LGjGGa+qi0+5RbR9Nj2DlLgnGTkKqE4l7sdnEXDZORDX9m28+IcoCNwu/G3S7TTqFEfJ
         VWFPdO3w/QvWZEQ/jO/Pf098bV+3fLuD0Yf+GZYWHIokCJbYVj9Pwg7ytwcCkGgXemGX
         e6MOSdhtUEclMQi+KXwQNMdfNTVdQ+c2DX+iz9FCch8mY836bENYB02hiyZSSfX/1p80
         6fDl/rHKKg3zA0OURlloVjDjppDuFgl/osIYXEaDqWtPi95lGWoMJYcel7ibYU8enPNY
         ++7w==
X-Gm-Message-State: AOJu0YwRUM4yuaJd32eHfGtrHpN/sjie39/xRyboKDMmqi1vnjjcPZPa
	O+Tj17I5Z0VG2PHqU2dxazguDjBhl6OcUHt3AVzvdGW3IoUi7vuD36hAOQ==
X-Google-Smtp-Source: AGHT+IEXKlhWHTdlbi9oZ4MlqzDLSixvZjVCGN6r+LV9fuJBXm7EzN75Yr+OQa63VXbFiG+3o+8zfg==
X-Received: by 2002:a2e:be89:0:b0:2fb:cff:b535 with SMTP id 38308e7fff4ca-2ff59027b26mr25465521fa.13.1731605908407;
        Thu, 14 Nov 2024 09:38:28 -0800 (PST)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df50ab9sm85623066b.51.2024.11.14.09.38.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:38:28 -0800 (PST)
Message-ID: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
Date: Thu, 14 Nov 2024 18:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergio Callegari <sergio.callegari@gmail.com>
Content-Language: en-US, it-IT
To: linux-btrfs@vger.kernel.org
Subject: btrfs scrub results in kernel oops does not proceed and cannot be
 canceled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

yesterday my laptop (kernel 6.10.13) froze coming out of hibernation. 
After that it will not boot anymore, saying that the root (that is on 
btrfs) cannot be mounted. I am dropped to an emergency shell and if I 
try to manually mount from there, I get level verify errors.

Tried to boot a live iso (with kernel 6.11.5) and to see what might be 
going on.

Managed to mount with -o rescue=ibadroots,ro getting transid errors.

- As soon as I start the scrub the kernel oopses.
- The scrub does not seem to progress (calling it with status).
- The scrub cannot be canceled.

The kernel oops appears scary. Even if my filesystem is corrupted the 
way in which these tools break rather than erroring out in a nicer way 
is not very helpful.

The plain btrfs check report a level error on one root and I think I do 
not have backup roots.

- is there a way to find out if the problem affects all subvolumes or a 
single one?
- is there a way to find out what can be trusted attempting a data 
recovery with the mount based on -o rescue=ibadroots,ro?

Is there any way to find out if my nvme (the hardware device) can be 
trusted to be used again (namely if the problem originated from the 
hardware of from an error in the kernel)? The fact that the problem 
appeared when using hibernation makes me thing that maybe the nvme is 
not at fault and that it was something else.

Any clue on what could be tried on my side? Why does the kernel end up 
in an oops?

Thanks,

Sergio



Return-Path: <linux-btrfs+bounces-8120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0497C4DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3509282506
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09130194AEE;
	Thu, 19 Sep 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b="TScvKoLe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF7193432
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731124; cv=none; b=EqiAnPqIy+CynnZxzU+UJo3v5YUEStRzhe/e9enWHCL1EDIaM0kP8YMFvX4wyJ6tcd3doCVp2iDiZ/meHzG9zOXVsdtcho4U3UDC6Ug7P6cAR4hdERHvb6NRvjPm3adovBddlPc21r79+stlvyOubjcAZAAPY8iFB0YCZarwXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731124; c=relaxed/simple;
	bh=0Q/61FqcD0ep1ExjDTIlrqO2375C0jql2r++x+0EBWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZz3KSGCkj8ebNmgcsY6Uuj7bsn+eHy5QN4ZGwLVmNE9zU3i+Ol+4BiuBWI8afnYiC9xUmEK9Wjmkh3p3MQXo4LBrk4aYingnu4KPt88qoT3R0F1k3L6dSnSRXuD7dMQPxlRv9pOXmzuaO62v8/XgPIlZ8EJMzCa1qMdTIkVRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe; spf=pass smtp.mailfrom=kota.moe; dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b=TScvKoLe; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kota.moe
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-846be74b299so195854241.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kota.moe; s=google; t=1726731120; x=1727335920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InEs4KmFwzKWhT1u1iftaF0AZ3Wdu3Q2SzOjZlEZztA=;
        b=TScvKoLeHJW9YKDtcwUBHA15Oh0tsaryRV27hxFZ4eqOsnYjz4SzVNLGiOO0CxyUiZ
         wNuAE/Cr4F6515XHBftjStdF0F537z71iADCgrH8tuJ8MSkMpMn3MTOmEcF8M23EXyEr
         VI3JhztMNvoHFaUJdEyfV6+wPS1nNlxuXs/GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726731120; x=1727335920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InEs4KmFwzKWhT1u1iftaF0AZ3Wdu3Q2SzOjZlEZztA=;
        b=HFmw3xgpaa7BNVi3lWda9b1p1cm/G7LuRnFmbs4GusN0z0wM2vysoesg/qhrvn1gTm
         tkN1V0Wkh947TWwON+pI2w/PWLTKOkvhKXn7XPFNN8xlxhsMLkxXt5PEd21aA++66wyn
         0RXyDoK7jeFNdrZo5Y4cP9OSlddwMqlItCkWTZaTrEv2zCmus8VeF+WvGct1weV9EI68
         BMcDOUwUpTzCgeGmKUUpl4PIQDlajkXebWnl0b1ioCVR1kb+a4U10gAioGNl94L619eV
         Ko1RoUvl4+HSuJ24fOrdSvHpPshKj6gJfQGHQegf4pk5dCS9FDeHH6b85vS12LK/48gC
         haSA==
X-Gm-Message-State: AOJu0YwmIwU6T7V2zuqWuS3I+8/ApwuwX+AO4sWWrjuXUorRTSGekUef
	UhVc/vUHxO/fneukqvwoLAe1KF5Xj6rl8MDzVbzjFl6GCnxph0Yr1r/hUu1eD7a3AsgF9fwa+kF
	A7JhhNRfVuF49DUX4Dkvtl8asXxSKs4HPVfrnDQ==
X-Google-Smtp-Source: AGHT+IFq7MQnP4Idr7kWu0wn5mNbtgNbTO1KmrBkqlPikSm/1pVu21ibcMEATaonj2jmU8DfqXUpg5MvWy+yefj52vE=
X-Received: by 2002:a05:6102:4415:b0:498:dd44:32c with SMTP id
 ada2fe7eead31-49d415a60ddmr25183778137.28.1726731119676; Thu, 19 Sep 2024
 00:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
 <5c42a8a3-6571-474a-936b-df13057ff0ea@gmx.com> <CACsxjPbjbBFV1YBSfMSN07kx6qoNrFihVC6oqZOmrtZgKHYytw@mail.gmail.com>
In-Reply-To: <CACsxjPbjbBFV1YBSfMSN07kx6qoNrFihVC6oqZOmrtZgKHYytw@mail.gmail.com>
From: =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date: Thu, 19 Sep 2024 17:31:23 +1000
Message-ID: <CACsxjPa1T+XUXqQ450fn69O91_g6mte-U_xhctTMmL5RujSzxA@mail.gmail.com>
Subject: Re: "inode mode mismatch with dir" error on dmesg
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I just updated my kernel and I'm now encountering some additional
errors, that overlaps with the directory containing the previous
corruption:

kota@home:~/.cache$ uname -a
Linux home.kota.moe 6.10.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.10.9-1 (2024-09-08) x86_64 GNU/Linux

kota@home:~/.cache$ ls -lR . | grep -F '??'
ls: cannot access './mesa_shader_cache/a0': Input/output error
ls: cannot access
'./mesa_shader_cache/1a/bc70b1f1d2efc3fc867739909e6c3f586de8e9':
Input/output error
d????????? ? ?    ?        ?            ? a0
ls: cannot access
'./mesa_shader_cache/56/af44c0b3f9711d3d2fdb577beb527d95a9ae20':
Input/output error
-????????? ? ? ? ?            ? bc70b1f1d2efc3fc867739909e6c3f586de8e9
ls: cannot open directory './mesa_shader_cache/77': Input/output error
-????????? ? ? ? ?            ? af44c0b3f9711d3d2fdb577beb527d95a9ae20
ls: cannot open directory './mesa_shader_cache/a0': Input/output error
ls: cannot access
'./mesa_shader_cache/cd/cb796d11e04af4607054e2b7230091f5e7dc4f':
Input/output error
ls: cannot access
'./mesa_shader_cache/f0/b401bcf9f5add776020730e84d31f4e3ac8366':
Input/output error
-????????? ? ? ? ?            ? cb796d11e04af4607054e2b7230091f5e7dc4f
-????????? ? ? ? ?            ? b401bcf9f5add776020730e84d31f4e3ac8366
ls: cannot access './mozilla/firefox-esr': Input/output error
d????????? ? ?    ?      ?            ? firefox-esr
ls: cannot open directory './mozilla/firefox-esr': Input/output error

kota@home:~/.cache$ sudo dmesg | grep BTRFS
...
[52524.008236] BTRFS critical (device dm-0): corrupt leaf: root=258
block=583989673984 slot=0 ino=19219306, invalid dir item type, have 0
expect (0, 9)
[52524.008241] BTRFS error (device dm-0): read time tree block
corruption detected on logical 583989673984 mirror 2
[52524.009237] BTRFS critical (device dm-0): corrupt leaf: root=258
block=583989673984 slot=0 ino=19219306, invalid dir item type, have 0
expect (0, 9)
[52524.009240] BTRFS error (device dm-0): read time tree block
corruption detected on logical 583989673984 mirror 1
[52524.009537] BTRFS critical (device dm-0): corrupt leaf: root=258
block=583945076736 slot=151 ino=19219306, invalid dir item type, have
0 expect (0, 9)
[52524.009542] BTRFS error (device dm-0): read time tree block
corruption detected on logical 583945076736 mirror 2
[52524.009718] BTRFS critical (device dm-0): corrupt leaf: root=258
block=583945076736 slot=151 ino=19219306, invalid dir item type, have
0 expect (0, 9)
[52524.009721] BTRFS error (device dm-0): read time tree block
corruption detected on logical 583945076736 mirror 1
...(repeated a few times)...

Is this the same kind of corruption as before? Or is this a completely
different issue?
(As usual, none of the corrupted data is important so I don't really
care to recover the data. But would be nice to get rid of the errors
so my backup software stops complaining)


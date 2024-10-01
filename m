Return-Path: <linux-btrfs+bounces-8400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA098C4ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FFC1C2389B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B21CDA05;
	Tue,  1 Oct 2024 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRWlSe48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FD1CCEF4
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805318; cv=none; b=rmbwDkRLvLmjQ36yoSWXHtZwxmD0jzK14rTdVKUk23l92VKi1YbGar4iEsJWBvI8cNl7JbsRvA3fVRaVn4Gq1qhtDne21tQOxl11NL0TO/bDFxrONpv/0ZXdrznHu7/u2nbEGj1fR8KT/zBbmtzio9LWm1SM479RdhZZZGaPMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805318; c=relaxed/simple;
	bh=j2MlapMuA8HgwYV774MYt3PEVLynbUxpU5QalrWQ2/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf7hM3W3638rbeZeW7On/UOG2cYtJvpi3FjDyKRA3SrPhGmo860T6K+bF0iRQEGveSFYW9XuFwoBeomF+2xgW6ne27fygBHQl1yoXOpnyFJrODj4Rmz6ZJ6zrpYLTOjiekzgdwKHUDqomM9rZ7hWXk9VMg25la21P9Kenv/8Kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRWlSe48; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a706236bfso475454466b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727805315; x=1728410115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j2MlapMuA8HgwYV774MYt3PEVLynbUxpU5QalrWQ2/M=;
        b=lRWlSe48MLJSGVRWOTQy+qhxcUMmVIX3knTXCGK9+Dn+gnQF3zGNd9MmOpB9iGCImm
         9jfvg2Ew/iHgf36reo+FexFYwgmqMTBTECXKy87umpMrGhtnxwSVyBKxZh6tOKgiCP+S
         c+y2c6seEy0qSWu44LZgmY1acWtexxHkQwBThNcRZEjWmt8rM4Ku1yxadY1s/rU6FTvo
         r3SkPEEFnCaOnx5AQCcOrUWixiQx2q/Ha/AtI2etrvUASX439fvGf3yID78Csp79To8T
         4vC9g4wzNztfaYdDf8+QfifpsviFnpUkU03Ng8fBxzzOAi8VJGJTz5U2De+GZEVic+K9
         V75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805315; x=1728410115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2MlapMuA8HgwYV774MYt3PEVLynbUxpU5QalrWQ2/M=;
        b=bXW/ELjyuVEGDNjaT8c7ohHwWT9asGDKgPsBK/uXq0fMFECvW5nVQttEQ3+kgMgOkG
         K0NgYho1R7ezTL1Ln2qdqmz2nozXIQMw8cSroeZeAog9F1AyvmP9AJXKV0qfrmmGRJU9
         nWJHEqJ+pDdme0eBtPF7E7OE/SdpRkQmMuy/gLgeqPAxRgOR1oHCIcjLJpavu+zwV5eQ
         llPKpEq1YudTjsk3P9ue0fwp1JOuwo9ywZ1oxA0eoBCrzwuoqO2cwP5rePem0wD+LCiz
         D1W1JJzagUyfdjuzKjz+/Nn9zOkTim4K2xhrNwM/R8wL5YkTvMoV4GpEDMSXp3pMru0/
         IyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4JIlqtIDWAyesC8pNZt3LauUVBVMDEz+dsQtFPs65idHYDI71P7NJLhu0Urbxn+nsj7ZmjtucM+czqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3QXKvVRC40HpP+8e0rroArmuiafcdZ+Si2bIJdmMbrcBvzOr
	S7Hi1lBHtdd+mNpi+5GxdSlGgt7/nNsiTspLrFDZglUDE55F5MLdrHFOTNnBKQC7lJdDYhONqH6
	Utn36jKy/U7GhvJ70lLDVII4fu3M=
X-Google-Smtp-Source: AGHT+IGuddhj/GrPsc8Na8q6qw8Fe63zLaGUvh4tBSlGee6kI5n1e/npZg28wPCIOhz/OmakA1H7PGA49gw3fXReevg=
X-Received: by 2002:a05:6402:42c9:b0:5c5:da5e:68e with SMTP id
 4fb4d7f45d1cf-5c8b18b9df3mr250954a12.3.1727805315198; Tue, 01 Oct 2024
 10:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
 <20241001150941.GB28777@twin.jikos.cz> <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
In-Reply-To: <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
From: Matthew Warren <matthewwarren101010@gmail.com>
Date: Tue, 1 Oct 2024 13:55:03 -0400
Message-ID: <CA+H1V9yT5+EiirhRL0a63zT+YhDT6MyM-09JuC+kGqXQJ2ZjBA@mail.gmail.com>
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
To: Peter Volkov <peter.volkov@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> so this bitflip most probably means that my drive is failing

It could be either a failing device or a memory issue. I'd recommend
running a memory test to rule out the memory being bad. If this is a
multi-device filesystem that uses a profile with redundancy then this
is most likely a memory bitflip issue.

Matthew Warren


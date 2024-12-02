Return-Path: <linux-btrfs+bounces-9998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E89DFBA7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D2BB22B55
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942DB1F9AAB;
	Mon,  2 Dec 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn6lEJFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D71F8AEA
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127017; cv=none; b=RiU2UbIE2ov1o+WvWN1wfIVxKEqHtHmEim490YHZKNswNNIXLeOfFl06WnwcJ/PSPPawPC7LUvGuqBT5o9QNBaZJ/pFuKbXSLv5q52TUmcOeX+dVujyzT3pvKNDEDz5YxdeWTm4Yi9IFx/Hr37JMgP5KE4VCZ720JLPj1ZMHakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127017; c=relaxed/simple;
	bh=xKoGLXjgzc+SsMJYIzQjZlKWEPzPr8SWTtGptt/vfd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YSwSTDJRpG1qGt/rGkPJx0Uwk4evVjE8KcZ0IUuvmv5yN90TRLpDmLYDvzJvIJJkt1BA8PQg7YHoHNpdArVgm+/lPD4rYcrhegtRPFjoYN/xmXyLM66frh6R4OSHcV0GeOfJtdpL0AmYNCNMV4HbLISVcCks1qUIqQzHZh4P3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn6lEJFy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3983426f80so2517314276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2024 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733127015; x=1733731815; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKoGLXjgzc+SsMJYIzQjZlKWEPzPr8SWTtGptt/vfd0=;
        b=Mn6lEJFysMmd4PrSmBxvgzEuhabl5wsD/XAd/O3222YvAKADJnhxBwLoLdYgkFe6sl
         VhhXtVVKeNB/9qFZG2WStTUfbUQsbJmxjHfSIZ1pCT0hat9WQjvtV2jVKqgOGX/fgAj3
         1c8DYqGsBpFW8jIoRWCMJCNNIb5oyMfraYs6SUucg6V5Gknwj07rgrWKb13k19SYMOwT
         v1+rjSGyT+ffFpPz7Ua5aHQ8DNuvukCVf0Pz3Qx03tvRtj1TS5EeuEzzmFfEf9/FvtKH
         ZbiurmZvfyJuCbcvsdTp13jRXmvICacNiw7LI+JVaK9Uv4p4ToCLapc2FWJe3MJrWe9D
         l3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127015; x=1733731815;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKoGLXjgzc+SsMJYIzQjZlKWEPzPr8SWTtGptt/vfd0=;
        b=uM6T1q3GVwicMtuYflr9/Qt1PsTishppZemRatduTcHqNsU5dxyFjC9RL07cfZBjz2
         SMo0m0thdnza31OFwa4dyNUumectgwwBCzM2KxUYtmzu1aYdHdUPlkvq0cJHDRS7pt+4
         xmEIaDG/rMA7Yvb4VWLKFdzDV2x3vxwcxRukvgJHflrfI1wQttqJ1OPfcoXumbkb5w+I
         8YrLl0oRskJEAYxrSiNOtRBqbTRdUPBd7dteyRHnuZ7DAx/GI6dizCMIH5rXSYayF6dp
         m8vXlV09TtlH1iiOAK8/8ZdVN5EEXJwx0ybhDG3OLU9ZLxlRmXNKpyjPmG602jIr1WPR
         U4Yg==
X-Gm-Message-State: AOJu0YwqotPkvdwil5RccDuX0/oI0Pdm6vIiDpRCayTeKGramO5y2UP7
	iwkCCGNdUNLHEcQtQANUWqFP8s0OhesfKZE35SMSGL8qR7xGOgQ3J1ZB7v/V+vho8EHEeeCXRRJ
	IW1aJq43pTGeMCn+dT9AJWjehv6jTBA==
X-Gm-Gg: ASbGnctrwY1TRsqX5itrPMndhST7KOUeGrsNUKMdIM+9jsuudYdW906jytLTuR+S7lB
	ClR/MIop/RkMm+e/lDy63i5aD9QAoDqZH
X-Google-Smtp-Source: AGHT+IGsmVaotmUzP9heYwMV8Ul1D+6uo7NutD7eNbJoYOhzey1gD90fmPECjOAg2o5+rsNZF5JyGPsDuqyA73dnOOI=
X-Received: by 2002:a05:6902:1025:b0:e35:d8b1:571e with SMTP id
 3f1490d57ef6-e395b86a08amr18367808276.10.1733127015432; Mon, 02 Dec 2024
 00:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
 <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com> <CAFvQSYS650FwYj1n_2yZb9x7hw3yui4HyK87cA6pdNP53tav+A@mail.gmail.com>
 <3145e2ec-a25b-4d9d-a5fe-00e0de5fefd5@gmx.com>
In-Reply-To: <3145e2ec-a25b-4d9d-a5fe-00e0de5fefd5@gmx.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Mon, 2 Dec 2024 09:10:04 +0100
Message-ID: <CAFvQSYSnXJvnqM8SD-SPeyS2TKM3qJ+0-UVZTwNZYj2uXHDynw@mail.gmail.com>
Subject: Re: "fixed up error" during scrub reported multiple times for same logical
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qu,

> Yes, single data will never be able to be fixed, thus this should be
> metadata.
>
> What's the profile of the fs?

Data was single, metdata and system dup.
I suspect the SD card is simply trying to "prolong" its life by not
correctly reporting read errors - one of the reasons i decided to use
btrfs.
As I am not keen on replacing the card as the pi is rather
inaccessible, I switched data also to dup.
Thanks to btrfs' send/receive backups over network are super comfortable anyway.

Thanks again, Clemens


Return-Path: <linux-btrfs+bounces-13445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F38A9DD24
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A22465A53
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E81F5825;
	Sat, 26 Apr 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfRGxfoB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B091A256E
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745700145; cv=none; b=AhKSsUrp9ILSsxJ0ExHa7+hiFSugDIvYKYSSHlKbz3IVRAkIqT1n0uqe3f41G5DyFR6gLP/fcPGIcS3O0nX+8/XaTS7WbIze1WLNA+gV3CaWqasPH9uw5FvE0tUMKWfcQ6Eifymu0ANh9q/XeoN1CZ56Vv6kY7dweSS1aRX3Obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745700145; c=relaxed/simple;
	bh=P8MqfKApKNTrxMY8092hEwpuDAis6zjKtQGlD9MSgVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XrPBAlPZkEziXNX7Rhx3fD2uOdee5kMIpoFsMr2EU0qr/17x70tJlPOoqExrlSi8fkVIPfh87q6weMt0vuqeBWXwzhSq4A9u14E8X03MmNPGdTfB4W68D8Zo1vl/oYnXy0pboXn1pGfaI+dxZTgWDaQOFrfkjsKDI1TP+ZPICWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfRGxfoB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so5723033a12.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745700142; x=1746304942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpfBA8z6WVRRSDTtryNafg9P/JhHVrgIh2NslRYR8tE=;
        b=RfRGxfoBy0yuRF0iYVKIrZqhx7BmqGw46ZSX27jbxSGHBiRV/PAJQZfPCI62mumKgy
         pm8wLCwZzMvnR7QJo+E5hctlncxwvCTWPIJJYFRlBAYl/9pbDnTU7sR154gM8N24Yfga
         ig8hwIN+fe8CyKGKyyRQTBQ8hNJENYEcHCpP2ycmqJwgylR4qY3yULI/EXF5iBOcSgdy
         wnivVBXUD8SAPfeTFJoBZi5ekadGxwCKNlzNIuAXir2ZxjxvSrUQVrZR811h4Z8YJeT+
         mYhQva5R7R+zmVm3Mk9tYGbb6+CPbkR3ZMoybI0/vAoU5NwlPtQmqbEy2bqbwj2n5esw
         JM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745700142; x=1746304942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpfBA8z6WVRRSDTtryNafg9P/JhHVrgIh2NslRYR8tE=;
        b=gluiGMzLb8fd6Vdw3tg7RxJX6H0pKq5zdBHO8Mt7oed1BkcQAJ7pxkp+fNRSlEFkQH
         224u7g4O1qnAOSJqdyqUHI25SBjiTkI1xoysQa8ny4Ws/roQ+A8HlSX4hsW1YIruqIqW
         czoVVTu3HNZ+o3viLNurnoPYkojCLH+1qoc27KaZtOXARDmest7bNX0VDfnb9xjllzJw
         n2krrT7hLE55cIZytj5Wv20QfN9V1bPRTdYrt7+3HlOJRm35UAtlsI5+Y61jpdttXjy9
         mdXBqs5SPoAfWtYIQ5S9Yw6D83tUvz9rrWPZrxZ6+X1uk1PDljtvQ01nS8LdycePwYM/
         vlZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/IqP9yhwCftURmvCUsbuqwY586R4KpPCIjPbZJAM95e/FVM05AFszPGR/6/kPio54ud3Olm/k6U8pFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQuKilN4sSJNb9NFbzVLKME190qEDm68XDNLLVr+20+cMDR3v
	jSkMKXwiPhp8+Vpx413AKXEwiCi+5lJV2uRBRGADJd3UAvaIBnMe
X-Gm-Gg: ASbGncv2BAUTU8REgzHBRp8x3hisA7aWELg2HxPB8UzClUkYwkASm4VLeyk32dGEhVX
	m4KMSpt2CF++NgFhiU33SYoNd8/G6CTCPXmRqxdYbczyCHvCc7rDnrnPualDesdtbABSYflOgyx
	/G4fFN5W053/Xz+5zSGAm2eWqHX8xmTECGqq/1NvAz7IyuuTl5f0SICgSpJK0gHlQc1y/00Cgdw
	DnNt3oOno42gnpcvblSWAhQvNhQC1RO89ExsdAY9nRxv5luemGikYaLlYp0eG4kjKtRRkeXFDsc
	QKe/ejAZAK6OFMrf/0UP8UCqvQBPrJTucH8g2K/8IafBagmUANi7MWn4v8ldC0Ut/DNpSbFDRqI
	/HzG8cLD5lFXZ+0utfoYCAjA1tW7HAupjEdaJ/ud1td9EiDE+CRYNGNh8/m8yinR2iCIc
X-Google-Smtp-Source: AGHT+IGvhpC6a2G/lN1n+3ww94UvgjjoKd3LzyixzmNY3uDs7ak6q7lpoHbPMDnku0G/+16NStQyQQ==
X-Received: by 2002:a17:907:948b:b0:ac2:6910:a12f with SMTP id a640c23a62f3a-ace7133c7f5mr605628466b.46.1745700141379;
        Sat, 26 Apr 2025 13:42:21 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:b4b9:d84:88d0:f6eb? (2a02-a466-68ed-1-b4b9-d84-88d0-f6eb.fixed6.kpn.net. [2a02:a466:68ed:1:b4b9:d84:88d0:f6eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed704bdsm340670166b.148.2025.04.26.13.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 13:42:21 -0700 (PDT)
Message-ID: <4012f82a-191b-4023-9079-0dde92eff242@gmail.com>
Date: Sat, 26 Apr 2025 22:42:20 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
 <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 24-04-2025 om 01:24 schreef Qu Wenruo:
> 在 2025/4/24 01:36, Ferry Toth 写道:
>> Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:

>> While here, am I right that we can not generate the rootfs with 
>> compression on?
>>
>>
>> Reason I ask is, Yocto of course builds the rootfs and than has 
>> mkfs.btrfs create the image. But it runs as unprivileged user, so can 
>> not do mount.
>>
>> And then can not do defrag.
> 
> We have this feature recently thanks to Mark!
> 
> In the latest release v6.13, there is a new option "--compress" added to 
> mkfs.btrfs, which must be used with "--rootdir".

I built 6.14 while configuring with --enable-lzo

Configure says:
	zstd support:       no
	lzo support:        yes

Finally running mkfs.btrfs with --compress lzo

I get:
-EXPERIMENTAL -INJECT -STATIC -LZO -ZSTD -UDEV +FSVERITY -ZONED 
CRYPTO=builtin

And
ERROR: lzo support not compiled in

Strangely: when I run with --compress zlib and I check the resulting 
image with btrfs-compsize it says:

Processed 8969984 files, 2574779 regular extents (6008702 refs), 5007593 
inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       91%      532G         582G         820G
none       100%      489G         489G         575G
zlib        38%      350M         902M         926M
lzo         46%       42G          92G         243G
prealloc   100%       99M          99M         678M

Seems like it tries lzo anyway and is mixed up about support not built in.


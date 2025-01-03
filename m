Return-Path: <linux-btrfs+bounces-10698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB85A005B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B003A3A3D58
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035371C9B62;
	Fri,  3 Jan 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4qx8j98"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762C1B0F2F
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892512; cv=none; b=gS0X00wbAey0eqipqMXQE5hdUix44Kv8ZIlu6lHacTLyEh320twSm+Wfy9p7TP01qgRzvH6iU8l90ZTgeY5m6rRMyMpjHOesCJ8mTWG/i7XsbPoJWqfWjzookxUhuKfiJti6TRQdngcLabJvlwYc05qGFsc1m5lUsnSIAyVWR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892512; c=relaxed/simple;
	bh=mWfP3B1P0PFGVRLYq61Qf2pyiRniUFLezpAp0t+cI9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=npsZ8A/1mLqcV1BnT7JyFVLtrWVnm8u+1TN++euZjWEwkOgwcOlkuFbqY6TXOOEOWIpviA65usgO9Y6xEJbE4QBFKnTUDZNqGfjmKaSkSCPOfnoAcaiTxz10waGrIea/lMTEpZtR8wh18RiCdnmNwvph7hMBClzgilL5ylDogDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4qx8j98; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6a618981eso1981148466b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735892509; x=1736497309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bL8WGj4mbaMRTCzkJT2QRt5/XJzlLy71DFGvGb72R5Q=;
        b=G4qx8j98myyUJlgBtoDp7NdiPxVp8I7H/fXO02MbFXHyGI/imQQMpgRwR97RxIosY+
         FIecnZcMZqvrYlf77cP+5KyQk2Fff6KA58S66nNYNKrmsVsehrmRaFhk5K9rHF9B41UV
         qRWyZ76jdGm8FoBlJzqQC5QHlTADGFqCjlnynWSE1Q/X1BCwG/uiB0QkP56Qq+qibydK
         4p1oWUNG0w8V8cIaDkA8t44+EyH1WTNheLrurPaYniIErK4+M9biFOqVPK/1Mu61E5wS
         o4vGBih19wrogx1//q5d9bNRvHGTHptuS8pktTbqWLKVfcQ8Ick4xBHpChYZvV0Nzhxy
         CSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892509; x=1736497309;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL8WGj4mbaMRTCzkJT2QRt5/XJzlLy71DFGvGb72R5Q=;
        b=OXkqCZrGiT/6C8/erPM5GwQxurYz4xc2dcVwti6/bP5rEaSlziMmBZ1IMANWDM3cja
         DN8N8eDwLEcnV4aRAd0x/csKx6s7HVvw5RtDbEqTCPo8+83j4GZQjy2/+Nnns8YxGpC0
         AiDWCkYY+AEk0HqzH89Dif7izKUowsGerrnw8W43PuMsRKpwHxw9WeRl2sN4XcBn6+ey
         l3SKmUIPL6uiFIYACcFufI78MGXXgmw+RK3TPRjTwfT6QM4u7QWk1sf71gnzdmDTSTVd
         aQtkpV2eGqDn4hW5rrqVD3/8XSlpDJs3g7+zbp3j2o8oRm5yamM7bOhpWv5tXc7dd0nI
         PByg==
X-Forwarded-Encrypted: i=1; AJvYcCXE98MAjdvBIYnqGG0IutLKmclkMpfTR39AyiV3h7iwVtcMol5tTiWcEv29/8ZabNJdB+oZ8r6hm4xU5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmtRsUnbyAyGMYDN59cg5BV1bSSsssmP7rHLouy8ibzDJvU+v
	0Dz9pu6xAgbeZXAia2xatK9uZAl2BDS5sfGTCKH2ha6SVW2TgCoy
X-Gm-Gg: ASbGnctyo8DRWL9AO+JcLW2n04Q/fIp9A/BndMwqTnW+7McEjtPK/XfmcGZWz+pjPIO
	nuhA4UcKuFNxsdn0F65q7WaZiu/PqpyfnjvdMiMkwqB17UF+tRz40hPcBPKVdNnUCnWro3VK7nS
	B2L80znGqZILElfH83LUXtdy7ss85cuG6uLNunno3n3APMhW4BV9hoPTNhBtbIT3DePUVG9WnaT
	qOmYvAyTAEqQebIbFT+78phLMnjNpZc87ZUzZTUoSNkQubEkaQ6to6PK91sItfckvSoetQ9/HBI
	vimHCBq2oJYwgMVgedJxlLNhmI/r1EV/jZgNItY4IHZMajlhV9HhmSubAieyeoNibZYmcc65d/R
	kqNFZEs2vr1ibEqo=
X-Google-Smtp-Source: AGHT+IF9s06RJVFozs6YTEHE4U6J0E6fKUZdg2jCRoKP0WGZhQIe8szlKBXxJoE9z2oWJpGvlpgwNw==
X-Received: by 2002:a17:906:c14d:b0:aa6:800a:1291 with SMTP id a640c23a62f3a-aac2702af66mr4044203966b.7.1735892508355;
        Fri, 03 Jan 2025 00:21:48 -0800 (PST)
Received: from ?IPV6:2a01:cb04:91:ab00:546e:9d21:e7f5:ca84? (2a01cb040091ab00546e9d21e7f5ca84.ipv6.abo.wanadoo.fr. [2a01:cb04:91:ab00:546e:9d21:e7f5:ca84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f3e8sm19051522a12.43.2025.01.03.00.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 00:21:47 -0800 (PST)
Message-ID: <02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
Date: Fri, 3 Jan 2025 09:21:45 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS errors following bad SATA connection
From: Victor Banon <banon.victor@gmail.com>
To: Roman Mamedov <rm@romanrm.net>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
 <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
 <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
 <a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
 <20250102183329.35047254@nvm>
 <5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
Content-Language: en-US
In-Reply-To: <5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

`find . -type f -exec cat {} >/dev/null +` returns over 5,000 entries 
now. After `echo check > /sys/block/md0/md/sync_action`, `cat 
/sys/block/md0/md/mismatch_cnt` returns over 3,900.

When is it time to call it quits and reformat everything?

By the way, once I inevitably restore from a backup, is there any risk 
that I backed up invisibly corrupted files? I'm pretty sure my latest 
complete backup was after the SATA issues had started.

On 02/01/2025 14:40, Victor Banon wrote:
> On 02/01/2025 14:33, Roman Mamedov wrote:
>> Btrfs stores checksums for data, so unless you turned that off, reading
>> corrupted files will return an I/O error, not bad content. So you can 
>> just
>> reread all files into /dev/null, and the corrupted ones will be 
>> unreadable.
> I have run `find . -type f -exec cat {} >/dev/null +` a few times, but 
> issues persist even after deleting all the i/o error files. It's like 
> there's always new files that get borked.
>> Overall for your FS it's not looking good, there is no proper fix for 
>> "parent
>> transid verify failed" and this may require a reformat.
> Sad to hear. So there's no way I can fix this by deleting corrupted 
> files and running a scrub? What's the best case scenario here, and 
> what should be my next steps?
>> I remember reading something about the mdadm RAID5 making this issue 
>> of Btrfs
>> worse, due to mdraid "write hole", which its PPL feature is supposed 
>> to fix.
>
> Sadly I have heard all of the warnings about btrfs and RAID 56 much 
> too late. More recently I have read conflicting things about whether 
> or not that issue was better, worse, or the same with mdadm. Not that 
> it matters at this point.
>
> Thanks.
>
>


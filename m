Return-Path: <linux-btrfs+bounces-10701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE608A00967
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 13:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7513A3FA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77B1FA157;
	Fri,  3 Jan 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddvmn0so"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F213AD0
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908151; cv=none; b=BbbHW2p98q7NXWdVT9OisgHLYl2e2U5Bb8X7yNWlqpaOOv3Nkb2+dkZYEH6V3c1jluDdkG/eUh+ZHqZsmj35V8/tm39sEZlLibmumoKCRzaKUBmPsTEbkiccwrCOc+Lh9GP5jaVPCnGypPtBlJ8354PnTOQxaYP7NKFAnt4BcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908151; c=relaxed/simple;
	bh=FB40DxFffvcBSBoLhwA8+eJ337rpTYhZnRF8l4x8zdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf574gbua7glZZjRLwm2ytQPllhy1h8XiZei8D/577ru+StVKxUn5NRxxUgSI6UtnQ0CsDxYHAWCMTi74sRSg5QQiF8QA7bWs50PWAL/d7WjELFFlVS8Oq1zbrM1/vCplmSrizGfzWpOoToss93tyqdCPSp2zdAgydt2euq3Zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddvmn0so; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862b364538so6991995f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735908147; x=1736512947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTsZXeOG2M0UnCWSEvBQ4vUeUXEzoxFot/27cEEjtTY=;
        b=Ddvmn0sowdAIgMY9NwbsvWe31bhaqmKlVDiFvT3I56bUDTurrHOSxdmI0P6ZxI+za4
         eGBs49FfgcOCvbi157/5cXIHZ96AH2/PfGB+YeUup0G0sz5KuqxrZ/g6IIwK0gykfOqd
         dl5/+cXsxYpWu0hnXl92EvJa/2FGh+AhXKwFP/sp526BZengxANZ41hTYzKY0PUWcbwp
         y+4P9TRCI4BzvA4bZTF1QM/DVabsVCn0FWC3idTLj1gNujqBDyCalNwbtRThJViutEYI
         1gN+a8SGbN5TLsyIXH5HBOx6H3fHr3JGtNC4d3q1rICnXY1/EgSyPc5CjyjB0Cd9NII1
         EH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735908147; x=1736512947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTsZXeOG2M0UnCWSEvBQ4vUeUXEzoxFot/27cEEjtTY=;
        b=VXIesU14CLxOHTdFsWQXZfroPerev3rp5oQmDTYNHckCpufagBY1IIQdvQ/2cYrIpG
         t39S5Yjb0tSYWUyUSp+Fr16JWIvkOPWtDzpFpk9ISh8UiXMGM36FK5tzXDqbJZ3KkmXv
         nqUwVyQHdK2UxP97fZaY5NBAedco1Ngq4ToWRrjucQRzGGBAKF/JrdfQnAQ+tu0RfR+s
         exVLKOKnsTftdcjG9AJiXXH6bzD9C3zrlLgrjc+kvIfBb9GL0vFPReVpcpwqrncqtSAS
         NqSG8znW/rtfcWcUz0uOjvqHrs3Tb5VdViT4M23TGAKX9FjYQNyTOkyUhPIbIWAp+9c2
         t/tA==
X-Forwarded-Encrypted: i=1; AJvYcCXC/7FXaAez/CNMRo9+9eqchbnZKr2vgW+V/w7X+/0OWAS4ptjtNUxC7w4yxNhDoJ7/E9xVjQYxT9tZnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdx9KTIH/frORTyaQTHNo826cMocDa5h5NJhOauDRk4KUvfgjE
	n9zUMU/aSp9VA9o+AAqKsmeclbMt4C9o0pE2SEjd6x/+KtR5XmMkhK3jiLCnOX57Ow==
X-Gm-Gg: ASbGncsUHBuXSEldLQY1tHWw1U9o1I8Vyds2sdAY+wXoBwZqom+DDd1mQxWP+Ywy9DE
	oYu7vdQnMMTL7FkzYCeJV8XufwMXGokeARjsIOvZCMu1sh9yn6Cwjf2LXo0gWr3+Pds3PrBFwDj
	dqZkJXzmg139S+JKQ5Xgdpaaf99bh5fouCZHOuE72XALva+mWJsZR8KVHZRlHgIy0CLCCqntVmA
	vHGUI+oBLksY4PsXmHHaxS0w4C5J9TkurhkRpvOYsFoKDxN7zEtFJosqa9PWY16xUrEUKyt/XhL
	wOpJCkKUYTGI7y9R
X-Google-Smtp-Source: AGHT+IECtrABxyslMBuJDFn2+w1f+J6KPk3vV7Pm9phcSkjry5orylxwsw6aIDjtFNUJzqoyLM1GMw==
X-Received: by 2002:a05:6000:400b:b0:381:ed32:d604 with SMTP id ffacd0b85a97d-38a22a11b7amr46795403f8f.10.1735908146726;
        Fri, 03 Jan 2025 04:42:26 -0800 (PST)
Received: from [128.93.66.153] (ptb-02008469.paris.inria.fr. [128.93.66.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472d5sm41172876f8f.47.2025.01.03.04.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 04:42:26 -0800 (PST)
Message-ID: <032d71e6-954e-4fc6-bf43-18a6762d08b9@gmail.com>
Date: Fri, 3 Jan 2025 13:42:25 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS errors following bad SATA connection
To: Roman Mamedov <rm@romanrm.net>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
 <76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
 <f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
 <a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
 <20250102183329.35047254@nvm>
 <5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
 <02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
 <20250103170900.7016c4c4@nvm>
Content-Language: en-US
From: Victor Banon <banon.victor@gmail.com>
In-Reply-To: <20250103170900.7016c4c4@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2025 13:09, Roman Mamedov wrote:
> When it stops mounting :)
Ok :) So there is hope... So far the file system is usable, it just 
occasionally goes into read-only when it encounters i/o errors (like 
during a scrub for example).
> As is, surely it is easier to restore 3900 files from the backup rather than
> everything?

Absolutely! But I'm a bit worried because I've already identified and 
deleted thousands of files, and errors persisted, and new corrupted 
files kept popping up. It's possible I've been doing it wrong, so I'll 
give it a go.

How do I identify which 3900 files are mismatched so that I can delete 
them? (I'm assuming it's fine if I delete them now and restore them at a 
later date once everything is stable - some of these files are the ones 
that are not backed up anyway so I don't really have a choice)

> The problem is, it could be that the transid mismatch errors won't go away
> even if you replace all the files, or you might not be able to do so. Attempt
> to delete or otherwise manipulate some of them might fail with the same errors
> in dmesg.
So far I have had no issues deleting files, with the sole exception of 
the file in the trash bin I mentioned above. I'm not sure what to do 
about that one, apart from hoping it goes away if I fix everything else. 
Do you have any advice?
> Should not be, unless your backup system silently stores half-copied files
> into the backup until the point it got an I/O error, and does not warn you of
> the error, or you miss the warning.
>
Ok, that's good news :) Thanks a lot for all your help, I really 
appreciate it.


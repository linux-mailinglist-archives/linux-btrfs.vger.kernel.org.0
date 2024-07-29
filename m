Return-Path: <linux-btrfs+bounces-6852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D093FFCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F37283AF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A292189F33;
	Mon, 29 Jul 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8qQwp7K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15118786A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286267; cv=none; b=UwkLeLp0ycc5/05RPkS5HKe+gUTLUw66PfidCURYcymyz+LDoSY0YTOc959c4WdGyLetvMe+A/ztv/XByVaEM6M6MrBUd6P20mbTYr/ZR3zM2RyL4d6aD4L0NyOJQSShWcdqb3aSIm0jdKmTgpAUZ6/9v3wh6PZIkkmv0jj8spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286267; c=relaxed/simple;
	bh=5vDHTM0dfPxmzqIXXTE+JOdCX83msMmPHq8+7Gas6n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vp3OeAIBRQpFzLx+P1QIcZ0ALTayhSN6ymYorN/WwXfbSDP8g0iLNUF0v4Fqi78U38pJRoZYBzJF9EakE/GmZmbKtRzzBK35nXP9cV3Uyf8xGguLLSGwBtCg4dHfh8g32tUNMwub3NKPbyPp3EJYIW2/stXU/EWpApJhglSssDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8qQwp7K; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d0dc869bso281295985a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286264; x=1722891064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uj1MHBO/4p1HZXaDi7UMAkBpqktfxfykm5Z6pMHpAmQ=;
        b=h8qQwp7KMF/JSpXcvbZx8Tyl+D7mi7JiLVxQI1x+JGjUOMobQ1Er8U7pUrM17GS3Yn
         AdavqU24yW1l/Ffixh3g8d1fiLfQ1yDLkWz32xsaNRvEu5kaPz/LhhZgGIbrU/Pq+Gz4
         MQOlUtE7IrPuhU4nysurckytUb6fDSeVxTVAk6ZyaKpxt613zA9oJHzZRMd9q2WEu81E
         R9xQugtgP8W+PDCoaedGsa/5SudICYR6EKxsuA6tzhuQW9lbjgPD0PtY3xY23F1Obls6
         889DoRrdAAhmpsrIbTbbNu3QWkWwlUFSwVbxm3Z92qveRo4rEblSxgJK/iqcyPGiEm81
         y2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286264; x=1722891064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj1MHBO/4p1HZXaDi7UMAkBpqktfxfykm5Z6pMHpAmQ=;
        b=sVzP1XERqqynKBZ5T1E91ksVg68Zo+PJOL6hCRp8nJpUp7bVnpGKLznDLI0hoa12r8
         y3C/FgPXlIwuYYZdWetqy+p2GmeY+/IgZ3CdrJhOnV83Mn/SA9z2E61j4OaC27R8QKGa
         7rvi9T1N9tQaNrwDJhR5FQmXZYSdqGFEUoX8A55zSneQNYtCMMBhruNjPQKzIMj8YDBp
         VHidq7iVrZRaWn0bwGjJXIZq9DqxkOnZkksPo+XOmq6G0focnjQsJHkqrjTK0Ae9Ws8E
         tW4UjdBAMgizyERWMBowY26w63/NDeybFETrL4OqqpIJXlk1ytnIEdsCX3IXnjQXMqiU
         Y+eA==
X-Forwarded-Encrypted: i=1; AJvYcCXw5l86ObIBITPVsXOUuO7bQhC9THWwvR6mszVAH/ESQJ/epyfL2xAJOfKBHG7bg+Qhmm7DTKQtf9DXVYscDfw4fjN9yqVAT75ekYE=
X-Gm-Message-State: AOJu0YwT7OWqPGU6Ve3ZajU/weOIXwVh0AxLU0FEG5IQj8uPp6yQGaGb
	tTNmHw0saXBdDtJMNQkfAqqWJltcMXRReVSSqoRSwHsqByPr/2oa3L8M
X-Google-Smtp-Source: AGHT+IFg5o7GrASZ/slohzxqCWzvyHF/BAYFLT8qqX8D23arpdepwKy+oLwAaZog5tJQIyraQGz03A==
X-Received: by 2002:a05:620a:4111:b0:79f:148:d834 with SMTP id af79cd13be357-7a1e53175d9mr1197468385a.59.1722286264389;
        Mon, 29 Jul 2024 13:51:04 -0700 (PDT)
Received: from [192.168.0.13] ([82.66.65.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1ef65065dsm225648885a.8.2024.07.29.13.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 13:51:04 -0700 (PDT)
Message-ID: <8854ff40-bbbd-4e35-b0b5-f9f4820fdebc@gmail.com>
Date: Mon, 29 Jul 2024 22:50:40 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Virtualbox and btrfs superblock issue
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAK6hYTsFwBVXAJ3yBkBX-3tgmAj=1OFxN=2kybiovxjtTX4yOQ@mail.gmail.com>
 <43062b94-e758-4283-bf55-68d4f2f2fdb5@wdc.com>
Content-Language: en-US
From: =?UTF-8?B?QkFSRE9UIErDqXLDtG1l?= <bardot.jerome@gmail.com>
In-Reply-To: <43062b94-e758-4283-bf55-68d4f2f2fdb5@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 29/07/2024 à 16:32, Johannes Thumshirn a écrit :
> On 29.07.24 16:03, Jérôme Bardot wrote:
>> Hi,
>>
>> Sorry if I post at the wrong place but  I didn't find an issue manager
>> (like gitlab).
>> (I also asking myself if a not already post but maybe before i subscribe)
>>
>> So my issue :
>>
>> On a windows host laptop and with a parrot vm with a btrfs and after a
>> power failure the vm looks broken.
>> At start the vm drop down to initramfs.
>> When I try to mount from an iso (of the same os/version) i get following error :
>>
>> mount -t btrfs /dev/sdc1 /media/user/to-rescue
>> mount: /media/user/to-rescue: can't read superblock on /dev/sdc1.
>>          dmesg(1) may have more information after failed mount system call.
>>
>> and dmesg get following :
>> [71283.615636] BTRFS: device fsid 70bf0953-3ee3-481f-8a7d-f7327c6fba67
>> devid 1 transid 182616 /dev/sdc1 (8:33) scanned by mount (24156)
>> [71283.627681] BTRFS info (device sdc1): first mount of filesystem
>> 70bf0953-3ee3-481f-8a7d-f7327c6fba67
>> [71283.627711] BTRFS info (device sdc1): using crc32c (crc32c-intel)
>> checksum algorithm
>> [71283.627725] BTRFS info (device sdc1): using free-space-tree
>> [71283.639345] BTRFS error (device sdc1): parent transid verify failed
>> on logical 26984693760 mirror 1 wanted 182616 found 182618
>> [71283.642087] BTRFS error (device sdc1): parent transid verify failed
>> on logical 26984693760 mirror 2 wanted 182616 found 182618
>> [71283.645163] BTRFS warning (device sdc1): couldn't read tree root
>> [71283.646224] BTRFS error (device sdc1): open_ctree failed
>>
>> How can (if I can) I fix that kind of issue.
>> (i did not create backup/btrfs snapshot)
>> I get that issue on 2 similar setup / power failure and one with a xfs
>> system too.
>>
>> I'm really newbie with btrfs.
>>
>> thx for your feedback.
> This looks like the superblock didn't get written correctly, probably
> because of some kind of cache (volatile write cache in case of a disk,
> or some other cache in case of Virtualbox).
>
> Ypu could try to mount with -o ro,rescue=usebackuproot and see if one of
> the backup roots is still valid.
>
>
I try with the same result, the thing is with a xfs i can came back to 
life a disk with the fsck command.

Maybe virtualbox manage better xfs . If it's not only related to vb, 
btrfs can be a improve based on my feedback.

(ready to redo with some debug option or whatever, just ask)


For my issue i guess one of my only solution is to use photorec or 
similar software.

I will make update here if i achieve my rescue.

thx for your help.

J.







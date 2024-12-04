Return-Path: <linux-btrfs+bounces-10052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5609E32AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 05:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61B9285B0E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B0155A52;
	Wed,  4 Dec 2024 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyeF4TJm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D681219E4
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286582; cv=none; b=HgdbCu4bPHaQCO0K4ZgylUTBB+zc1S1jz+4Va9DRtg772FMPhwHcrkyQ3GNJ7zKrCiohe9gjxYG31CNSfoWzR3u8arOOQnrwD83NSOSkwvygtPGfI+zwexuWkAqKirV8wv70+EqDN2rOMKmJDxTu8tiXR/jWgN5Tp6NLB/Oaq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286582; c=relaxed/simple;
	bh=qKSxXUgLYF5gTifT9wX/DmqTndFVVYVV5BtJwFPVlpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eSXXi78n2oDcK8q7GYsYGxbfkUrlE5H8dLiuDehQekWyi/on28Fd4ODJaqzYR0Dm3PiQUKyfMHJqRyreY9415DrJVdMVxELGnt1Bsy04RvF1y9UifTlAm8YDsW25rqQoBBKkGOho8RgsXjt+E3XvYCWDXaUZMBFlozXvVCnIUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyeF4TJm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de6b7da14so6197205e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 20:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733286579; x=1733891379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0LZE0VPwLaR9B7O40rz/WJ8B5CqZjtefyLc1Yluf30=;
        b=TyeF4TJmittSB63YOGJ5BIc35j5bXpxwnIu/WMpat8rFjZtH0igW3wGHFCxEYwRWG8
         tzS6AfD1j+bgQcbyf52MRGAx9EHsKGsm0lRBPZNE6m+lOu6AdGuqzEDiIgnO6I15qiyo
         Ste8YVneQonOBZCdaBF5rNTQKu0sdKVg/tHj9Y1nU95mYKu68vnoNioIN9Twx3D/crnu
         sglcMzi75pF6J99sTWeoT6R0WGIqfh8GV4aC7/4R0pAU28SPAtrMP7bP6jOdgAPUpdOq
         U9n9z666Bt4GQ+REiStU1wqNsiNYklR7EA/WoJ5A0IQsy/jOLr70j2A5TUgFvNcyGXSF
         EvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733286579; x=1733891379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0LZE0VPwLaR9B7O40rz/WJ8B5CqZjtefyLc1Yluf30=;
        b=dEOMf/fDSODb+9YdEI6PX97MKCEaTDCKVUP/bhMV8NTvxdusQ2SXtr+TSAV3APSJx2
         5fJupZzqkpV3OROPJ4BNfk0+M7CsSsc7Q5g65xDE85sWDc4ndetslKioKigtYmVOQrvx
         FgFPB/zZZc0ixaQDc2aahBdWjFTXwctCYxmC28FLpwMKggmV6XsQIiIZbMYSdanSe04n
         ts4C/s7FDg5Tq7LCY8WH/rtgjjeTXMnrXXYAtqUJakmQjXTAuXQO9X6OldNd2hShVzhf
         xy6e6iD+g0Z8Ki2YR4KU0LEAVp1uYanvOOO3fcJpgJUEDoeYhbIVGu6wEI9krAq2KJvQ
         srkA==
X-Forwarded-Encrypted: i=1; AJvYcCXdjTcxj9C6NcHgjtWC3cv/RwJdWPsIJPY13fNu3Q0qtGgPP13eftQ4ekZ36Xy/BCdnIkpGOTBzh/Awzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcUyEEj5t8nCK02C//lXJEmDih1aDWmPj/C0f6utU/aufM6mb
	P3By/sgvXZJguxiH5LNRjWD2iwaEJboGa0Wff+kWgtBUVv+7jlP43FBHug==
X-Gm-Gg: ASbGncu8nK1O0C9DYCsNEQPPsh1db/bifVXeElsn92lGkoSnfERbMH1MtVh5+0R8LkX
	xLyzkox3krsXjjS8yBNFhAlix+8INuU8+FkXptNDSUMDUX1X+9uw9GNEiQFjSn4Gewz5hZsAWgn
	LO7SUYwyMXbFpybX0xolClBVDBd+sIEld2queTHylh94EYCHcwneoxgxHlGX7JJdWDEFJIFM8/6
	X+x6MXrlEFF/km0SJYfSRr6gf65CCVeHL8tLu96uTgLJWhqcVMVOMHueAjlzp+V+cCrd8qmZiWv
	1cNW7NJpMdAiTI7A3j9xRQ==
X-Google-Smtp-Source: AGHT+IE4agohEhc6VAMTs8WN0MNob+4afD8dTyyeEFgLnQdV3DSHZJkS+ong5saUEvtEHtt6+OvqoQ==
X-Received: by 2002:ac2:495b:0:b0:53e:1c4f:ed07 with SMTP id 2adb3069b0e04-53e1c4fed0dmr384948e87.6.1733286578774;
        Tue, 03 Dec 2024 20:29:38 -0800 (PST)
Received: from ?IPV6:2a00:1370:8180:3d9b:1e04:1260:b51:786c? ([2a00:1370:8180:3d9b:1e04:1260:b51:786c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649647dsm2064374e87.195.2024.12.03.20.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 20:29:38 -0800 (PST)
Message-ID: <a98fb4d0-1d80-4ae0-a79b-2acadb7b9722@gmail.com>
Date: Wed, 4 Dec 2024 07:29:36 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

04.12.2024 06:34, Scoopta wrote:
> I'm looking to deploy btfs raid5/6 and have read some of the previous
> posts here about doing so "successfully." I want to make sure I
> understand the limitations correctly. I'm looking to replace an md+ext4
> setup. The data on these drives is replaceable but obviously ideally I
> don't want to have to replace it.
> 
> 1) use space_cache=v2
> 
> 2) don't use raid5/6 for metadata
> 
> 3) run scrubs 1 drive at a time
> 
> 4) don't expect to use the system in degraded mode
> 
> 5) there are times where raid5 will make corruption permanent instead of
> fixing it - does this matter? As I understand it md+ext4 can't detect or
> fix corruption either so it's not a loss
> 
> 6) the write hole exists - As I understand it md has that same problem
> anyway
> 

Linux MD can use either write cache or partial parity log to protect 
against write hole.

https://docs.kernel.org/driver-api/md/index.html

> Are there any other ways I could lose my data? Again the data IS
> replaceable, I'm just trying to understand if there are any major
> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't care
> about downtime during degraded mode. Additionally the posts I'm looking
> at are from 2020, has any of the above changed since then?
> 
> Thanks!
> 
> 



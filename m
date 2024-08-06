Return-Path: <linux-btrfs+bounces-7018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF8949B9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE661C22760
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F2171E5F;
	Tue,  6 Aug 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOsYMvSS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA6374C4
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984905; cv=none; b=pV+2t5qaeAtpmN2xalpNU9mQ9I/0cYDEFuIQxINv97KT8UYpyhWKb0n+5JDNg38B0cxM9svkzHEWUsy/9BtuSKnGlSCoyMxll7Xugvjkjam+kSQ6Ad2LI9PXnI+QHS78XMCqyusdbk0oJtwcTU0e6CoiCvkf7ljANsziuzxWqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984905; c=relaxed/simple;
	bh=/u9cgUP1uQmadgDS/Tr4HroEqet0ZTDCE8yyPrqvV48=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EJyWnPtO/I2O2UmI6y24iX8C4iZ0O79Qrso2/C/j+ygVbdpY1nrPC4w7lu9moZfSEjdyvrkxaVQ917bjlRCub/2wrWCT2+Ov0LEzkkDJVYDBWeCyzhcsmw3o9LpSokAfjuh5UYfIOQ8Ob7ogrCQsc5907rrxDrAnJwMTcJGmn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOsYMvSS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so1858036e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722984902; x=1723589702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KalNrQSdtajI3OpkeyBvgsmYsjRnShx8qUtkXNjZr+8=;
        b=bOsYMvSSjSX70qla04oQdjWkPPpWvn7DsxwdFKCcATAu8FSiNGdgpxiw2jbhanr302
         2tIO433ECWsWrrP2PELrERPdFkiCB/ewQXUnezsNKk0grii53ac+4VvzQn/A68pUC9w4
         4JzodobR6P+2b58Uv1iR0c4L7ntxMnFP7O58RWBrLf3oXfFWLuhOHRegfdEl6JcE11JM
         CsCGtRa3R+tikEhdsCODTs+qbXEINIk327lu1puNiwVyq2Bbfw9WUjeGwk92MpKnsuu+
         L60edqxrVexjugZPPR4heKV2PDA75e3vxSGjY4BP66gHExsTycoCO79w4vwbUEeE3Bx7
         Mntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984902; x=1723589702;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KalNrQSdtajI3OpkeyBvgsmYsjRnShx8qUtkXNjZr+8=;
        b=OvC8zvupgj8GgOhzDB0RPcJ2ohPI/0KpKxFCGkd0eFVScz7VZbQ0BHIH/eGffi35mD
         ESqBx65Hv+IB1Yoc5VoRsdFj2K0LpFApQblhvRja4BI7UGZ2E3o8zP9Ks85PMOy9A3YS
         sDROYr2fHvOAt7tKYxR3WEo01jW3lhmeY24qfgwGpPrTdVdxECUANnNI948L9HPoAMxO
         XCqpCznz1hAQh6uERG5TlwekKolb43AkO2EA/8+eSOj4z1Skr6ctD6m+XGFjM0JK/zFg
         c1Mv8pBhXedOKCsT725fr+8QXAx5MefkzEHCelajY8OavcHwOd+jKky8kEe1Rmp05JZt
         xA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWHHLx3OS7rBNezzLrKkOARM/yUU4ZKZb7dVpKarpJSL0N0bTf2b5XZdwFdrxAGIazYPfG2WX844Ih0Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7M7BUEVZSK4ASFMkdNrmDjD7UU/JRyM+Ki5LYWQbALZNsWp1l
	Pikt293fDYnwbpgNpK+iir+vjhzYloa/1xbhbYuOss3cWYZclZxwoHNHNA==
X-Google-Smtp-Source: AGHT+IFGUTyRES5ldKA7cVCpuepgCcIK3L7oGDSDERY+eCGbafDa6XHfZiUrN5FtJqtthniyDhSX8g==
X-Received: by 2002:a05:6512:2302:b0:52c:dc25:d706 with SMTP id 2adb3069b0e04-530bb3b14e9mr10930532e87.52.1722984901257;
        Tue, 06 Aug 2024 15:55:01 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de4835aasm12633e87.305.2024.08.06.15.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:55:01 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <c55cbcab-450b-43d5-b4dd-08f2b5294757@gmail.com>
Date: Tue, 6 Aug 2024 22:55:00 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
 <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
 <69ac8794-8a36-4a67-ba54-c11c44bf5044@gmail.com>
 <0c6112d6-3d65-4791-9642-927c97f9b926@gmail.com>
 <97a1d83f-d5e2-4680-a694-2d141b0d81a9@gmx.com>
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <97a1d83f-d5e2-4680-a694-2d141b0d81a9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 22:18, Qu Wenruo wrote:

> There is an attempt to enforce defragging for such preallocated extents, but not yet merged upstream due to interface change:
> 
> https://lore.kernel.org/linux-btrfs/cover.1710213625.git.wqu@suse.com/T/

So, can we count that you are aware of the problem at this point? Because the main goal of my report is to make devs aware.

For me personally "Don't use defragment. Ever." advice is enough. In real need of defragmentation I can manually copy files without reflinking (rsync never reflinks anyway) or from another drive. Not a big deal really.



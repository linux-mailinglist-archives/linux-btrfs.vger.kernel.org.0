Return-Path: <linux-btrfs+bounces-7016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B5949B79
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9029E1F222D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D91741C4;
	Tue,  6 Aug 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+XruILj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F216CD11
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984176; cv=none; b=YDIiGkYiBK4XZmV1vDBxDLKaBsUAhx7lROfl9+TTCwjolf5lsc7I3SS4IgexxuAu/7aesoHVC8FJTfLZ11MErDLgV46g+BprJwgBNlwrce4jceeWZyYP/8UuUxLCv16xXHogqy5izWRVYVLCLUiCXtiWuErH+KZOcg+7d+c9yiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984176; c=relaxed/simple;
	bh=XeAKDrOqU7gYsVP5lSF9WezanVFyeBrhyKklkvu9X50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CN9SIqchPY/czefjsCYtSrWtpkLDQjPZpTTh/HNvkv0Lt+Resl/3P/qbezO5LqgN6XYwUV0JEyE6d4kuQNg0fHfDFMdals7lywpgva+6O961fiMf3nqGDuunQecj63dg7GxYSUijmhoALZKlO7c/2i2eelnP5yRysuE1WxXWyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+XruILj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ef95ec938so1489024e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722984173; x=1723588973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qk2nQqK/akMl5ViyBGmol0My49fyRxXfo4eunOOkRUI=;
        b=C+XruILjDHUJvVEFOLwqDJ6Ylq76CuItIXomKmb+WzlWESWuFhjmSXa0qGY/ouyevb
         y1/yuJYon6KidHjlKmZ3N81qlPyWe49gpPPq3Tj1PMo5YuQ3GllOTpS4EJcDiqoocB9z
         2WAMTf3OsqxtXBBzHfNaGs4aptZCiBxqRNHBvTW5wUEtjulCePx2HNuZjTC6jX4KQ+2H
         /SpL1zFHy+FBlalyfZuZ1Klg0yKHtsFboj1kHCbeaOFxeddJ3KyyaiYzmUWmojOIH5wf
         pwg/xzX0Tb99FSFmSZfL94kDfEtGNgONU7E4znwKH2LrCR8o7s6TVPTlJOY5QYZGiPwU
         f+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984173; x=1723588973;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qk2nQqK/akMl5ViyBGmol0My49fyRxXfo4eunOOkRUI=;
        b=MUbHOyQoTP/xcRBha9trY3x8NQwI3lsMIbGOc4UdA2g4Dl6/Gjnz+/vZnIRyNXPiNX
         uKW4SDscoM34LqLilA8I623nqR8MEQEZKPcN9b7Ydf2P6ECK2bQmidhp7eWKbllOpYEo
         2NeJYRIUV7WmW6vJB3PsjUsSqyQEkAQ6eC2WuaQpmAGc7P8n0/x+B4Ad+PED7pW2b0dt
         8BRjjy/IeF2Y2SuSej2sbzGDb/iDBf3hc8CmY+4qvXeIaUcpk84D73ysyKpx5/4oxSLY
         aMNmwkyMPg8ofObi1ouytEqK1VcYUpUaKlV7o6qEJyX/9sD6kqPPWv+4PrEAwtmSqUc+
         ovLg==
X-Forwarded-Encrypted: i=1; AJvYcCXbmsK2vZMpudEiYgoCA6pRF4tv8xzPTyu8ZWt1f65t/HrTX9ljy/6W80Nu2ACbibBnfnkmkwQtwac+P2iuC/QBkPzolMSRTwUrQFE=
X-Gm-Message-State: AOJu0Yy62D9g++cNyU8LaaeQXBnTiZow5C/Cs97Q1cOVZVu9jhQHW4UE
	uIvbUYgq+JJvOVMQS4z2A0NT7C+sKqni/extTzh51gpvpce1niEq
X-Google-Smtp-Source: AGHT+IFHdcO0eprNN1GwY5VJN4IxeHiLA1/IjH2tmzwjJckCegBJHScpCV1p/lOt9xfW0/+uac9FSw==
X-Received: by 2002:a05:6512:33c9:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-530bb39a069mr10891608e87.23.1722984172553;
        Tue, 06 Aug 2024 15:42:52 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2fd7sm10717e87.10.2024.08.06.15.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:42:52 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <a149ff05-73bd-4232-a532-8c5efb4a69e0@gmail.com>
Date: Tue, 6 Aug 2024 22:42:51 +0000
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
 <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
 <55a368af-ab0b-4bb8-b61b-53d20b163d63@gmx.com>
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <55a368af-ab0b-4bb8-b61b-53d20b163d63@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 22:10, Qu Wenruo wrote:

> But you're using btrfs for its super fast snapshot, and that will force
> data COW, causing all the complexity.

For me the data checksumming is more of a selling point. I.e. yes, using Btrfs in a NOCOW mode kinda defies the point.

> It means, even you have written 10GiB new data, as long as our
> transaction is not committed, you will only get all the old data after a
> power loss (unless it's explicitly fsynced).
> That's another point very different from old non-COW filesystems.
> 
> Instead "commit=" with a lower value is more helpful for btrfs, but that
> would cause more metadata writes though.

What about "flushoncommit" mount option? Does it make data view more resilient?



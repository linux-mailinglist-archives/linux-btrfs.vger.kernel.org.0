Return-Path: <linux-btrfs+bounces-7006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B994913A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1DBB29851
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FC1D2F67;
	Tue,  6 Aug 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUSxhdV4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA31D1F4C
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950579; cv=none; b=gsehHx+eMmeJMmOnJb/uCgrYq1m09rRVY7CKaDrkSl7uCehn0tUhgiC+lFNlU6KcRROf/mWuQOZSUstLC6uuUxF/QgpgY3mmrOXgSBgA9YD9MNuJUsbgI3i5hrBjyHlbQhtXVdUzAUsveH0pf3uEMNCyKDTgF+C3Y6tAx3Zm4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950579; c=relaxed/simple;
	bh=8ynV2Md3qj8nuXFwGDcuKe0GyGCCqFs+/tgZjA02y0A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EDaJw0WbQsZSq5Pxdh2H5QBzbvbAMJndr/+caIWNFuqkVwsHvjABI+o7nTBQFL1j4L9vEGVrAlqZQl6YPlErvblgd6GqQlP55GbgFAn2g58kjpRzirDS+uvsIXJhRilPJVRl+7j8PdDvlvoerUs+G/4u5GNwaB/F7E12LrsTMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUSxhdV4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso967222e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950576; x=1723555376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUo4vviXe9ozjJ4+Bm0z7UuROWrLxsNxbAGVBZzoDH8=;
        b=WUSxhdV46wpKQw8bVBtkZaav2QXn29onN+dWyfZh9PSbYVvLeeCYHFEAplI1jrVScu
         HQ0rSxbbpjpv6/GhIlwPom/+0AQhwXU9fhJypC1Ud3c0qWzP2kSKu4xS9QDXbohOFMc2
         Vsux5a0roOtBCiMVoqoH8VrkyEZYGXZtLk1V1v8qfrtR22Ven7orEosr/0HP9q3SSDhk
         Pv8hquHtOpYsT6qoQ2LT8s2yqYRc9yX42+aYzrX9agZiRSR7RkCoa3FnnY3ZoUIV4JhR
         Pau14GX6wp42QjKJW4myJXAY+bQZrdF3AteViufoaC5TQtZsTPUhKV+uAMle8YDWgwPw
         zZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950576; x=1723555376;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUo4vviXe9ozjJ4+Bm0z7UuROWrLxsNxbAGVBZzoDH8=;
        b=RF4ounepWjus8NreIjK2WeBLzypNN3VXA9ZPNwtQnxzlm30X5MVH7tkUB4R6wBMEf+
         +OCvDKb3B65ngBFZzpQr4ZKoCB14AkZsoQX49A82lrFWu2azq9MxRX3lGDHL2jXtXrie
         LTJRWxEz56WVNYETQUZ2kyDzLP1ZFikch5CuIfBHL5fEEVC3vt3XuHV+M81iBBp7AIx5
         opqpYARI/Qnr4lunHKVlxeayZGphK+FGORPQjEWeTh3qmm62tQXZlLzTRHHesZg+RwwE
         UK7odVAjK3DOgtICXpwi/1K9rC2Wm+i4MdzutrXZeC08afiYHueCqqZ3zz31ycYs7dFz
         pwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8sbsEMItcVqkcLCRUzAVNV8/MnxRznXYargk118G1oX2pExP7JVLnfmg3GSBCCvvTouVlbwPIPL2WFL4zFMm19b9GVv0JD58Bmsw=
X-Gm-Message-State: AOJu0Yw7e+znnl97oyo1nPRsjCRSHQhZGf5bc0PJtkI9LC5ue0oBKE4p
	4j1VrY075Zwf6QQxNNm9m12Tm69aC3JrkS+3+zh6hOgX06LKC5hW
X-Google-Smtp-Source: AGHT+IHHFbCALwpw2HC4lYK7ZLplhRlCdaNOqPPNi5bK+iKsegXulvdecNHsGpwUcZlWLIOwKAHWQg==
X-Received: by 2002:a05:6512:3c9a:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-530bb36b3bcmr9969637e87.13.1722950575492;
        Tue, 06 Aug 2024 06:22:55 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07de9sm1459726e87.61.2024.08.06.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:22:55 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <0c6112d6-3d65-4791-9642-927c97f9b926@gmail.com>
Date: Tue, 6 Aug 2024 13:22:54 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
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
In-Reply-To: <69ac8794-8a36-4a67-ba54-c11c44bf5044@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 12:17, Hanabishi wrote:

> In fact fiemap "TOTAL" adds up correctly to the actual file size here.
> So maybe it is actually compsize lying with "Disk Usage" or something else weird happening.

I reproduced the results on a dedicated disk.
No, compsize is not lying. Confirmed by looking at total fs usage.

# compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
Processed 1 file, 3 regular extents (3 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      449M         449M         224M
none       100%      449M         449M         224M

# btrfs filesystem usage /mnt
Overall:
     Device size:		 29.88GiB
     Device allocated:		  1.52GiB
     Device unallocated:		 28.36GiB
     Device missing:		    0.00B
     Device slack:		    0.00B
     Used:			450.82MiB
     Free (estimated):		 28.92GiB	(min: 14.74GiB)
     Free (statfs, df):		 28.92GiB
     Data ratio:			     1.00
     Metadata ratio:		     2.00
     Global reserve:		  5.50MiB	(used: 16.00KiB)
     Multiple profiles:		       no

Data,single: Size:1.00GiB, Used:449.51MiB (43.90%)
    /dev/sdc1	  1.00GiB

Metadata,DUP: Size:256.00MiB, Used:656.00KiB (0.25%)
    /dev/sdc1	512.00MiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
    /dev/sdc1	 16.00MiB

Unallocated:
    /dev/sdc1	 28.36GiB

Notice that the space overhead does *not* belong to metadata. It is the actual data space wasted. So the problem is real.
Which also means that fiemap is the one who lies here.

# xfs_io -c "fiemap -v" mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE       TOTAL FLAGS
    0: [0..460287]:     7335440..7795727 460288   0x0
    1: [460288..460303]: 7335424..7335439     16   0x1



Return-Path: <linux-btrfs+bounces-6999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56477948CBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BC11F21097
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230911BE233;
	Tue,  6 Aug 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKgksuVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48D1BD501
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722939830; cv=none; b=Z8Ro2m0a+tNBFqE+E4Rvl9h3CHhNjzWWoxnXlT3lpzzcJHgIc/0Iz3hj2YL4/I5S4xQebQPhB3dnVaROM73XVMol7gVYX7zvjP43+iP4RC26ZxHmYd1V6taYlnUc7qAPJ07aZleA29INamp3LWtQ06y2lEzhGw4cgktA6eTQ80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722939830; c=relaxed/simple;
	bh=1r54Rx+4bFkHj40dedbCdi/YLRjBUZAJjP81wVdLCoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p91lYpCsPDGinWdcgL2fJWx7xOhc1E3xzSUAdU2jrqyVaKQZ6uo6Xmlw+HPSQOiglHN4+pT/oHchak1NLCtFhchStg98Lxze1uK7oXeaJxv/9Gl+9zUaOrOaTngtJ/uF/kql4Uaxm1kAf8WuDISxfgkA8mLpsFmVi4eKQl2Jjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKgksuVN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530ad969360so701490e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722939827; x=1723544627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1r54Rx+4bFkHj40dedbCdi/YLRjBUZAJjP81wVdLCoA=;
        b=JKgksuVNu09rSk/3gJ1QpAKlhGnCDKmqswez++ltSLO+i6twRS20r4SaIuIZ2Rfo3G
         rvVLhKb8x26Uu2vzp0fXFv4igzZXPPb1JnyP4ybDxMf+akPO4XMePYHjKkv4n9VUQ5Sf
         ZRstj+AvGXRYkjVzyiWrbh3fI1C5Qi49g9fit8RYgpoCmiYJp30dVjpqPKxa8+NSL7Dk
         aG/4fvJp0URfJy3ZvG7UsqS7Rt2N7Wra7QHtw3AZzAQxj0V7bC6+SYdaBviv/KVvZuIL
         Ca5ejpO4f6XI4FK8wlngKumIcHm6chvdK0yqndBz1ea+VAyK+l5p/ae677tHO7ZMta4B
         25lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722939827; x=1723544627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1r54Rx+4bFkHj40dedbCdi/YLRjBUZAJjP81wVdLCoA=;
        b=vosGIWTWkzYor5d6eY7E+wqwlFyqXAxeJ8/c7BHm9YKAvLtEktiAP48yfziM4HKJPR
         95yNKqE81uYVz+mRnvKkRPnBclUykre+LhuKrbhvdmaYorszLdrR8lpK0fpd4ononN5p
         Ju3Kh89KKeGSIH5wXwbZz8YuLLE0wjNd7JsIC8A8mlpUDopH5Me7ntNEdBM5eAcSuSqH
         4EEOgF5ibRFrkC36cGY78KDw1No+rDDxOPVONU9XG2PjRdDPbIzv2QUf5qfBrEfSJtFM
         IdPa8zVdizPCJaj1VqvF5TbpIlBKpiYR7hnnqcs9cDxrcUOuSARAQPb9dmL1690Hdt7l
         nCXg==
X-Forwarded-Encrypted: i=1; AJvYcCUd4u9IegBWU03s+IhQPv5K7wu0aLMn/B3pBLJwZ+A1rPooqD7c5ihCQ1EepwIZRsYmF2M+47+/QBZurNT81qjYYLBQH1ITOnyTnBA=
X-Gm-Message-State: AOJu0YxRG5NR+gYervTM18Q4Z4rFs6yuU4Elwa1QsXsbua+59/SEo+fB
	EnCTJyiDWmANKZLNDUuAJEsBgy2dobxIMwkrb5Hs48tUMTfxMb0F9gUUNg==
X-Google-Smtp-Source: AGHT+IFzRQ0sFD5QjJ2NlPs2qnGkK3R8/nnH9Ir7PV4WL2Pp3e+r7y8q9Cq+/DyyE/NBiFv8a1nBeQ==
X-Received: by 2002:a05:6512:239e:b0:530:ae22:a6f0 with SMTP id 2adb3069b0e04-530bb3929c7mr10910877e87.5.1722939826180;
        Tue, 06 Aug 2024 03:23:46 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba2a0a5sm1405340e87.163.2024.08.06.03.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 03:23:45 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
Date: Tue, 6 Aug 2024 10:23:45 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 09:55, Qu Wenruo wrote:

> So either there is something like cgroup involved (which can limits the
> dirty page cache and trigger write backs), or some other weird
> behavior/bugs.

Yes, this line reveals something. I do have modified dirty page cache values. I tend to keep it on low values.

Now playing around with it - yes, it is seems to be the cause. When I tune 'vm.dirty_ratio' and 'vm.dirty_background_ratio' up to higher values, the problem becames less prevalent.

Which means lowering them cranks up the problem to extremes. E.g. try

# sysctl -w vm.dirty_bytes=8192
# sysctl -w vm.dirty_background_ratio=0

With that setup defrag completely obliterates files even with default threshold value.



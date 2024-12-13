Return-Path: <linux-btrfs+bounces-10358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C69F1751
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 21:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5211883685
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419591917D0;
	Fri, 13 Dec 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xBH0SIqn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6618D649
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121062; cv=none; b=dZdPXARPaQgQCWRrs5qhJUvqDuljiEYVO5c+edqcwYuTcymFbLAeIAhN46+SmkcfseIUyxlSgZldemDCk1oca0wS/TpgRrUzgRAKIq6H47nGCVTpxPGCYe/gwLH6m5oLV4scbL04CpJdy65r32WZtNZJ2kW5/xWbvJ91o+rNj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121062; c=relaxed/simple;
	bh=smCs9UmXtJPjFiU3uifpihSrf85xBBxVxy499zh6onM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XnsfSEKCu1L+Qi6F6dzGg8kQPqfSEs8kQlAI3g+G4Xk3C6jCiuFm4FEWytSzRF6XEpM6D+ZBzSl2qF1FFkVidmK984wZKCriisU+yWndfnnW+BpsEWCyTXZJ5ewBOU1uIkurFLQX3w19zejxIu9uAitw8UJDzIMQeVbI4ty4Otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xBH0SIqn; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6ed0de64aso205638185a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734121057; x=1734725857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lDloO6Oi1p5gWtp9SabZKV2wm3DDD9SCjB4kdUqBlg=;
        b=xBH0SIqn/tYfrWr7XUs34dlPTIi+zdEPBFBnyCtMSJppmbtnzZnXWxa8yD43FgKGO3
         7eHvEXhqZed6PescYmAb09WkP6WL0FdXXgrYJ/u145OZrLpgQcwo7Xt3VvjMe3tPgY1s
         pCHAwIcCV9WS45RaANtGHa7StTyal6BGmIWBkdmbVcN2OmRaL076ij3YCMEebnHkuHL5
         hkuvbaLeLvgm09HeumSHUqBVMyFicqCwF9DqjAg+2YErR3bdkkyD/5GAWetvXEc0+yGx
         lv07m00lsAIximzfFiqMybScLF+DlZHVmqAgSn9bcsgQwXiwMQiBZHibxlKtP1nUgVQg
         ARnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734121057; x=1734725857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lDloO6Oi1p5gWtp9SabZKV2wm3DDD9SCjB4kdUqBlg=;
        b=aDYj7j54O6gxN10ttnJW0NrKIBJDNzZ8Bn6AolmQ2EscPJy11rGkIWqQestytpGvRZ
         gP6iXD023gEBS7kzFFew64acMWvgVSu696MmYM7j1hMngUmAIBln3Jtn6gNDR327Z8S6
         FlUVLNwBRm8d6xPxWTpn2MWwf1jBhp5TnRBNWCceYbK0XoYCY/vt9N6DkeHj9Ejn6A7M
         SuI05JWKtAD0sJ4zKR7M2vmEEGbFYiqEyfkdOo4CUgsPkcHDLLvMxHploTOfVk4yrVnu
         B7Lr7mMfXxSYnS7ZV1XdRYIk/bQ9J4yflVYlqh7g3DU5Do+jgXrKqGENDIiyCu8XYEZe
         J67w==
X-Forwarded-Encrypted: i=1; AJvYcCWyPVYYCReZWRpjUHtaspG8KrBo3Ihlf3HR+uMa2k51q7X10iyKPAOVumZoXORnj82qHGMviQhn1lY2WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHh/gLxYq549L7NrTQvs0/UUeLIa8run6Nl93M9+ki0qdtfjsx
	q8mFoUJMykKhOdOExE/PgSKEjUiQSnY4aarTOVrxJ8LilBV8CanzsPjpIE8LwAONzeSpKVgz1gn
	r
X-Gm-Gg: ASbGncusMUlfTSp0UI257G/Fkr1VS5dgRbVmg3akCONn77nNQS+OAtDRgmGkd2hd6gO
	tlR0297N5b0VLeN28V/QEzXVXgmJus2N3tvqepzNLu8zQFp+ZIfVv5f8J35zG0yts0Hb8Lm1cDt
	W7Mr0kYJh9uQDBIK7/Q1n647beNy/SSDl6R2rIsfV1eAyi7muDMqNJnKWhypjQdk/IryqjYAcx6
	S59n7D2O9M/GD2/is0B8oL2xkXAjvMZkqWJvDuUL2Te7J+0HyAkDA==
X-Google-Smtp-Source: AGHT+IFWQ8O03w9sCZX7QdUh3+tEkrMGP05QEC0pcj2VGuP/WOMg+0K2J7T30/VuJZglaUiqpxb4ng==
X-Received: by 2002:a17:90b:38cb:b0:2ef:83df:bb3b with SMTP id 98e67ed59e1d1-2f13aba96a6mr12293455a91.8.1734119432568;
        Fri, 13 Dec 2024 11:50:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cd5sm3566691a91.34.2024.12.13.11.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 11:50:31 -0800 (PST)
Message-ID: <3464006e-e1a5-48e4-b229-4c1c8609164f@kernel.dk>
Date: Fri, 13 Dec 2024 12:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: don't read from userspace twice in
 btrfs_uring_encoded_read()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241213184444.2112559-1-maharmstone@fb.com>
 <20241213184444.2112559-3-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241213184444.2112559-3-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 11:44 AM, Mark Harmstone wrote:
> If we return -EAGAIN the first time because we need to block,
> btrfs_uring_encoded_read() will get called twice. Take a copy of args
> the first time, to prevent userspace from messing around with it.

Looks good to me, however I think you'd want to add:

Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")

to the tags, but probably whoever applies this can do that.

-- 
Jens Axboe



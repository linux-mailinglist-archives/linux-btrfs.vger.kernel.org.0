Return-Path: <linux-btrfs+bounces-9793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C49D4084
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 17:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224BA28241A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCE01552E0;
	Wed, 20 Nov 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iH+2mqbZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56214D28C
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121370; cv=none; b=oi9s9VHFIyKmjGWOXH87yQI7hVbzhBj3W80WNm5YpEDzYZrA0Fl3QA32gEAj8s/riYhGNscR3dLq4O1DOvgFPUaqDpCu/duLXLwrqdeqBcsk9qQ/rIllHiRsuNRuFb7i9UVLZD4VeVfQEfrQ7znFjfgVrRLxk8+UnVeI3GRtoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121370; c=relaxed/simple;
	bh=uTcW/OXkP/DVlYo+bDrcBN3tSEWrHeyWrIUDmBqXaFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dPd1PH2B2M9rqCZsqGR7+v7g6C5beiSeTAbwftjSGhoeQafEBRYTxZPmVKQ98MznxCWp6TXCXtYf06sUCWWvClOEwqXyoGub6C0EgBYXKu95dNVtpBlXonArqx/vbvisF52EDksBnVf43P+yVSUC1UQbwuI9Y7v74AEdc58iZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iH+2mqbZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e6005781c0so3684612b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732121366; x=1732726166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSXJWfERfexWCJawwZmjuxM0TstuZH3uBUhDK90vA7c=;
        b=iH+2mqbZjb+fIDp7kJsH2ypmZgl58Ju0yj5myVjpWTmbRMg4v3EdXuL6kKDee/GaHo
         ICyahGcBCgltgZMOo7b3TIQHlUsY2tPbo3YFIDDFgLF7DNCYPmUezWKug4j6wI/uETv8
         Gh2aAx8BRpnPLHuUtAn8S8nCyb5ItA+ZKY2gPiucmE+Nn4qSaCf2OWS8ABCv/N5O4eWt
         P3hh8oaZiqsHqH5M2UVm6kenJSi/npXnR2oKqbkJ5z2cAIAfGx6Os78EDiYJ8Bp8geQx
         9h1v9MVZimdfNrDsLca9mJuF2wLpfE/GdcwBZ/VF7PJ3TGwGawH3Rm5o1OZf9PgkDk7M
         hzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121366; x=1732726166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSXJWfERfexWCJawwZmjuxM0TstuZH3uBUhDK90vA7c=;
        b=GXn48CE2WsICX3fCCihHTYPDzEC/ppXnfSCsLZ4a7IrTEdmGbeuV90jnmr0DZx8jUZ
         iQrBwnoqwUpLPI/iyi4+dcM6p/E7JLGDcVUA5eOm8qUDDw3a/h0twzOrJ+T1uIAhC0ql
         OwzPE7v1l2/74hJiIupCF1OfBo9Rv4kT4vbS6llMhk5zUcsR0b1mSTBP+LJL7YGewq4u
         RO0ME/7lAI9+JV1EEzmrkbym/JLkZFbAkfiArSxd4DVDVvPYKflX4A3dgHG0sc96O1sx
         uon7UgYxSYHvz9n7XBaKbhK5iFz/Nx17QrSs5ciZPCQjRf0L+KD2Tj93dgAjOO+Iis5i
         77UA==
X-Forwarded-Encrypted: i=1; AJvYcCVzzE3cCfAeoGNRam/XuDnAg9new8LIPn7Hz/VMVCY0f2GW703I0ZcAEsSl3E4Q/OR0fYohY+4mW/wpAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4YFc64wLdlGA1OvN5GvROkc25jE1tSrBXsE5i92KaWAN4YhH
	TVn9yvVNYKFDPhWAwTPvwf/YZPj9EiFkyt8TWjcgEAzabLoNmr4dIpnk/G7/qr/nyt4JAZNURM0
	2JjY=
X-Google-Smtp-Source: AGHT+IFvK3/eQntYouSJyiYiPaa68TxNVW7hxbWFCD0pCaluEsNtDf75KWjGPnoR0UXIzEf0uqVYxQ==
X-Received: by 2002:a05:6808:2110:b0:3e6:58cd:fb22 with SMTP id 5614622812f47-3e7eb7130bemr3258601b6e.10.1732121365929;
        Wed, 20 Nov 2024 08:49:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bccfb837sm4317101b6e.1.2024.11.20.08.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:49:25 -0800 (PST)
Message-ID: <a537b557-c9a9-40f9-b230-62f6b35eccd3@kernel.dk>
Date: Wed, 20 Nov 2024 09:49:24 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] io_uring: use sizeof for
 io_issue_defs[IORING_OP_URING_CMD].async_size
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241120160231.1106844-1-maharmstone@fb.com>
 <20241120160231.1106844-2-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241120160231.1106844-2-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 9:02 AM, Mark Harmstone wrote:
> Correct the value of io_issue_defs[IORING_OP_URING_CMD].async_size so
> that it is derived from the size of the struct rather than being
> calculated.

You should probably just fold this with patch 1, where the type is
changed.

-- 
Jens Axboe



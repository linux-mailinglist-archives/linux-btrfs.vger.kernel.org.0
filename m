Return-Path: <linux-btrfs+bounces-16913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D1B82EBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 06:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401343BB35F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 04:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108E2749DC;
	Thu, 18 Sep 2025 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk6YJCrh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10B2253B0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171562; cv=none; b=cHTdvadYJJejhNRb5AF2bcp4BNbV8pGra6yAvAOE21XOsrQazUtu7B/wkFQonB1OeGFMfmcCPiVZ1QyERvwDtH33Lq/1lHw0oRiHVxUGCBvFMQqE4/tVPDNGciCSCN/TMkCaILWbH61u4yXHjbfzJ3KkXwLMTmQsmlkPpX27S0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171562; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SpQGdwOQ+ii+W+ykKyXlB9QN2pnPOFx7yC5mvtBLqjiLG+KfjPpHresepmBst0MIpDOJvo8HkNGjgezeXQZqOu7LGqvnQ2gbB6rX+uSJZ1/G7Xjf4n33djodRbEvNNR4w9/WYU/w+7BJu43uML/7FwXTOloE+K5PlvX4D2nffKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk6YJCrh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so412095f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758171559; x=1758776359; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fk6YJCrhsgffatA0N+0Z9hBR3q6tGXw6qXnqj6/S0M+rRXpa396DRUx5PgWd/cC7Cr
         99ZUu2TbBnbOdi0Rwox4tbn/BGHv5BywM+NrN6nUqh8de80f50IEulFxelqte86b4TlY
         uEDtHuATNADaqysphvMb3JW34i4JANc3AA4yrGRY7f7bLJDekIcjZqtkt59ojMTvpf8L
         DGY3ZgF/0nZdtZg6og8HhwlVWbSaFa9v8zhdbv8sb9WldQo+r33x+M1+UNqoAwvv2YFW
         PqaXL1foFDony4CT/v03cb35Skmhhowv9fWpVt3BKnYr0OmSqTCuh9bSBgbcAtUtxZpo
         D0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171559; x=1758776359;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=lawrZ6OTGNSmQNUNxua5MeaTK3l5j6x1OPumWhaVCo+f6C5xMTBpUzDYhNzGLWIrAO
         SGJBEFYshs/3YkBMToG9bj6K2yvUv/kx+eGkUUSgs1LPHmMVGgES/PSLETbPXDhVHK8R
         v/Kk45U9NUwoiYvF9uCqTHHlGnJTjzCCGWCOemDWmp60Ty0W+NMmUvEQ/3NTJ0htoIHE
         TehZUI0PqmQxhSX3Y1prxBBaYaXmrpCWPuf3bkXbcEzn4PHCxGFbGpD6usqBZQ4rxm2W
         tbhDT3M0AY8weNgrShmju7NxFhY9Y4BbtNyuplu68dQYRKG1To0Ov9D1jEubSWciUaHu
         fF+g==
X-Gm-Message-State: AOJu0YzOHEyklDq/slvfuP0yvwcnZuMYAQ24v/JFU76l1/Bi3r786FWM
	kP6FYe5Ax33qif0rxi3Jdr0H2pBhw8UEziqjBZNS8CJ7/2MZ/BfA/PUnY5LY48U=
X-Gm-Gg: ASbGncuanrqZEpsOaY5VYMw4Nzz+3ceg0O3lYDkNYrrmPu8oWxKfIiQhJd5meImx+DF
	4Zh0U0hvgW2LElBBa/zcT2S1EXjXkBvq9VfsfLnEZQBDIH9QT6G6JLYE4wtzhGXZTTlppdWWFuu
	u4/5o6PN+C4iJb24c5UOgb60D0PCDV8btsRlNngbsqyqWWiLzzpKlnxjm9npNJpBTmdmE1j+yOP
	/Xxfi9aZ2HUYSyaAJqhpATbS2gGuv6Wsf98MowZyjrZWj35Fuw6bmmjmOH/9UJ4G98XtSbhKfY2
	KGG4gu+Co6jLihQOd/Tyjy0N40RynJrz44/W7pLZwpWn7KF6v9vQ0UhmLJ8OPvgVymCH2qzXqLg
	nABCl0MKUQQoLMimuE/mPfPoqxhuEK+QC7pooHMU80RjkkApK4SRg+DA0qLkVar+gRC1qvKOr3Y
	u6UQ==
X-Google-Smtp-Source: AGHT+IHqKvGwB+s0jm/tZH8z2H9jjDcMLzKtK5NFmIr+NSwGTeyRsotzvcJgFO/R0/VsnmlJJQHbrg==
X-Received: by 2002:a05:6000:4024:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3edc9e2ba59mr1725061f8f.0.1758171559064;
        Wed, 17 Sep 2025 21:59:19 -0700 (PDT)
Received: from [192.168.2.5] (ppp046176100065.access.hol.gr. [46.176.100.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e849a41sm62862825e9.20.2025.09.17.21.59.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 21:59:18 -0700 (PDT)
Message-ID: <039a0c0d-1ba5-4142-8cb9-fe1ee7b936d4@gmail.com>
Date: Wed, 17 Sep 2025 23:57:30 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Elias Tsolis <estatisticseu@gmail.com>
Subject: unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




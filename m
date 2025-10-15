Return-Path: <linux-btrfs+bounces-17828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C4BDD919
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FF81920AD9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7152D193B;
	Wed, 15 Oct 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA2V3Ax8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EB319870
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518750; cv=none; b=ezi2dOThKo7P16y/n8N/Y6Ka+8NmoKosxQ8pZv1o65132gdW/NmG0gFZ+PRDfP+1yWRVNkr8sVYq2Ku2IExW7YmPTK0fGY+yRAQVUc+FTBp6TA6aNKo3Plmsq2eGB00tC8Gb7cYu0heeB1rse37yNjzl+mElOXTTYLl+UVvyFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518750; c=relaxed/simple;
	bh=TKD/HBirrUxlMfwFpNqS8U37UUaOtjaWo7a9DGrd1Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DCCEvOJxRDVWo5vUVd6LS2WDPgSUozHv+BJ/T0XBjjfes6Wri2jVC4mlhS6P/A1DUZa9H1AXBHAlGAZcDtXH5U2umQdVkC4G2/YWPDxLzdrmtPOaZlmj+h1jHrgbzT5FBU21wJqZEInVvtSQocbi8JaMbo2wi01Y/IzQ8mrYTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA2V3Ax8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7835321bc98so6029166b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760518748; x=1761123548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKD/HBirrUxlMfwFpNqS8U37UUaOtjaWo7a9DGrd1Ek=;
        b=AA2V3Ax8aqF3dO1aWpgTaTbJW3kuCyxqPX7f4bFQFycFokTyy21Ayjr0jnYl95jUJZ
         uTyJ7UmGwwBq1tZFfh8ihxkDZ/vBQtIYoTqiW60Z1l1NZ6BOTcvQ9fAP68VgqWgoRc/E
         UibjiR/9K6Rl9Fs2iXTqvvDV5Qw7AXiNrXdnPC3d3ltLdG4j2mAJojXfule74XyaLyLH
         ubYMJdnURxbOLakNdJyYsFTraxyHFI5tb0bGA2FSBG650vZYxo44foumYFEa/0m0LX8P
         OEIVx7EOBKsrIsZLptX568x++fqrnhexCZ6k9Hk269YIWvR+sx+jPTR4c3tcrTLp+f79
         /SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518748; x=1761123548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKD/HBirrUxlMfwFpNqS8U37UUaOtjaWo7a9DGrd1Ek=;
        b=NbQvle19swQCz8iGA36hqNuTncHW10JmZb4cYijQqvxXEDspDeiD9Hk7NZ+NLeL4dd
         LWVw9FmqYQwzkHm1kTc4+lKy8wAEw3L3ysRKtqsO97YcwO10jHEp9e2OkqRdusbed4fQ
         27PwtF67MF9mFXbusKlK+KmqX+Ttlq2xal1d6hrx/F5GeqyXhEVxK+7HWOmUW78elnfG
         9eK9Kyh2esxIndlvaU/t8RwzLTx6Lt94yeRmbXPSm52QdN4C9LZU8+acD3caIq8ZLbEh
         eoMmGZJ7C5XpJdm+C9O/0w6OWopn93RUaDvtBOlb4SaJ8k5MpB6dZMQfPERYU3FzWC5A
         S+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1rx04KYwqq9XeTGcI2VIpCAz4QsyVY2YnA+DSXCnJcWhvVJN3kdoGGnSJsNJz2lU3886eYj6PhccIzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6kmzqANjELyDHTvvOzpfdSc3ua1P3I6dW0kXNaFAieW7Vuy4
	MCtm8rx7FkL+n8gIjTQlxohFbLEe1ajXgUV20pvSvRiubTyW/VEfCjVxYRj5tINyZYIXow==
X-Gm-Gg: ASbGncsLRMDw0xuDxbzPdSjW9CAhldARKHl5VMapxT9gjFKYtIandaBIMMDr2IXGkHb
	31F5LsPAKFgEI6rNBdtu6HOm0nIs2z4ONpq42uGFf+OcK0aaPadELaHw8t8FZhE2PnhvJ3PFoRW
	dI8tt3vTJPdKe/Px3UHrJXwtHulSytiQUDPHbGgwmmZe2tlKmZvEbY1MB6HAHd9kEe4EenWmAyT
	kL/FUB5aseXVA9c4RRlsY9hZVR5egEHm7ELJZYIATq616w6rTnOP3JH5WmmKql2wgtCMQxt9Iyy
	BiQVJEzHEeLixIX7M/lifDUcFgBVl0GFMdlGKai/nNP0Jpaeh64cNSjeztshqTijW/uAdSwvAy3
	TdkVlnaoYe+3eJFDo4RqIamREcqmVboun6hDRnhZDoDfQS4GGypTUNIOHOSR4cIvZhMmkNb7mVu
	GOypA79JjKlV81K9vO1qdXS1O1
X-Google-Smtp-Source: AGHT+IHqG8QgjOOFn1jJyZaKXOQGkuUJqRDEY/tX9NS7SvCv4ems2mCTB923DmZRlq730Z13nkRmJg==
X-Received: by 2002:a05:6a20:12cd:b0:2e8:6bf6:7d66 with SMTP id adf61e73a8af0-32da8190aedmr33283292637.22.1760518747951;
        Wed, 15 Oct 2025 01:59:07 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08de5sm190410345ad.83.2025.10.15.01.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:59:07 -0700 (PDT)
Message-ID: <640b5ba7-b911-4dd8-a8a0-117e2a8b3bf7@gmail.com>
Date: Wed, 15 Oct 2025 16:59:04 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] btrfs: remove fs_info argument from space_info
 functions
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760376569.git.fdmanana@suse.com>
Content-Language: en-GB
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Reviewed-by: Anand Jain <asj@kernel.org>



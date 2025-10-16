Return-Path: <linux-btrfs+bounces-17910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E60BE5D45
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 01:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6755E03B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69402E717B;
	Thu, 16 Oct 2025 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFpPaydY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAB2E6137
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658869; cv=none; b=hUVTvHtZFdAuSN3p22ot4qqaGSlklIXfUcDgqzyKQCBgqxVyTD8FEpVGdpIE4vxNcguddTMbHTa/DxbPzMQEbwEnJ2InEFRMBa05/o1HjKKgqJM6DJNAKugoF5PAN9avG2d7DH8o4Ye7uzj4bJEIRsb/mG9qp56YxNCJbknPRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658869; c=relaxed/simple;
	bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BokBQ9pk99QF4WguKDCTODpOSn/tYtSBD1sHfVG8LgEWHQQ1u8IyRwqDpBx4PGUasxFQaucb3Qc9yB3H/dEj6YSvMePT+bKR2nQrXteESv3aa899WqaenEynjGHqwkB+iDgsS8ck061ViMrzScIx7Lh3ev8AX9zapo3Ex8bny6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFpPaydY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-793021f348fso1306774b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760658866; x=1761263666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
        b=SFpPaydYkmZo0RTqgPHQYaesHemd/H0GP21+nM6sMqFUw3+49833ouFtyPSNo/19Xp
         /ySvXuCbiI8HMa72dynXW5hLJtQ1+4NkSDvxmm9MiEnrdRl6nRyIphadSg2ci1SupXy9
         OsG2RdK3KEY8jFnkkWFuJPJekjIoCbGISPjRLg0Sn7fSNbOQEVgrEcgNhYa+pd/0yc9t
         As0qL14huA/tfikUYIqcMn1CYBMdgi4SuqVe91uAr4NN6cD6gW1dCim3n34Q1ydiTF4g
         ZfP8BaqaF7ntUsamITQ5cQ5QgflIkYH02yXuFYS6oBK3cPqVBMpHcOXEimjPixWGYBz7
         qdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760658866; x=1761263666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK0HIlz8QpmZ8viy5ttoIR/Sw7DFRXGwB1wihf4h2uA=;
        b=ZgFFSXwpVmjPn8lDmSLIbpgNp2HgC3wbgr0h0Xoq1NPllKjK2kfw2Yo4agBjRfcU2C
         23shEpAWc60Z9OpqOVxyOk+INmak8U93Tq4+fJOaUGjkEfzo2Dk5eQkoSmlD+Nwg/LBA
         MxhxXeVN0diYzjHtpb7PGlvvWy0xioQ+c0qjoCcBxHnsYwq4SndFKmuKrTiGmdYi0KHy
         bRXrSkitdKgo4IAOpC6rlMWl8YIH0fSAdvPI0OAvWycMjCWh8UWlsJltHCYJk2B4eixd
         7tYmPafFR6h4f1iFom6v0f4hP1B/A7lMW4LXWEdbtgANyoF8Cg1h4gYlsoIq2q4awszr
         sMrA==
X-Forwarded-Encrypted: i=1; AJvYcCWtvuVKoiIy6JzfPWBCTPIUxgW6Pd9rWOoq7g7ROqLmUVIGr/OphDb7i0rebiT542O7jKL5C633DqjzSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2CRrwAXbm+GdW89ZYqyIc7oC24owrcRLO8n2eZuOi0qR7Xz0
	5WySw/Gxf9HARYyN8settQJrTdiSNlnH+abYyInw8JRHJcUugKCrQGuY
X-Gm-Gg: ASbGncuJq2weAG6FKzDnNKORV2CquVN97WT8OmG9bheE8YUy4A2pb0e/lAVnvWuWhbL
	KI7ma+y1+h8ZGSwyrqkaas/du54fNcGZuMsNa2nU+b1rLRFUIphlQfA7ol+nCE7BzNOZwv+uE+3
	Rce9eq7GAdTPN6tMFNzF8AUO7MNckGf33DMDpjySoF/Fq1LlViARXwplzhVnfEljsGIGZzBtj5a
	ZewoeXwUy//0CPlLLze6LiuD8H0B/S6Lo0Z2sLOPEBzkduyg8+2M6mnlOdovZVRxw1vIT9SFeNG
	NTQb7afSwMEOzjFNA0CUbKTsHfFgUqkx/Yv+z8i9Bwrbo7iK7nOoE3LZlPlnSb/RW6JYvxwNtVF
	1VBVjuHoVFGBQSMS8kxKygrvzlLIQ9cC3eyFzZGz7r/uO+nqmpuuVZwVw757KOGbXuxujO1X63e
	Z56On9ftfUkspQyknX+OCttP3t51CP3RWZgH4c6SZ0fyxvRsbrHxTErE8dereZiBqRd9u3p+vZ1
	dE=
X-Google-Smtp-Source: AGHT+IEQTO2Rn6Zn2mjzgAtb5MC9kioqoXxy+wCCJOa0aqfiGZuVMbJgx4ckvtvqbeTnmHskZ53hzg==
X-Received: by 2002:a05:6a20:42a3:b0:2fb:add5:5570 with SMTP id adf61e73a8af0-334a8606ff6mr2179365637.33.1760658866309;
        Thu, 16 Oct 2025 16:54:26 -0700 (PDT)
Received: from [192.168.50.211] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc18c96sm23614670b3a.37.2025.10.16.16.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:54:25 -0700 (PDT)
Message-ID: <96fa1a22-2df4-4047-9cc5-459e9846780c@gmail.com>
Date: Fri, 17 Oct 2025 07:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Carlos Maiolino <cmaiolino@redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

looks good.

Reviewed-by: Anand Jain <asj@kernel.org>



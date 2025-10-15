Return-Path: <linux-btrfs+bounces-17829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02724BDDC29
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71453B9F08
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69031A068;
	Wed, 15 Oct 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzt4jhLd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C773176FF
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520311; cv=none; b=KauIODZBQS9mSzujRokepCucIUwHxptNKBxe3RQrVUPJvXcApBeRUk/ElYbge/yheDpPwEvRbuNEqdIerbVmAKD/YioBDcJm51WqI/sj4lflqmTq/BL3RXsrruEyiPSf5RMXDee3i9LrnKp85f7ziSJzsyMGUPbmhBlAw6xHc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520311; c=relaxed/simple;
	bh=NFihtD33g1/QEozXMGNi7uxgp1voHZxvLOGiSpQoIs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EAfWak/zWHW0kPDRQOFDKWtY5qxSle9Jgy2xXvdeVwC4fgViCOZH/ozurqfixv0wa6XQHRMDqAOpXtw+YkK+vZZ1ZD2Yb89Va2aty84gCWyv3RZQ/nw3BpUsieaZBIQpoVOy6edMtYmGDU+eL4zXGaanvrO+nO3bBBUcON2TT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzt4jhLd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b593def09e3so4316980a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520309; x=1761125109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFihtD33g1/QEozXMGNi7uxgp1voHZxvLOGiSpQoIs4=;
        b=Gzt4jhLdZ7ZpyeFcLXdr2JiVixqiVY0VtttxJqX0XnH7A8EoMTsYBAEU/W8B4Y5ysY
         E5uIv6BRrQ9IR+O4Dky1f+CDnT9Ejy/3UzgE8FGRtfQdqA2ivrUhhdnukP2kAQzdPoyg
         Y/XZWCx4HJy++1xKkrxaS3sjV0+Aph83X9xiZK3oIoAtQh/JjALOp5MBUuLdYqS6SUNj
         EYcPQWudEI6CXOj8U8fBMVnrkZllX2KKq5eJEECFw4zXgamEKdqhHinOeBJhGVYeQcjR
         Q43R1w6Ril41HSbfE71T1+QkJChSmPWSE5i4JYR3MA59vMs0LoZEBbMt2q9it8FVbJe4
         9GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520309; x=1761125109;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFihtD33g1/QEozXMGNi7uxgp1voHZxvLOGiSpQoIs4=;
        b=sqzZ3G/E4+Phg4t3h7++7PZ+sSR9iORc2pDK2v9V2Qkeiyc7+KApmK6/q1axFsp+mG
         nIimP1PqsPu30d0xNYsIBhoW3qckdMYx1SwHRXPzAQ6BjrnrrVbxOP9wDlQElMvWOSGy
         M0o3xZikOmITaq4QaPLNJKDZ+ggxpDUzAJc1VKpSf+P9oHYRuUACk7Urdk18zdaAEPvO
         TwYTGtXZ3AdwagMIMDM6LfDfckoDpdUv0H6Eq1ppg9BMb13JYrw7V9JZgn81YuzpWEQX
         eP5pT+wSe5amwzIei3lxMVRomrD7lbxTcgUtPgOcNxBJFEFrQkKK3qJ4DAlwzTpOB94v
         BtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyo8Iql3VUF51CdBvJuHpUWDZ95tdem9fiBiJ7DocLU8T0yTtTU2Ko1gcIbWadnW9Ti+XUvFfe6yiBAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXb9tbMzShHBIWmgIzVUlWfLK4uv3cW9Whrod3UYF0fFPrMaO
	3zgTKhD5sKXPGQ0M22hf1n2VxNufdpB0IjiGfdo//XDfD/Ip+hzrnSaw55Y7vusF/uUAQQ==
X-Gm-Gg: ASbGncszgoKP22SB/WAkW71/+yHyNPYacf2aqgcTVZ3eO8L8d40WbvItrqDI/6PlrB/
	idzT03RS8yi0UZu7Tr2M2bzPj0RWsO0+V3E/fP3bQznUyxWDNFG0Va3Z6yL8OIYQtYa4DFDFXsO
	Z4NKiK6flPEJw+A1K3Am244RNQ/g98IPfccSF+IIofFUq7O6rHf+MzcsJjressDJg3G0zptLqOr
	n6IFCOiW5h8PAKbe0ji6Ynl6IPsYVQ9yOmO0rTqAwafVDXxIuAHiib9p64aIyKmUGoiuWC1QUrx
	yG4PAXKmmnGo5dlnM2m4cGTed/a5IGAWbKU/Sb9fW1qyhKfNqg/m2uAR55KN42D4h5uKNzE7EQI
	s4XUgZKVNhvDT1+jRA+R9EfguPnDdDgf23xbZn1B72QWa2fJZA7FzA1CInEXF0O8GQkiEdZ7hw8
	eeA4VR+Z36sV2m/wNq3e1HHRRx
X-Google-Smtp-Source: AGHT+IFwLVuhDaDTfDqlotBn9102eQhTLOrjxptvxV9sGmIXzHNLlGxCb53M3C9cX96RcOYEfEnDZw==
X-Received: by 2002:a17:903:2a8d:b0:262:661d:eb1d with SMTP id d9443c01a7336-290272901e1mr359317695ad.1.1760520308846;
        Wed, 15 Oct 2025 02:25:08 -0700 (PDT)
Received: from [192.168.50.102] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deadbfsm191126405ad.4.2025.10.15.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 02:25:08 -0700 (PDT)
Message-ID: <95520026-f663-427b-b65b-73c8bbfeff3f@gmail.com>
Date: Wed, 15 Oct 2025 17:25:05 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] btrfs: add shutdown() and remove_bdev() callback
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1760312845.git.wqu@suse.com>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <cover.1760312845.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


For the patch-set.

Reviewed-by: Anand Jain <asj@kernel.org>
Tested-by: Anand Jain <asj@kernel.org>


Some distros might need the btrfs_remove_bdev() function
for backporting so older kernels can handle disappearing
or failing devices more gracefully. The function itself
is backportable, but the call stack that uses it doesn't
exist in older kernels.

I'm a bit concerned, devices can disappear for all
kinds of reasons.


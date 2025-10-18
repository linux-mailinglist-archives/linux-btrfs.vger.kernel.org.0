Return-Path: <linux-btrfs+bounces-17994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352DBECAD6
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B0D421DD1
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8672EB874;
	Sat, 18 Oct 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+YXrvq1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1361A316E
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760777318; cv=none; b=XhN+jKU8zFS2EnBJqhiC3IoBdCPeFmt32qJN1OSzd9oBn5r3wImgRqugp6Ncv8Eeyl8m5MQz5/V6xIBIdJ8XeT7BJcECPSMY38mJmzDnqx/PkJmgVFYpVWv5wAxowhdGK+VBW8ae6ZgQocAxAoUz8DKOWQnbBmABWrrJFnkFh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760777318; c=relaxed/simple;
	bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gJnxzz4CRqbTl5NFeKGBSAcgxCV3osVoWBQHnnQ+zMjIbfTpLuYDkkuJPSYkK71MfENDgD5IYEzgfMS83QCf862re9BEnehEVN4ucrrnfhGc9S/mwEhbCZYXRIRqyalEbBBCWiPmaPN/Af7GAI9DcC8P3xA13FpSxWuT1KOg/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+YXrvq1; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-930a0a14e13so46849241.0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760777316; x=1761382116; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
        b=h+YXrvq120n70r73zXKdOn86Gptfmet3C2xNR6vi2VfdQRHsw8ZbCx/3+mczysQuXY
         3I0pHfzDXEc2vU4Gy8OYgjYeZNFFvRfSWf+A+7bTh9+m7g00EUAahtNYgxgSnXU4iZjc
         wM+/U6Md90qsgW3H6jUfghACI2iIt+5NA5fZ80x2acjWqNHCp6Dc1jIqXe3Fpz9eDUTD
         /8KKSwPMDiiLRydp4dkmvf+LlHrgbfQ2qLbSeO8nEdsu4AGp8SbibSAssajsXvWMofxu
         DkXfJ2fJ8EwPlPuHitrk1ZFEYRusmWrCsqFZKXvajA7VDHEf/r7e6T8pqZRbB7ltEI8o
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760777316; x=1761382116;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krVQ/wnpCDpBBy+ZH1VvhMN0FqIcllfCgJaAQCKemmw=;
        b=g3H9wEXRKfXvc5K1T8kSKo3SAJRwuceEJ1ciVczh4fqlOm+FwYaEooXAHxtuLmjM7F
         zAI2SV1/8EBk4P8ZpaYL0abY6kICwLNzgpRAebZgyDWoy740A3lH0ovQNR0OYhCAHGxA
         yKHi7tv30IP8EqWlaPN0sbBdDThcnGjQQU/Pe9UonNLk2h5ofHyv3EvEjYvB4W/WcG0b
         ZapP7hRFOiaoRJywtU2bcNnQLNT+O4fVJQrP/wqUPN4FVaQnwoLh08ZCjWrxsb3q+41R
         hdbWfEAHaU8WGo7HufiOSugUMyyivnCm5DbNvhyBMheK3QMUvteCXIy8jI0FPPI8B6D8
         WJnw==
X-Forwarded-Encrypted: i=1; AJvYcCUS91W/YLfNyWG7A+r2GkjTX/3FeIcD0T0rGmKbDdXzagCXE3CYo8vVdpTcWvoTr0LQmoB7MY9UEsfuWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyncqAXHpJ1qO2BFGVOIrad/rzSTdu+osSyQ9DQyfI3VUyJ2fJ
	vk4EHmLBfzpQtNMRIyuJ9DQyJqa6KLSXOPa6sLcKHzJoVtUSfkPuIu57u120OZwaRNs+zKO1kV/
	PY00FK079GGKQjhYPS4+mL9qYXWT2xmc=
X-Gm-Gg: ASbGncvlq22+llwvToEBc0v1UneUzHNcpM7OZB8g4v/yE3jj32w/Ae6x9oc1u4D5u4O
	V6Q2dLhT0qOsHGZbigxRUiCIA8lIiIuNZLLI8WjqysW/a9LQR5KfEUYmEWMXMjPH89KoXwrEyqT
	hH2jC2A5E2Hqm9IxNxdp4IVj/uPXRe4CQE2rPmcshc1KyTlkNuV6x6CcVsXP+AoHffC3qxWKLQq
	zB0iccHtTPcukSdEMhTGXdTxquW8WIo989Aqeum7p0ewbaEvXcMBWLU59daykg5S2NGrJ3i
X-Google-Smtp-Source: AGHT+IH+35tkoNkDZi4Kfek0sHfIGm6qquzzBqilO88Ji27d0+BF3jHiGdftot4dUKA6gHYqHTNj90YoNLdNHjUPtCk=
X-Received: by 2002:a05:6102:3a0b:b0:5d4:460:8e6f with SMTP id
 ada2fe7eead31-5d7dd55eedbmr1141234137.1.1760777315808; Sat, 18 Oct 2025
 01:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian <christiansantoslima21@gmail.com>
Date: Sat, 18 Oct 2025 05:48:25 -0300
X-Gm-Features: AS18NWBorZOBAkGsNXDT1dJcGL99kDvhxs1VBNaQlHzRAkXFiimDIYkW6xXq1i4
Message-ID: <CABm2a9ebHfFNatSAsjSCTmRYBa1UeuhnDj8nZtGnKWXiCXOpHw@mail.gmail.com>
Subject: How to start contributing?
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I would like to start contributing to BTRFS and I would like to
know if you have something like "Good First Issue" for newcomers?


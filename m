Return-Path: <linux-btrfs+bounces-19974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB1CD7B14
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 02:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240843001841
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68734B68C;
	Tue, 23 Dec 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfOsId7s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365834AAE6
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454091; cv=none; b=rZMvcdYQNhjBUSkgfLu1a8zzjvFn/HzsbrE6iBXTSBaIk0fviR06/NZTPVrBGX+y8QiohJdGuDULFOdPL692zg23vNTx0QK+tOU35DvsJsg3ubOby0AtNALbPDKoI4P//HYES3yELhZDZ9NDzTANV6Ur0StkPI6a5B+6q9/G98s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454091; c=relaxed/simple;
	bh=Dw1tVh0CmnWqKDbnt9xHH3i4dpkMlWgLPtv4rSVZoxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb1+Ru68OjCEY7d198CYqso/1y2KJ5dEqbaigI8DO+78twc6/phQpAlrVRB9uUPOFe4NUsbNxaONFIkzbIHUVlHqlxOUpBTcwGnY9ZgYDICEgs6l3YhDEzuKvZ7lfWPYOr/CCpy6E0HjrJPwxjs4ATU+e4RNb+zYnCXnUPhossI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfOsId7s; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-596ba05aaecso4556384e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766454088; x=1767058888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=OfOsId7sIcDGQy2pTh1vUpxLeUMu89wMN8s4Lk5g1kjn6irxsnAKWeUrpNqRGyoG36
         KeetWAt4xPplCAfvWllRU2qX5LiXDYmB4HICp0vluIlAJj36byf5FlO7IURPnAFcLIfz
         EdOrskXj59Xi4pyqUHPyuUwgjUIFaXZtWIz1k+TrIRp3q+8hANEkpNpTzlkL1uX3AgQ0
         ZClbOvf3LRxSqsQg1qNBWzRHYzc57vVVkz/mG+VKQYTkkt3PAwUnDwDy8f5K8XKVszoR
         AeOMq3ZA8JcsAWy+d3QFwQ9mUBT9ymlXsOOpr25TL6BQd5Dr8Z9ZO80mclH1UxWOzlrI
         yN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766454088; x=1767058888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=pr9BiWOeSVK7gT55SUtQJ3+ZrEfHV39Mt/IqiDFXsshHxWQDf0tJ4gStXjAkui1uW4
         OmYKZG5Mhp7QktnxFDNmynUPXqZgdd/vuqeH3F/PTkLEFaEaj9cXFlVEyf6/dBC+SsTj
         kpHqLpttJqO/BL7Fs0sxWryhzYsAbUCbkhkkrjSp340HFdzpK1ncB1+uyLDMOgFS9p1g
         XIYFYDTJhEETf55IZQp1pxvRw9H0SwhcwMLdEuzD0PY2Y0XqurT2YD0fgwT98YdMNL6j
         3RpNTkd+JdADSsou8nc88z0gyzQ0ncEwj8TDLkutpZwPLXgw3vCyOlxK18aJzkXSLat+
         tCvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6HnOL7xsghXH92eaBy6asrqwzWjctZ7Ox4NKePii96p8/d1Cst1N5ARhrvm/fKHHUCVTCNy2TEdAeMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWsiVq2pLnbR6rpyDRsMTv2mWFsVEW6A7G5sESkAjGp0tq1cl
	DlBl7xwQJGEaJx4LPzjeNNCAiTsQLv7OZV2x5tSxCLhidIjD+rJ5eJa0
X-Gm-Gg: AY/fxX6isntIsjnYP91Pip6cGkC/rQPWW3C/vz/alpGXQIpFOtrXycWGRoszPqT6vJ/
	tAQdbp73FBAq4jaLiD957uER33+mOV+i21aubvpAYs21HbaUECxgMLeHRq/gMVESnQMezjGlBXV
	g7Cqyz+Ll3hOtkkw9JJVYCj4LtHGA2lzlGbkxOEmv9TdazIfhqippuNf2TqLSBbiiDdcIF/6rFZ
	AWqmQxcZvgaFWFnlBkZSUfihdy1mfgXWC/ClU74RIJKiAFzDQk3HgoKjdRj017HQNgjaB2ueh98
	7NrTg1nxei5O9YfuxbiVXfWUjFJa+cpFOSHuKoV15SEnyl6lZi5JaQ5z6iaWEx2iCuNBaVqzhX9
	1O7ac08xK9SriLbhlIkT+pooJDDZXFcoTYYn1rGBTzfIYUkjGODfYcWfapt0Mq37dzWIg+W0feD
	q4aKl0KI3P
X-Google-Smtp-Source: AGHT+IHWUix04V1tUMjJhj8LmwIJFsrYjMJ2eegt/yizChdKwHOARh8H0MmDtl7KvKnzF0od4dTcxA==
X-Received: by 2002:a05:6512:234b:b0:59a:123e:69ab with SMTP id 2adb3069b0e04-59a17d08c20mr4858078e87.10.1766454087534;
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185d5ea6sm3600776e87.5.2025.12.22.17.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 04:41:14 +0300
Message-ID: <20251223014114.2193668-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Also, I don't understand how mempools help here.

As well as I understand, allocation from mempool is still real allocation
if mempool's own reserve is over.

-- 
Askar Safin


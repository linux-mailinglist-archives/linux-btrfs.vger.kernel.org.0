Return-Path: <linux-btrfs+bounces-6155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8792449F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 19:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDF1C21C0E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069D81BE22F;
	Tue,  2 Jul 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ArfmVdyP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA115B0FE
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940370; cv=none; b=W3hbzwNd1I7jwXYTGxXCJG4EOyulzC8Xs07QGuKqLZ6Gtrfof6ZjnBjwsQvp/8LuSiiktUbiONz6qD8jrKAs7ABWEqYn23QSz7nymtXRmtMvteTpjWLK2VYZ205IbzVlUYx4OBlYf6N/2qW7BxMM8pUn+9bDm74gZA6l1LtkufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940370; c=relaxed/simple;
	bh=Zo8afXlRJ3VF42DhqwWuzSoE8qenF3nxgv4om2qNjLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtD/aNdSYwvEhXUBnX0bHxkvwfGJMBYKPCJTOgMB054v/xDFnYbZv1KnBFHUWT+iMCumQyHKUsWesafi9YwN3nGZnGEzqJVy9SIHU3/YIYI4n6gM7FJQYoq5fhxIqeLaRm9rsqByZrcBNBmmcVfduymYbKmWeFSN/cVBqW2qVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ArfmVdyP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-444fd22b7e5so23964971cf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2024 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719940366; x=1720545166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UkpiCWe7l9S6XZQy3VdozNsBifAGRGKHHhRjE0pa3g=;
        b=ArfmVdyPpO6c7Ow9aaY3EsoKHSSFx0rjby8WUAUYefB8AgBfbegYR1r/bsmbM00ece
         nxj58lSo4ht/3QaiavLZpLhTjOsGo2bCJ5Rc1egeLGq8sKNHm/fypnCLGYag+vrGw3Ih
         AEbtGTE4THSBEi5Vf7CB0eS/lhK19zjEPZqm6q5J3sBj26OuMiRn93WCLz2AhBez98Rj
         lVa8Ld5/3zcYWXqIRgyyZI3uIGiN8xVu5TrZftVYt7byJZ5XdxgGTtL7yEldq/tI9528
         GY9jFr61veXtBTq5xIa4HS4Y7Dry9RbehIewPElpztPeAIgtIwjTNcHReWuicn/dLEVu
         Ijgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940366; x=1720545166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UkpiCWe7l9S6XZQy3VdozNsBifAGRGKHHhRjE0pa3g=;
        b=UH6yxrMJc6XmUkfvcfj3YBcX9ls4Fvh2OlmWK2RmA4VOzGOFrB6XC3SR1v/rVbyEgG
         e+94LcjTWqzz5+El2XHQHojBNoJLMCzbFof4e0SrEqja4EZuIk59exERCB1jZk+AnM1G
         Ldq/PCS3HrfLpYXIVRWBndx4G6M4tNngzN8RpfZViv5GhIMt4SOuw8xDBlgH4eEsoYjF
         FHvZo+pcCJcSWclBbatGjKg7mGLVpzNWaiiGUihjwOPSao3w1/QuBoUNcJF3tLmm9SAS
         SGCSvasiDXZ3NMK6GQru4DrIdghEji4XF+sah4Q+k7dS0fbFoXqkpveLL3wgnvUIOQtY
         dwlQ==
X-Gm-Message-State: AOJu0Yxtl9yg7eqIHfhzhNBafoqvpzxOQeOtK2PgUlFI0iB1UAHLG4JW
	fHkK4Nf2KHywyS/W4nk19yfUgqrG2hAdMnT7AxDodM8PKwl3rkiIijMQSSn6ZOQ=
X-Google-Smtp-Source: AGHT+IE+7B+padQV9NDDw4vFEfAbgNR1YPhvfW9oqalLUAx5hGKr+whs7yHPai5zkOe8xTXydxaJAg==
X-Received: by 2002:ac8:5d4f:0:b0:446:5b69:2e74 with SMTP id d75a77b69052e-44662d9de4bmr114502921cf.16.1719940366524;
        Tue, 02 Jul 2024 10:12:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143fb7dsm42776431cf.58.2024.07.02.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:12:45 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:12:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: receive: retry encoded_write on EPERM
Message-ID: <20240702171244.GA574686@perftesting>
References: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>

On Tue, Jul 02, 2024 at 09:27:49AM -0700, Boris Burkov wrote:
> encoded_write fails if we run without CAP_SYS_ADMIN, but the decompress
> and write fallback could succeed if we are running with write
> permissions on the file. Therefore, it is helpful to fall back on EPERM
> as well. While this will increase the "silent failure" rate of encoded
> writes, we do have the verbose log in place to debug that while setting
> up a receive workflow that expects encoded_write.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


Return-Path: <linux-btrfs+bounces-3817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31330894CB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 09:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3911F2238D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCD13D3BC;
	Tue,  2 Apr 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1loZz/u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E73BBC2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043223; cv=none; b=cdJBoDjFqiLPOmHddau3lwvlQD+bht2nBTnOVobk0W+xLQhR84AxH2/SVNq1LkibDsHCMrLl6rHm7Wo7FRwaFEFROqQ+oi5X40mLQAKE7iS4Yg5/5A5hOkcSdPkusePjt6oxpLdhLRYJrkP0qScq1IjFXETat2dJ9F/Gfjstza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043223; c=relaxed/simple;
	bh=jrrYf8qFTjNcw/5jvRSQNtpvIx7LG4WrMrdHQJ1/RKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1WkaMK+/IwnwTuMbrFu2fB1609b4RlLJ9KxOyMaZaBc72GZcbcWzOrEJFE/AVKzlKmfaLWeyvK6//naOo7V6fleHmVqSCNCzoHHCJ8DlxSpr883c0wFVYTe6CeE/zf1g8gZ77GEkgiESyNWB4HMPv47LM9XFZ5b4MKaqkgx85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1loZz/u; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690caa6438aso28396526d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043221; x=1712648021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zgFodEMQz7C5rraikbBXYMhJui433OON0SbDtsfpO8=;
        b=D1loZz/u6kvNduCNLztFI9rtthXoDB1Z8ihhgkbApypqsE9vFchP/iom0/XBIJgJ0/
         sNIqzAIfvEz19ZuJt9W4PAFgs5rUpIFdNxChhm9VF80n8WZOTnXo+o+gEi/jMY3FSC+5
         s0FtVx/j/j3DOD4iooVbtgYCBx5i0txpGI21Qvt5YQWGbZDn4VCp16gbBFcJQZEaZ/5v
         KS82tTdf98xDuVIH+7NikLCks2UUXjvjIjwSplm2LcOkGZ2tbwtiELhpbt2KPgeykB+6
         NmTEsoheu03H1c7YlC38dsu5aSaFhsNwzSXIcbshYA5zMwSQ4BcO1N79feQGkD1tYsTJ
         SNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043221; x=1712648021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zgFodEMQz7C5rraikbBXYMhJui433OON0SbDtsfpO8=;
        b=MA/GwvRFTaXYqD4VTU6+0SO7xAleCbe/nKXDdJ3wuigi2p8tt75u6nbRDFnG99LHWf
         icrJPlruAueYTi/17avn1DiehIIUCS0P9IWWowVuXvjqk3m3n+PpAcFZEYjYJ69Ww+P3
         Xuy1XqIBaPmV/YAdOXBGpvMFDiQxxJ2ICdLHmhzCDpIhP8a8kIaPTcASACGKCFKO10U5
         fYxycmczedyjJvYoDezWkDF8fTU7Lhh8ilusp2UtNzl1UkklXZDitp8iLy1ZqbDsMcnO
         ddgExwZ0coGv14IkscuMG8Q6EphuotbhIheOs8oo0uKVtbqU+c6Bbw+p6LY25Ot0yIaz
         y4VA==
X-Gm-Message-State: AOJu0YzWBVGPblqK1+EfP2UWuSxLoOredARqNsr3IUlxxqCi8kg+S+8P
	u4qjyjufnFDVrCh6DHLY3GMj6s0uACZdD+od19moqygenjQmFhfe5/Oc5794nf4Lq/sdGOITMl6
	+wEZBeXeqHZRG5VsSa7FoWb4qIAd2iin9kUnYXQ==
X-Google-Smtp-Source: AGHT+IHfqgdfHOcc2AVK5Y4YWbe5sTaem7SCyMVWQqmwowAgQo2tSFfsKrL+Y6KDImpDLaY7kHBxDyOYiDws4LmGojc=
X-Received: by 2002:a05:622a:292:b0:431:43e9:ff60 with SMTP id
 z18-20020a05622a029200b0043143e9ff60mr12589355qtw.8.1712043220784; Tue, 02
 Apr 2024 00:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712038308.git.wqu@suse.com> <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
In-Reply-To: <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Tue, 2 Apr 2024 09:33:24 +0200
Message-ID: <CAK-xaQYwyT0zyqgVbca26zGOyYzFoA4YGDVxLT3Xve6_=sA0LQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: add extra comments on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 2 apr 2024 alle ore 08:24 Qu Wenruo <wqu@suse.com> ha scritto:
>
> +        * This is an in-memory-only member, matching

Just a stupid fix about "mathcing".

Thanks a lot Qu,
Gelma


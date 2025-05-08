Return-Path: <linux-btrfs+bounces-13830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A22AAFAF3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AD3B6F55
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3122D793;
	Thu,  8 May 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JWf8NvVK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EC22A805
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709821; cv=none; b=sL7/FRvuKypiuRb5Vi/+BfnTs6p5Pa2Wz/vgEZID2y55vWEIn6rJBb+YMhQI2KZ9F0x1ruBcBB/xd/h7BBVm74DyGNZziXi5/FGj8GBpNTA9R0n3ED3g8rSPPqlGEHGeogXNVZpYDNP+StcKbzygTyRZsUWukZbvMk9y7NO2SmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709821; c=relaxed/simple;
	bh=p3igjo1WeQ4ei3xNoOb2bq7IvOmv4IUIwEwUY8QYhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGK5EsxS1xRPl0P2sNxffrPpK2ceRutSxi6M9T0wdeRK8OXd9C8B1UXegibsGRlnopTndEN4A+xta26/rDYIb6Rc47AMs8MdydIvhFJYctRZj3bV89iXJd9mpQaPx8joXOK2j1YIrT6JguhapKmSebf1eHOvip3tL59ITlUx2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JWf8NvVK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f5373067b3so13514076d6.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746709818; x=1747314618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=JWf8NvVK9bUx0/Ju0P0yDXn6tL+F8x5LDb8BTcVfNadkKrSjQWAvuLseMheqG+1Slg
         zV0ej5oRae3oaQR67NJzvwpIz391Qv4j97wTp/dpjFRZ0oZ0Boag0F5hG42/2G+JreZX
         pBWHMwLA0rZ0Ue14AR+cT0qB24c8Co1T64YpB3Wx2r1KPiczlfTeqq9NHreyncmE9w/D
         hYXmy/2d4kZ0mXeHVxwxyn/33ydCWqx29AlspiOp1I2Wcftj4rXXu6moiUGI5897TwgE
         xobMNV3ljgx53LwTKfs0uw0oyk3KQB4X994AcNUDhYv86UDtnic8iXAvZiYYAMPFx4E1
         eT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709818; x=1747314618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=RzlFnwuFp8fyR/hpXr+2xdbs+prEhSxG0E061+RqdqzFu9S3iBehXWBbidL60HdVvw
         SIdXkkzcJjyzSBDtV9J34rtAvNrUgqrqv8rAVocnZcbfboCJFwR1pJiigoJaLbDIwqmu
         prfKRHGBGzyAqxVf50F1pZIP3M+3zyfZnXzvmd9kV+Zp2OT7Q7JmbHv0eMl0BIlldNEk
         GcGiOHrqnPwysfUeyFQ2dbyO6Au15r6rADysis5Fd7yN+DdeUECUcf2OHDZ8GEvE4tk8
         42Lw/r70E9nfxPVreoEUADZplAkm5tSMf8wtD1yYNnOYnqXRJzdCM+v4m6C1IrG+6xIz
         OcZw==
X-Forwarded-Encrypted: i=1; AJvYcCW54cWcg4HUN3uv0CC8d4gfvBwAwi5WWE0lmH2bSnpzv5BFRL+We70qzo2qqV67SmP4xM4saFfia2SGSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXaFi+qIKAQofBWT1V4Grg4mvDh+4KuL1MQvyO5m8ekGytzuD
	ERBzrCKvyWhgTsIG/G9ow75Nj5o4Offv2RQ2GhSKdu7c0kWXcN688NlhIYXi/zl775mmQe2F0ai
	j
X-Gm-Gg: ASbGncvHDUx9w6UyY+qtXubiAnJHBiafie46CkyKGlhPnkDIkqTVjgVAFwTjLYod0iP
	V+gr7xBOhbLcyXpu7sPcYun0zXh5U7byX6feYwtEwLdNzL4+34agDbLLfTiNK/T0z2FyaoariWH
	otowIWrtMaJRgNQ2A7/QqiVAQc4h0ICMuTkofNX3FgvT5WUikQDxsMnMglyY4H32ZSSAj+LGKQF
	X/rcbeaGh360hyrRqfwmQEoSA/S7K+IYoHkq5CAljQY1GhARUN8+DsGB/Y6fv3/wW1mshEab9ZU
	4y11+yG1ROO2Sg03qzLwpFnaJrWv9wZCIz0X
X-Google-Smtp-Source: AGHT+IFc67B3rj29wLwGe5b9hNdUhbBaJDAFmOrgjOa9uQdS/eOlhjhIK4I5PRu/Z5lCJQDbW0IFWg==
X-Received: by 2002:a05:6e02:12ef:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da73867d6fmr68904585ab.0.1746709805765;
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945471sm3173148173.70.2025.05.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Message-ID: <0df727b4-c0fb-4051-9169-3bd11035d3e0@kernel.dk>
Date: Thu, 8 May 2025 07:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 6:52 AM, Matthew Wilcox wrote:
> On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
>> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
>>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>>> +		size_t len, enum req_op op)
>>
>> I applied the series, but did notice a lot of these - I know some parts
>> like to use the 2-tab approach, but I still very much like to line these
>> up. Just a style note for future patches, let's please have it remain
>> consistent and not drift towards that.
> 
> The problem with "line it up" is that if we want to make it return
> void or add __must_check to it or ... then we either have to reindent
> (and possibly reflow) all trailing lines which makes the patch review
> harder than it needs to be.  Or the trailing arguments then don't line
> up the paren, getting to the situation we don't want.

Yeah I'm well aware of why people like the 2 tab approach, I just don't
like to look at it aesthetically. And I've been dealing that kind of
reflowing for decades, never been a big deal.

> I can't wait until we're using rust and the argument goes away because
> it's just "whatever rustfmt says".

Heh one can hope, but I suspect hoping for a generic style for the whole
kernel across sub-systems is a tad naive ;-)

-- 
Jens Axboe


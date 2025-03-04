Return-Path: <linux-btrfs+bounces-11995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678EBA4D3F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 07:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEA172383
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7D1F5826;
	Tue,  4 Mar 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwru0z9w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A71EF390
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070321; cv=none; b=nRC1bzF68k74SETIwjK9G3SgmytKbuwFoOOh5hS17OJu9MMboxGIYs3BqLeovzUAEDgdG0HFr5ZRh6Se7a6MjwaNWalEicHcbCZPUkMAD7/Uq5qzKsn/4RRpmMO+Wkep4U7N2J+oN11C6sX13cZanh7ib1F8qip5P/7tGOdEbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070321; c=relaxed/simple;
	bh=UNemzjEolWkVpXd+vHEUDLISnHTvnYzN1kSGKvl6Zds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNXBbZy8BWU0ytJJQgopv1OnAQUa/LeuLM8md9+ElM1IsjrwbtzrVXx40CoAUgIV5aFoKEWvm306YlKaLHBEnxKf9HqsvdVP6v3LkwU3E0WqbmFBjkcDzgrFyYvCv43DsqYytUJGNuyWD0S44sVHBHSKCSG6PMhsmTUhtb8cL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwru0z9w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf5358984bso433701966b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Mar 2025 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741070317; x=1741675117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=cwru0z9w6I9kYZLHKjC7ShcjO6Q+m6+8TlfAW59dooRqzfVOsnvZ8nO3TUlXuBdde3
         baONUhoME8sU56p7a8tuM/OQJMoUt6UyFBibY8XuUWOtskjywR4hKBqvNq0mXBPzOCBj
         S4W6ZPC9b6p5IAA0zxVcxZOly4KcJVh8XaJN+NfGGefGGnHwaZ13DHhRdP8Hny5JvG6T
         0lXPEO1BIH8tKvd2jkPaNfwS7hcZ+2EN6NCX6bDc/EMbKbsMbiuxV8lHqEj/cEWkzQMN
         gNNBnsaXDIysx3oz6z14lA+esNgev8AGwyI9oLi18+D2oYbeMZTRDnFhAK30SQj3ItkY
         ikOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070317; x=1741675117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=tLq3J924u1dXfYEqkvbbKA0t2Swc11UbHU8UUjJDnxxXSg4mbrlqmgh2vucXTw+Ff8
         sjJtyh/KC+0hJAwzkPOr1q7TJ8am9KH97JRmNGrHVfBFlnLZN5adh1aVoJeljGpskt6A
         3VCtp7UX1VZHAlcXSlVioAgeAZgmFbGENymAzfEpgALudB0dV6hjZEQsZ6Gzh/zUsZU2
         MnNB2tYXxXwYRtOUW3/FLaFwH2wSpc7MhXSZAek1oPXY3tkClq/xyUOwn5lplWlv1XJp
         M03T0fqJcWBDH6mzJf5NHkpRCwD3ewRaKpAzBpH0L/i2rhEY2+KhB/1kfNoRQ4zcO0nL
         j7ww==
X-Forwarded-Encrypted: i=1; AJvYcCW4gFOnmctjWXMC9gZVWzjjgEdWN9zzIzlgcmYkSHv/5jvgBrAEHHaFSM+dZ8JDa5qR735RP1kFQhEZxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmjv40J5EWuhUyjTLFxbn7Ib5qkp71xlve3jboqiGHnra9xYK
	A6AnVHliCUTx/HM57GUtMlyD08PSQWt0Mfmwh6e+8bUefFLLfFpFxYMo8H2mDUA=
X-Gm-Gg: ASbGnctzm7gprJgdng+F3faVeC31J3S+FYTtUrfRI5bu+0AbMtItxdZav57hfx5hCXM
	obHhxVGxoi6lz9kuTUUmfBBfXQNM9aSZllvmHQyd/S9jut5XonHOOEbQ5irMfjRfxhdKGZTnEBr
	okOchi/il8DrC+4RbYVBIO09k2YGZdUUaqOnhGfkTs5YoMcw8aJjfCAbA1O0Kj+nWzFywbesU7e
	1pxuUoxh44Y2TQlqK208U2L+N/9e8qulGDSsXkT5mMZe69wliRIS2g/+5FipDf08XHp2QQRw5F+
	aZn5UU60K1kM6zIAnQBz0UMixD526xCIODgjXyT0Wl5MHcjJwg==
X-Google-Smtp-Source: AGHT+IGe2iwcRIWzldTGCdfW0AwQOIiSjBUeo6MIzBTmW4OuUn9Z0MsTNtF9xRej5K0PMydq88UZNA==
X-Received: by 2002:a17:907:1ca1:b0:abf:6744:5e9c with SMTP id a640c23a62f3a-abf674462f0mr1005575366b.5.1741070317014;
        Mon, 03 Mar 2025 22:38:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1de83fa49sm199356466b.158.2025.03.03.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:38:36 -0800 (PST)
Date: Tue, 4 Mar 2025 09:38:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Message-ID: <b71c4088-4d8b-4613-8af5-e81f32abecf9@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
 <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
 <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D873FT11P5M6.JLH3TCARWATJ@wdc.com>

On Tue, Mar 04, 2025 at 01:34:00AM +0000, Naohiro Aota wrote:
> On Tue Mar 4, 2025 at 5:31 AM JST, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 22 Mar 2023 20:10:09 +0100
> >
> > The label “out” was used to jump to another pointer check despite of
> > the detail in the implementation of the function
> > “relocating_repair_kthread” that it was determined already that
> > a corresponding variable contained a null pointer because of
> > a failed call of the function “btrfs_lookup_block_group”.
> >
> > * Thus use more appropriate labels instead.
> >
> > * Delete a redundant check.
> >
> >
> > This issue was detected by using the Coccinelle software.
> 
> Since this function is local to the zoned feature, could I have "zoned: "
> added to the subject line?
> 
> Other than that, it looks reasonable to me.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> >
> > Fixes: f7ef5287a63d ("btrfs: zoned: relocate block group to repair IO failure in zoned filesystems")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Don't use Fixes tags, if it's not a bug fix.

regards,
dan carpenter



Return-Path: <linux-btrfs+bounces-19132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008ECC6DB89
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1181F2DB2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8133E36C;
	Wed, 19 Nov 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZKvRYRPV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA826B2D3
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544552; cv=none; b=sJ2JF6+wN2u3A9jeM1wO7I1ljOej/xbBgfeijesol5TSlMeN62YIqZYZ59CQ0nGzu/SjxPuDrwHtGjR1lXAHfuQ4Ww/GvW3iVMlVQN20xaII7Tuxehh+oh5xOtqhWgQMD+bBZSHa8yW2owRjTJEdHz2H8nt3D3UlcdlMc676qFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544552; c=relaxed/simple;
	bh=y//bjX1IPGqw4/t7Ag9SLqane8j1AAdamP2YMs7kk88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyUZXsUwjZ8+HV+4yPrhU8nA30M59V3IvahCRyULD+jSVsxTiug9wTB/GFw9RPnoo9dfSL7+dl5GtHJb3u3r4DjMCfvi4u1w/xToy6T8z2o8ucBNhMRYgG8XHC/g3GiJp9aMQkUCdaErZTRD58MO14R8r20M3SgFR8Vs2xfEGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZKvRYRPV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a219db05so22475635e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763544546; x=1764149346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCYXNjICUHVKkB2y8Z4V80FMVBmTg0jKTfhTOGN9WF4=;
        b=ZKvRYRPVFOebJV+LhYh7HK90fPnlpCHDfMxgzNO8JXZQdEGFfSditb8iiRFtPPLfyZ
         R7npeaDCBUb4bXkZwiqZNX6LN5MS37qSZXH0iRcWNJKKbliP489P1oeGImAEkaKDIY3o
         +reEpqNlC1UGuBLQ2gCZRBSKyWk+xS1QsrgnuaLXQ+kJMyU2jp52IimXfSoTtcMPrYos
         PWRsQmza9fsT5CZALhpJeLZBBh6e47hzuPyx2foQt/DzcPXm40sknAJZh1KZi6nRuyJm
         VNJntht/YJuz21NzWGKO6ROusi1sP3UamOrQN2QuLyjaMykvyZWaFmoSOFVwNn0/7Z1H
         BvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544546; x=1764149346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCYXNjICUHVKkB2y8Z4V80FMVBmTg0jKTfhTOGN9WF4=;
        b=fxcKWI6ye5sC7ua8WF3AEj7ECCxYvf0NTc1DtU/f0QY9t0te9yj3K7vlJJqXREdjV0
         /+HnJsWIdmOVx6T0O02tBR4CaPEkbGlG6HZ63RDt/1gF1n47FlMOE3WHOFCakblBbf26
         aEGKDvH71ty1/QscYKfAXZPdxfqFtLg0mGjaWKvUZGEOxFwE68vP34mYR+Vo05gi/bQ/
         6CPtiU16RD9kI7moOF3xoSayXrhO7EByI/D4f7dWzTpwBxFIUWucxUqwt1NU5os5re6G
         hCMbaO0r0IyA2uWkCBvaiMq2q3Wz98ZNzILldg0TKYYrl9WMQDr1R8sVVxPTUDG3h0Qq
         8F/g==
X-Forwarded-Encrypted: i=1; AJvYcCUauoOWJzPGcURtTbmXnS69QwV4CTaWCxi6l3OZ1JPHxesNod2XCZwGNBLKjgbsdwC3gpQi2gndc1wd3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng1Oh563Y/dS8EBvUCzAxbdriQq0sP75OrvxAHR1s7a0HCsHL
	tKw1RfMnZv1zWsYkqSLLl9aUQoucCpKCIZ5wWp2TMN/4n/PvOBpKJ457wrwBIy5CmKmSQlgHa7r
	LAC0E1qh5uVR32oCIBC1zXqZiDSMJsq89sRNv+DktSw==
X-Gm-Gg: ASbGnctIp4zncIjjizNwL4PnmFwoi2c+86+V+WfU+nbgSj9DTqYVzzdWTmpemsdl+i9
	5PIAKfw29N5kE5Ew2RzTmK/Td7/XHzJazGwNgWqB7xcE3XVXteOgandXaCAX0coWhC5xC9SQwq/
	gJra5YrUOTaDJGI/g4vIzYHXi01xjTjRfG4VryAmggz8TrBw47+JIs89mrubNxhdfJjD1hwgvS+
	GPSRbz0dJ+aQPMb05X1rphuKVqKa1Wp8pkdmQetwkl6baUusWlQl4emJJIn/f40HNeBFYPRrczQ
	LJtwcUrIhaaAJwwMecyoKkxqbrGRezI+rWS+pRDaW7Vwp00SbeKyv/Iq3ceEHII/l0CH7/ycK3g
	x99U=
X-Google-Smtp-Source: AGHT+IEUUYeTbO5DdGVVxSsUSvfQcVSZiAgzcUVMPxVlx5S0WpxmFVaHBUM7wcEnV+HQ5swNK8nS4nTVwZgJ3BS/VzI=
X-Received: by 2002:a05:6000:144c:b0:42b:3e60:18c7 with SMTP id
 ffacd0b85a97d-42b59374807mr16675080f8f.36.1763544546190; Wed, 19 Nov 2025
 01:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com> <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com> <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com> <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
 <aR1-TxfczR-Q6ao9@infradead.org>
In-Reply-To: <aR1-TxfczR-Q6ao9@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 10:28:55 +0100
X-Gm-Features: AWmQ_bk_OSz76YSl4w9B7PC18YbFfa2JBKe3T3i59cneGKFUy73Yup4RtYVXtQY
Message-ID: <CAPjX3FeGgDbX_JSWN8tf3Aicx2ZSYt5Rwwa+p+WRGN7cQk13sQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 09:22, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Nov 19, 2025 at 08:34:13AM +0100, Daniel Vacek wrote:
> > That's the case. The bounce bio is created when you submit the
> > original one. The data is encrypted by fscrypt, then the csum hook is
> > called and the new bio submitted instead of the original one. Later
> > the endio frees the new one and calls endio on the original bio. This
> > means we don't have control over the bounce bio and cannot use it
> > asynchronously at the moment. The csum needs to be finished directly
> > in the hook.
>
> And as I told you that can be changed.  Please get your entire series
> out of review to allow people to try to review what you're trying to
> do.

It's coming. Stay tuned! I'm just finishing a bit of re-design to
btrfs crypt context metadata storing which was suggested in code
review of matching changes in btrfs-progs. The fscrypt part is mostly
without any changes to the old v5 series from Josef.

--nX


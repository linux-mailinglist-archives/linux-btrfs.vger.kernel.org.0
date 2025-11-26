Return-Path: <linux-btrfs+bounces-19355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C7C87D60
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C5EE354D51
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908630AAD7;
	Wed, 26 Nov 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zimage.com header.i=@zimage.com header.b="XPwl9pBQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from beta.zimage.com (beta.zimage.com [47.180.143.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D122A4E8
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.180.143.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124547; cv=none; b=KoMO44Z8wvHpFmdAr1vBZw0fo2oitxFOfWXhBvMSl4zBaeajDi3dJv5ERq5KCv+7TjB9xGcQLMLIVeSEXF7LX6s29vznCc6fp3eNd9LL53UPOy2bvrCUvlOy5Wvj8vhXbRtTG72yrDQb6AIlPFPF+MogwdnmQmv5u2obi6YH+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124547; c=relaxed/simple;
	bh=HBYOxHw14Lks+yHwo3Oilip+HRhf5k2PkfEnNkdT8y4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=djnN3JsTbCJwUnwzeV7U+SBLwKqEQJVIfJj+dTEkjxOwV/zSplKH16TcZ2bNxDOHB0I4vynzYhkC2ofh0ldWdF4qdfd/8KUa2MyrZ2l+ZwKSwVO05x6O35jBDBqvadrlk5PjTfI5Sdkjgq+rqhW6rAqI9++1UWyEQftBQH8Pb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zimage.com; spf=pass smtp.mailfrom=zimage.com; dkim=pass (1024-bit key) header.d=zimage.com header.i=@zimage.com header.b=XPwl9pBQ; arc=none smtp.client-ip=47.180.143.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zimage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zimage.com
Received: from [192.168.1.109] (shaper.zimage.com [47.180.143.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by beta.zimage.com (Postfix) with ESMTPSA id DA0641AA33
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 18:35:42 -0800 (PST)
DMARC-Filter: OpenDMARC Filter v1.4.2 beta.zimage.com DA0641AA33
Authentication-Results: beta.zimage.com; dmarc=pass (p=quarantine dis=none) header.from=zimage.com
Authentication-Results: beta.zimage.com; spf=pass smtp.mailfrom=zimage.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zimage.com;
	s=default; t=1764124542;
	bh=HBYOxHw14Lks+yHwo3Oilip+HRhf5k2PkfEnNkdT8y4=;
	h=Subject:From:To:Date;
	b=XPwl9pBQuDm09G0M0xJXs0bva4AvZqdabdHy6cyBIa4EpyeGbABC19wjSEXJxqmWn
	 9VAe4ODMmV7XgIOqXj9YuO2W4W9F0CN7/BnRi0YEvgcQLxmm2cQzPowvjwS2ib5SbP
	 z5R7SDb89gWJnQWA73M6SZDQQs3kYBhXXpyPCSRM=
Message-ID: <a92b9d5be3ffa6fd88962c369ecc92472afb3cb0.camel@zimage.com>
Subject: Requesting guidance on no space left issue
From: Jeff Gustafson <ncjeffgus@zimage.com>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date: Tue, 25 Nov 2025 18:35:42 -0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,
I've been on the btrfs IRC channel seeking advice for my issues getting
the volume mounted again.

I haven't had issues with my btrfs volume until now. It has been
growing for years, until a couple of weeks ago. I didn't get ahead of
the growth and the volume went into read only.

Initially I tried to re-balance. I should have specified data only, but
I let to auto and it tried both metadata and data. I tried to cancel
the re-balance, but I couldn't stop it. As soon as I tried to mount rw,
it would start again. I tried various mount options and at some point
it just stopped mounting. I think my mistake was trying to mount with
the clear cache option. I let it run for 7 days without it mounting. I
just kept mount at 100% on 'top'.

I've been reluctant to run any rescue yet until I get some guidance.=20

I now have a drive I can add to the volume, but I can't add it until
the volume mounts.=20

Here are some links to the output I was getting from btrfs check
commands:

http://cwillu.com:8080/47.180.143.227

Should I run btrfs check or rescue commands? If so, where should I
start?

...Jeff


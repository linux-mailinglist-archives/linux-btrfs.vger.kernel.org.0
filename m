Return-Path: <linux-btrfs+bounces-14795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FEAAE0C34
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7457C4A04FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B33328DF1F;
	Thu, 19 Jun 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="YPRCtOAz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A319D8BE;
	Thu, 19 Jun 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355976; cv=none; b=teHOQNO+/8jHSIyJCGAUKEomPgHMu7wzbJDpL7HOruxsldJvfpwrQ+B0PWyHD45/Tdk8viU1RkMURFcdcdHA/8zsr4WPSgaGCPgDkzbuyfQswkVZhpo5PWloa7leJ+sLuLjieSYO3rn1pAt6krZ8d+ysLLTg7/AengpoHdDRvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355976; c=relaxed/simple;
	bh=2U/l2PnxLrKImL4dUICzMCLm3l/pMEFrrw1mzZW2ckY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRfKGfmCzBVwDZ/ig1bnMXrskP287DKxeCgc9Po5y1JzrlIHfiD+H2X9uCOS5rUa0Q2Gw7pQKeakj5iCnVlsN+bYcsCvV5uiiSxhN/uJv8LaxvHgEbVYpzt+nektg6DLeG9HW7mkmtbHD0YekLd8BWQNEmAc+dbrKIYaXFaoMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=YPRCtOAz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bNSzk2mVXz9sWQ;
	Thu, 19 Jun 2025 19:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750355970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9+ckaoJjURrvPx9FWjFciiooMu/1f1K+tszFhwB17Y=;
	b=YPRCtOAzbpVrVSksy4oKfgYloaiayN2y7SidmDGheBxq5J3+O7zAfd/jwnKXh8Hye8A4Pt
	OlwNdjGJLDVeEyW40/L+U1xH9kINSGDkNZlrGP32v2m4gzGb6lpFUm/F4wmHg230S43+VK
	DOR9XZazVEO1JfsWXIlqlGA+g0TyI0BvZHufa3dNiCWWeQ1DJgfyqoSCdKZzE8PyMBv7X+
	FaUHdtGV40j7i+gzer2ofDAUOKnXpIHvk7exz9SBXhIH6LZDaKQytt0Dqm2P0TYzZDJErQ
	7LbiqGzISPh33sfUE5CiJo21vW1ZlF24QhYvJgd/elaenldjUP8ljum+KwKkKw==
Date: Thu, 19 Jun 2025 23:29:23 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	kees@kernel.org, ailiop@suse.com
Subject: Re: [PATCH v2] btrfs: replace deprecated strcpy with strscpy
Message-ID: <rbjjfbhrwh4qjfj4pjhb5zzrvyddjlekfed6kfcrtuurj2ovgg@dm6xesb7nuzm>
References: <20250619140623.3139-1-listout@listout.xyz>
 <20250619153904.25889-1-listout@listout.xyz>
 <b8945d37-3eb9-4ad6-b3eb-2725dbb008ad@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8945d37-3eb9-4ad6-b3eb-2725dbb008ad@harmstone.com>
X-Rspamd-Queue-Id: 4bNSzk2mVXz9sWQ

On 19.06.2025 18:06, Mark Harmstone wrote:
> On 19/06/2025 4.39 pm, Brahmajit Das wrote:
...
> 
> Surely this doesn't compile... strscpy takes three parameters.
> 
It does, the third parameter is optional. From include/linux/string.h

#define strscpy(dst, src, ...) \
	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)

But I'm more than happy to add the third parameter.

-- 
Regards,
listout


Return-Path: <linux-btrfs+bounces-15712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D95B13894
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 12:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053FF16FF6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B925228B;
	Mon, 28 Jul 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="pL4r0XfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319091DFD9A
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697334; cv=none; b=TEwwtIkjeXYkBV6ArPEYHdwdRHX6rfOZkWlCfSLz3u/3+bPHnzcm5KwGWL4D/cW2WfIqcIdIHK7TGKZmu5WxdflI3x5VLsnAfdbt7H8WtUHd2mXp5mZLnYktypsEAwpb8fs2KI/v37V704Ti0q77XepWm6yY9z8rt31Udd/izIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697334; c=relaxed/simple;
	bh=pRJo9EmXe4Gs+ae+/VnloVXAbYCaixwtL+vK+47lioM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOLlgdnf/51eCJY95LXfo8zAq/s9ISWUGCr6OWDGslpIKWMeGV5vyORncFu/6Swtav9T91EjPO2Jvg4ciG53r5TL3Eim+zL7oVJEudMPQWF89J6+HM8GgoViBSd8WibALc0EniNTndxIOjijXB9Gqv1pZKr0Ea1UImCPWd9mMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=pL4r0XfE; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 0C909609A1
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 12:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-transfer-encoding
	:content-disposition:content-type:content-type:mime-version
	:references:message-id:subject:subject:from:from:date:date; s=
	dkim; i=@rus.uni-stuttgart.de; t=1753697326; x=1755436127; bh=pR
	Jo9EmXe4Gs+ae+/VnloVXAbYCaixwtL+vK+47lioM=; b=pL4r0XfEFZX9ZGsROu
	118qTxU/t0M4OyMDOJLPULra6/m0rzfjao7HJqJOk8Z61gPDKG/0uOl1lhYXjlGU
	U/w+E/4H6s37P13VPnKkuefM3wEPoZ11mGipsW/ldFmMfoD1DAhuP5AFavzAqR7w
	C0OP3RWfbu/KEKIW0GxomMx/56tKgA4vJSY0NABe3Zcpo3eX+4j0Q7DL9A0p/3Mk
	/Y5gdJGBsUERXeXqASthxbuCcc/IIrrhyg7xeHTg8/U+J/Jt97bI5ZflrJiRGmPq
	f8Eyn2nwK4x+jJl1O6qR7nGXQvimi9vhlWxJ4Z9gWxpJST01q3bfI3+4w54uMVQb
	AlKg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id VO1SZZBpYCjn for <linux-btrfs@vger.kernel.org>;
 Mon, 28 Jul 2025 12:08:46 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 28 Jul 2025 12:08:45 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: cannot read default subvolume id?
Message-ID: <20250728100845.GE842273@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250727174618.GD842273@tik.uni-stuttgart.de>
 <d738f9b1-2717-4524-b5de-3c5636351b44@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d738f9b1-2717-4524-b5de-3c5636351b44@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-07-28 (08:06), Qu Wenruo wrote:
> 
> 
> 在 2025/7/28 03:16, Ulli Horlacher 写�":
> 
> >
> > Why is there a "cannot read default subvolume id"?
> >
> > tux@quak:~: btrfs sub create xx
> > Create subvolume './xx'
> >
> > tux@quak:~: btrfs sub del xx
> > WARNING: cannot read default subvolume id: Operation not permitted
> 
> It's a warning, not an error. And you can see on the next line, the
> deletion happened without any problem.

But this warning confuses a user: 
Is there a problem?
What is going wrong?
Have I made a mistake?


> You're running as a non-root user, meanwhile default subvolume id search
> is done using tree search ioctl, which require root privilege.

Why is this subvolume id search necessary for subvolume deletion and why 
is it just a warning and apparently no problem at all?
If it does not have any consequences, it should not be displayed.

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<d738f9b1-2717-4524-b5de-3c5636351b44@suse.com>


Return-Path: <linux-btrfs+bounces-2216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5781C84D1DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49D4B22CDB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697684A20;
	Wed,  7 Feb 2024 18:57:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from caracal.birch.relay.mailchannels.net (caracal.birch.relay.mailchannels.net [23.83.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01680050
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332263; cv=pass; b=rY1wuWd+mKXhqLwJqPMxYaaoGCUC1pPxs5LBOgBmofVhU/gBA0Pvm3r9qVylr2vzzS3Ev8wOwXfRNP644el29yUE+r2jgTdumvN/MhmVqvlj+1afAmGJMMRwwNSkki+ZpIcOdh6HLVOasnVILjkSQnhXzuZNeB4YhmG0J3wrj+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332263; c=relaxed/simple;
	bh=ieX5NdpQuG3kRWgKtgwrlmPiJriMcM+fUkG9GGalp5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQUJ13tlkz9YU2xajopxqZLP0is/3cjix7RRGHp0psYXiXQlzpYxHiqi95QB06I9tP7kEDipmlz0noX+tYW0AVry7Mmk/azMG/G6hB5Gt3PjGGQJjkL8GzpAM0a+bk/eB4FplAUM/upl7LtzEGmxwWBkKQ4V+BayPYKD8P5Ps/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 327225043DE;
	Wed,  7 Feb 2024 17:41:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 09E465044E9;
	Wed,  7 Feb 2024 17:40:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707327660; a=rsa-sha256;
	cv=none;
	b=dAeKajbW8ao72LxyYb3A/Kz3TdAmWD9/Xxft3rVZVaaoyil4z1OF8jO/Vuvs/4Gi2LIf73
	dM/1CKFcarINCADPahkquNHA1s1sBM9jfSkmonTa4YR+JoA/W/ta83bt3kJfIFvjgt8O21
	nfpDwaviFSkK9p1zDA8Ow2GtKnOLWKy1RmCKatfQhko+oaBEEYjopuoLpZSuBYvXoBG6Qk
	NWchgR9zf27r+6SAdg/VjYjBLONY8ddF6foe/OEL/py83OSTPNh2cltqunEMm/lKu7eAJb
	QIdwKzaT+phGoUljjkjXYhXPIGH7QCGh9ot8ZZW5IkveYV+cy1OSZGw7rMAMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707327660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwhh8AISlT+qE+3nNnZalupKUwTGXa+qjxQecfHVY+A=;
	b=H6LUm6+FUf902wf5jGoXVnEs6BLSLOk2rsu3bLDH89aTGrDbbwlmZhJpJgKkqctMHqp78y
	sSIt8AtOgW1NN28J5l47Cbadh/V8+hautsUlis6AbLg6R2QyZnPPg9QIirxZjSWoHXMob/
	XehfdiTUpidMq/4KlPDqFFDaGSau3DkNHDmK+z+eTnbMlBT0L0ybt0bW5VwlhnPZwt0lqi
	YthCKt5jg1W6T9020Jf6X0jLSh1rxL+wWd0G6d/nnLbHF45hO36i2ObRwg1fWBMpxH3p9X
	z3Gl4IjcYFAsUpOqjy8nLjFC+jIYal/pmY6JY5IPGh6uvJIqr8XZUjruBk5GPg==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-wmqrw;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whistle-Towering: 1acdb9133eac47c2_1707327660957_1655709320
X-MC-Loop-Signature: 1707327660957:526435975
X-MC-Ingress-Time: 1707327660957
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.124.22.107 (trex/6.9.2);
	Wed, 07 Feb 2024 17:41:00 +0000
Received: from p5b0ed8de.dip0.t-ipconnect.de ([91.14.216.222]:59356 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rXlup-0001D3-2X;
	Wed, 07 Feb 2024 17:40:58 +0000
Message-ID: <0bf0c7e2e6fc023d6c1ea14b09fe509ce1c32ba5.camel@scientia.org>
Subject: Re: [PATCH 2/2] btrfs: defrag: allow fine-tuning on lone extent
 defrag behavior
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date: Wed, 07 Feb 2024 18:40:52 +0100
In-Reply-To: <CAL3q7H7nbjJhZiE+VMxBui5zgEGBNjO+J=SF9WrmtRETpT8P_g@mail.gmail.com>
References: <cover.1707172743.git.wqu@suse.com>
	 <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
	 <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com>
	 <6f730234-f252-47bb-b52f-3eac960c863e@gmx.com>
	 <CAL3q7H7nbjJhZiE+VMxBui5zgEGBNjO+J=SF9WrmtRETpT8P_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Wed, 2024-02-07 at 12:27 +0000, Filipe Manana wrote:
> A percentage, in the integer range from 1 to 99% for example, is a
> lot
> more user friendly, intuitive, obvious.

If by that you'd mean the percentage of wasted storage, then I'm not
really sure whether I can agree to that.

Especially percentage of what? The original untruncated extent size?
The user would never really know what that is.


If I have e.g. a 10.000 files with extent sizes of 1 GB, then 10%
wasted may already be too much for me.

But if I had 10.000 files with extents sizes of 1MB, the same 10% may
not be that much of a problem.

OTOH, if I have  10 million files with extent sizes of a few kB, than
even 1% might be already too much.



If the clean up of such wasted space is a manual operation, then I
would be best if one could somehow see not only how much is wasted
(which can, to some extent already be done via compsize) but also some
estimates how that is distributed like in the examples above... and
from that, which precentage or ratio or whatever one has to specify for
clean up to get so and so much wasted storage back.



Cheers
Chris.


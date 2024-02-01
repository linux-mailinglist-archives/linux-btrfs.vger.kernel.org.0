Return-Path: <linux-btrfs+bounces-2017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08998458D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 14:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A607F1F23BDF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9C5CDC4;
	Thu,  1 Feb 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ouo6nnHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQ/R0jSV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4E5336A;
	Thu,  1 Feb 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793837; cv=none; b=oEPMjkpsED9b7n8YKVXs8hg9s15xGf0uFtCMY7Jp+TAu8f9mzlomvy41UgqdERTeVRfWt5dGbh7V9zs3HeGk4QQVsAZyYEp3khDdhsJnEkGKAt1ejLTs9Iv1b2MBIz3iLwTAMRJuG7RKSls+7PUe36oymff9BneT3cnO+V/vWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793837; c=relaxed/simple;
	bh=i3O7cEFRCRp3NV/JR3K5Es7KwxtLcyjexe/DSFkKE/I=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=O8bltsLQZqE+dZmvrD3uHdHslHhfzYgFldUd1Ze5gXraG7iE45RJfzOQbZUpK53QqAZeTnHqO3upbElWKSiANKBaDE7ydZpcklSyEJVgAuRwwTcQ8tEKqKRATo0HnE2kIux1I8A21IUsrWNsHeh4gizE13oamdP8eeybzCfJjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ouo6nnHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQ/R0jSV; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 956B05C01C4;
	Thu,  1 Feb 2024 08:23:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 08:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706793834; x=1706880234; bh=XuJgHFQS6a
	WaNcA1flW4h2V6VHVKbCfJg9vcYDiFWZI=; b=ouo6nnHEiDCY3TlC0TfL0s7DMA
	5ACdf31FhVUJJRdCFILqqHY0IDqmd+h1MJcqEkP7byBoyTP3jm0uS7E5KYnGx7WV
	SB0uySCqflqbPrUy47WQ3l99edUCG7NPPqCgc2Yh2RxQodHJOx8OiY+zjiAeyYyQ
	fkJSn1cliU+X0fzOzEi07Rr/AQglKlh08byavYNEJnxUp09G7ZwYv2vrxZlaQu6C
	u6MPDcjzmb3Ru6/YzGYvROfj9aboqfaRVTu1on3vL5pdAWu34J+zrh1juc6LOV6+
	nHU+4AiuNgVBZ1ajD+cMD2wRKCN5b79yumNLCucDCpdZo/hab7HCO1Q3hKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706793834; x=1706880234; bh=XuJgHFQS6aWaNcA1flW4h2V6VHVK
	bCfJg9vcYDiFWZI=; b=KQ/R0jSVqSOV8Fkh55Ix7fr3moctr7qhpbtuufmtlfbo
	cGQHx5nS+ZswlCHktEzY5YwoseyMx4WVIn2Iqpq0py1HBvaJ6soJMWGmvd7sYULm
	//wGTiPbNQPHQZ9UwTfDpw5CTkKCZwJrGZHNHDvYL+6k3jg4gq3SVtQHTdQ1qKLN
	Kqq0arvRr5JGVAlufR0FzACbHPdixNaO25zNbeoxh2SSB3iv8UZ+PAewDQO5JQXR
	HyLhBc7HL+j2mgsJWYtu0TSj0dXlDZy1s7yZwU5mx0hv1aAznj606JDmZQQg2p6f
	D+54BgNtJgupHsYt8t5uEozqJpE880nNq5jb0bIq4g==
X-ME-Sender: <xms:apu7ZexO_aiE5Lu_ah_i4S_j7HMol1CnYgaph_RdQAA6qW0QdBKcyw>
    <xme:apu7ZaS-SDqU88HGavhs3QbfoUUKDv5mFz1juKdlYdaWHsYFXJ8_bpAJuc-QD0_hV
    I-t6a3Dl_tGtP37uWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:apu7ZQXc0Bq5T42FhMs3Bh3Gjqiis0tqgSX5zGo0IUebXygplct6vQ>
    <xmx:apu7ZUiYGYDQSz11Yg_JSZ56VTBSiUnJj9-hSU8y2djfB6Ms6-1s_g>
    <xmx:apu7ZQBLWpj_1owuba1QZOUycZaR0jOUMZLGpMO6LkN2w9MtRQXTuw>
    <xmx:apu7ZZzQJfjTfGJ_bOd1EBaGKg2X4UI6HGTgGpfpHiqzRxcmGyvpYQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0184AB60089; Thu,  1 Feb 2024 08:23:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
In-Reply-To: <20240201122216.2634007-2-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com>
Date: Thu, 01 Feb 2024 14:23:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "Marcin Szycik" <marcin.szycik@linux.intel.com>,
 "Wojciech Drewek" <wojciech.drewek@intel.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Alexander Potapenko" <glider@google.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Ido Schimmel" <idosch@nvidia.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Simon Horman" <horms@kernel.org>, linux-btrfs@vger.kernel.org,
 dm-devel@redhat.com, ntfs3@lists.linux.dev, linux-s390@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Syed Nayyar Waris" <syednwaris@gmail.com>,
 "William Breathitt Gray" <william.gray@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
Content-Type: text/plain

On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
> From: Syed Nayyar Waris <syednwaris@gmail.com>
>
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
>
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.

These functions feel like they should not be inline but are
better off in lib/bitmap.c given their length.

As far as I can tell, the header ends up being included
indirectly almost everywhere, so just parsing these functions
likey adds not just dependencies but also compile time.

     Arnd


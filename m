Return-Path: <linux-btrfs+bounces-2162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A984B9CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6738A1F250D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0671339A1;
	Tue,  6 Feb 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeC0/nmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BD12E1D8;
	Tue,  6 Feb 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233882; cv=none; b=L0pf7IqIZTVxRQEnyfe8oVZbqZVrP+nVaX+tkKsJHmlZHJiN+cnyja0YGriSeG9bT7GN9zmuVJCqokWBl8rRStrTFrNQuT9NmjlDWWeqWHxh9aji1/6LhOzdTPrd10D0nr7XfFomSETeX7tsZ5RTFEJHei3Tj+Pv1rFE+GQeqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233882; c=relaxed/simple;
	bh=GS8UEbSCgKgB/gRexnGVpyWM7USUW2+rfEyDI5KxFn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKLm59GU8SdbTf3YMKNINZjHWhgTThmPPAisGqJx1tE+tp7w3SXcmbn2Q6kEjm1JhD/Ws/76GY+CjQx7C5L0jgI7x1rLDR98qxUx9eGq4jt1cVngQOI4WH8gmw4TSNqKQ/GqaeqYd+2xPAvQGgzN+TsNAmlEspufas8ogxuctvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeC0/nmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DB0C433F1;
	Tue,  6 Feb 2024 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233881;
	bh=GS8UEbSCgKgB/gRexnGVpyWM7USUW2+rfEyDI5KxFn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MeC0/nmpBcpRMXw4qehV9ITDmznAf7JstSxhzuhPvmSPmjuZdqbsqo9BNmRWeWoWd
	 o6eg1wrNN0GLFHvCP4CrxHM1IUwHDsbtV2bixepEFmxUcEkfWDFOuQWczE7xxRSG3e
	 fkjZ9WfXNGazSJn3AhGHp8LkWiNAfqf0MISuAAroSLY8+e2CMIL38rjyPOIA1Hr4af
	 I/WAm6tx7tx/or2mxg+UxmdYJA41uax1G65P1WiukM+x0qx0inmSelMJJaw8HwkCgk
	 pf5HGsj/y9OPoA+7/Isz2zUwgz2b/aQ3J1pOh51tJl+5J6UnLmIkqdM6dBb6L22Lkb
	 A9JQU7chc1uxw==
Date: Tue, 6 Feb 2024 07:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Marcin Szycik
 <marcin.szycik@linux.intel.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Yury Norov <yury.norov@gmail.com>, Andy
 Shevchenko <andy@kernel.org>, "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>, Alexander Potapenko <glider@google.com>, Jiri
 Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "Simon Horman" <horms@kernel.org>,
 <linux-btrfs@vger.kernel.org>, <dm-devel@redhat.com>,
 <ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/21] ice: add PFCP filter support
Message-ID: <20240206073759.4d948d1e@kernel.org>
In-Reply-To: <c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
	<c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 13:46:44 +0100 Alexander Lobakin wrote:
> > Add support for creating PFCP filters in switchdev mode. Add pfcp module
> > that allows to create a PFCP-type netdev. The netdev then can be passed to
> > tc when creating a filter to indicate that PFCP filter should be created.  
> 
> I believe folks agreed that bitmap_{read,write}() should stay inline,
> ping then?

It's probably fine, IMHO. I mean, I think we agree that the rarely used
inlines should not sit in a header included by half of the kernel (not
an exaggeration). But IMHO a better fix would be to move out whatever
cpumask.h xarray.h and other common headers depend on to a cut-down
version rather than making your helpers not inline.

So I think all we need for now is for people to ack the respective
patches? Looks like cio and ntfs and missing acks, so are some of 
the bitops core patches.


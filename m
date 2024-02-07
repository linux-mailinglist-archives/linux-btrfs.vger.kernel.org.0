Return-Path: <linux-btrfs+bounces-2213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9284CDA3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05441C26633
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3357FBA1;
	Wed,  7 Feb 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBQ8kVxU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3F7E78A;
	Wed,  7 Feb 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318337; cv=none; b=rHveHYdqcppLdzIijZycH0O4McitjcUVfiUOQwX3GoimA+RWlw69/Cpd2D1NEybbo+P8L3j/VkSwAdDC3WbfjTuYpp/88dLDuq2wSeTdvYuD3/OsRCnDaQOGWSVOI8Y6qkg0TVV47RxNz3wOEjSgZ0neJNfSQCbI55+2yPLzanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318337; c=relaxed/simple;
	bh=xdYb7yvdmUvbOrysZ8nVH2p13juopXq78Qj4JrTKaYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUG4xCwnedCEcEhu6piHfvRfZeSudlqdJZPpG3oeSkxrELIdhZicCd4n+DfpY26xwOxGhMohH2S2R3k9KtFazmrazUhSvczWqklIGFJvsb9z1iXQs1imoQ172LjwIUuSpFZFV+zQFWxRmst5/zz0dPrQaqFUa8TUUzTHkyCfsvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBQ8kVxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB56C433C7;
	Wed,  7 Feb 2024 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318336;
	bh=xdYb7yvdmUvbOrysZ8nVH2p13juopXq78Qj4JrTKaYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBQ8kVxUG3u2NzR7vI0RyO7FcuDhOI5tK4ZCjq+i0nGarriA6z0+OMNNLw9BQRhhF
	 QYGEG5Q+jAxdGz8V6LHRYhGKjEuMzD58gtHIRXbWHPsBQgxQVVrn+kcnCB+uDnxZqn
	 FJo3I3Li5AEcbnecnLjkzDPzQigIPC2hUURhCt96+LnPIVPXcTRPVdIF3lXXojkHEs
	 hv819gKkeEvra5H4sVpaDSFTBBZilFrO46/nIBURzzMJ6ag79dw7nBKF35uhGAVAHJ
	 uagDuNzGyhi2e4cjjG/HVhyAhkRt3J+jkWDn3fCc3zjUL3IfcpO4eI80MrOoc1uncB
	 kfa5ZsGA6uXQg==
Date: Wed, 7 Feb 2024 07:05:35 -0800
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
Message-ID: <20240207070535.37223e13@kernel.org>
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

Well, Dave dropped this from PW, again. Can you ping people to give you
the acks and repost? What's your plan?


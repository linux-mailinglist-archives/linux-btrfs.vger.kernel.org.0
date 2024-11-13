Return-Path: <linux-btrfs+bounces-9574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E819C69C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BCD1F254A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 07:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1E185936;
	Wed, 13 Nov 2024 07:20:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C48230987;
	Wed, 13 Nov 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482410; cv=none; b=S3qdwmjJeZcMwEFauC/5JCdPm6rkvkv5l3vsYL8rEdb2GfEHqJsIB5Vbqu6XhlaPN9P9aIlWsZSTaIegUf4PuuS71+n/Fi4qI7sAMJfUXo6ZiBdFxBNVG7ZWjoJjfY+kvucuNt0mnIqpraTYkEB+5DqY8BM6tYk3xH/zdJugZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482410; c=relaxed/simple;
	bh=MkC2yEun47+jz9KbRBQhLyuuCy7eM0dQpjN+TRpyRSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwbECsWAG3GnewwBGeSjazu3GQTU1Kpa4XntWs313nSFqq5AxT1gLW3Yajm7QyyxDigGleuIack6NFCBT6al2EeVb6J5lLNlx4wvq2IXBKWbGI97PueBEBmQ4MiA5kqW0OQ/tml6GWvO7L21g0sWcu5sd3AcwzehBBWFYJuQsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21E7A68AFE; Wed, 13 Nov 2024 08:20:03 +0100 (CET)
Date: Wed, 13 Nov 2024 08:20:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, linux-btrfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report] blktests zbd/009 lead kernel panic on latest
 linux-block/for-next
Message-ID: <20241113072002.GA23458@lst.de>
References: <CAHj4cs9RsmCdRAeXjEiqcqDrhgws=qkVR1=kkfxn-cCSWOdTSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9RsmCdRAeXjEiqcqDrhgws=qkVR1=kkfxn-cCSWOdTSw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 13, 2024 at 02:06:43PM +0800, Yi Zhang wrote:
> Hello
> 
> CKI reported the below panic[2] on the latest linux-block/for-next[1],
> please help check it, thanks.

Thanks.  I had that test blacklist because it always fails, but I've
bisected and root caused the problem now.  A fix will be on the way
shortly.



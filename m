Return-Path: <linux-btrfs+bounces-19321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9CC82592
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A602234A4D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4832C927;
	Mon, 24 Nov 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfTZbhn4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F6319600
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013926; cv=none; b=DPJoAXadj4+SHzFylBdG3n2UkpaJRyujXHwsQy5oXB5wUKp+EPmW3v1cvWCnZfkX0Frqqaz+D56PNEt+gZjAQT8BhF1U9g+QZSDH9JgNQilXBZ9G9vCFrmiUEIaZZ4/xI/YBuKx1yGHWkrZlCq8X4088vwysyrLsJ5smbt0HJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013926; c=relaxed/simple;
	bh=kwrO+Mnb6L8qVWUtNbvySCVYiWHMfhYzBQP6+X0oeys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cJCCXb88mP8q/wN4a/smVijQLDrZoUu0xfzBqtMLaGlCgdHjx5idRuivVCWeXreU9HKJ50uJB0xAaujeINF9ePepBq7LTC7uScVAs8wBO4gW/CD5jn9DsPzxCXlLbaXRNoTrLD7wcDVmKM9lurTvp2qU/TQB5uVLb+XxdU9XWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfTZbhn4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764013922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57MP1DopHTQAggif2CcNJ9umqlpooR5GfWP71F0mvdU=;
	b=ZfTZbhn4WjnJlxA2awBka8eJ9JAnYJrnmHlF5omPkUPFL2YbiR4I3rNuj8ZJVyOWpsrcX1
	W+KuxC3NXRG0EUVl4iUCDtjMULYe9uFU7any2bBKGwC33srBSDIdgNJgjbmi+6gMLMWqT9
	6yJRej3r1sFIA//Nd+OGS7semhd7Fi0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-uL-TaeAMNeaDna5HDm89iw-1; Mon,
 24 Nov 2025 14:51:35 -0500
X-MC-Unique: uL-TaeAMNeaDna5HDm89iw-1
X-Mimecast-MFC-AGG-ID: uL-TaeAMNeaDna5HDm89iw_1764013886
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CE861800447;
	Mon, 24 Nov 2025 19:51:25 +0000 (UTC)
Received: from [10.44.33.72] (unknown [10.44.33.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EDD918004D8;
	Mon, 24 Nov 2025 19:51:18 +0000 (UTC)
Date: Mon, 24 Nov 2025 20:51:16 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Askar Safin <safinaskar@gmail.com>
cc: Dell.Client.Kernel@dell.com, agk@redhat.com, brauner@kernel.org, 
    dm-devel@lists.linux.dev, ebiggers@kernel.org, kix@kix.es, 
    linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev, 
    linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-raid@vger.kernel.org, 
    lvm-devel@lists.linux.dev, milan@mazyland.cz, msnitzer@redhat.com, 
    mzxreary@0pointer.de, nphamcs@gmail.com, pavel@ucw.cz, rafael@kernel.org, 
    ryncsn@gmail.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
In-Reply-To: <20251122224748.3724202-1-safinaskar@gmail.com>
Message-ID: <4085e0de-30f5-870c-ff82-5a293fe8ac73@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com> <20251122224748.3724202-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Sun, 23 Nov 2025, Askar Safin wrote:

> Mikulas Patocka <mpatocka@redhat.com>:
> > [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> > 
> > There was reported failure that suspend doesn't work with dm-integrity.
> > The reason for the failure is that the suspend code doesn't issue the
> > FLUSH bio - the data still sits in the dm-integrity cache and they are
> > lost when poweroff happens.
> 
> I tested this patchset (in Qemu). It works.
> 
> Here is script I used for testing:
> 
> https://zerobin.net/?66669be7d2404586#xWufhCq7zCoOk3LJcJCj7W4k3vYT3U4vhGutTN3p8m0=
> 
> Here are logs:
> 
> https://zerobin.net/?5d4a2abbad751890#WMcQl4FAZC9KqcAuJU3TSVr7wuVnPFwI7dlinA9QHOo=
> 
> Tested-By: Askar Safin <safinaskar@gmail.com>
> 
> There was no any reason to wait for me. You could easily test using script above.
> 
> Also: Linux shows this scary message when booting in Qemu:
> 
> [    0.512581] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
> So, FUA is not supported? Does it mean that this patch is wrong, and works purely
> by chance?

If FUA is not supported by a disk, the kernel would send a flush request 
after the write request with the FUA flag. There's no problem with that - 
the cache will be flushed correctly.

Mikulas

> -- 
> Askar Safin
> 



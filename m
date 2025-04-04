Return-Path: <linux-btrfs+bounces-12792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFFA7B79B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F1B1733B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 06:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860F17A2FF;
	Fri,  4 Apr 2025 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="07J0PH7j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD906101F2;
	Fri,  4 Apr 2025 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747131; cv=none; b=FqNNqZGY72/BOwV8nvNqZR+8dKA8+RIcmaIlhE2qvNEUkvZYFmLyzvsKjIlwzOEHKCFilPxBDcEFcJ6BxC13eMx17v+Udu0blMf/29JnPcjvt0HwmEdMhV2Uyo+NwNDPNyl7EIwp1g51CPKGZb0if0wfjQTzxhSaCop63qmXlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747131; c=relaxed/simple;
	bh=4VR7RFfNBRmJEmEOy2a0WW5MIh7heXFUkSABGT9e7SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBFXDfQTmxsbM5rCOWnEFmnm6rN0qs1FdLcNyyeuWzf0tasjblchkyo/oZD29oZZyfNYG7LURibpo7lTryU8SlSMIdiggdKcyLgpWWtIGV0OvomgGAVoC1CBXIogZH9H8NDFJDAutpLgTFiwfZd4yL5LkX4gYbRENm+ugM4lgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=07J0PH7j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ule5b3tDr3T/7IRuYvVluy+OwIJNqk5T9gj+TpXMj0c=; b=07J0PH7jVhkDC4dlr4jn2yoyVD
	xrKxd6k4L7Ae7Zu/Q2CCtO9FSNiMu7K1CIO+08ljtUD9Lzcu0ujiXluosHDmc/wXfKL96/+fg0iaw
	5asMqnfTaB7VELwUfXLJ8J1rwxGzKV7Mwo2QcFIVzjzfURrwoDAiX6Hpu+YUeAw8bV/SsTAGkSsdY
	mQt4n0ttc+JDMfAOFM1nlMDJcmLyFvIgZ7DWdQLg1bbWRbO6q53l6RoLWVNmmUQYppreUs3AYB41R
	ZbN2Y5GW08sH4Rkur7oSElzLVOZfY6Rz/xnVzLKEP64Xqm1gQbw4OwPaFcAWyPTz5Ln4jJe54UeYC
	ycN3ZqZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aHV-0000000AqSx-0qaE;
	Fri, 04 Apr 2025 06:11:57 +0000
Date: Thu, 3 Apr 2025 23:11:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
Message-ID: <Z-94LaTObhgZT2Rq@infradead.org>
References: <20250328012637.23744-1-anand.jain@oracle.com>
 <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250328180213.GH32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328180213.GH32661@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 28, 2025 at 07:02:13PM +0100, David Sterba wrote:
> Maintainers should be allowed to push their patches without RVB, that's
> where the role and status adds value.

Hell no.  Stop beeing so weirdly entitlted, that absolutely does not
help to get you anywhere.  If you are so proud of your role and status
use that to nudge someone into reviewing the patches insted.

Why the f**k do we wven have to discuss these basics?


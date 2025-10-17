Return-Path: <linux-btrfs+bounces-17919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF7BE6878
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 08:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7335A1A643A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C530EF67;
	Fri, 17 Oct 2025 06:05:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121032EB853;
	Fri, 17 Oct 2025 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681109; cv=none; b=QuZnY1NbROmclbyuK2z9ljf48tZJyLrWRd07RuZOiXB5iCuqyUHAwGKMM6qIK6hogadknHyV7bqib44Jz9IWcGTqpYVFj47OFm/yj7p658oTzuXwukNiDEcxY1T6dtldBjyNX9BSA2oyc+EOhFLV1hopDU7Ps/M3XY/tnM7a/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681109; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5OVk7HXRscxZZwJjBUg/fGRFPPgY/WMuD+Q/3FGJly82RXbyLO8o2zZCQu2boL8hcSDTMiynD8vx1LlST26xV1Kh4KZCH50hyNsG30qL6HJMNb1emrOCun56425j9TXLzjjNz9j+vNGrcwFPd7IxLKvfcQ9/UIorYxE000Jvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCEDA227AAD; Fri, 17 Oct 2025 08:04:53 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:04:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v6 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251017060451.GA32502@lst.de>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com> <20251017055008.672621-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017055008.672621-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



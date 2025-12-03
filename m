Return-Path: <linux-btrfs+bounces-19475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B546C9E027
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 08:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19E23AC358
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA72BE7CB;
	Wed,  3 Dec 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fhqh+UEy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DC29E109;
	Wed,  3 Dec 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745211; cv=none; b=G9cweC4nPM2UJIFgdAKpk3sTUyL2NplFHiXwEogseXIK+G779jx+4yov1QtGmXPVRpJ3mhQ9fSy7yIgJOCN/ZGOlOkqAtedcelr7cCd1LIiIxyutVuTq9NjmmfqfPMYNa7DwnDHoVMODhNXEz41GswLy99AFDZCVZwc9kSTG1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745211; c=relaxed/simple;
	bh=I5lf7g0xAOjWdU4ZyjRV66iHrvV3tSj8kM6QDX2HKSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsP7qmtK4UtLVNZledmfrB1vD1r0XSr0HQpzMfKqfRlynI9qxz+Ainw6cr9CBp7CPAKRJlDJ63HrDCY84xQGKMh+wcwfgvCDbGaW3GxmqpCWctHQYh7iS/EqQ5b9uiqU71VMucqAg+3tV+asEIUzxZPKj31qFoipYc1vVi0k+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fhqh+UEy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VJqpFrVujNbKhtLoEDTUT5PqTMsA91l6sKEhJ89/1So=; b=fhqh+UEyWf1H7LwNPksaUrPjOy
	A0GvlFFbiKqKrHwxpVOvmAu+L/mrm52mkA9IyWGSTtQqmDPo6slwsk1Uif5XD8JbrGOcQiyOh0RHd
	AB7aYa2O/JBkP/oG4wwdon+VB5WNRqcwVA+RhmFmbhEIfK7Sn1ViK5h7HNWx9nsdGZr0kHCsr5X3Y
	youmnGHyIpKZvnG+ChqMtx+vNQGUm4bryNYGGsqiH/55Yyl7s6xDfoizMbQD2dsdQuSFDo5m4fupH
	WGjcssRUpaXpjmIi8w9fc+UK316V+4PiiNc3nAvllbDK83wVFQPdbSXPwEomXasacD07kxshQRxqJ
	XCwUJUSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQgqL-00000006EGM-1ddu;
	Wed, 03 Dec 2025 07:00:05 +0000
Date: Tue, 2 Dec 2025 23:00:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jani Partanen <jiipee@sotapeli.fi>
Cc: Christoph Hellwig <hch@infradead.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.comi,
	dsterba@suse.com, terrelln@fb.com, herbert@gondor.apana.org.au,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
	weigang.li@intel.com, senozhatsky@chromium.org
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
Message-ID: <aS_f9axsi0QmmhiL@infradead.org>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 02, 2025 at 05:46:29PM +0200, Jani Partanen wrote:
> 
> On 02/12/2025 9.53, Christoph Hellwig wrote:
> > On Fri, Nov 28, 2025 at 07:04:48PM +0000, Giovanni Cabiddu wrote:
> > > +---------------------------+---------+---------+---------+---------+
> > > |                           | QAT-L9  | ZSTD-L3 | ZLIB-L3 | LZO-L1  |
> > > +---------------------------+---------+---------+---------+---------+
> > > | Disk Write TPUT (GiB/s)   | 6.5     | 5.2     | 2.2     | 6.5     |
> > > +---------------------------+---------+---------+---------+---------+
> > > | CPU utils %age @208 cores | 4.56%   | 15.67%  | 12.79%  | 19.85%  |
> > > +---------------------------+---------+---------+---------+---------+
> > > | Compression Ratio         | 34%     | 35%     | 37%     | 58%     |
> > > +---------------------------+---------+---------+---------+---------+
> > Is it just me, or do the numbers not look all that great at least
> > when comparing to ZSTD-L3 and LZO-L1?  What are the decompression
> > numbers?
> > 
> 
> What makes you think so?

Well, if you compared QAT-L9 to LZO-L1 specifically:

 - yes, cpu usage is reduced to a quarter
 - disk performance is the same
 - the compression ratio is much, much worse

and we don't know anything about the decompression speed.

All the while you significantly complicate the code.


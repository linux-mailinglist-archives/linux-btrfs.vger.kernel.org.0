Return-Path: <linux-btrfs+bounces-19128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C8C6D650
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A79E34918E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7322A4F4;
	Wed, 19 Nov 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ljxhr6aU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953611DE4CD;
	Wed, 19 Nov 2025 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540617; cv=none; b=qV5xQZtnvRIYjZiJnRDOlcKvaKorkWiQLBJeh7upnZxC2f/SASCqj+RkAH4wFqXYdp/Wsxa37CBLZK9+JWGADiwoQ86Ayhn9eJsUmrSoZ2PotU5/znzwEgSXgSszKPLkGGpdWx0/cWeU7L1vbZBLS2qqr8B6PIxOsyZJffVNYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540617; c=relaxed/simple;
	bh=nlRmQoiHx00/QDotX/kmnxD+e5F6CJr9FD0HDiYbf9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB16YdL8uY9p8dZjWI/tBZt3ahLD0qc6LTREh/QcrtQD0RyTMUyVsmSEFyDuRbjVHykPN8Dbi5o6cAW4j9hySm1hQ05nb6YIYycbVytiUP24Lgdh5JpZOKrCQikcEAg59AlzVYcFfgfk4HF4zH+y3gIznTpAtSMNWrVEfBAotiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ljxhr6aU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nlRmQoiHx00/QDotX/kmnxD+e5F6CJr9FD0HDiYbf9E=; b=Ljxhr6aUs5f1lFCVxdnVsv7ioW
	TrOUze6mSdbG0ZoXBwlpYgpUWRv0pOPkYF4isXNRYlIksqg2rLUMcYN4UGNkio1R8vtzMlg/3At/Y
	BrypoJcbKcSrRMqJ/d+QnLWeKI/wcRzinEIhXwIPiW9CF2qGvR16lkyyGoxkRuu+7kvTXuvGNCfnS
	QiVc7b49bShdO/LynUkyVDCYJwuDzUDsnVc1yzdUoH4BPTEel1x6QEFN+YomZ4uGNyl/Mlaa2rjgE
	ER9WxHRItl7kAuyCoM6FMWMp0mWoTbD0TdlTesl+xFEw7ctwap0jboRfCdJi11u1UkKfTegePIZR/
	UfPLU7Bw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLdTT-00000002mqG-1IR5;
	Wed, 19 Nov 2025 08:23:35 +0000
Date: Wed, 19 Nov 2025 00:23:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Message-ID: <aR1-h75CvzMHmsJQ@infradead.org>
References: <20251118160845.3006733-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160845.3006733-1-neelx@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Patches 1 to 3 just add dead code without the actual fscrypt support,
which you've not even posted anywhere never mind having queued it up.
Please don't add this kind of code without the user in the same series.



Return-Path: <linux-btrfs+bounces-15734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B27B14958
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2ED18A023A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1B26529E;
	Tue, 29 Jul 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w0ufw6AM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4D263F4A;
	Tue, 29 Jul 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775159; cv=none; b=mbbkT2aXK9D7uC0+NlcRAGyxQjVVbZkq5X+6L9bcU9Orc2f4ZsfHaj9R/iRHOEekgh9N36j6thaPMzN8pzd6sO/5F7wjrFEDMS8mII+a4FrCSEW2xKnhoVH8vKXRDeyxIE0rxRuyxqbbzzD5GZQ4LdSj2HJahYswwxgPrUkqrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775159; c=relaxed/simple;
	bh=j6mfMfxqQCCGAFzEaGIqCChOERnWsOHyEnn4SWLn45g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF71gO41kqSxSCtnBtMiwKCjXLcHljVgFpdO8N0WUA/XVi2c9t73AIQPv3jDzHUQuwsETXElPi92AV+te016LHyH9/SdnKFZ3lP500Xm4YdVuFwbgaOfDPU5mqi07CkWIA+BcHJIVU8Tjfj1UJ91r3ffJVo3Y0t4rWdQkekIDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w0ufw6AM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h+jpAUrtYaVAPVbZ7KO7NC9I+YnSaB8JEsQeg3bdRoA=; b=w0ufw6AMdXcdyDZYLk4Z0B5fdT
	8RrqEKGqQ6KD/8pieQMsIQVe/JMtAkq8vEoazJ6Z6qpL2RyuxYUqxIdlDyWT2zkiOO2mijZ4qrJKo
	gASoQrwRut4jW9kRPNGbVsjthEoe6JxRA91fhnX33ij1iZqQl04fpkSZCWqK/3mLCvi9RnhdfhGja
	PAXyxiMM4pkyM5hrKNT7PHyvuHWY15WjxLqCHuLzL7JmWwunFGA7J6uiXY6XFAJiPCOTcVRYk7k3m
	vDE1TNSfXIrlkeKfmriG6DTZlr+iJxTiUXl+qx9U8KZ0I7qvzV1wRYeZCY0M8XFyDnzqam1ap+qdv
	DPhp7KCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugf25-0000000GAD8-1aZF;
	Tue, 29 Jul 2025 07:45:57 +0000
Date: Tue, 29 Jul 2025 00:45:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
Message-ID: <aIh8NT2DhablZp5G@infradead.org>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 29, 2025 at 06:21:48AM +0000, Nirjhar Roy (IBM) wrote:
> +# writes, due to increased metadata sizes.
> +# Hence have a higher write tolerance for btrfs and when
> +# node size is greater than 4k.
> +if [[ "$FSTYP" == "btrfs" ]]; then
> +	nodesz=$(_get_btrfs_node_size "$SCRATCH_DEV")
> +	if [[ "$nodesz" -gt 4096 ]]; then
> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
> +	else
> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +	fi
> +else
> +	check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +fi

Everyone please stop hacking file system specific things into generic
tests.  Add proper core helpers for this instead.


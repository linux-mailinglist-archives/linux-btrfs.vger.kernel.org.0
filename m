Return-Path: <linux-btrfs+bounces-3504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3FB8862A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C1B282D2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5913664E;
	Thu, 21 Mar 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCOhezx8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C50132489;
	Thu, 21 Mar 2024 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057269; cv=none; b=WEXHGIDRKVAD4kVgXU1kbyA0ZJEGyM+QIg8OdyUM0wZv+PgtGp3/9u2DZya5ZlU1jFl74NLF/Lktm2QGW/+Fp39yTUT/k1nWObzF2EaqUiI0/z/HtQMQc+xdWqB+oomBuwjlzjMmL+mWmkEJa9rK08Ueau+eYxxic75qf7WwPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057269; c=relaxed/simple;
	bh=cddODeBi/hStXwNzhxsGIzhgaV24iIK5uc/BU/XrWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCfOECHDqo5l1x/hC2qu78M5RsYpg/kBUxuWH8M2arO52tzFfGC3vxo/0g0UGhH+HNvsUNHg42YzcjXaPYZd1rA5aB6OiiuGB0JS3JMyrYJv5ej+9Y2jzzTVkabEo/Cu2KXtIukvvmkNmmltpbVn7+4tKMWXZR5T6P78F6Q5NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mCOhezx8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Qj6WavbTTSyR6bJ6c46PUhs+EgCRaMncymugl59LOg=; b=mCOhezx85EWRCq927mwSnlvDfW
	lvRWTFgdoeMngXe6mV/g+pSZuPepYeXi2rLerU35zZPut+UVYxGSmFTwpnviFabaJeUshlkhF2+F2
	6GX8XNc5DR+XJd5CJrAG7U2F9K1ZFsIabKO2V/cYkItI69Kf2ierd3yKptldsJoSuMsSTYD7aigFV
	RIoyRK5IqR6cHLFxvlsOwlwZHVJ28F+RQR1aLz2orJR971T/JCa/cWEh64zMgBrpqkl+xHpHVo0zw
	cVhh+TG3CsBZXbhN7sl9YvZXlS6o06WWNeWU/Ds/2qw9uiyk80qZZYBgDdjNb0lYY1CJlexBehDO2
	Q4Vnr6MQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnQ9r-00000004lF3-28Sj;
	Thu, 21 Mar 2024 21:41:07 +0000
Date: Thu, 21 Mar 2024 14:41:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Message-ID: <Zfypc1dUeazjsoQz@infradead.org>
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
 <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <Zfn412vXi8V7Sqd3@infradead.org>
 <20240320160802.GE14596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320160802.GE14596@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 20, 2024 at 05:08:02PM +0100, David Sterba wrote:
> This could work, the number of exceptions is short:
> 
> tests/generic:
>     547 _supported_fs generic
>       4 _supported_fs ^nfs
>       2 _supported_fs ^overlay
>       1 _supported_fs ^xfs
>       1 _supported_fs ^btrfs ^nfs
>       1 _supported_fs ^btrfs
> 
> The example from generic/187:
> 
> # btrfs can't fragment free space. This test is unreliable on NFS, as it
> # depends on the exported filesystem.
> _supported_fs ^btrfs ^nfs
> 
> There are different reasons for the exclusion but at least for btrfs
> could be transformed to e.g.
> 
> _require_can_fragment_free_space
> 
> Not sure about the NFS part, it can be either excluding remote
> filesystems or mandating a local one.

I think the same applies for NFS.  The underlying fs on the other
side might or might not allow fragmenting free space, but it doesn't
matter to NFS testing.

(then again reading through the actual test I have no idea what it has
to do with fragmenting freespace vs just stressing the test, and
I hope not work / unreliable just means it takes forever as no
one should be corrupting files with this workload).



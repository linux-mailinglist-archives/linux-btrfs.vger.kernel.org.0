Return-Path: <linux-btrfs+bounces-4646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387F8B65D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FF51C214EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32C18C1F;
	Mon, 29 Apr 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="orHR1TQH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsPDjT9D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B29101E3
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430185; cv=none; b=SiIhqFAAeLVCoDHhb3q8qcPVs67EzmfCCfpKkcvTbb9ShzeZ+WnReX986nFCf/W61QJZ6S87tzpST2+j8Dput/pQ+Su3h1pHFPJrHI8VuBg2LD+B6wM7AL9F4ygtJ+DHM2imq5alsAtSUDW2E8ThsbBkoLCEx/zLJSGk+Ft/ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430185; c=relaxed/simple;
	bh=bTJfq/HrWRk3gFNGKMNZ4G3BXn2HkEB5GBCRvUOvmOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYdITbSGmai6Q4fefs5nmkmI91nSiyPu7AqxDMKL4qz8wFUQrLCcUz+WaAMIJlhROV/BvtDfAL+JIn15Jk+f4YAXTxFh65XZYoAgKJv66L8Tc/DoqJXRMDqt+gQrKqZRzuja7yKpsARddYNEo5V6i1HYQE1d3y2+xP3eW35MIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=orHR1TQH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsPDjT9D; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5A51B180018C;
	Mon, 29 Apr 2024 18:36:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 18:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714430181;
	 x=1714516581; bh=kYoHYa7vvX9oOMlK1L4sudDexiONsIYIP3rVBE692CA=; b=
	orHR1TQHPn9yeKUSRUcd8wuyxNHTVc9kRr44WheFRafhwM22hvm6XgiaJhI5h7YE
	sJCcvIfzlZVvLyLC+n5rYdWDu/Hg68AuKUgUtkQvPjcZ8g4OFZXtnw3/3iVeHErH
	RWPmiMYqUQDdJc20T3+OxxOX1aXBwvRcNBy5/eaV80JF7GFngEfFKv0E2OqFzCZw
	ndHIsBZk3S7bCHTABwP0637HmpPTek0aJ/YfidnXR9kXKfyzXR0AfnvgKjpCXuK4
	x/siTkwm5xz8apBx7BdG8IBcm7QX436h3ee5x9JGfY2jX3J9xfyqbnDqqs3Wc5dL
	rbWMfGgzcrKIFRBZPACPaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714430181; x=
	1714516581; bh=kYoHYa7vvX9oOMlK1L4sudDexiONsIYIP3rVBE692CA=; b=S
	sPDjT9DkJDB5NolSRhXGG2puDulOFrbck87WU5oBsxEWM407Dq0BAdn3kW04cJQN
	XroYNXVWixi+zlwZybr5JLg69a1dwmkbkETERXtlXDDNbMKKTNm3qvgfniZPgT/8
	3Vf0oHD6YqmK2ThyOcIjPmhKYGA1roo2Twfdh9g4+5fos9eRd2q/yAzyXk4cGsPo
	PqHoX63GbF1Pb2wvQ7apnq6+nkUa0IpfFXMjnbIgZKFhcOr+GBY7NwThs08TunAi
	2Teo/cm83VWR4Kd9cqRkRcF4v8eFhYGI5hC/yRzZVZGRIX8fJYii/4sXDtArElAW
	l18jqTq1H8P+L0Tyi31yA==
X-ME-Sender: <xms:5SAwZg3oOvwY7zJp8Q96StUjPxZy24CbIwIfD9Xpf2otjO__vizj8g>
    <xme:5SAwZrGXgsv84K0RixXNv4CHkwOTEaUAsOztE5OqjiloHvQmgqeoys64Jxe9o8nLC
    TkIVfiTpLGQc8Ez7e0>
X-ME-Received: <xmr:5SAwZo70b0fm1jjqQziYPz5QEw51vvTseyepEEQ-a2EGZqRQF5-C4rWjZGlk181g6vR-4xUlE_206E9C0I2a1irgZS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:5SAwZp0gLtx0lDZ64qK3lKdry_Oqr_xF1Ix1gYq_HWMU_zd01Cs9lQ>
    <xmx:5SAwZjG18KOsFDJnyF7lHyuAl1Mw3mqNTJagBA8dfSCjGIOwNX5xAA>
    <xmx:5SAwZi_IWRh_A8_I4Vgif7-opQK-kIgPMIa4G9fLzs2DJFOZkhWj0g>
    <xmx:5SAwZokHBsgY_4hXWTt8k-aulOAQt066k1UYAwUhSmaTeSmApSQHRA>
    <xmx:5SAwZrBkW-zn9LEL6oJQwoA_lkGIfcRpvIITDlmgx-W6gI4FA3n8hkQO>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:36:21 -0400 (EDT)
Date: Mon, 29 Apr 2024 15:38:53 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup
 removal
Message-ID: <20240429223853.GA37505@zen.localdomain>
References: <cover.1713519718.git.wqu@suse.com>
 <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
 <20240429124741.GA21573@zen.localdomain>
 <d817e2ba-799c-4c88-b5b6-98b8e7233687@gmx.com>
 <20240429221956.GA36465@zen.localdomain>
 <5dc104ea-7dbb-41a5-b170-5beba73ce583@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dc104ea-7dbb-41a5-b170-5beba73ce583@suse.com>

On Tue, Apr 30, 2024 at 07:59:17AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/30 07:49, Boris Burkov 写道:
> > On Tue, Apr 30, 2024 at 07:30:58AM +0930, Qu Wenruo wrote:
> [...]
> > > 
> > > I'm totally fine to do it conditional, although I'd also like to get
> > > feedback on dropping the numbers from parent qgroup (so we can do it for
> > > both qgroup and squota).
> > > 
> > > Would the auto drop for parent numbers be a solution?
> > 
> > It's a good question. It never occurred to me until this discussion
> > today.
> > 
> > Thinking out loud, squotas as a feature is already "comfortable" with
> > unaccounted space. If you enable it on a live FS, all the extents that
> > already exist are unaccounted, so there is no objection on that front.
> > 
> > I think from a container isolation perspective, the current behavior
> > makes more sense than auto dropping from the parent on subvol delete to
> > allow cleaning up the qgroup.
> > 
> > Suppose we create a container wrapping parent qgroup with ID 1/100. To
> > enforce a limit on the container customer, we set some limit on 1/100.
> > Then we create a container subvol and put 0/svid0 into 1/100. The
> > customer gets to do stuff in the subvol. They are a fancy customer and
> > create a subvol svid1, snapshot it svid2, and delete svid1.
> > 
> > svid1 and svid2 are created in the subvol of id svid0, so auto-inheritance
> > ensured that 1/100 was the parent of 0/svid1 and 0/svid2, but now
> > deleting svid1 frees all that customer usage from 1/100 and allows the
> > customer to escape the limit. This is obviously quite undesirable, and
> > wouldn't require a particularly malicious customer to hit.
> 
> OK, got your point. Thanks for the detailed explanation, and I can not come
> up with any alternative so far.
> 
> So I'll make the qgroup drop to have an extra condition for squota, so that
> a squota qgroup can only be dropped when:
> 
> 1) The subvolume is fully dropped
>    The same one for both regular qgroup and squota
> 
> 2) The number are all zero
>    This would be squota specific one.
> 
> So that the numbers would still be correct while regular qgroup can still
> handle auto-deletion for inconsistent case.

That sounds like a good design to me. And as I mentioned, you might be
able to share the conditions for squota failing with EBUSY and normal
qgroup printing a debug message about being inconsistent

> 
> Thanks,
> Qu
> 
> > 
> > Boris
> > 
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > Thanks,
> > > > Boris
> > > > 
> > > > > +	key.objectid = qgroup->qgroupid;
> > > > > +	key.type = BTRFS_ROOT_ITEM_KEY;
> > > > > +	key.offset = -1ULL;
> > > > > +	path = btrfs_alloc_path();
> > > > > +	if (!path)
> > > > > +		return false;
> > > > > +
> > > > > +	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
> > > > > +	btrfs_free_path(path);
> > > > > +	if (ret > 0)
> > > > > +		return true;
> > > > > +	return false;
> > > > >    }
> > > > > 
> > > > >    int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > > > > @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > > > >    		goto out;
> > > > >    	}
> > > > > 
> > > > > -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> > > > > +	if (!can_delete_qgroup(fs_info, qgroup)) {
> > > > >    		ret = -EBUSY;
> > > > >    		goto out;
> > > > >    	}
> > > > > @@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > > > >    	}
> > > > > 
> > > > >    	spin_lock(&fs_info->qgroup_lock);
> > > > > +	/*
> > > > > +	 * Warn on reserved space. The subvolume should has no child nor
> > > > > +	 * corresponding subvolume.
> > > > > +	 * Thus its reserved space should all be zero, no matter if qgroup
> > > > > +	 * is consistent or the mode.
> > > > > +	 */
> > > > > +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
> > > > > +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
> > > > > +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
> > > > > +	/*
> > > > > +	 * The same for rfer/excl numbers, but that's only if our qgroup is
> > > > > +	 * consistent and if it's in regular qgroup mode.
> > > > > +	 * For simple mode it's not as accurate thus we can hit non-zero values
> > > > > +	 * very frequently.
> > > > > +	 */
> > > > > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
> > > > > +	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
> > > > > +		if (WARN_ON(qgroup->rfer || qgroup->excl ||
> > > > > +			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
> > > > > +			btrfs_warn_rl(fs_info,
> > > > > +"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
> > > > > +				      btrfs_qgroup_level(qgroup->qgroupid),
> > > > > +				      btrfs_qgroup_subvolid(qgroup->qgroupid),
> > > > > +				      qgroup->rfer,
> > > > > +				      qgroup->rfer_cmpr,
> > > > > +				      qgroup->excl,
> > > > > +				      qgroup->excl_cmpr);
> > > > > +			qgroup_mark_inconsistent(fs_info);
> > > > > +		}
> > > > > +	}
> > > > 
> > > > If you go ahead with making it conditional, I would fold this warning
> > > > into the check logic. Either way is fine, of course.
> > > > 
> > > > >    	del_qgroup_rb(fs_info, qgroupid);
> > > > >    	spin_unlock(&fs_info->qgroup_lock);
> > > > > 
> > > > > --
> > > > > 2.44.0
> > > > > 
> > > > 


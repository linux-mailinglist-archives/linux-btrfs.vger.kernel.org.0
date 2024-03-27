Return-Path: <linux-btrfs+bounces-3668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932488EC72
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD1C1C319ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DA149DE0;
	Wed, 27 Mar 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pslnqaV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sU/uAxHN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE559B74
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560031; cv=none; b=gHLJTreEIzrRyqF4OmURn0yJkLPAVkudMU5xLZxbdfGPeRgeJO3d0TDO9BEFSX5P1iRXy6qwipA2GBec+D3Eusv/W0gqHQOop+PY+BBrG4m3AvphWnjsdYH60LKuySqdZob1QpchCtDRAoe1DYYSvWi4NPyJJC2z0McB8wqLQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560031; c=relaxed/simple;
	bh=tRTuW6PuG1YAJyEl/cyO259out7tAGONUGaOVzw1s0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFJOXa7S34QnLCaz3ruCJYbIzBApIP/XHU6n11PtZF2DZcCvqlf2lPJDdTALmYszf9YsQf6ESgIGF0GYj/3T1zKvjrHUFDz8yLKDIzEGA0aU58QsTXnz5PTVtPB/LcDlKbcefNRpHxI73+niD3RruNyUA4wlSBvgZXwhrKsSWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pslnqaV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sU/uAxHN; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A68F63200A32;
	Wed, 27 Mar 2024 13:20:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 13:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711560028;
	 x=1711646428; bh=I6Md6zWCY0Q6ZD59GNivQ6btYarOYktcu7ptzbmyPh8=; b=
	pslnqaV0qTqZq+TwhqUkcawJ/Rvux+yV25i1RBFKvEEqcv/GaO5Tg5Um8US2MBtN
	5lbVps8aScQDkDJC6spk5eFrdVIgswoubUM0Wq3XOkqTSqhBqZyFCOX/bUy/oJpC
	7KJ3uHuhNmJN7ScFGkLGWqr98HVHINJe4YTD5h5gxh2iPuTU4XWu1lrVMoY8cqUb
	+67vAagnRRrrBED21aLXTfD2P8wEjji1kQ9PLhN8ZLeZvGGF5KohT0WRIx01XGrq
	qtoFNBr2CPfTccZ9gt8f+X2bNMbzIIf/+8ud8oDvns4jWneyHaOzDpW14Bzkka6X
	VYvIuJS5jEKWqfWbVxKUAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711560028; x=
	1711646428; bh=I6Md6zWCY0Q6ZD59GNivQ6btYarOYktcu7ptzbmyPh8=; b=s
	U/uAxHNVGxbI9Zr/prgI+D6IxptMy08wNS4/Zooz1K1OfrvI4ybs3vweT4lksh8n
	Of4uKvf0y2SvfXbauLY2lY57tNzELEdJ++sp1oA8gxkyQ8blrg+h9oEU66WZriYq
	OdVUs5Z+MI5FlYFsPRpDMpZnf7biIkLjfo8cTJMQGFSP7Ep+XBQHGMRVj4X+42jR
	aIWnx0aKhr/q8ue6gM9L99+kWlsEAb//nrrCO1mjJROToDJqHfGadRh7N62ID723
	rptlpI1lddmW+q0F/Piy5FG4b0cBwyHR2JBDV2DlDqqP02LyaoGazvYvh+1d1Ozf
	DtIMUqeiDQwHSqX0l/QJw==
X-ME-Sender: <xms:W1UEZg5fsSTYQvHGmVgQdx4dsyEKld51dJrZsVv5UO0FQhSJxH51uw>
    <xme:W1UEZh4pygcguPT9aWddUuUX-KxbYruWdhQnN8mYMUmsswoDUc2igon-dhmmyuMPw
    lZPN7oDvkZDKUJRldI>
X-ME-Received: <xmr:W1UEZvfNDNUlO7K1kBx6uPtgR8EvQQUuvDw9cXqkpApcS4zFsEZo0LkD20pVdvhrDgGNTHKTEqeKFwH8FpIOycdXR1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:XFUEZlIIF46PBsjVy9zdVhJNFYRJAyezESSUR7f43UBgsMG2BT2ZbQ>
    <xmx:XFUEZkL7IzXI61UDEQrZuijKk097TxaE7u9zwED8RtutlhxSkz5t6Q>
    <xmx:XFUEZmzjzVEEby0oFC0fP2hBYyToxLxJJfsfErLboO0bKxL9zX5Jew>
    <xmx:XFUEZoJuKpFrtZQtn8p1tCzYg0UWM2wTa3rV8o-R7byOaF2RrRokcA>
    <xmx:XFUEZrVuBj7QzZME4r1FxosUdAaBZAJ4MJ81TZbYgDsSIDLn5b0Y0A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 13:20:27 -0400 (EDT)
Date: Wed, 27 Mar 2024 10:22:34 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/7] btrfs: free pertrans at end of cleanup_transaction
Message-ID: <20240327172234.GC2470028@zen.localdomain>
References: <cover.1711488980.git.boris@bur.io>
 <1697680236677896913e26948a76a2dd01dad235.1711488980.git.boris@bur.io>
 <78f3a17b-4b74-4b8e-b7c9-fa8a5eaecefe@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78f3a17b-4b74-4b8e-b7c9-fa8a5eaecefe@suse.com>

On Wed, Mar 27, 2024 at 08:46:39AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 08:09, Boris Burkov 写道:
> > Some of the operations after the free might convert more pertrans
> > metadata. Do the freeing as late as possible to eliminate a source of
> > leaked pertrans metadata.
> > 
> > Helps with the pass rate of generic/269 and generic/475.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Well, you can also move other fs level cleanup out of the
> btrfs_cleanup_one_transaction() call.
> (e.g. destory_delayed_inodes()).
> 
> For qgroup part, it looks fine to me as a precautious behavior.

Since the call isn't per transaction, do you think it just makes more
sense to call it once per cleanup not once per trans per cleanup?

Or would you rather I refactored it some other way?

> 
> Thanks,
> Qu
> 
> > ---
> >   fs/btrfs/disk-io.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 3df5477d48a8..4d7893cc0d4e 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4850,8 +4850,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
> >   				     EXTENT_DIRTY);
> >   	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
> > -	btrfs_free_all_qgroup_pertrans(fs_info);
> > -
> >   	cur_trans->state =TRANS_STATE_COMPLETED;
> >   	wake_up(&cur_trans->commit_wait);
> >   }
> > @@ -4904,6 +4902,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
> >   	btrfs_assert_delayed_root_empty(fs_info);
> >   	btrfs_destroy_all_delalloc_inodes(fs_info);
> >   	btrfs_drop_all_logs(fs_info);
> > +	btrfs_free_all_qgroup_pertrans(fs_info);
> >   	mutex_unlock(&fs_info->transaction_kthread_mutex);
> >   	return 0;


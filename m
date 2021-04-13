Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1B35E8A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346879AbhDMV6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 17:58:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38651 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232532AbhDMV6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 17:58:04 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F69A5C0189;
        Tue, 13 Apr 2021 17:57:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 13 Apr 2021 17:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=GUd/ZS6nofxSPI/Y6ar1moERlZy
        XV9C28b9a4xMgmtM=; b=g8SQ1H8SSvaplm3kwsVwrRbDxZOCpl9aD+3ONohZHxu
        EfR4becRH8Jo6qYW+XnbzA+Pc/9clnM08tiP2FHolhddvpGJlcE5vZOkRnge/3ml
        wcWExycE2BI+rMX4ZKQjDMvAAqDzVpLuNTAMAP/wAZ9Jk7crmfBnY4hXfulUSMzX
        gs8WW85OecF9w371zlom6uzjwKtMQBxRO2o6vT5D+O+dlOIxVD5AAUFDsHlOev/V
        kLBlRdDvHeGpCo+XbdReNg6goPfK+wtV6Z7S2D5iCiTO6w8JTki21WzTlJas8yCf
        7fTxciYi0Ffe8qcJQHsb6GFOuqUcDcBIfb0qCMaFOeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GUd/ZS
        6nofxSPI/Y6ar1moERlZyXV9C28b9a4xMgmtM=; b=lZS7580fRIs5VjLd0G78Ns
        qtuEiyxzOQvVh3w/HEClKa5gDQn0eY7xloorGKT+ZblpJ1P2v09GyQBVa53i+03O
        BOxqoBijV73//0Rhmp7Dmcrr46af5XinjfTy0GbrnD7PAODwdaMJ6iTU8jxUWzrt
        KsAepoHmPzv3thjp9dNxTDLlmepeR5jPpXa4vSbDD/TmvqE47odKjtEiRsbd087k
        9DIez0LJmXgAurQZnLQmyFSrFVRR7rf5ET52ddG+szPwIQTSuVwWOzyZWuRxxVIS
        WoF4gYGfcsSVLghZn48Gc+QdPKc0hikupRsPtpqUdYjyOYFD9AHwsWQg+wpp77xA
        ==
X-ME-Sender: <xms:1hN2YHInLlfujuu1rL3sdS7GA6yEmH_Swj85G5D58J7CXiOCH_b0Tg>
    <xme:1hN2YLJTJRfgi9uWRxZKuyzHu4KXxrSZCH0ReKkzx1t5WF-GQUkU4MC3En34p1gPR
    HziZpm_7kU2VVbU1wE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeltddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecukfhp
    pedvtdejrdehfedrvdehfedrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:1hN2YPvmjt9DYUEJCOWyhW11t4gJcKEo2tTJDXBR4AEfBl5TeSTRnw>
    <xmx:1hN2YAZHpXG6TtJ5FyAjOtSTZuLWgxsxd3GBtCjyyp7jigpyNUciQg>
    <xmx:1hN2YOZl-sqBxPwz1VJM72IOYW-rXaZeCcm2QKAU8vr0bZ0ZI5nHPQ>
    <xmx:1xN2YM2KSUEkGPqHDkuU2RRZ-qEIE4EMF1uKTmmdjwRDGyGtHFTrjg>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id B43DD240054;
        Tue, 13 Apr 2021 17:57:42 -0400 (EDT)
Date:   Tue, 13 Apr 2021 14:57:41 -0700
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Annotate unlocked accesses to transaction state
Message-ID: <YHYT1TUka52Wya8C@zen>
References: <20201124144413.3168075-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124144413.3168075-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 24, 2020 at 04:44:13PM +0200, Nikolay Borisov wrote:
> btrfs_transaction::state is protected by btrfs_fs_info::trans_lock and
> all accesses to this variable should be synchornized by it. However,
> there are 2 exceptions, namely checking if currently running transaction
> has entered its commit phase in start_transaction and in
> btrfs_should_end_transaction.
> 
> Annotate those 2, unlocked accesses with READ_ONCE respectively. Also
> remove the full memory barrier in start_transaction as it provides no
> ordering guarantees due to being unpaired. All other accsess  to
> transaction state happen under trans_lock being held.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/transaction.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index df5687a92798..e5a5c3604a9b 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -695,8 +695,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	h->can_flush_pending_bgs = true;
>  	INIT_LIST_HEAD(&h->new_bgs);
> 
> -	smp_mb();
> -	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
> +	if (READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START &&
>  	    may_wait_transaction(fs_info, type)) {
>  		current->journal_info = h;
>  		btrfs_commit_transaction(h);
> @@ -912,7 +911,7 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_transaction *cur_trans = trans->transaction;
> 
> -	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
> +	if (READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START ||
>  	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
>  		     &cur_trans->delayed_refs.flags))
>  		return 1;
> --
> 2.25.1
> 

I think some parts of this have already gone in and the conditional has
been lightly refactored, so this patch no longer applies to
kdave/misc-next.

Assuming this is a change for adherence to best practices rather than a
fix for a specific issue (in which case it would be nice to have the
issue described in the message), the patch looks good to me otherwise.

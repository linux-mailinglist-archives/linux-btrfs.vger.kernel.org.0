Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2757B8BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiGTOrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGTOrS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:47:18 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F44E878
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:47:17 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 3315E808ED;
        Wed, 20 Jul 2022 10:47:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658328437; bh=zPE/asdeZI+YLmgcie+SZ8wpZBwDUXH1Muv3RFdDCY4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=gub8SshMeucbS3UjMvkkuuziqAns+WyYOw4cf8jQmJnqhxe3Lq9YiA6hoF20hEDlg
         BW7DUqeLmIg1/XU5VH8ocWsrd1qtmC+QeQN6KzWQ11qdmJK+UGP8enfR67pK4csIHp
         rpg+oo4951UYbw8fyHWsWVUGukpgEE5HNs+KHh+bEhCgC47lv1VxDCPKKfd1wgMA+N
         SMRJG7tYkMurHD8ERP/iZLmMIV9Dqw3nLRc3aP2UyKgvHzVzP0ERmturniLeeTj9e0
         rau/ZEVR7KHW+j9avkjua5o0r3yVQfhl9bTmiOvSfGMede9VWY7roTj+wc36KAm/lD
         wkQkjF2Cq8jMg==
Message-ID: <a71f27ea-9d2b-f44b-2222-b9f35949a944@dorminy.me>
Date:   Wed, 20 Jul 2022 10:47:16 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] btrfs: Add lockdep models for the transaction
 states wait events
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-4-iangelak@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220719040954.3964407-4-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/19/22 00:09, Ioannis Angelakopoulos wrote:
> Add a lockdep annotation for the transaction states that have wait
> events; 1) TRANS_STATE_COMMIT_START, 2) TRANS_STATE_UNBLOCKED, 3)
> TRANS_STATE_SUPER_COMMITTED, and 4) TRANS_STATE_COMPLETED in
> fs/btrfs/transaction.c.
> 
> With the exception of the lockdep annotation for TRANS_STATE_COMMIT_START
> the transaction thread has to acquire the lockdep maps for the transaction
> states as reader after the lockdep map for num_writers is released so that
> lockdep does not complain.

"acquire the lockdep maps for the transaction states as reader ..." took 
a couple readings for me to grasp. Maybe "get a notional read lock on 
the transaction state only after releasing the notional lock on 
num_writers, as lockdep requires locks to be acquired/released in 
[somehow]". (I don't know how lockdep complains, but I think saying why 
in this commit message would help me understand the 'why' better.)

> @@ -2323,6 +2344,15 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	wait_event(cur_trans->writer_wait,
>   		   atomic_read(&cur_trans->num_writers) == 1);
>   
> +	/*
> +	 * Make lockdep happy by acquiring the state locks after
> +	 * btrfs_trans_num_writers is released.
> +	 */

Same sort of comment here: elaborating on why it makes lockdep happy 
would help me understand this better.

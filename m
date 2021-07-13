Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A903C6B4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhGMHjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 03:39:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49842 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHjj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 03:39:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 729C2221A0;
        Tue, 13 Jul 2021 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626161809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObnTNNgn33Y0MxEt5ZaJ54cI3ZFxcMKTjIA4GFcBkN0=;
        b=lgiUlZSsUlCsqbS5TG/hlYKaXrGkhszHCL75abx9F0Pklu71+0NL/F6jLnBNXVfy6LoK7t
        kgeiMZIgY2QA4OVE+p1QxxXviz9njlH4lYiRE+HNSV5hC+lhVnmt6oum0YNce9EORsdVJz
        QzG+RAU5/ot69o4+CFwwkL0D7qlWUsw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 487DA139D0;
        Tue, 13 Jul 2021 07:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id f1bJDpFC7WBvdgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 13 Jul 2021 07:36:49 +0000
Subject: Re: [PATCH 03/27] btrfs: use async_chunk::async_cow to replace the
 confusing pending pointer
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210713061516.163318-1-wqu@suse.com>
 <20210713061516.163318-4-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <396d992a-3211-e2bd-86b6-1d034474e0b2@suse.com>
Date:   Tue, 13 Jul 2021 10:36:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713061516.163318-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.07.21 г. 9:14, Qu Wenruo wrote:
> For structure async_chunk, we use a very strange member layout to grab
> structure async_cow who owns this async_chunk.
> 
> At initialization, it goes like this:
> 
> 		async_chunk[i].pending = &ctx->num_chunks;
> 
> Then at async_cow_free() we do a super weird freeing:
> 
> 	/*
> 	 * Since the pointer to 'pending' is at the beginning of the array of
> 	 * async_chunk's, freeing it ensures the whole array has been freed.
> 	 */
> 	if (atomic_dec_and_test(async_chunk->pending))
> 		kvfree(async_chunk->pending);
> 
> This is absolutely an abuse of kvfree().
> 
> Replace async_chunk::pending with async_chunk::async_cow, so that we can
> grab the async_cow structure directly, without this strange dancing.
> 
> And with this change, there is no requirement for any specific member
> location.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

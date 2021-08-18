Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C823F0395
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhHRMMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 08:12:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhHRMM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 08:12:26 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84D611FFB9;
        Wed, 18 Aug 2021 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629288706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oauaeid5kS8iNTdftSWve3mbzui9gaYKkQjJR8xXV+M=;
        b=emX8Scy806YkPO6OgPhs+s1Hg88Ap1y3FrF0J5tgfPJeDGS4z6Yz2BytlbTGAfWepiYSeH
        OCFt8Qbk4e1IGF3VzudM+o6L7SNtaXkxX9wMSR4ip0pnYftEvzXx0Yw+Wg7cZuigyEB5xv
        pi41uqhHsrA0mRGxmWsW7w++dHlvknE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 329EA1371C;
        Wed, 18 Aug 2021 12:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j7O2CQL5HGExRgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 18 Aug 2021 12:11:46 +0000
Subject: Re: [PATCH] btrfs: fix a potential double put bug and some related
 use-after-free bugs
To:     Wentao_Liang <Wentao_Liang_g@163.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210818091518.4825-1-Wentao_Liang_g@163.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1dea8c28-8ca6-83d4-8eb0-84fe1ebb7cc9@suse.com>
Date:   Wed, 18 Aug 2021 15:11:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818091518.4825-1-Wentao_Liang_g@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.08.21 г. 12:15, Wentao_Liang wrote:
> In line 2955 (#1), "btrfs_put_block_group(cache);" drops the reference to
> cache and may cause the cache to be released. However, in line 3014, the
> cache is dropped again by the same put function (#4). Double putting the
> cache can lead to an incorrect reference count.
> 
> Furthermore, according to the definition of btrfs_put_block_group() in fs/
> btrfs/block-group.c, if the reference count of the cache is one at the
> first put, it will be freed by kfree(). Using it again may result in the
> use-after-free flaw. In fact, after the first put (line 2955), the cache
> is also accessed in a few places (#2, #3), e.g., lines 2967, 2973, 2974,
> ….
> 
> We believe that the first put of the cache is unnecessary (#1).
> We can fix the above bugs by removing the redundant
> "btrfs_put_block_group(cache);" in line 2955 (#1).
> 
> 2951         if (!list_empty(&cache->io_list)) {
> ...
> 2955             btrfs_put_block_group(cache);
> 				 //#1 the first drop to cache (unnecessary)
> ...
> 2957         }
> ...
> 2967         cache_save_setup(cache, trans, path); //#2 use the cache
> ...
> 2972          //#3 use the cache several times
> 
> 2973         if (!ret && cache->disk_cache_state == BTRFS_DC_SETUP) {
> 2974             cache->io_ctl.inode = NULL;
> 2975             ret = btrfs_write_out_cache(trans, cache, path);
> 2976             if (ret == 0 && cache->io_ctl.inode) {
> 2977                 num_started++;
> 2978                 should_put = 0;
> 2979                 list_add_tail(&cache->io_list, io);
> 2980             } else {
> ...
> 2985                 ret = 0;
> 2986             }
> 2987         }
> 2988         if (!ret) {
> 2989             ret = update_block_group_item(trans, path, cache);
> ...
> 3003             if (ret == -ENOENT) {
> ...
> 3006                 ret = update_block_group_item(trans, path, cache);
> 3007             }
> ...
> 3010         }
> 3011
> ...
> 3013         if (should_put)
> 3014             btrfs_put_block_group(cache);
> 				//#4 the second drop to cache
> 
> Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>


Apart form the patch being buggy you have not demonstrated why doing 2
put block groups is actually given that there are invariant that
guarantee bg will have at least 2 refs held. So it seems you have
produced the patch without considering the big picture of how btrfs'
block group state machine works.

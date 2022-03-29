Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A324EB359
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiC2SdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiC2SdM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 14:33:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C7179429;
        Tue, 29 Mar 2022 11:31:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48F071FDA6;
        Tue, 29 Mar 2022 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648578688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtAGlblxU33UEYgAgfC+H5UuPFuHTP34DbTO3E1emW4=;
        b=TPaGbvNl3lqWnz/qjo9dy/g/grj+Kf/HcuojNIZBusOAfig4RElHxWtDNUQaopgjSO8IY3
        TNoZ5rn7NB9aU54Fp0vRW4P8PbHKU+ZXp7zKOk/dnzD2YOIa2DE40iTg2SuR4pfHnYhxOE
        RfE2r+AWVCTJEhyMZiUq708rcJHanFY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C86B713A7E;
        Tue, 29 Mar 2022 18:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /9fpLX9QQ2IDRQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 29 Mar 2022 18:31:27 +0000
Message-ID: <9c49bded-dbdc-8b8b-e6d4-f71fa7d33cbc@suse.com>
Date:   Tue, 29 Mar 2022 21:31:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] btrfs: Allocate page arrays using bulk page
 allocator.
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1648497027.git.sweettea-kernel@dorminy.me>
 <9cbd861d3b302e19b990848ea747d2ea91d01aed.1648497027.git.sweettea-kernel@dorminy.me>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <9cbd861d3b302e19b990848ea747d2ea91d01aed.1648497027.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.03.22 г. 23:14 ч., Sweet Tea Dorminy wrote:
> While calling alloc_page() in a loop is an effective way to populate an
> array of pages, the kernel provides a method to allocate pages in bulk.
> alloc_pages_bulk_array() populates the NULL slots in a page array, trying to
> grab more than one page at a time.
> 
> Unfortunately, it doesn't guarantee allocating all slots in the array,
> but it's easy to call it in a loop and return an error if no progress
> occurs. Similar code can be found in xfs/xfs_buf.c:xfs_buf_alloc_pages().
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

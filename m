Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3E52E7FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiETIrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiETIrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 04:47:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA55EBF1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:47:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06E3221CAD;
        Fri, 20 May 2022 08:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653036453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MjjJGmFitNptT06JZXFkXl/iUhmJr8bIVMRCSEdODzM=;
        b=libHILvD8erLh3HZQWYDZhf+XU4tr7UlKmict5fur59Ncwh4Z+RxVb8KDP2rRoBNXHtMSa
        U9eg76RpT1CNkO63/IdXihLTyjAHqOeeOfEP4H8t+iG8x/7Ijw+V3wWksjcUVmFnK/GUoJ
        yd+907T5qkGhOYMivtgGcHLFm/FRsp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8B1013A5F;
        Fri, 20 May 2022 08:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cjaOJqRVh2J1WgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 20 May 2022 08:47:32 +0000
Message-ID: <3c8da817-963c-224b-f99e-faeacb1e2ce2@suse.com>
Date:   Fri, 20 May 2022 11:47:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/15] btrfs: quit early if the fs has no RAID56 support
 for raid56 related checks
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-3-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220517145039.3202184-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.05.22 г. 17:50 ч., Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> The following functions do special handling for RAID56 chunks:
> 
> - btrfs_is_parity_mirror()
>    Check if the range is in RAID56 chunks.
> 
> - btrfs_full_stripe_len()
>    Either return sectorsize for non-RAID56 profiles or full stripe length
>    for RAID56 chunks.
> 
> But if a filesystem without any RAID56 chunks, it will not have RAID56
> incompt flags, and we can skip the chunk tree looking up completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


This seems rather unrelated to the rest of the series so it can go 
independently and ideally should have been a separate patch of its own.

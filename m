Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611DC566F09
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiGENOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiGENOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 09:14:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543934B9D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 05:39:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E82101F992;
        Tue,  5 Jul 2022 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657024712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JtDNp8SsZThQ8xpO1lciAisLJWrMeu7r7Ffx8S8yjio=;
        b=G32veW0YlPYot7smv145J7/6UOSd+vAWeRHsybSmwgVeWLWhxT4oJXSL9VeMqkjhOrOQBz
        CrNUYya+uZhYRFkpGKUePD/UNpYsZx1X2ZO6gNaDmx+JP26gCtbaFAQazPee0U8QwmvxNe
        4fKKfTJ3qZveRX3UruRdud1B1wrBdfY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D04413A79;
        Tue,  5 Jul 2022 12:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id APuMI8gwxGItTAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 05 Jul 2022 12:38:32 +0000
Message-ID: <e31a4468-6589-58fe-4717-6b605b7f42ff@suse.com>
Date:   Tue, 5 Jul 2022 15:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: don't take a bio_counter reference for cloned bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220625091547.102882-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220625091547.102882-1-hch@lst.de>
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



On 25.06.22 г. 12:15 ч., Christoph Hellwig wrote:
> There is no need for multiple bio_counter references for a single I/O.
> Just release the reference when completing the bio and avoid additional
> counter roundtrips.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Though this doesn't apply cleanly on current misc-next so had to 
manually clean it up. Also the changelog is somewhat terse essentially 
the block count is now being "carried" by the top-level bio or rather 
the bio_io_context  since btrfs_bio_counter_dec() call shall be moved 
into btrfs_end_bioc.


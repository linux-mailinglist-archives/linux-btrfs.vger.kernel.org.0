Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F48574D46
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiGNMPl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237521AbiGNMPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 08:15:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A825283
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 05:15:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A70F733BC1;
        Thu, 14 Jul 2022 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657800936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urzysNyG8NUPyYZMzEeQ10Fo5OyzbG1IGloSB84IFOo=;
        b=r96w/fEShRA/9xTgTz91FnkXodMlsvglmFgp9Ncs4gllj4Blw0QPYIxYjE3f0wwKIyKeSM
        dcFuhvlSpmphn3h9/+NVryeQFryT1gW2IjoakTexzjg1ruaWRCIUpP9NTUwjNH9gJMwErl
        pjVK7MCMlKn4JpriBh2pK9uoMGl2aT8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F597133A6;
        Thu, 14 Jul 2022 12:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EA+XEOgI0GKrdAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Jul 2022 12:15:36 +0000
Message-ID: <d8d787dc-a3be-9207-0f2d-3e089ea5b9ea@suse.com>
Date:   Thu, 14 Jul 2022 15:15:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-6-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220713061359.1980118-6-hch@lst.de>
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



On 13.07.22 г. 9:13 ч., Christoph Hellwig wrote:
> The stripes_pending in the btrfs_io_context counts number of inflight
> low-level bios for an upper btrfs_bio.  For reads this is generally
> one as reads are never cloned, while for writes we can trivially use
> the bio remaining mechanisms that is used for chained bios.
> 
> To be able to make use of that mechanism, split out a separate trivial
> end_io handler for the cloned bios that does a minimal amount of error
> tracking and which then calls bio_endio on the original bio to transfer
> control to that, with the remaining counter making sure it is completed
> last.  This then allows to merge btrfs_end_bioc into the original bio
> bi_end_io handler.  To make this all work all error handling needs to
> happen through the bi_end_io handler, which requires a small amount
> of reshuffling in submit_stripe_bio so that the bio is cloned already
> by the time the suitability of the device is checked.
> 
> This reduces the size of the btrfs_io_context and prepares splitting
> the btrfs_bio at the stripe boundary.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

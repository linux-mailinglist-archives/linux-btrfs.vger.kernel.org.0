Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C75715A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiGLJ2U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLJ2T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 05:28:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF849CE39
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 02:28:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C8892006A;
        Tue, 12 Jul 2022 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657618095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnz9RPp8VtW3hIxqIiWlNLcFmx5DPAsC6POrXOMo6zQ=;
        b=dytk6wc9gSJ/7hIBXdcHLWmxmhBYRXXHKlbampDlznrXJGiHoZJi+Kto5KxxO5IZDg7/dU
        OP9EvTmbKADOyffpjvF6tkfz36yvkpMd0S4tQW3yVrvjwHiouVeipHwWyQBNMv2DfD5+O7
        4H+cVpxywFSn7OqTgNyjDp/iYdhGBfw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E9713638;
        Tue, 12 Jul 2022 09:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vz2GOa4+zWI2UAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Jul 2022 09:28:14 +0000
Message-ID: <d5bffdd9-1ed5-89db-18c1-2bcccb9f537c@suse.com>
Date:   Tue, 12 Jul 2022 12:28:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] btrfs: stop allocation a btrfs_io_context for simple
 I/O
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-8-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220704084406.106929-8-hch@lst.de>
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



On 4.07.22 г. 11:44 ч., Christoph Hellwig wrote:
> The I/O context structure is only really used to pass the btrfs_device to
> the end I/O handler for I/Os that go to a single device.
> 
> Stop allocating the I/O context for these cases and just pass an optional
> btrfs_io_stripe argument to __btrfs_map_block that is filled out for this
> fast path.  Additionally the num_mirrors argument is changed to be passed
> by references so that the mirror_num can be returned in addition to be
> passed in.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch IMO needs to be split:

1. Make a patch which introduces the various split endio functions.
2. Then do the cleanups around __btrfs_map_block group and how submitted 
bios are being initialized and processed in btrfs_submit_bio et al.



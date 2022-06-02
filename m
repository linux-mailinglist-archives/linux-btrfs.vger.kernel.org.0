Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0753BC99
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 18:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiFBQdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiFBQdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 12:33:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F71120B5;
        Thu,  2 Jun 2022 09:33:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7323E21C73;
        Thu,  2 Jun 2022 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654187587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RFn6fA8O/arXRwmW58dU+KnJpUShIpSYqFWbbSXAGw=;
        b=ZMEc2Ws4Gz/J+OMuRzhq+3qdXW1FjeJJO+CZ8tg1EIBTvTSkmphsNhDZdvP7bszoNEx8NU
        pfHr57NA4nfBWjYGto8oQoZoQhAjzotJW629JvAyXtByR/UrTFrbT79OZdH7AfwEW0edLG
        U5SGsKNNQyL2pooQ7M/p9Q+Sg/HLy/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654187587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RFn6fA8O/arXRwmW58dU+KnJpUShIpSYqFWbbSXAGw=;
        b=pC+KeC+tunUls0SWFj3THG/6DAkyVWpb5Ff9rB/HX1Hidb90SqAkzXUsQQABYXcb5+2L59
        QZSJt99LX/t6J5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C6E9134F3;
        Thu,  2 Jun 2022 16:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2cOODUPmmGIBFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Jun 2022 16:33:07 +0000
Date:   Thu, 2 Jun 2022 18:28:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <20220602162840.GV20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Ira Weiny <ira.weiny@intel.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
 <YpjVKAGz+GuI4GB0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpjVKAGz+GuI4GB0@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 02, 2022 at 08:20:08AM -0700, Christoph Hellwig wrote:
> Turns out that while this looks good, it actually crashes when
> running xfstests.  I think this is due to the fact that kmap sets
> the page address, which kmap_local_page does not.
> 
> btrfs/150 1s ... [  168.252943] run fstests btrfs/150 at 2022-06-02 15:17:11
> [  169.462292] BTRFS info (device vdb): flagging fs with big metadata feature
> [  169.463728] BTRFS info (device vdb): disk space caching is enabled
> [  169.464953] BTRFS info (device vdb): has skinny extents
> [  170.596218] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4
> devid 1 transid 5 /dev)
> [  170.599471] BTRFS: device fsid 37c6bae1-d3e5-47f8-87d5-87cd7240a1b4 devid 2 transid 5 /dev)
> [  170.657170] BTRFS info (device vdc): flagging fs with big metadata feature
> [  170.659509] BTRFS info (device vdc): use zlib compression, level 3
> [  170.661190] BTRFS info (device vdc): disk space caching is enabled
> [  170.670706] BTRFS info (device vdc): has skinny extents
> [  170.714181] BTRFS info (device vdc): checking UUID tree
> [  170.735058] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  170.736478] #PF: supervisor read access in kernel mode
> [  170.737457] #PF: error_code(0x0000) - not-present page
> [  170.738529] PGD 0 P4D 0 
> [  170.739211] Oops: 0000 [#1] PREEMPT SMP PTI
> [  170.740101] CPU: 0 PID: 43 Comm: kworker/u4:3 Not tainted 5.18.0-rc7+ #1539
> [  170.741478] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [  170.743246] Workqueue: btrfs-delalloc btrfs_work_helper
> [  170.744282] RIP: 0010:zlib_compress_pages+0x128/0x670

I've just hit the crash too, so I've removed the patches from misc-next
until there's fixed version.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9144D53934E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbiEaOr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345315AbiEaOr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 10:47:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60F6F4BA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 07:47:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 111C41F86A;
        Tue, 31 May 2022 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654008474;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+Grnx0YnBHA5wHOYMjjzKpRfhcXH/VUae2f1kQi/8Y=;
        b=CqsD2VpNxAiQr3qNjcJb6lvPUHzOUBA45H6tUmz0FmFZOS6qbls1WZRD1gEoSjX6dTugER
        EmB07QyAguQ39h19G1bsMBkoCOxf/By/ro1A6IaAQzJO0FjmYoelz5KNVgrlYjXdIcHmxc
        rLGlEw9qgjDGBQIoChQ/Br0OArrHf8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654008474;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7+Grnx0YnBHA5wHOYMjjzKpRfhcXH/VUae2f1kQi/8Y=;
        b=FTOO3yeCDGTrZ5wNUNJfIXepJjbcDFJVIg7fLrUTO6R9Oi5HR+/Cdup95x35SM86du4XuR
        1v6T7KA9GCWhMiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB8A813AA2;
        Tue, 31 May 2022 14:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yBOtNJkqlmI7OgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 31 May 2022 14:47:53 +0000
Date:   Tue, 31 May 2022 16:43:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add btrfs_debug() output for every bio submitted
 by btrfs RAID56
Message-ID: <20220531144328.GI20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
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

On Tue, May 31, 2022 at 05:22:56PM +0800, Qu Wenruo wrote:
> For the later incoming RAID56J, it's better to know each bio we're
> submitting from btrfs RAID56 layer.
> 
> The output will look like this:
> 
>  BTRFS debug (device dm-4): partial rmw, full stripe=389152768 opf=0x0 devid=3 type=1 offset=16384 physical=323043328 len=49152
>  BTRFS debug (device dm-4): partial rmw, full stripe=389152768 opf=0x0 devid=1 type=2 offset=0 physical=67174400 len=65536
>  BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 opf=0x1 devid=3 type=1 offset=0 physical=323026944 len=16384
>  BTRFS debug (device dm-4): full stripe rmw, full stripe=389152768 opf=0x1 devid=2 type=-1 offset=0 physical=323026944 len=16384
> 
> The above debug output is from a 16K data write into an empty RAID56
> data chunk.
> 
> Some explanation on them:
>  opf:		bio operation
>  devid:		btrfs devid
>  type:		raid stripe type.
> 		>=1 are the Nth data stripe.
> 		-1 for P stripe, -2 for Q stripe.
> 		0 for error (btrfs device not found)
>  offset:	the offset inside the stripe.
>  physical:	the physical offset the bio is for
>  len:		the lenghth of the bio
> 
> The first two lines are from partial RMW read, which is reading the
> remaining data stripes from disks.
> 
> The last two lines are for full stripe RMW write, which is writing the
> involved two 16K stripes (one for data1, one for parity).
> The stripe for data2 is doesn't need to be written.
> 
> To enable any btrfs_debug() output, it's recommended to use kernel
> dynamic debug interface.
> 
> For this RAID56 example:
> 
>   # echo 'file fs/btrfs/raid56.c +p' > /sys/kernel/debug/dynamic_debug/control

Have you considered using a tracepoint instead of dynamic debug?

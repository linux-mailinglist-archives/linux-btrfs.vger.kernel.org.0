Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532461FAC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKGRFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGRFW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 12:05:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016A12D21
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 09:05:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D043F22587;
        Mon,  7 Nov 2022 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6u73g3FNKFIJ/AVAqMoG/iueYq5paQYSNy/prxonyM=;
        b=koJWV7rgCkJxFasChx5kYHFtTk7FmFQLe56gU2X31s0K3iUFCtmHvQYj1iZdch/qpwzyKz
        kRvVnDmkoSiCJgLE0ez1KjhWA8q8XL6Y+EjrF307Mk7AwiyU3XoCC35eHNMZAWi/tqNnrh
        Hy0OkBhydW4b+6ess+ctwXeLPjukw1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840718;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6u73g3FNKFIJ/AVAqMoG/iueYq5paQYSNy/prxonyM=;
        b=5Xn2mwT7rKhMZkpwNn8Sb6n72mnO9ihp98toANnrYLvH3pzfJL+rhKWVqK6A+To5/G/FQM
        zS1l3hFLunoiDlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC51E13AC7;
        Mon,  7 Nov 2022 17:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZdkbKc46aWMmfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 07 Nov 2022 17:05:18 +0000
Date:   Mon, 7 Nov 2022 18:04:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: raid56: make raid56 to use more accurate
 error bitmap for error detection
Message-ID: <20221107170457.GV5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667805755.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667805755.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 03:32:28PM +0800, Qu Wenruo wrote:
> Currently btrfs raid56 uses stripe based error detection.
> 
> This means, any error (which vary from single sector csum mismatch, to a
> missing device) will mark the whole horizontal stripe as error.
> 
> This can lead to some unexpected behavior, for example:
> 
> 
>              0        32K       64K
>      Data 1  |XXXXXXXX|         |
>      Data 2  |        |XXXXXXXXX|
>      Parity  |        |         |
> 
> When reading data 1 [0, 32K), we got csum mismatch and go RAID56
> recovery path.
> 
> If going the old path, we will mark the whole data 1 [0, 64K) all as
> error, and recover using data 2 and parity.
> 
> But since data 2 [32K, 64K) is also corrupted, the recovered data will
> also be corrupted.
> 
> Thankfully such problem will be mostly avoided after commit f6065f8edeb2
> ("btrfs: raid56: don't trust any cached sector in
> __raid56_parity_recover()"), as when we read the sectors in data 2 [32K,
> 64K), we will recover discarding all the cached result.
> 
> 
> This patchset will change the behavior by introducing an error bitmap,
> recording corrupted sector one by one, so for above case, at least we
> won't try to recover data 1 [32K, 64K) using incorrect data.
> 
> The true solution to this destructive RMW problem will be read time csum
> verification, but this patchset introduces the basis to handle extra
> csum mismatch error better (csum mismatch will also be marked as error,
> but only for the offending sectors).
> 
> This patchset itself doesn't improve the raid56 destructive RMW
> situation by itself, but would make later destructive RMW fix much
> easier to implement.
> 
> Qu Wenruo (3):
>   btrfs: raid56: introduce btrfs_raid_bio::error_bitmap
>   btrfs: raid56: migrate recovery and scrub recovery path to use
>     error_bitmap
>   btrfs: raid56: remove the old error tracing system

With minor fixups added to misc-next, thanks.

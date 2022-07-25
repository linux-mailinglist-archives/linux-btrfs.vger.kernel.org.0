Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5F0580235
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 17:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiGYPtp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiGYPto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 11:49:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1FDEE7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 08:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E7223730F;
        Mon, 25 Jul 2022 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658764182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXEryDzBw/LW9ys0ndjvp1sB3M8b+hFqgKvXA/31i2c=;
        b=wziH6evJVkFTy8cbHZ6AehH7NeZ+HxtyXBCzGiSygXtHG/zH7/gvn+usDphe3CxqppWtll
        bNpkHpOenr7zLlt93s2cq34jUTjJQKR5smuVx85xPa1DmOjhOUV356KyXCrN5Sepv/Be2q
        SsrQwI0CMEsTcH2skfq1eT4ROLwCLgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658764182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXEryDzBw/LW9ys0ndjvp1sB3M8b+hFqgKvXA/31i2c=;
        b=Dw+wqZlD3XrsuM3mAXImr4BS9Gc9W2Er7Q/jGmaNwWUKFIrihCmHuJ3Z69Vp/lmcLmcMGI
        vmeOoS3nGjctVbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F296D13ABB;
        Mon, 25 Jul 2022 15:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iEmUOZW73mL+OwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 15:49:41 +0000
Date:   Mon, 25 Jul 2022 17:44:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: do not batch insert non-consecutive dir
 indexes during log replay
Message-ID: <20220725154445.GZ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Filipe Manana <fdmanana@suse.com>
References: <a69adbc22b4b4340a7289d8b9bbb9878d6c00192.1658411151.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69adbc22b4b4340a7289d8b9bbb9878d6c00192.1658411151.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 09:47:39AM -0400, Josef Bacik wrote:
> While running generic/475 in a loop I got the following error
> 
> BTRFS critical (device dm-11): corrupt leaf: root=5 block=31096832 slot=69, bad key order, prev (263 96 531) current (263 96 524)
> <snip>
>  item 65 key (263 96 517) itemoff 14132 itemsize 33
>  item 66 key (263 96 523) itemoff 14099 itemsize 33
>  item 67 key (263 96 525) itemoff 14066 itemsize 33
>  item 68 key (263 96 531) itemoff 14033 itemsize 33
>  item 69 key (263 96 524) itemoff 14000 itemsize 33
> 
> As you can see here we have 3 dir index keys with the dir index value of
> 523, 524, and 525 inserted between 517 and 524.  This occurs because our
> dir index insertion code will bulk insert all dir index items on the
> node regardless of their actual key value.
> 
> This makes sense on a normally running system, because if there's a gap
> in between the items there was a deletion before the item was inserted,
> so there's not going to be an overlap of the dir index items that need
> to be inserted and what exists on disk.
> 
> However during log replay this isn't necessarily true, we could have any
> number of dir indexes in the tree already.
> 
> Fix this by seeing if we're replaying the log, and if we are simply skip
> batching if there's a gap in the key space.
> 
> This file system was left broken from the fstest, I tested this patch
> against the broken fs to make sure it replayed the log properly, and
> then btrfs check'ed the file system after the log replay to verify
> everything was ok.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, add to misc-next.

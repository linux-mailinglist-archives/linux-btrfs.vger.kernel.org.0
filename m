Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994A6DA0BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjDFTMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjDFTMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 15:12:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FEE59D5;
        Thu,  6 Apr 2023 12:12:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73E1C1F37C;
        Thu,  6 Apr 2023 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680808327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHJ/7zRzPjjXOi2F10vF9rZ9V0TrUv+2tZqKAaapEJU=;
        b=OcWrcu0l98HfYbAucJ2Hcyt6xXggIfTTy5Tsapp7gnXEzlPLvYa/KNF/2UsoeSFNw7mz+c
        nKJRRPe3+geqL+NNYh0j2GFgzO7+hqBcL6obQV815ngtkhaj55h9r6jvBuVyimr12w6MJ2
        8FkEZ1SDsB2QDoxxT+DvLTaLDs7B9Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680808327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHJ/7zRzPjjXOi2F10vF9rZ9V0TrUv+2tZqKAaapEJU=;
        b=FbcQ+OKRAnKlPWN101NAUu79j+AbCjziWGryLPWJU+eXNpligODazsgBwjkDEhlYUzofY6
        2r8/sWP2wbRKgeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 385F21351F;
        Thu,  6 Apr 2023 19:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHnMDIcZL2Q4QgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 19:12:07 +0000
Date:   Thu, 6 Apr 2023 21:12:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Genjian <zhanggenjian123@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
Message-ID: <20230406191204.GZ19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:08:38AM +0800, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> compiler warning:
> 
> ../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
> ../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  2703 |   btrfs_setup_sprout(fs_info, seed_devices);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
> ../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    70 |   (__if_trace.miss_hit[1]++,1) :  \
>       |                                ^
> ../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
>  1878 |  u64 right_gen;
>       |      ^~~~~~~~~
> 
> Initialize the uninitialized variables.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>

The warnings are still reported by other build reports so I'll apply
this patch. If you have found more please send a patch or I can update
this one once applied. Thanks.

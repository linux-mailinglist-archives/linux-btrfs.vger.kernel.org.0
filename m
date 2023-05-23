Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D370E23A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjEWQaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEWQaJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 12:30:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1595C2;
        Tue, 23 May 2023 09:30:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23957227E1;
        Tue, 23 May 2023 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684859405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrLx0Egcaw0whIq7DRTtuN+cxqWzcno7lSmgBonJeXA=;
        b=LC+69jToeST6d2IF1TdJH6kiCDDPcm7fdmkXnivKpaoxE1boWMPwxiPVqzyJE65siJY23V
        uuj7yTe+4srNnFdmw23A53bYIXXJiWou5+DQ1XPfS14+9D6xHV2rU1RnHQ8E5+ulOUfWTu
        xAfgWOweUgC/SzDJDdx0ilBwX2yX01I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684859405;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrLx0Egcaw0whIq7DRTtuN+cxqWzcno7lSmgBonJeXA=;
        b=MpvjYiTfjUOWbbzzdRvKMyyQIar/RVwcbR8LuwtUCm21Kk9fsoIpT/ns/pnqmZa7xkKxMG
        4SWPukg946lcdfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD9E813588;
        Tue, 23 May 2023 16:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VdFTNQzqbGQdHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 May 2023 16:30:04 +0000
Date:   Tue, 23 May 2023 18:23:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warnings
Message-ID: <20230523162357.GX32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523085935.713859-1-pengfuyuan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523085935.713859-1-pengfuyuan@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 04:59:35PM +0800, pengfuyuan wrote:
> 
> There are some warnings on older compilers (gcc 10, 7) or non-x86_64
> architectures (mips64).  As btrfs wants to enable -Wmaybe-uninitialized
> by default, fix the warnings even though it's not necessary on recent
> compilers (gcc 12+).
> 
>     fs/btrfs/tree-log.c: In function ???btrfs_log_inode???:
>     fs/btrfs/tree-log.c:6211:9: error: ???last_range_start??? may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      6212 |       first_dir_index, last_dir_index);
>           |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     fs/btrfs/tree-log.c:6161:6: note: ???last_range_start??? was declared here
>      6161 |  u64 last_range_start;
>           |      ^~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>

Thanks, this warning got reported reported recently [1] and the fix is
now in queue.

[1] https://lore.kernel.org/linux-btrfs/20230516013430.2712449-1-zhangshida@kylinos.cn/

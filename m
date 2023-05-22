Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6E70CD12
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjEVV6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEVV6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 17:58:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED0109;
        Mon, 22 May 2023 14:58:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9176022196;
        Mon, 22 May 2023 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684792695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYYBfAEklIkusqn/OFlyvssNM5BtkSvAxPYQGLeR6DA=;
        b=E0huGujJ38TVeY/+kimceO/8xRMb/7KPMPPacM7fT428K6H9I+xfZPmpSfK9FIQQYlos36
        ZNsQwEvq+z8rYOtYj9Cz10xv4/wzn6Rxp4DwjDL7aX/uXP5Rkn7XMHObk5iJFDJoIppdCW
        wimECkhMynUZ8uo30mveB0p5dQ9YT6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684792695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYYBfAEklIkusqn/OFlyvssNM5BtkSvAxPYQGLeR6DA=;
        b=msdZbqtnddTbxCQCgCiuZswoZh+qJz2/KDZpkP4rH/PV5+sQuN+f0SD7lQ2zKQiHY5+RSn
        P7gNgHv0OeQHnvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6613C13776;
        Mon, 22 May 2023 21:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4kwGHfla2QudAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 21:58:15 +0000
Date:   Mon, 22 May 2023 23:52:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhangshida <starzhangzsd@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Message-ID: <20230522215208.GT32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516013430.2712449-1-zhangshida@kylinos.cn>
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

On Tue, May 16, 2023 at 09:34:30AM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> This fixes the following warning reported by gcc 10 under x86_64:
> 
> ../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
> ../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  6212 |       first_dir_index, last_dir_index);
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
>  6161 |  u64 last_range_start;
>       |      ^~~~~~~~~~~~~~~~
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Added to misc-next, thanks.

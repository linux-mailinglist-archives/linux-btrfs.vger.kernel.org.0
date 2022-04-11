Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6254FBFD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiDKPIP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiDKPIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 11:08:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922F25C76
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 08:05:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C34391F38D;
        Mon, 11 Apr 2022 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649689553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJPk5RuZ9shOXGxCCb5S9E0uJryZGr0hJTgTAn4ZY3Q=;
        b=ogGT35pEVU56VfPqGSq/OjP3JNdiLILtFJ24kT5EkxflS7jNpe6Do0xOa1V+mDu57a+QYN
        G+mOTxzrt+K+zcV4WL997lPMNQZ6q/NieqDcFr9qApf7qu3xDvzl9RPpS9rjihYyzLMGck
        8cY7UKPZYg01VzJv+ghoNG/2ssYOMmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649689553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJPk5RuZ9shOXGxCCb5S9E0uJryZGr0hJTgTAn4ZY3Q=;
        b=YkhIp8+IpMRt21Rb6wIWNy+qH/z5k4XhRczx+YmAjA/0tkQH6hdjr2JaJs1qvBhws0GbP4
        ZR3dr+eIWa6DkyDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB0CAA3B82;
        Mon, 11 Apr 2022 15:05:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D03DDA7F7; Mon, 11 Apr 2022 17:01:49 +0200 (CEST)
Date:   Mon, 11 Apr 2022 17:01:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs-progs: add RAID56 rebuild ability at read time
Message-ID: <20220411150149.GP15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649162174.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
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

On Tue, Apr 05, 2022 at 08:48:22PM +0800, Qu Wenruo wrote:
> This branch can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/raid56_rebuild

The mkfs tests fail in 001 with the following last command:

====== RUN CHECK root_helper .../mkfs.btrfs -f -d raid5 -m raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
WARNING: RAID5/6 support has known problems is strongly discouraged
         to be used besides testing or evaluation.

kernel-shared/transaction.c:155: __commit_transaction: BUG_ON `ret` triggered, value 65536
.../mkfs.btrfs(__commit_transaction+0x197)[0x43a107]
/...mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43a26b]
/...mkfs.btrfs(main+0x174b)[0x40f68d]
/lib64/libc.so.6(+0x2d540)[0x7f969b5ea540]
/lib64/libc.so.6(__libc_start_main+0x7c)[0x7f969b5ea5ec]
/...mkfs.btrfs(_start+0x25)[0x40d965]
/...tests/common: line 540: 29172 Aborted                 sudo -n "$@"
failed: root_helper .../mkfs.btrfs -f -d raid5 -m raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
test failed for case 001-basic-profiles

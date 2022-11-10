Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC462449D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 15:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKJOq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 09:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKJOq4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 09:46:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66B554F3;
        Thu, 10 Nov 2022 06:46:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1BB41FB05;
        Thu, 10 Nov 2022 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668091613;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Jt/suhoiYzWx8U9sRxeRu3aHlramCXqjk1o47e51K4=;
        b=tIqdljimZAIP/7sNgVslYhzp8QAME1gnD81dh7eTbbQfuT8V7Kxx77FUoALkx2yzEftZ+d
        YSnwGQNmY3shsHJoYAZFh32nxZ/MmsSta4mu8P217LNMWe498ZPGKRneGsAOlwH7lYewg+
        Kgh7V/CqMNHESKAZk8p/5/BHIoALotI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668091614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Jt/suhoiYzWx8U9sRxeRu3aHlramCXqjk1o47e51K4=;
        b=JeADnOSXrLzJwGU8WSKiphzsdQs0BjByZlgaZw+MLxRf+cV4sxoGuQ42R0ZgT0nE2hXTtL
        yEpOB1ZGgE4sQsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C736D1332F;
        Thu, 10 Nov 2022 14:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YvE+L90ObWPRLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Nov 2022 14:46:53 +0000
Date:   Thu, 10 Nov 2022 15:46:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in
 update_qgroup_limit_item()
Message-ID: <20221110144630.GF5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 10:13:42PM +0800, ChenXiaoSong wrote:
> Syzkaller reported BUG as follows:

Do you have link to the report? Or at least the identifier of the
report, there's some automation that recognizes Reported-by: syzbot-...
to close it once the patch is merged.

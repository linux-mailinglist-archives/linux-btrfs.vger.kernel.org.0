Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2558194C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiGZSEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiGZSEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 14:04:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561127CCB
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 11:04:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEEE31F9D5;
        Tue, 26 Jul 2022 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658858659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwtQiQ+/GlEO1lfY8//sxnUkArsRBGZmlpGLUNdOxiQ=;
        b=mz5yHcLm55m1pGZmIyUvJchpPnDvk/5UdF4FTseGVWhNZSdLx2xq1ibZIA7AB1Ce6S9GAY
        4bghiAKYtrd4EQTScrzOtB52ceZYyesiUyaZzjH5Z5gsea6Xt+uu/NTMeNDV3Zqy4b8lNY
        Xqdy32Yl3VEU0JLThh5VAXnG3a4DDE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658858659;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwtQiQ+/GlEO1lfY8//sxnUkArsRBGZmlpGLUNdOxiQ=;
        b=H21mAojGayt7tOMFu/rBe4nCy3Q85Hg6rLZR1czg8oXwPHVICkt6nhAT3ij+nv5rM53JmD
        RoMC39nP6ZKmHxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A479913A7C;
        Tue, 26 Jul 2022 18:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zNQoJ6Ms4GIkEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 18:04:19 +0000
Date:   Tue, 26 Jul 2022 19:59:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: separate BLOCK_GROUP_TREE feature from
 extent-tree-v2
Message-ID: <20220726175922.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1658293417.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658293417.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 01:06:58PM +0800, Qu Wenruo wrote:
> Qu Wenruo (3):
>   btrfs: enhance unsupported compat RO flags handling
>   btrfs: don't save block group root into super block
>   btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2

It's short series and I don't see any new code to use the separate tree
for bg items, so it's on top of the extent tree v2, right?

From the last time we were experimenting with the block group tree, I
was trying to avoid a new tree but there were problems. So, I think we
can go with the separate tree that you suggest. We have reports about
slow mount and people use large filesystems, so this is justified.

Will it be possible to convert existing filesystem to use the bg tree?
I'm not sure about a remount, that would need a new option and for
single use. We could possibly use the sysfs interface to trigger it, or
leave it to offline change by btrfstune.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A05A85BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 20:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiHaSgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 14:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiHaSga (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 14:36:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356A112389
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 11:31:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95846220B8;
        Wed, 31 Aug 2022 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661970716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4daFVFjGhBwkA4TxRCa4zib3uGkbzZqGxA8/ULS23JI=;
        b=ODQx6CdtrPuaTaD25fMw4x6G5McozIMKAj2YNCGAaMmq6rfnqlH8QHvTCXUvbRg5G+SNHq
        2AZB1y+axSvbDcTgca3420P/h2zKDKXYnRpKtcbke1M+cJYaAuy+F4UqwpZwFnmkk4Ox3Q
        eQnPVTiKZi6wuaz9Hp+Jt29yzEVntcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661970716;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4daFVFjGhBwkA4TxRCa4zib3uGkbzZqGxA8/ULS23JI=;
        b=3A/vrtnzzsakqIRhKiwccqlqXj5tWTeacPfe1KlL7pyvOWqj5ifV6sdIb4py8957XOq0Mg
        vo0I5HUe3YWKG2Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70F151332D;
        Wed, 31 Aug 2022 18:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0YTbGRypD2P8OwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 18:31:56 +0000
Date:   Wed, 31 Aug 2022 20:26:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] btrfs-progs: separate BLOCK_GROUP_TREE feature
 from extent-tree-v2
Message-ID: <20220831182637.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660024949.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 02:03:50PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> [TODO]
> - Add btrfstune support to convert from block-group-tree feature
>   The infrastructure is already done.
> 
> Qu Wenruo (5):
>   btrfs-progs: mkfs: dynamically modify mkfs blocks array
>   btrfs-progs: don't save block group root into super block
>   btrfs-progs: separate block group tree from extent tree v2
>   btrfs-progs: btrfstune: add the ability to convert to block group tree
>     feature
>   btrfs-progs: mkfs: add artificial dependency for block group tree

The kernel part is in for-next so I'll add this to progs, so far not
under the experimental build but this should be resolved until the
final kernel release.

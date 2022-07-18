Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D73578639
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiGRPZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiGRPZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 11:25:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4628E2F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 08:25:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6D911FCF9;
        Mon, 18 Jul 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658157948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzEly5Dg4oVnIoDJN1df0+CA3YrwDtkxs/YwuyrXlZ0=;
        b=Yr+GJN3+kuHxbpOvbOSbX+ur+v3EpNqlgUUdhVIqsNNykx1Nc2Hk8ZoiszfP9su56P81xZ
        /O0CLd/Ti07OvNynihHO2NYB7rpGokqw0FvoYLu2WmLxo4dtFXhS1vnsr4TgMbS0tvUj8s
        XleN0+/hCzTq0e8SgzZ95QBiFsZpd1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658157948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzEly5Dg4oVnIoDJN1df0+CA3YrwDtkxs/YwuyrXlZ0=;
        b=2E54fnN725VxLocJLhC8hQ6CeuK4fnkAFpH7SlAZUzu1pjPjhAvUWT/OeKeqr/XWM91QhN
        ZXBdxP3U4hU8ORDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BE5513754;
        Mon, 18 Jul 2022 15:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZXJ0JHx71WLnWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 15:25:48 +0000
Date:   Mon, 18 Jul 2022 17:20:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert: Properly work with large ext4
 filesystems
Message-ID: <20220718152055.GE13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220607102421.170419-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607102421.170419-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 01:24:21PM +0300, Nikolay Borisov wrote:
> On large (blockcount > 32bit) filesystems reading directly
> super_block->s_blocks_count is not sufficient as the block count is held
> in 2 separate 32 bit variables. Instead always use the provided
> ext2fs_blocks_count to read the value. This can result in assertion
> failure, when the block count is only held in the high 32 bits, in this
> case s_block_counts would be zero, which would result in
> btrfs_convert_context::block_count/total_bytes to also be 0 and hit an
> assertion failure:
> 
>     convert/main.c:1162: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
>     btrfs-convert(+0xffb0)[0x557defdabfb0]
>     btrfs-convert(main+0x6c5)[0x557defdaa125]
>     /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f66e1f8bd0a]
>     btrfs-convert(_start+0x2a)[0x557defdab52a]
>     Aborted
> 
> What's worse it can also result in btrfs-conver mistakenly thinking that
> a filesystem is smaller than it actually is (ignoring the top 32 bits).
> 
> Link: https://lore.kernel.org/linux-btrfs/023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech/
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.

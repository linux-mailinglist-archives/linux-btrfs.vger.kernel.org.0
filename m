Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DAB777CE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjHJP5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjHJP5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AF2704
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 08:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFC6621862;
        Thu, 10 Aug 2023 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691683019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kzxa3KTN+F2CvqyIUFLFsM1utDGjx8JbALsQVJULS44=;
        b=oJP0Ep3/5jORaQ3hED9ecrlGhOI7uo9VJ2P1DRjuX4DeFsPaGXw3gbniia3DZWjhjIv+9d
        rVaOcpmFoixob5obLSYrycGbL44UZpeX9+kBEU/HDTk4yiLxUB8FgMNgcpCvG+G5oUch+H
        ZLfRBWalxynhPDbjHIH6sgR0fWKdSek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691683019;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kzxa3KTN+F2CvqyIUFLFsM1utDGjx8JbALsQVJULS44=;
        b=KNJVEitEOKIzwsQt8OQJuLpzpDraYR/Fd+00rxKAQAoesILLlcloAsUp3iNHZskVzeG4bF
        ADH/ruvpdc6D8VBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA42C138E2;
        Thu, 10 Aug 2023 15:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OcqrKMsI1WSYLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 15:56:59 +0000
Date:   Thu, 10 Aug 2023 17:50:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set_page_extent_mapped after read_folio in
 relocate_one_page
Message-ID: <20230810155034.GF2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <447c5374eeee4ad7abb5320602be92bf5748c04c.1690816368.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447c5374eeee4ad7abb5320602be92bf5748c04c.1690816368.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 11:13:00AM -0400, Josef Bacik wrote:
> One of the CI runs triggered the following panic
> 
> assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:229
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/subpage.c:229!
> Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> CPU: 0 PID: 923660 Comm: btrfs Not tainted 6.5.0-rc3+ #1
> pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : btrfs_subpage_assert+0xbc/0xf0
> lr : btrfs_subpage_assert+0xbc/0xf0
> sp : ffff800093213720
> x29: ffff800093213720 x28: ffff8000932138b4 x27: 000000000c280000
> x26: 00000001b5d00000 x25: 000000000c281000 x24: 000000000c281fff
> x23: 0000000000001000 x22: 0000000000000000 x21: ffffff42b95bf880
> x20: ffff42b9528e0000 x19: 0000000000001000 x18: ffffffffffffffff
> x17: 667274622f736620 x16: 6e69202c65746176 x15: 0000000000000028
> x14: 0000000000000003 x13: 00000000002672d7 x12: 0000000000000000
> x11: ffffcd3f0ccd9204 x10: ffffcd3f0554ae50 x9 : ffffcd3f0379528c
> x8 : ffff800093213428 x7 : 0000000000000000 x6 : ffffcd3f091771e8
> x5 : ffff42b97f333948 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : ffff42b9556cde80 x0 : 000000000000004f
> Call trace:
>  btrfs_subpage_assert+0xbc/0xf0
>  btrfs_subpage_set_dirty+0x38/0xa0
>  btrfs_page_set_dirty+0x58/0x88
>  relocate_one_page+0x204/0x5f0
>  relocate_file_extent_cluster+0x11c/0x180
>  relocate_data_extent+0xd0/0xf8
>  relocate_block_group+0x3d0/0x4e8
>  btrfs_relocate_block_group+0x2d8/0x490
>  btrfs_relocate_chunk+0x54/0x1a8
>  btrfs_balance+0x7f4/0x1150
>  btrfs_ioctl+0x10f0/0x20b8
>  __arm64_sys_ioctl+0x120/0x11d8
>  invoke_syscall.constprop.0+0x80/0xd8
>  do_el0_svc+0x6c/0x158
>  el0_svc+0x50/0x1b0
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x194/0x198
> Code: 91098021 b0007fa0 91346000 97e9c6d2 (d4210000)
> 
> This is the same problem outlined in "btrfs: set_page_extent_mapped
> after read_folio in btrfs_cont_expand", and the fix is the same.  I
> originally looked for the same pattern elsewhere in our code, but
> mistakenly skipped over this code because I saw the page cache readahead
> before we set_page_extent_mapped, not realizing that this was only in
> the !page case, that we can still end up with a !uptodate page and then
> do the btrfs_read_folio further down.
> 
> The fix here is the same as the above mentioned patch, move the
> set_page_extent_mapped call to after the btrfs_read_folio() block to
> make sure that we have the subpage blocksize stuff setup properly before
> using the page.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

With the updated patch referece added to misc-next, thanks.

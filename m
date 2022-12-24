Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACE6559C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Dec 2022 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiLXKU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Dec 2022 05:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLXKUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Dec 2022 05:20:25 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A40D107
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Dec 2022 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202212; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r2mZ3ZsV1eEGuy46kFs1Ey6KnDqzgjDYOoxAiFKLbV8=; b=MOOQ770ULB+PNuXSjzcJhDuJce
        lzHfM/OPemeJTFOfG1V1M8IaDtzLOAUbm9rdYYpOZ7Ye02H9wLL1hjZgQV7DaVCa2TF7H1iDAP1YM
        x41a9wvlu6g5xgtgvtETqHDOSDdQH9veYc+dNurwNxBvsUA2a4nEKxMvHMBvv1lNyt3LxcmqNLDXr
        MVwhggpSzCRIkp06SojBkjQh3vhoUZaayuvfrvTQDK4yVC5VTacLTGqJ4r+IR1mUpcHXoY7IPdjre
        7FosQ66YkxoYDBwxT8mSE5gv+LEfZFjqAarUDuU7RpGPufQXvB31cc8bz+C2XKIbXlJqhq4voAZJF
        5heH4vVA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:18233 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1p91dc-00ELpk-KR;
        Sat, 24 Dec 2022 11:20:20 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Btrfs progs release 6.1
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20221222205716.4916-1-dsterba@suse.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <00ac11fa-b6c9-6234-50db-3af1c2ae826c@dirtcellar.net>
Date:   Sat, 24 Dec 2022 11:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.14
MIME-Version: 1.0
In-Reply-To: <20221222205716.4916-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have nagged about this before, but here goes again.
Can we as users get some kind of deduplicaiton support for btrfs-progs?

As a conservative Debian user I tend to stick with what is in the 
package repos, and I also believe that most people will feel more 
comfortable with a "official" implementation rather than some random 
program for this kind of stuff.

something as "simple" as "btrfs filesystem deduplicate -R /mnt" would be 
wonderful.

So pretty please with sugar coated syrup with on top of nectar or 
something ...and since it is Christmas - please do consider adding some 
kind of deduplicaiton feature to btrfs progs in the near future.

PS! Merry Christmas to everyone! :)

David Sterba wrote:
> Hi,
> 
> btrfs-progs version 6.1 have been released.
> 
> There are new commands that are in the experimental mode until the interface
> stabilizes, which means that it's a good time to give feedback or point out
> deficiencies. There's no ETA set to remove the experimental status, I think and
> hope that the feedback loop could work better if there's something tangible and
> ready to test. The code is not the hard part unlike the interfaces and
> formatting, this starts at the use case and user input is the important part.
> 
> The json output is also kind of experimental but there are tools that want it
> now and can give feedback before there's some common format for all commands.
> 
> Relevant issues
> 
> * reflink group and commands: https://github.com/kdave/btrfs-progs/issues/396
> * inspect list-chunks: https://github.com/kdave/btrfs-progs/issues/559
> * all current experimental features: https://github.com/kdave/btrfs-progs/issues?q=is%3Aissue+is%3Aopen+label%3Aexperimental
> 
> Changelog:
> 
>     * filesystem df: add json output
>     * qgroup show: add json output
>     * new command: 'inspect-internal map-swapfile' to check swapfile and its
>       swapfile_offset value used for hibernation
>     * corrupt-block: fix parsing of option --root argument
>     * experimental (interfaces not finalized):
>        * new command 'inspect-internal list-chunks'
>        * new group reflink, command clone
>     * other:
>        * synchronize some files with kernel versions
>        * docs updates
>        * build: use gnu11
> 
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> 
> Shortlog:
> 
> David Sterba (21):
>        btrfs-progs: inspect: new subcommand to list chunks
>        btrfs-progs: string-table: cleanup and enhance formatting capabilities
>        btrfs-progs: string-table: check bounds before writing to a cell
>        btrfs-progs: string-table: add ranged API for printing and clearing
>        btrfs-progs: tests: add string-table test framework
>        btrfs-progs: inspect: new command map-swapfile
>        btrfs-progs: fi df: implement json output
>        btrfs-progs: docs: swapfile and hibernation
>        btrfs-progs: fi mkswapfile: update help text
>        btrfs-progs: add new group reflink and command
>        btrfs-progs: docs: fix typos
>        btrfs-progs: docs: add 6.1 development statistics
>        btrfs-progs: docs: updates, clarifications
>        btrfs-progs: qgroup show: add json output
>        btrfs-progs: add json formatter for escaped string
>        btrfs-progs: use escaped json format for paths
>        btrfs-progs: device stats: fix json formatter type for devid
>        btrfs-progs: docs: typo fixups and formatting updates
>        btrfs-progs: docs: add some kernel 6.1 release notes
>        btrfs-progs: update CHANGES for 6.1
>        Btrfs progs v6.1
> 
> Josef Bacik (21):
>        btrfs-progs: build: turn on more compiler warnings and use -Wall
>        btrfs-progs: fix make clean to clean convert properly
>        btrfs-progs: build: use -std=gnu11
>        btrfs-progs: ioctl: move btrfs_err_str into common/utils.h
>        btrfs-progs: rename qgroup items to match the kernel naming scheme
>        btrfs-progs: make btrfs_qgroup_level helper match the kernel
>        btrfs-progs: ioctl: move dev-replace NO_RESULT definition into replace.c
>        btrfs-progs: image: rename BLOCK_* to IMAGE_BLOCK_* for metadump
>        btrfs-progs: rename btrfs_item_end to btrfs_item_data_end
>        btrfs-progs: copy ioctl.h into libbtrfs
>        btrfs-progs: stop using btrfs_root_item_v0
>        btrfs-progs: make the find extent buffer helpers take fs_info
>        btrfs-progs: move dirty eb tracking to it's own io_tree
>        btrfs-progs: do not pass io_tree into verify_parent_transid
>        btrfs-progs: move extent cache code directly into btrfs_fs_info
>        btrfs-progs: delete state_private code
>        btrfs-progs: rename extent buffer flags to EXTENT_BUFFER_*
>        btrfs-progs: sync compression.h from the kernel
>        btrfs-progs: replace btrfs_leaf_data with btrfs_item_nr_offset
>        btrfs-progs: don't use btrfs_header_csum helper
>        btrfs-progs: make write_extent_buffer take a const eb
> 
> Qu Wenruo (1):
>        btrfs-progs: corrupt-block: fix the mismatch in --root and -r options
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C060BA50
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiJXUe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiJXUdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9F2A437
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:44:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6305821940;
        Mon, 24 Oct 2022 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666619275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+ZzMEjxy0gLwhbWMcm7O4mBx7wKHrSwg3Ok1reM4pA=;
        b=m+p42OuMsNXrgKayCYBxj6G+XPyXgW/48zm6SF8UJzMR/BSWI1jU+B4jZqHBDhRs7tDAXH
        0nhpd15RY53xeRvgsq3NpBYOd0YyVZ10P7rCwHvpvFT2fsubEYgnXSz9LTKi/cRkxxJLjz
        BVMft8vie48g6rE+VCIKEYGMtY5HrGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666619275;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+ZzMEjxy0gLwhbWMcm7O4mBx7wKHrSwg3Ok1reM4pA=;
        b=1RHHMQfdiwOJqY2yT6g7xCS0HUVac4LfHRSXrGQZEkqIaD0oOoepMdP4vwNFzPAFD/PP5U
        DPiCIcLkJ7IL1QDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A45D13357;
        Mon, 24 Oct 2022 13:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fDc4DYuXVmOTCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 24 Oct 2022 13:47:55 +0000
Date:   Mon, 24 Oct 2022 15:47:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/15] btrfs: make open_ctree() init/exit sequence
 strictly matched
Message-ID: <20221024134742.GB5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665565866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 12, 2022 at 05:12:56PM +0800, Qu Wenruo wrote:
> [Changelog]
> v2:
> - Rebased to latest misc-next
>   Most conflicts comes from the new function btrfs_check_features().
> 
> 
> Just like init_btrfs_fs(), open_ctree() also has tons of different
> labels for its error handling.
> 
> And unsurprisingly the error handling labels are not matched correctly,
> e.g. we always call btrfs_mapping_tree_free() even we didn't reach
> sys chunk array read.
> 
> And every time we need to add some new function, it will be a disaster
> just to understand where the new function should be put and how the
> error handling should be done.
> 
> This patchset will follow the init_btrfs_fs() method, by introducing
> an open_ctree_seq[] array, which contains the following sections:
> 
> - btree_inode init/exit
> - super block read and verification
> - mount options and features check
> - workqueues init/exit
> - chunk tree init/exit
> - tree roots init/exit
> - mount time check and various item load
> - sysfs init/exit
> - block group tree init/exit
> - subvolume trees init/exit
> - kthread init/exit
> - qgroup init/exit
> 
> The remaining part of open_ctree() is only less than 50 lines, and are
> all related to the very end of the mount progress, including log-replay,
> uuid tree check.

I'm not sure it's a good idea to split the open_ctree to the sequence if
initializers, some of the code looks like it's not isolated the same way
as it was in the module init/exit. The readability is IMHO also worse,
verifying that some parts depend on each other requires jumping in the
file. Maybe some parts can be put into more helpers and we can make the
exit sequence robust enough so we don't need tons of labels and the
whole can be called regardless of from where it would be called.

This is similar to the array based approach but keeps the code in one
function. As it is implemented in this patchset I think it's taking it
too far.

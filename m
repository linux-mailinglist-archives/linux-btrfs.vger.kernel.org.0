Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2F798731
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjIHMk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbjIHMk3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:40:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5A1FC6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:40:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6466221BAA;
        Fri,  8 Sep 2023 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694176822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS15BjzWidChula0by5R534iDjPEyTmog9P8hxKEBFI=;
        b=wjWOXwuq+DhmZ5tCGjAYb+yGTYUijP+wALI9Y9ZCNHqZ0lAn5jfZscJM33MYCYDKMosA4G
        2YAfS4CUFS1BdspUavOvuIJypCe767jGDdPxeI+UXujI5MOQZ5zC78ECKWbqOVkIxqoi+t
        M40r2FdARtmwi+k489ELswfdjwQAVd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694176822;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS15BjzWidChula0by5R534iDjPEyTmog9P8hxKEBFI=;
        b=l4WCn6CiJXkoqkLQYF6Rp3ifDsjsi8BwvYPYb2TmKuH90EK92SnvCJQoWlNNBs+OEDO8/P
        pIdVPmoqHBEK3yCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2456F131FD;
        Fri,  8 Sep 2023 12:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bU3qBzYW+2TdQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 12:40:22 +0000
Date:   Fri, 8 Sep 2023 14:33:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: drop __must_check annotations
Message-ID: <20230908123349.GX3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694126893.git.dsterba@suse.com>
 <565b63e6e34c122ca9bbe1e0272f43d6327a6316.1694126893.git.dsterba@suse.com>
 <ef9b407d-b9ac-487d-8194-6a26e4cafb21@gmx.com>
 <20230908003415.GT3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908003415.GT3159@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 02:34:15AM +0200, David Sterba wrote:
> On Fri, Sep 08, 2023 at 07:56:24AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2023/9/8 07:09, David Sterba wrote:
> > > Drop all __must_check annotations because they're used in random
> > > functions and not consistently. All errors should be handled.
> > 
> > Is there any compiler warning option to warn about unchecked return value?
> 
> By default this is checked for functions annotated by warn_unused_result
> attribute, which is exactly what __must_check does. The check can be
> disabled but that's not what we want.
> 
> > In fact recently when working on qgroup GFP_ATOMIC, I found a call site
> > that we didn't handle error at all (qgroup_update_counters()).
> 
> A quick way how to check if a given function is properly handled is to
> add the __must_check attribute and run build. For qgroup_update_counters
> this is found right away:
> 
>   CC [M]  fs/btrfs/qgroup.o
> fs/btrfs/qgroup.c: In function ‘btrfs_qgroup_account_extent’:
> fs/btrfs/qgroup.c:2736:9: warning: ignoring return value of ‘qgroup_update_counters’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>  2736 |         qgroup_update_counters(fs_info, qgroups, nr_old_roots, nr_new_roots,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  2737 |                                num_bytes, seq);
>       |                                ~~~~~~~~~~~~~~~
> 
> > I'm pretty sure that is not the last one.
> 
> Yeah but we'd have to add the attribute to most if not all functions. It
> could be possibly automated using coccinnelle scripts, list functions,
> apply a semantic patch to add the attribute, compile it and get the
> results. A quick test shows it's doable.

We have 3179 functions, lots of them return void (but they might ignore
return values from called functions so it does not mean they're safe).
There are 65 Functions that don't have all their return values checked,
which 2%.

There are several that do the extent bit handling and we knowingly don't
handle the errors because all fatal erros lead to panic. The remaining
are a mixed bag, I tried to check a few randomly and it seems that the
error handling could lead to bad situations.

Ideally we should audit the whole list, and also maybe identify some key
functions that should have the __must_check attribute, e.g.
btrfs_commit_transaction (which is not in the list).

add_async_extent
add_delayed_ref_head
add_extent_mapping
add_ra_bio_pages
addrm_unknown_feature_attrs
btree_release_folio
__btrfs_add_free_space
btrfs_block_rsv_release
btrfs_cache_block_group
btrfs_cleanup_transaction
__btrfs_commit_inode_delayed_items
btrfs_del_item
btrfs_do_readpage
btrfs_end_transaction
btrfs_finish_ordered_io
btrfs_forget_devices
btrfs_free_reserved_extent
btrfs_free_stale_devices
btrfs_grab_root
btrfs_inode_lock
btrfs_log_inode_parent
btrfs_orphan_del
btrfs_pin_extent
btrfs_ref_tree_mod
__btrfs_release_folio
btrfs_release_folio
btrfs_repair_eb_io_failure
btrfs_reset_sb_log_zones
__btrfs_run_defrag_inode
btrfs_wait_block_group_cache_done
btrfs_wq_run_delayed_node
btrfs_zone_activate
cache_save_setup
clear_extent_bit
clear_extent_bits
clear_extent_dirty
clear_extent_uptodate
clear_state_bit
del_qgroup_rb
del_qgroup_relation_item
del_relation_rb
dev_extent_hole_check
do_zone_finish
fill_writer_pointer_gap
find_next_key
get_raid56_logic_offset
inc_block_group_ro
insert_root_entry
invalidate_extent_cache
link_free_space
load_block_group_size_class
maybe_fail_all_tickets
pin_down_extent
process_page_range
push_for_double_split
qgroup_unreserve_range
qgroup_update_counters
release_extent_buffer
remove_from_discard_list
tree_insert_offset
try_merge_free_space
unlock_extent
unpin_extent_range
update_backref_cache
__update_reloc_root

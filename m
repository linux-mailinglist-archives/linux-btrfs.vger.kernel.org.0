Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD094CFF05
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiCGMoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 07:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiCGMoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 07:44:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF4A1FA73
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 04:43:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE0A81F37D;
        Mon,  7 Mar 2022 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646656994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zm3yxjprfqx2kWI6P7D1NAE1nSgkou6wmGdk5DAx6yk=;
        b=TvUQ5cBCarWUEt48nVa8IsduZFz1dBCP3DhsdxQoKdP3CssTiipf/hPIhZKrKyPvdcI1Py
        IQiCN3gy7pzHk9Vf/V+wtR1eXPpOt8izZXlzSc/Gsv+mugjXwMtxfn1gRe4+oVEPqocjmk
        LeFloygdwrIXfkCYTuTXsfHXVYnFTa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646656994;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zm3yxjprfqx2kWI6P7D1NAE1nSgkou6wmGdk5DAx6yk=;
        b=Qy86irhI75thKAJdItZ/YqXhiexgW58qwbnti4j0BkpZgTC2el53Y/gdd4rnz+cB+EA4sc
        i2yL0/jfA5KwE6Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A5521A3B84;
        Mon,  7 Mar 2022 12:43:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1C49DA7F7; Mon,  7 Mar 2022 13:39:19 +0100 (CET)
Date:   Mon, 7 Mar 2022 13:39:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid full commit due to race when logging dentry
 deletion
Message-ID: <20220307123919.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <78d0dffe5f48910e126886559d0c69194b32eab9.1646416779.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d0dffe5f48910e126886559d0c69194b32eab9.1646416779.git.fdmanana@suse.com>
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

On Fri, Mar 04, 2022 at 06:10:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a rename, when logging that a directory entry was deleted, we may
> race with another task that is logging the directory. Even though the
> directory is locked at the VFS level, its logging can be triggered when
> other task is logging some other inode that had, or still has, a dentry
> in the directory (because its last_unlink_trans matches the current
> transaction).
> 
> The chances are slim, and if the race happens, recording the deletion
> through insert_dir_log_key() can fail with -EEXIST and result in marking
> the log for a full transaction commit, which will make the next fsync
> fallback to a transaction commit. The opposite can also happen, we log the
> key before the other task attempts to insert the same key, in which case
> it fails with -EEXIST and fallsback to a transaction commit or trigger an
> assertion at process_dir_items_leaf() due to the unexpected -EEXIST error.
> 
> So make that code that records a dentry deletion to be inside a critical
> section delimited by the directory's log mutex.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> David, this can be optionally squashed into the following patch:
> 
>    "btrfs: avoid logging all directory changes during renames"

Folded in, thanks.

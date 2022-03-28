Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0084E9B16
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbiC1P2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiC1P1n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 11:27:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA963516
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 08:25:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AED95210EE;
        Mon, 28 Mar 2022 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648481097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2Ajj1s0aWDH/aA0AE+vDEueDdkgDLOL5n02mcJv6Tg=;
        b=z3mYImy1YWlcTEEyDOlkp8jKXCpGjC0DwfqJcW+pY7akBi07KqRW+7bKHJD6h7GjV54ch9
        f0/cnNIid0Krhnmb3xbrCkUCWJKtjTLZZU2QPgJpB4FstgOPuVTYJ/qXEAv4DH8uo+lIfq
        XoUXTNHoQHOHsGSaFPFjGkvmtkky+ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648481097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2Ajj1s0aWDH/aA0AE+vDEueDdkgDLOL5n02mcJv6Tg=;
        b=L+VL7vFAFDmp/xem0glL3HdQQXNqYAWJachdGjsaCFkooXDJcUK3xZVSPd5f2yMHlUOeOe
        uDstY89T6oFB1qBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A422CA3B87;
        Mon, 28 Mar 2022 15:24:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F4ACDA7F3; Mon, 28 Mar 2022 17:21:00 +0200 (CEST)
Date:   Mon, 28 Mar 2022 17:21:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, boris@bur.io
Subject: Re: [PATCH] btrfs: rename BTRFS_FS_OPEN add comment
Message-ID: <20220328152100.GP2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, boris@bur.io
References: <67a23a46711e1e479332622728d035af0b21bc16.1648120624.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a23a46711e1e479332622728d035af0b21bc16.1648120624.git.anand.jain@oracle.com>
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

On Thu, Mar 24, 2022 at 07:29:51PM +0800, Anand Jain wrote:
> The in-memory flag BTRFS_FS_OPEN in fs_info->flags indicate the status of
> the open_ctree() if it has completed for the read-write. The mount -o ro
> or the seed device don't get this flag set because they aren't RW
> mounted.
> 
> The threads like delete_unused_bgs(), reclaim_bgs_work() and
> cleaner_kthread() test this flag and if false they return without executing
> the functionality in it.
> 
> This patch renames BTRFS_FS_OPEN to BTRFS_FS_OPENED_RW to make it more
> intuitive. Also, add a comment.

I thought that that the open bit is set once the filesystem is set up
during the mount phase enough to run threads but yeah it really is only
when it's writable. However, there's a filesystem state bit
BTRFS_FS_STATE_RO, in a different variable, can we unify that somehow?

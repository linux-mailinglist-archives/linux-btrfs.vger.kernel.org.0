Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA3741BC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 00:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjF1WbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjF1WbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 18:31:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3B213D
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 15:31:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1BF91F381;
        Wed, 28 Jun 2023 22:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687991467;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvPneGEJQjy410MGIDkllTVXYfGQbGZqdEfjsk4wYa4=;
        b=W2Jelv4+1WO9NMHwUo+zoPRuMoRW6Ft+uM0VxL/u0xWmCuX4fuQqJ7+phfl5V69Azb9V91
        4MLPUeCL8gYxR9f50EiHP6SSX9TjMM3WVZe7A6WpiQHkpj/YWrzlIDbR8bo9uqE8IX3kjh
        FlLApQvh8E+ESes/DBJwEYhp5nntpi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687991467;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvPneGEJQjy410MGIDkllTVXYfGQbGZqdEfjsk4wYa4=;
        b=nfp0lyMXaeHwhjXLRPSlilV9uPCkSFMAApKqBhorT0R92Pj6XQHRV+IsSN+ztUKaTMNKVz
        3ktSyRNxoY1fkgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8563138E8;
        Wed, 28 Jun 2023 22:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IfTyL6u0nGTRbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 22:31:07 +0000
Date:   Thu, 29 Jun 2023 00:24:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6 v3] btrfs-progs: cleanup and preparatory around
 device scan
Message-ID: <20230628222439.GH16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686484067.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 06:26:51PM +0800, Anand Jain wrote:
> v3: Contains fixes as per review comments; details are in the individual
>     patches.
> 
>     Patches dropped:
>       btrfs-progs: check_mounted_where: pack varibles type by size
>       btrfs-progs: btrfs_scan_one_device: drop local variable ret
>     Patch added:
>       btrfs-progs: drop open_ctree_flags in cmd_inspect_dump_tree
> 
> v2: I have separated preparatory and cleanups from the introduction of new
>     features so that they can be easily modified with a smaller set of patches.
> 
>     Added missing git changelogs. (Looks like sshfs lost my last few changes,
>     now fixed).
> 
> --- original cover page ---
> In an attempt to enable btrfstune to accept multiple devices from the
> command line, this patch includes some cleanup around the related
> preparatory work around the device scan code.
> 
> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 7 serve as
> preparatory changes.
> 
> Anand Jain (6):
>   btrfs-progs: check_mounted_where: declare is_btrfs as bool
>   btrfs-progs: rename struct open_ctree_flags to open_ctree_args
>   btrfs-progs: drop open_ctree_flags in cmd_inspect_dump_tree
>   btrfs-progs: device_list_add: optimize arguments drop devid
>   btrfs-progs: factor out btrfs_scan_argv_devices
>   btrfs-progs: refactor check_where_mounted with noscan argument

Added to devel, thanks.

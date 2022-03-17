Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9F4DCF53
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiCQU1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCQU1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 16:27:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BF156C5C
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 13:25:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA0AB210EE;
        Thu, 17 Mar 2022 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647548748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cr9aF59x/7gUb3yjpsJv8lmrfhgmnL9LSYZuGFdukyY=;
        b=qLbb5WW6NN7/6ZdXOgyc+i301UHrkFTFHQQLbjVT95EwMicQ874j21So+a+qqd7UTubnea
        tjkRas6mjhMAOduajcfL4ecgD4aWDH7zQBc0oPJOVa0Qx4VLgiOG/pRuDG+HoPhhhamZA3
        8rq2G9wLfcKtt3dkU9h6uB/+PtMz304=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647548748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cr9aF59x/7gUb3yjpsJv8lmrfhgmnL9LSYZuGFdukyY=;
        b=TUyEPVuNEk76L/gvdFUL7Pix2yOcXg1Gvuh73V6vzIwGuva+FJidrNy7nd5/jwMWOWiw23
        sRY46cN7sUkkE9DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BDADFA3B81;
        Thu, 17 Mar 2022 20:25:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D08BCDA7E1; Thu, 17 Mar 2022 21:21:48 +0100 (CET)
Date:   Thu, 17 Mar 2022 21:21:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/4] btrfs: inode creation cleanups and fixes
Message-ID: <20220317202148.GE12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1647306546.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647306546.git.osandov@fb.com>
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

On Mon, Mar 14, 2022 at 06:12:31PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series contains minor updates of the final four patches of my
> previous series [1].
> 
> Based on misc-next with the previous version of "btrfs: allocate inode
> outside of btrfs_new_inode()" removed.
> 
> Changes since v3 [2]:
> 
> - Fixed a struct btrfs_root leak [3] in patch 1 which was fixed later in
>   the same series by patch 3 for the sake of git bisect.
> 
> Changes since v2:
> 
> - Mentioned reason for removal of btrfs_lookup_dentry() call in
>   create_subvol() in commit message of patch 1.
> - Made btrfs_init_inode_security() also take btrfs_new_inode_args in
>   patch 2.
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1646875648.git.osandov@fb.com/
> 2: https://lore.kernel.org/linux-btrfs/cover.1647288019.git.osandov@fb.com/
> 3: https://lore.kernel.org/linux-btrfs/CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com/
> 
> Omar Sandoval (4):
>   btrfs: allocate inode outside of btrfs_new_inode()
>   btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
>   btrfs: reserve correct number of items for inode creation
>   btrfs: move common inode creation code into btrfs_create_new_inode()

Added to misc-next, thanks.

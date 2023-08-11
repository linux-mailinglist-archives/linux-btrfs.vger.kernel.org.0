Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E084C77939C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjHKP65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjHKP6z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AF30DB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C87021888;
        Fri, 11 Aug 2023 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691769532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMU1kovYrhXZz4aMkc4pCwmEilXXz0tDmWy+xj0UsM0=;
        b=zZHedBCLck+QUyBPOEINisGfuDFVQO/LUBuZUl5V7Fq79cXBQjOE/7/L0Qq122P8srWnW0
        rBEMdIJSpjtV++Q09ZNkPdVv+9eRnaLi6zCxrqMoacIm7fBxiO4GVSTslM4VWaKY0Ee/5j
        i9nW6P9cGHq0yvpztiZjGv9jTrsw4zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691769532;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMU1kovYrhXZz4aMkc4pCwmEilXXz0tDmWy+xj0UsM0=;
        b=W0A/7GjiqmmjnB25M3grMjcIo2ZGzwUT9pr8SCHL+PcTZvHl9Cce3Od8uol0tzmXv5Vh6m
        4S0Ipyu1ZXPCDnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAC1C13592;
        Fri, 11 Aug 2023 15:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Tal1OLta1mT3PgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:58:51 +0000
Date:   Fri, 11 Aug 2023 17:52:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix replace/scrub failure with metadata_uuid
Message-ID: <20230811155226.GV2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <50a6bd0ecd4e9e2b900de07c8ea47b71959df8ca.1690526680.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a6bd0ecd4e9e2b900de07c8ea47b71959df8ca.1690526680.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 28, 2023 at 02:48:13PM +0800, Anand Jain wrote:
> Fstests with POST_MKFS_CMD="btrfstune -m" (as in the mailing list)
> reported a few of the test cases failing.
> 
> The failure scenario can be summaried and simplified as follows:
> 
>   $ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb1 /dev/sdb2 :0
>   $ btrfstune -m /dev/sdb1 :0
>   $ wipefs -a /dev/sdb1 :0
>   $ mount -o degraded /dev/sdb2 /btrfs :0
>   $ btrfs replace start -B -f -r 1 /dev/sdb1 /btrfs :1
>     STDERR:
>     ERROR: ioctl(DEV_REPLACE_START) failed on "/btrfs": Input/output error
> 
>   [11290.583502] BTRFS warning (device sdb2): tree block 22036480 mirror 2 has bad fsid, has 99835c32-49f0-4668-9e66-dc277a96b4a6 want da40350c-33ac-4872-92a8-4948ed8c04d0
>   [11290.586580] BTRFS error (device sdb2): unable to fix up (regular) error at logical 22020096 on dev /dev/sdb8 physical 1048576
> 
> As above, the replace is failing because we are verifying the header with
> fs_devices::fsid instead of fs_devices::metadata_uuid, despite the
> metadata_uuid actually being present.
> 
> To fix this, use fs_devices::metadata_uuid;
> 
> (We copy fsid into fs_devices::metadata_uuid if there is no
> metadata_uuid, so its fine).
> 
> Fixes: a3ddbaebc7c9 ("btrfs: scrub: introduce a helper to verify one metadata block")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.

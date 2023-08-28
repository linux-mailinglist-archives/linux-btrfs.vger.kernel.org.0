Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2978B485
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjH1PeV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjH1PeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 11:34:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46FE1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:34:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88EDB21AB0;
        Mon, 28 Aug 2023 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693236844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/IvL9KSu87BJQSIEcoh9QwZj0Sw9IFROwVED4UXsto=;
        b=Wlvi8AW5ZXyv3deW4MJ/T3eAJzKz49+j1J+82m6n4ApNfNTymQtAiUd1TU+JiPNqUmoiLx
        isd4OnQt8iPGPQYQ4bBpjSU7p8VEGiNHRsGAmdVflW02QdgI5j8G2kuI36NuSGCy/J+nTZ
        zVotgUEx5efgi8SsxL5IgIXolWRGZGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693236844;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/IvL9KSu87BJQSIEcoh9QwZj0Sw9IFROwVED4UXsto=;
        b=pUMHjxEIDEF3nzDk8DSGRckF5UpblMtwA741vCMIzqO2zkldvW8m6G4xmQQTxRZvB4oGsU
        0EI6ZjsZuy/cjFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D10813A11;
        Mon, 28 Aug 2023 15:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDXSGWy+7GTNBwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 15:34:04 +0000
Date:   Mon, 28 Aug 2023 17:27:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 2/5] btrfs-progs: tune use the latest bdev in fs_devices
 for super_copy
Message-ID: <20230828152729.GB14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692963810.git.anand.jain@oracle.com>
 <c76f142e562f0c337cbd657b07fd9105e5ff34c4.1692963810.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76f142e562f0c337cbd657b07fd9105e5ff34c4.1692963810.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 10:47:48PM +0800, Anand Jain wrote:
> btrfstune relies on the superblock of the device specified in the
> btrfstune argument for fs_info::super_copy. Instead, should use
> fs_devices::latest_bdev.

This lacks explanatni why it should use it, it's not obvious.

> To support for reuniting devices following past failures of
> btrfstune -m|M|u|U as in the following patch, use
> fs_devices::latest_bdev.
> 
>  btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>  btrfs-progs: recover from the failed btrfstune -m|M
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

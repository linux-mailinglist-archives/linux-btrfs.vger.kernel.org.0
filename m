Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57956BF28
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 20:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbiGHQ5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiGHQ5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 12:57:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B82EA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 09:56:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92DDC21EA0;
        Fri,  8 Jul 2022 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657299418;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Yta/RPjeBRZrblUXV9Iyj3UMIlt5xFsmBNnBefYBtE=;
        b=I2WZbtmeAESBcwNF5JZw6E78QiRKE1Nm0cizr5ER9gHU/z+oaXUbbAgVB/jwXZ02Wy75oS
        jaGeu64X6QMJjTjP4YyuItmxDuCd6x+g7RnBIpXy+6IWHy7pw8BekIRqkPxmMaA0ULB5R4
        05o1Lp9wofShCAFqQX8kpcpC8B+bQZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657299418;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Yta/RPjeBRZrblUXV9Iyj3UMIlt5xFsmBNnBefYBtE=;
        b=xwUcDa64cBx9nmHuQnW5D3pYjbfXJmiKFisjhD/oKqhVyp+FaaIXNWIPlt9feEhioXShnV
        BKUH7TGDTbyeezAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7893B13A80;
        Fri,  8 Jul 2022 16:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vbpvHNphyGKvFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Jul 2022 16:56:58 +0000
Date:   Fri, 8 Jul 2022 18:52:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: drop optimization of zone finish
Message-ID: <20220708165211.GW15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <c5e53de667c5ec4ff49aa1719da1be7e1f80734e.1656467635.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e53de667c5ec4ff49aa1719da1be7e1f80734e.1656467635.git.naohiro.aota@wdc.com>
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

On Wed, Jun 29, 2022 at 11:00:38AM +0900, Naohiro Aota wrote:
> We have an optimization in do_zone_finish() to send REQ_OP_ZONE_FINISH only
> when necessary, i.e., we don't send REQ_OP_ZONE_FINISH when we assume we
> wrote fully into the zone.
> 
> The assumption is determined by "alloc_offset == capacity". This condition
> won't work if the last ordered extent is canceled due to some errors. In
> that case, we consider the zone is deactivated without sending the finish
> command while it's still active.
> 
> This inconstancy results in activating another block group while we cannot
> really activate the underlying zone, which causes the active zone exceeds
> errors like below.
> 
>     BTRFS error (device nvme3n2): allocation failed flags 1, wanted 520192 tree-log 0, relocation: 0
>     nvme3n2: I/O Cmd(0x7d) @ LBA 160432128, 127 blocks, I/O Error (sct 0x1 / sc 0xbd) MORE DNR
>     active zones exceeded error, dev nvme3n2, sector 0 op 0xd:(ZONE_APPEND) flags 0x4800 phys_seg 1 prio class 0
>     nvme3n2: I/O Cmd(0x7d) @ LBA 160432128, 127 blocks, I/O Error (sct 0x1 / sc 0xbd) MORE DNR
>     active zones exceeded error, dev nvme3n2, sector 0 op 0xd:(ZONE_APPEND) flags 0x4800 phys_seg 1 prio class 0
> 
> Fix the issue by removing the optimization for now.
> 
> CC: stable@vger.kernel.org # 5.18.x: d70cbdda75da btrfs: zoned: consolidate zone finish functions

The commit d70cbdda75da is not in 5.18 stable and first appeared in
5.19-rc1, so this fix is technically a regression fix.

I think there are several other prep and cleanup patches in zoned code
that would make backporting hard.

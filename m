Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F01570C0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiGKUf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiGKUfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 16:35:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4D67588;
        Mon, 11 Jul 2022 13:34:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE4A422A51;
        Mon, 11 Jul 2022 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657571687;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGdKdLDRjm3U/EUfW6RYld4V3sBvGPXY3Py344NQDx8=;
        b=cAB41CLGP+SgRPVX8ehsovlLpQhGioC5GXFAd9pKgXM2vVH4/x6VCgA2hqjMfd719dAImi
        t/IvK4O2l41RacpN2TcoQf64LzcszrYBGd6lx7gZNTGTp1aIAvoRobjKWpJuufT1WLnDRE
        +9omPAu7LUaYG9Yq5IbuPFfe0nsFiL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657571687;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGdKdLDRjm3U/EUfW6RYld4V3sBvGPXY3Py344NQDx8=;
        b=zI7sTIf7VGUKAtD22gj/4j5BP1UD34HJ3wk52CE7SVSz4BJ3YznGqoTa8jowuRy1T+yo3T
        +5hlo5XQwnF12bCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC2A13322;
        Mon, 11 Jul 2022 20:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i7foJWeJzGKPTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Jul 2022 20:34:47 +0000
Date:   Mon, 11 Jul 2022 22:29:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/13] btrfs: zoned: fix active zone tracking issues
Message-ID: <20220711202958.GB15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
References: <cover.1657321126.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
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

On Sat, Jul 09, 2022 at 08:18:37AM +0900, Naohiro Aota wrote:
> This series addresses mainly two issues on zoned btrfs' active zone
> tracking and one issue which is a dependency of the main issue.
> 
> * ChangeLog
> - v2
>   - Support sanity tests (Johannes)
>     - fs_info can be NULL while it is running sanity tests. Consider that
>       case in CONFIG_FS_BTRFS_RUN_SANITY_TESTS.
>   - Propagete an error of btrfs_zone_finish() (Johannes)
>   - Add a comment to max_segments limitation (Christoph)
>   - Rename btrfs_finish_one_bg() to btrfs_zone_finish_one_bg() to make the
>     it clear it is related to zoned code.
>   - Do not reduce active_total_bytes when finishing a block group.
>     - While it's no longer active, but it still can have "used" bytes. So,
>       it should be counted to host "total_bytes". Or, it breaks free space
>       calculation.
>   - Do not try to activate a fully allocated block group.

The self tests are now working and I haven't seen any new errors in
fstests, so I'll add the branch to misc-next soon. This will be probably
the last big patchset before code freeze.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF06B2C56
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCIRtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 12:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCIRto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 12:49:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A13F601F
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 09:49:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25EC621C0C;
        Thu,  9 Mar 2023 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678384181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNBB54inVIy0lX4TsNYXWImapxg/tI9DiO4CrYf/adQ=;
        b=Ch4bpJY/Gz5i98SexV31JK50VEEdx+0zlIEhHlnwoXqNT7P6hGwzQN50sdoGD1kcAgiBo+
        7a4ZVgl3GGQyjVquJgDmfgnP0dIAOehAV3OQfVu81Pb7WfCqiWGBDrfe/S3gU2i87l/Cyq
        KujJIs1Y8RptxQjPM9z4jEeyzCgU5TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678384181;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNBB54inVIy0lX4TsNYXWImapxg/tI9DiO4CrYf/adQ=;
        b=VNsZb2nFJS88fyBtbV876OD/PjZ3Mnl3s9xKZmhKNAww3Hmi++BNz26LbzvoZtDTrrjbek
        32urwBoPp0Zyl2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD9D013A10;
        Thu,  9 Mar 2023 17:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6PMCNTQcCmQdJgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 17:49:40 +0000
Date:   Thu, 9 Mar 2023 18:43:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] btrfs: fix compilation error on sparc/parisc
Message-ID: <20230309174337.GJ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 08, 2023 at 10:58:36AM -0500, Sweet Tea Dorminy wrote:
> Commit 1ec49744ba83 ("btrfs: turn on -Wmaybe-uninitialized") exposed
> that on sparc and parisc, gcc is unaware that fscrypt_setup_filename()
> only returns negative error values or 0. This ultimately results in a
> maybe-uninitialized warning in btrfs_lookup_dentry().
> 
> Change to only return negative error values or 0 from
> fscrypt_setup_filename() at the relevant callsite, and assert that no
> positive error codes are returned (which would have wider implications
> involving other users).
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net/
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Added to misc-next, thanks.

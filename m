Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E435A80C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 16:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiHaO6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiHaO6S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 10:58:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B484620D
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 07:58:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A340F22102;
        Wed, 31 Aug 2022 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661957883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHd27FWcy5IZLGWqugu8rKrUj/KGPFkuR6N2kD/qPHM=;
        b=Vmeo44ndCfh9KpLYsM94m0K8v367CjON3px/M36SApU5YsSNMEltBkeh1GR9RPp8pY660x
        2iLCIqulQxBsHR8/z5CVefdlo2dn4I8M82rb+Mpek0NuDpkHW7sR9V9QLXO/TEktbqsmui
        ss7lpVcRA1eMsK/ro8Xv21vw55xu4IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661957883;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHd27FWcy5IZLGWqugu8rKrUj/KGPFkuR6N2kD/qPHM=;
        b=GzNx8mmKP5napaVw76YbpRUQ98impI6tvuA37N8x5rVmVRj7Y0nOJOt0jAldolYSA2eLhc
        KDRlGazYEjPKXeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8289713B26;
        Wed, 31 Aug 2022 14:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cim7Hvt2D2PFYAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 14:58:03 +0000
Date:   Wed, 31 Aug 2022 16:52:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: add check and repair ability for shrunk
 device item
Message-ID: <20220831145244.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1661841983.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661841983.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 30, 2022 at 02:49:41PM +0800, Qu Wenruo wrote:
> There is a bug report that, a btrfs with shrunk underlying device will
> be rejected by kernel, but btrfs-check will report nothing wrong.
> 
> Furthermore for such case, even if there is no dev extent in the shrunk
> range, we have no way to fix it.
> Kernel will refuse to mount, thus no way to shrink the device using
> "btrfs dev resize".
> 
> This patch will:
> 
> - Add check ability to report such mismatch
> 
> - Add rescue ability to reset the total_bytes in dev items
>   This can only be done if there is no dev extent in the shrunk range.
> 
> - Add a test case for above behavior
> 
> Qu Wenruo (3):
>   btrfs-progs: check: verify the underlying block device size is valid
>   btrfs-progs: fsck-tests: add test case for shrunk device
>   btrfs-progs: rescue: allow fix-device-size to shrink device item

Added to devel, thanks.

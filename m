Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D127A4F9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIRQsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjIRQrr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 12:47:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66915448E;
        Mon, 18 Sep 2023 09:46:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A92B41FFFF;
        Mon, 18 Sep 2023 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695055572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fl8rHAwuEP/VrNANo/6+MEv4fn0GXBjoz/4Pb7zykB0=;
        b=uojo8aFrCwhr79RwIWndaFmI+fNIHrQ7/FNWO0pz9Shuvmo2u1QUZ1+gk9R6iHL+OEruv8
        DgVA5NkOR3uPu0h9m2vsQPXsS9c5yReSXNOnfAPOYE/Wptxd23Yg4REyJcozOVsx0WvKUs
        5xmGDtJjtvv+m+TtVaVVTcV6hfEb/7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695055572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fl8rHAwuEP/VrNANo/6+MEv4fn0GXBjoz/4Pb7zykB0=;
        b=0sN+qWKIpWoaDwqCmOQvgvd/P9c4opTXjf6Zhc4vSrV0DzgGcphG95oDx/WPME7jDADNjX
        cjAdW8mpeIOfZjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DB2C1358A;
        Mon, 18 Sep 2023 16:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e4z2HdR+CGX2BAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 16:46:12 +0000
Date:   Mon, 18 Sep 2023 18:39:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/4] btrfs: RAID stripe tree updates
Message-ID: <20230918163936.GJ2747@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 07:14:29AM -0700, Johannes Thumshirn wrote:
> Here is a first batch of updates for the RAID stripe tree patchset in
> for-next which address some of the review comments.

Thanks.

> ---
> Johannes Thumshirn (4):
>       btrfs: fix 64bit division in btrfs_insert_striped_mirrored_raid_extents
>       btrfs: break loop in case set_io_stripe fails
>       btrfs: rename ordered_enmtry in btrfs_io_context

Folded to the patches.

>       btrfs: add tree-checker for RAID-stripe-tree

Added as a new one.

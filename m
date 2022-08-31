Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05555A8089
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHaOqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHaOqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 10:46:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BB3CB5E3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 07:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 256B5220D0;
        Wed, 31 Aug 2022 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661957165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UMtxoh8Ghv7U4sMboSL1f7TELYvIITdVV56vc4rDAs=;
        b=uD0pzjZwqUNLp54Ran+6kUoufycspwYxOqiQPafBcpGQSjuxPUqJ/7UrRJFlADLpbAjjI1
        uNQ2QB6ngR+W7MwnUKYXnkX9F9Wm5SJXH+oLKzlor/Eoi5GIVn4uRDDGPK5KalxNaX5T9+
        xqlrEsbxYR5elyODR3yLu4vC1KZk8hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661957165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UMtxoh8Ghv7U4sMboSL1f7TELYvIITdVV56vc4rDAs=;
        b=f4ql7R4cp6XNOksCr9d5+aDMurcrDJ58UQTyNZ90Dr0udMD9112hMLTCvIFqguN7282Rf2
        wxu53nUJ0YEBqCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E325A13A7C;
        Wed, 31 Aug 2022 14:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFhwNix0D2NcWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 Aug 2022 14:46:04 +0000
Date:   Wed, 31 Aug 2022 16:40:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in
 zone emulation mode
Message-ID: <20220831144046.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
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

On Fri, Aug 26, 2022 at 04:42:15PM +0900, Shin'ichiro Kawasaki wrote:
> The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
> fs_info->max_extent_size") introduced a division by
> fs_info->max_extent_size. This max_extent_size is initialized with max
> zone append limit size of the device btrfs runs on. However, in zone
> emulation mode, the device is not zoned then its zone append limit is
> zero. This resulted in zero value of fs_info->max_extent_size and caused
> zero division error.
> 
> Fix the error by setting non-zero pseudo value to max append zone limit
> in zone emulation mode. Set the pseudo value based on max_segments as
> suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
> max_zone_append_bytes").
> 
> Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info->max_extent_size")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Added to misc-next, thanks.

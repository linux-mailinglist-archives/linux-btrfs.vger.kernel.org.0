Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308FF5AB1D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiIBNl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiIBNlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 09:41:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7AD237E6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 06:18:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6107E5BE4C;
        Fri,  2 Sep 2022 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662123195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcsAfAYfPwyqxHHhVAY3dKVf4T6fRJYkGzfhs8EUWQI=;
        b=EoJzoWot/finkbzlco530bRKReb94d0MEyfOsy9UAyYZehLmV5fjz56TP2mtNz1znexXf9
        07bTRQq7nGLgHQxKeU3Mx9TG1CPhDMbjjpkvBOJYHe+ed4FpA9Yuu3WPMY07I4VsnHF2Hx
        BMLFR2qz8QcUUan5cfjpv6mYIEmv+HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662123195;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcsAfAYfPwyqxHHhVAY3dKVf4T6fRJYkGzfhs8EUWQI=;
        b=DCA8H02yhW64+Acj6qkkw6b0XOWy2ux0nz0awoqhyV4NVxp5jCvJex+VtYnDdeEDl46mWe
        mBF2nvCp3nO5q5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D87E1330E;
        Fri,  2 Sep 2022 12:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0L8RDrv8EWOscQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Sep 2022 12:53:15 +0000
Date:   Fri, 2 Sep 2022 14:47:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix mounting with conventional zones
Message-ID: <20220902124754.GW13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <0fef711e5ed1d9df00a5a749aab9e3cd3fe4c14c.1662042048.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fef711e5ed1d9df00a5a749aab9e3cd3fe4c14c.1662042048.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 07:21:07AM -0700, Johannes Thumshirn wrote:
> Since commit 6a921de58992 ("btrfs: zoned: introduce
> space_info->active_total_bytes"), we're only counting the bytes of a
> block-group on an active zone as usable for metadata writes. But on a SMR
> drive, we don't have active zones and short circuit some of the logic.
> 
> This leads to an error on mount, because we cannot reserve space for
> metadata writes.
> 
> Fix this by also setting the BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE bit in the
> block-group's runtime flag if the zone is a conventional zone.
> 
> Fixes: 6a921de58992 ("btrfs: zoned: introduce space_info->active_total_bytes")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.

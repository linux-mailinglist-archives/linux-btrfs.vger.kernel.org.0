Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAB574E76
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiGNM6s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGNM6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 08:58:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF365B0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 05:58:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3AF7221CE;
        Thu, 14 Jul 2022 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657803457;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqDTb0QZ0Wm+WY7a5H6FGTUCdDZqaZ1ndxyvwbDT5+I=;
        b=Sh05w4oc0kSZ/eniXoaIbJ83J274AaSpTHET3Ey9Qt/LcTDzwqq6OTEiGhbtp2mDl0v1ej
        C1gXZ8pMAGvBoVhJuMPMt6YECKQpu2ZCIGcFTyLQdX5d3ToRIClbNagJ0ubuiaQF9eHgJ2
        NmIBOxynW51mU+z7fdGnZeI+Mj/YJPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657803457;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqDTb0QZ0Wm+WY7a5H6FGTUCdDZqaZ1ndxyvwbDT5+I=;
        b=zgxDR9rF8pKf6UosVpBkZz74J6WrrV9v5PXV7kmLdXKRXPl6cx5xFi4DilIqhAyQCNSV2h
        aYWebqiLtf2fFPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99C9813A61;
        Thu, 14 Jul 2022 12:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7VODJMES0GLyCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 12:57:37 +0000
Date:   Thu, 14 Jul 2022 14:52:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: align max_zone_append_size to the sector size
Message-ID: <20220714125247.GJ15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
References: <20220714091609.2892621-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091609.2892621-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 14, 2022 at 11:16:09AM +0200, Christoph Hellwig wrote:
> max_zone_append_size and thus the maximum extent size needs to be aligned
> to the sector size, else a lot code becomes rather unhappy and various
> alignment asserts trigger.
> 
> Fixes: 385ea2aea011 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Folded to the patch, thanks.

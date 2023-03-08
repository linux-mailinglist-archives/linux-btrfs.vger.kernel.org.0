Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213FA6B1619
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 00:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCHXFA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 18:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCHXEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 18:04:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB3D2913
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 15:03:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62C621F388;
        Wed,  8 Mar 2023 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678316626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTn8dK2iPQDZf3VYsFvDLXfcXdp8xd2EAAGjJPGW7Q0=;
        b=krdTFy7vFMzc4AYN33GiGG9u8sNBQgJxLV7YH2zaltHiO2v7fquG8o7xyv48FZ72QkQc4t
        w0PPFja0xY8694VyCKhEcq0bek0tV4navBa+OG3VKgD4cbuUryEhic/fo3jd+F3Lhx732h
        5XQ1soZclysYL3mP0Z0bKrsNQrRi6FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678316626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTn8dK2iPQDZf3VYsFvDLXfcXdp8xd2EAAGjJPGW7Q0=;
        b=tr8QaGIE72RVHPWMwqjuHb+EQrUEqd2s6kac5JV79MDpGNb0EzklcHWj2Yv3Bkl19h4zbC
        wsPNiwfBIIRb9ECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 071971391B;
        Wed,  8 Mar 2023 23:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCvYNVEUCWQmdAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Wed, 08 Mar 2023 23:03:45 +0000
Date:   Wed, 8 Mar 2023 17:03:57 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 20/21] btrfs: Add inode->i_count instead of calling
 ihold()
Message-ID: <20230308230357.nk2nqojk5te5eb7d@kora>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
 <ZAdu+C8AMlcUOBhH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAdu+C8AMlcUOBhH@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  9:06 07/03, Christoph Hellwig wrote:
> On Thu, Mar 02, 2023 at 04:25:05PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > I am not sure of this patch, but put it to avoid the WARN_ON() in
> > ihold().  I am not sure why the i_count would drop below one at this
> > point of time since this is still called within writepages context.
> > 
> > Perhaps, there is a better way to solve this?
> 
> How do you trigger the warning?  Basically i_count could only be
> 0 when doing writeback from inode evication, and just incrementing
> i_count blindly will do the wrong thing there.

Without this patch, performing a writeback with async writeback
(mount option compress) will trigger this warning.

Yes, this patch is incorrect. However we have to hold on to an inode
reference in order to complete the asynchronous writeback.

-- 
Goldwyn

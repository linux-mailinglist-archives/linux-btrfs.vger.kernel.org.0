Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC350E698
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiDYRNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiDYRNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:13:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8DC13CE8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:10:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1E9A210E4;
        Mon, 25 Apr 2022 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650906641;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iECuf/FnLYBjTs5O6fZ8QSzJ8W8zXmkPfhBRv5uvyVY=;
        b=WYlF40k4thVUONPQdgPwRE5aKSSFhvw9XsOi2H2QH1hDPb/u5tVPD4wFJ8ibSZE6NUWlAC
        3I6K8LbDTWKLwFBWSpzksiIPxL5ACWQyX2s7gX3anJIPfltLTZ/F7Cb6y/0UDdStkASIVc
        /4e25WtoA90I9GjTxYCdniiD3Rbg+zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650906641;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iECuf/FnLYBjTs5O6fZ8QSzJ8W8zXmkPfhBRv5uvyVY=;
        b=/PfMbASvyMHXW6gs7NGZlryMQ4L0Y2swwb0EFop5oyWt1cGioLTXV3dsIvXjlbqB5cKhRE
        SXGtuES0aGhWoQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7B7113AED;
        Mon, 25 Apr 2022 17:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yJAUKxHWZmLDaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 17:10:41 +0000
Date:   Mon, 25 Apr 2022 19:06:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fsck: fix false warning on sprouted
 filesystems
Message-ID: <20220425170634.GS18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650180472.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 17, 2022 at 03:30:34PM +0800, Qu Wenruo wrote:
> During my attempt to utilize seed device at mkfs time, I found there
> there is a small bug that btrfs check always reports devices size
> related warning on the sprouted device.
> 
> It turns out we didn't iterate seed devices at all during btrfs check.
> 
> The first patch will fix the problem and enhance the warning output.
> The second one will add a regression test for it.
> 
> Qu Wenruo (2):
>   btrfs-progs: check: fix wrong total bytes check for seed device
>   btrfs-progs: fsck-tests: check warning for seed and sprouted
>     filesystems

With the test fixups added to devel, thanks.

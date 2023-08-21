Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE03782D14
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjHUPRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjHUPRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 11:17:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11ACC
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 08:17:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76AA621B6C;
        Mon, 21 Aug 2023 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692631056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+5MafRvmMxOPYiWbb/65+T2IY07ML502HE2X5NcAyk=;
        b=Az7Gh/lZKdOqdAfx2hjEBGSKsZ0bfu6n1AyVELg+oqLP+lGi9yNWD2aIVRj1K5vIE6Fq6B
        JhhlpNO0zpgi/K3V+v8Nm/P7lxtZ8A4fNDf+QVwupqCdAH6SIkhe2S5PuizN567Ed/+jZA
        /o3FhcPdFgj26I/lyxsD9MW5PSqbjXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692631056;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+5MafRvmMxOPYiWbb/65+T2IY07ML502HE2X5NcAyk=;
        b=x0YOP3m/HFCgWsPqa9wPeWbQw0SIG0+VlcV/8/V+oBx7VFq/WlJrqOKZ9lxaglqtAO/sJx
        q9spXYlePHt8dwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5373313421;
        Mon, 21 Aug 2023 15:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5Eq8ExCA42ROGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Aug 2023 15:17:36 +0000
Date:   Mon, 21 Aug 2023 17:11:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: doc/dev: enhance the error handling guideline
Message-ID: <20230821151105.GC2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <21bde19678039301b4806072e72b499085d0b40d.1691733623.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21bde19678039301b4806072e72b499085d0b40d.1691733623.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 11, 2023 at 02:00:28PM +0800, Qu Wenruo wrote:
> Currently we only have a very brief explanation on the unexpected error
> handling (only ASSERT()/WARN_ON()/BUG_ON()), and no further
> recommendation on the proper usage of them.
> 
> This patch would improve the guideline by:
> 
> - Add btrfs_abort_transaction() usage
>   Which is the recommended way when possible.
> 
> - More detailed explanation on the usage of ASSERT()
>   Which is only a fail-fast option mostly designed for developers, thus
>   is only recommended to rule out some invalid function usage.
> 
> - More detailed explanation on the usage of WARN_ON()
>   Mostly for call sites which need a call trace strongly, and is not
>   applicable for a btrfs_abort_transaction() call.
> 
> - Completely discourage the usage of BUG_ON()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks. Please use the 'btrfs-progs' for progs patches
and for documentation 'btrfs-progs: docs:'. I'm trying to keep the
subjects unified and searchable by category but it's really tedious to
fixup almost all patches.

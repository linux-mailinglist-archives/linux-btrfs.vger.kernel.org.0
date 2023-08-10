Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571B9777F29
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 19:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjHJRcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjHJRcb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 13:32:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031862727
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 10:32:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC7FA210DD;
        Thu, 10 Aug 2023 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691688746;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZjnUIVt4vSkSsyNJah+y0Yhsw2f6PR+8UUwjKxU+Fg=;
        b=xN6nVhT+tWVOts0zaANNYr9JIaCeGbuJJO5cNmxanK0AmVATjuUR+fgxVu/hgziug1Dgkj
        H8Ic58RvN6G7C9yip5EdHG8QXnQWFXRX2WsZhVZqMrFm/SP+dGsQfRbX1Vdh2wP3yLQzBU
        dnCY7w2WpbrFxp05TEscUbu50MY9mFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691688746;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZjnUIVt4vSkSsyNJah+y0Yhsw2f6PR+8UUwjKxU+Fg=;
        b=xb/BuDaOxRcWwleLC3nt8eVpLW827dnly4j3elS5dRnBij5oZiLVAf/Tx/dlQxc5ZMjt2R
        SJeub2+hxFJ7REDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4A88138E2;
        Thu, 10 Aug 2023 17:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DhxfJyof1WSeUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 17:32:26 +0000
Date:   Thu, 10 Aug 2023 19:25:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: output extra debug info if we failed to find
 an inline backref
Message-ID: <20230810172558.GL2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a27590a76d9682dadd39379c23ab7cbb00062833.1690887719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27590a76d9682dadd39379c23ab7cbb00062833.1690887719.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 07:02:28PM +0800, Qu Wenruo wrote:
> [BUG]
> Syzbot reported several warning triggered inside
> lookup_inline_extent_backref().
> 
> [CAUSE]
> As usual, the reproducer doesn't reliably trigger locally here, but at
> least we know the WARN_ON() is triggered when an inline backref can not
> be found, and it can only be triggered when @insert is true. (aka,
> inserting a new inline backref, which means the backref should already
> exist)
> 
> [ENHANCEMENT]
> After the WARN_ON(), dump all the parameter and the extent tree
> leaf to help debug.
> 
> Link: https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Follow the common error message pattern to put the error messages last
> - Go back to the existing WARN_ON() checks

Added to misc-next, thanks.

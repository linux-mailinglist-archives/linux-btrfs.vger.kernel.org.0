Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69207BBD26
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjJFQqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFQqF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 12:46:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF9109;
        Fri,  6 Oct 2023 09:45:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CED8221866;
        Fri,  6 Oct 2023 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696610739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqDMUwx47nLjOd+5PVCe7OmDbxetBPZSe0ERMtxmiWw=;
        b=VX1FIG7v7QeoQrq3ICOjtJWeeqm2yf11BndHW5OUan5KTAQiR4PxR6mWXITfVznSJjbkEH
        MojhVncOKS96omGJX/sxNbGdXgCk+7paENILy1470en+GIVcwiiU+b1rJGAWqkvKP9crF7
        Jz0t2EmR42tZvljkCZtAXm/WIwjxp+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696610739;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqDMUwx47nLjOd+5PVCe7OmDbxetBPZSe0ERMtxmiWw=;
        b=/ZKfHWVA4UsdFvi7LEgcC4jQ+4O+pgcrr5+lKa/SbWcTz2973sn4i2/kKvUuZ93E5fVjEA
        /uuDwF9kJrE5TUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64D613586;
        Fri,  6 Oct 2023 16:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tsbFJ7M5IGV5JAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 16:45:39 +0000
Date:   Fri, 6 Oct 2023 18:38:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: remove redundant initialization of variable
 dirty
Message-ID: <20231006163856.GN28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230818135525.1206140-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818135525.1206140-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 18, 2023 at 02:55:25PM +0100, Colin Ian King wrote:
> The variable dirty is initialized with a value that is never read, it
> is being re-assigned later on. Remove the redundant initialization.
> Cleans up clang scan build warning:
> 
> fs/btrfs/inode.c:5965:7: warning: Value stored to 'dirty' during its
> initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to misc-next, thanks.

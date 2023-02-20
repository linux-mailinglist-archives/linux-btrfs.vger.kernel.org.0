Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D969D46F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjBTUIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 15:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTUIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 15:08:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5134688;
        Mon, 20 Feb 2023 12:08:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BFC320A6A;
        Mon, 20 Feb 2023 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676923682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anAPKL4v5T2VXAdSnLnzzjjuc/GCIApuPqKTcg7bU5U=;
        b=QAHYdgM2/Htp3aCg3P3m4z6yEo9otxi51kDdaygqchuH6bgTm5azap03S65znkMEwpYgIV
        Ax71oVtYklj7cbGIu5fVpXXQSZrCoY5dSA7cZKHFaDkmXPaNYo8n6Yqk1BbrFjpimEPilb
        rx1HbNgdyw+YtAXhz151sIydHxWwctQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676923682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anAPKL4v5T2VXAdSnLnzzjjuc/GCIApuPqKTcg7bU5U=;
        b=pqp4Udjc3vZXvP/p70AhQw5+M2qIihDkGqeuGuA74qeHWERZ7AQkBuNEE60p+0tg6e5VST
        ceJDW1FNPC9yuoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2757713A38;
        Mon, 20 Feb 2023 20:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qo+wCCLT82OyVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Feb 2023 20:08:02 +0000
Date:   Mon, 20 Feb 2023 21:02:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     void0red <void0red@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: handle btrfs_del_item errors in
 __btrfs_update_delayed_inode
Message-ID: <20230220200206.GE10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230218043649.86-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218043649.86-1-void0red@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 18, 2023 at 12:36:48PM +0800, void0red wrote:
> Even if the slot is already read out, we may still need to re-balance
> the tree, thus it can cause error in that btrfs_del_item() call.
> 
> Link: https://lore.kernel.org/linux-btrfs/9b45f60f-c849-e072-64ef-298937e6a8a3@suse.com/T/#t
> 
> Signed-off-by: void0red <void0red@gmail.com>

Added to misc-next, thanks.

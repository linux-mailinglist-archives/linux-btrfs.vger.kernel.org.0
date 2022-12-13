Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CF64BC4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiLMSqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiLMSqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:46:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502A252BF;
        Tue, 13 Dec 2022 10:46:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 567EF22B96;
        Tue, 13 Dec 2022 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670957165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01sRJ/kU83m5Fgk2BYm0GD32kiR7ygZRdeTmPkKhxDY=;
        b=JJqNtBdEatj/CvWbN841pqmEuahdIAQBIv0ivh05pcL6GGybTDIto2P4TQ1URVRXzMX9d7
        yFB+wceKhjbkmtdvU3HN78pF1dCxdSSSMgmRyCiYBjXVzLROaDcxS7uWOetBUdPF++Bs9M
        VCBPRoy2ZB5yyoqUA5fZjLHpXutYx/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670957165;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01sRJ/kU83m5Fgk2BYm0GD32kiR7ygZRdeTmPkKhxDY=;
        b=QSCe7crFxKQHuE+n9exwrb6ZeHEX+pLyy+6D6lbyN013N05eRRd5BX6ajrqkZv2GgPKvrU
        xRhRffDhVVWm6VBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E64138F9;
        Tue, 13 Dec 2022 18:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iD+FCG3ImGP7ewAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Dec 2022 18:46:05 +0000
Date:   Tue, 13 Dec 2022 19:45:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Chris Mason <chris.mason@oracle.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_defrag_leaves()
Message-ID: <20221213184522.GF5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9a1d857866d4768090d7f89869076b7a5a85116b.1670875295.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1d857866d4768090d7f89869076b7a5a85116b.1670875295.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 09:01:43PM +0100, Christophe JAILLET wrote:
> All error handling paths end to 'out', except this memory allocation
> failure.
> 
> This is spurious. So branch to the error handling path also in this case.
> It will add a call to:
> 	memset(&root->defrag_progress, 0,
> 	       sizeof(root->defrag_progress));
> 
> Fixes: 6702ed490ca0 ("Btrfs: Add run time btree defrag, and an ioctl to force btree defrag")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is completely speculative.
> 
> Review with care !

I think it's correct, using goto for cleanup is for consistency and the
memset is not necessary on error paths but again for consistency with
what other types of errors in the functions lead to. Added to misc-next,
thanks.

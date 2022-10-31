Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0796138B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 15:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiJaOHu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJaOHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 10:07:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70510B44;
        Mon, 31 Oct 2022 07:07:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EAC7A338A9;
        Mon, 31 Oct 2022 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667225266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwrnfNb3Sm3mui32qBg0ljlM/3iexMemRjWpGGGpytw=;
        b=QOm9gz2hretDm0cm7wE53QHLgV6BqPVVeeiMuBy321J50KGBF3sjT2ryCQFN86CrT/u4ui
        nNK7C5KNd6xaXdg6RuJ5W2HbvffefG0Iew640jD3svB5F1zKXb9bceI+9MeSsWyW56xQjE
        FnczWXh3qL+jQmIgfhW8l+jG2HKPjsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667225266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwrnfNb3Sm3mui32qBg0ljlM/3iexMemRjWpGGGpytw=;
        b=8DmmgQRoR01I87hPFd/NnMxahMz7dycpb9TXDU01yxULkPOjvVfTvQrqwi3N71DQt2EaAo
        50bmdXA6L82u/HBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A420413451;
        Mon, 31 Oct 2022 14:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e99yJrLWX2NIcAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 14:07:46 +0000
Date:   Mon, 31 Oct 2022 15:07:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix a memory allocation failure test
Message-ID: <20221031140729.GZ5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <34dff6b621770b1f8078ce6c715b61c5908e1ad1.1667115312.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34dff6b621770b1f8078ce6c715b61c5908e1ad1.1667115312.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 30, 2022 at 08:35:28AM +0100, Christophe JAILLET wrote:
> 'dip' is tested instead of 'dip->csums'.
> Fix it.
> 
> Fixes: 642c5d34da53 ("btrfs: allocate the btrfs_dio_private as part of the iomap dio bio")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Added to misc-next, thanks.

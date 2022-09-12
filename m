Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC805B5A47
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiILMkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILMkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 08:40:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB0CE35
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 05:39:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EBAC33752;
        Mon, 12 Sep 2022 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662986398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdvZX7WOthJdY/axijyIJZXikkLXVBYT9KWX88/ZtPI=;
        b=D6JyPrkm5+oAbJyoiaxmLofq7bKESiQvb3f5wk+J1+iyFni3Oql4xBHN8CzvpEwWbHF17G
        zPjYOFZ9Jbqo1HQpBog0+Iq8PHb1OpW8Zz02rWAlDHPWlGT63jlbZM+aFIgJRDEjWIZS6+
        k/nXW1sQqAEXTaifadI9WCN19l6jtfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662986398;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdvZX7WOthJdY/axijyIJZXikkLXVBYT9KWX88/ZtPI=;
        b=wFgdZaCKfTTgj4GHe4FcvzdafinIeLkDrxiJEmnWxJGoOyU4jcK0mBH5LbwFjQGVwryEKN
        C1jj91Gh9fmpw8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 637D3139C8;
        Mon, 12 Sep 2022 12:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r3U6F54oH2OwGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Sep 2022 12:39:58 +0000
Date:   Mon, 12 Sep 2022 14:34:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH] btrfs-progs: fi resize: fix return value
 check_resize_args()
Message-ID: <20220912123432.GF32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220811152239.2845-1-realwakka@gmail.com>
 <20220912155843.F86F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912155843.F86F.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 03:58:47PM +0800, Wang Yugui wrote:
> Hi,
> 
> > check_resize_args() function checks user argument amount and should
> > returns it's validity. But now the code returns only zero. This patch
> > make it correct to return ret.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  cmds/filesystem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> > index 7cd08fcd..9eff5680 100644
> > --- a/cmds/filesystem.c
> > +++ b/cmds/filesystem.c
> > @@ -1203,7 +1203,7 @@ static int check_resize_args(const char *amount, const char *path) {
> >  
> >  out:
> >  	free(di_args);
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static int cmd_filesystem_resize(const struct cmd_struct *cmd,
> 
> This patch will make 'btrfs filesystem resize' always fail, and then break
> fstests btrfs/177.

I noticed that too when doing the progs release so the patch will be
dropped.

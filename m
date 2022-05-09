Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADC3520586
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 21:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiEIT7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 15:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiEIT7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 15:59:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED9E7306
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 12:55:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9554321BF4;
        Mon,  9 May 2022 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652126118;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1LszVqBGnj9ZfPkMsDtrCk9CmmFK+Bq0s72NYBwfLc=;
        b=Qa5Fw92dmuHfj6Vz9UgI5Mp48qVhe9F793uTy1zEAbxKELNFyoJpGqxZ9IFnPkXokp47IE
        LyWTVgB4rpCZ9QCzifT9j6tlKdjybbcoHZakCCEA8Secj/UQB+bdDy6OWGB77DAIAC8zIE
        hPIulTzjfPY0vY/9CtH/Xtt1JAD3sew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652126118;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1LszVqBGnj9ZfPkMsDtrCk9CmmFK+Bq0s72NYBwfLc=;
        b=2vlNBrFa2rF7cOIgCEf9iqI5l4itBfvLgAo7hpaXj60C8kNJ7YsJeKEXZyhSyY3N6svCHl
        wwaHqMOL6PnNHsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70A92132C0;
        Mon,  9 May 2022 19:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id izhdGqZxeWJ7CQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 May 2022 19:55:18 +0000
Date:   Mon, 9 May 2022 21:51:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Message-ID: <20220509195104.GF18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220504152501.GQ18596@twin.jikos.cz>
 <20220505070825.1218337-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505070825.1218337-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 10:08:25AM +0300, Nikolay Borisov wrote:
> This eliminates 2 labels and makes the code generally more streamlined.
> Also rename the 'out_bargs' label to 'out_unlock' since bargs is going
> to be freed under the 'out' label. This also fixes a memory leak since
> bargs wasn't correctly freed in one of the condition which are now moved
> in btrfs_try_lock_balance.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> 
> V2:
>  * Removed extra call to kfree(bargs) which resulted in a double free

Where does this patch apply to? It's using btrfs_try_lock_balance but that
does not exist in code nor in the patch.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCFA5365A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbiE0QD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354264AbiE0QDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 12:03:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0868119919
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 09:02:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5721621B04;
        Fri, 27 May 2022 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653667355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hiL0QTgoQcDcbXmPOYxZ/DHYuIIMqOiruSfev2vkCs=;
        b=wmSAoiRCOPUY2FmUJ4dW34NHNJbZw0XlkCBc1S6L/qproEMGy4lMZi+nJMnSRD/nGOZiM8
        mS77Q7PhaBvYZ0mf5zB2/EcGaw6uHzhMh4KRNvqEZTQMaMRJS6S1rrsA897wPveiUmQKZK
        NUN6+MNitiTj59bPLGTaA0xeeoZgrFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653667355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hiL0QTgoQcDcbXmPOYxZ/DHYuIIMqOiruSfev2vkCs=;
        b=4jHVui57VBxPgUZxUTrAGbWj4f/bDkCTNXD+NOaOiBnjE3/EnWtTh3edOw4Qh0Bc36ikK0
        EMEUF0j54HR46BDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2214D139C4;
        Fri, 27 May 2022 16:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1PtTBxv2kGLrEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 May 2022 16:02:35 +0000
Date:   Fri, 27 May 2022 17:58:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Message-ID: <20220527155811.GH20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220504152501.GQ18596@twin.jikos.cz>
 <20220505070825.1218337-1-nborisov@suse.com>
 <20220509195104.GF18596@twin.jikos.cz>
 <bf19be5b-ce93-463b-f4f0-f72a75480503@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf19be5b-ce93-463b-f4f0-f72a75480503@suse.com>
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

On Tue, May 10, 2022 at 08:42:37AM +0300, Nikolay Borisov wrote:
> 
> 
> On 9.05.22 г. 22:51 ч., David Sterba wrote:
> > On Thu, May 05, 2022 at 10:08:25AM +0300, Nikolay Borisov wrote:
> >> This eliminates 2 labels and makes the code generally more streamlined.
> >> Also rename the 'out_bargs' label to 'out_unlock' since bargs is going
> >> to be freed under the 'out' label. This also fixes a memory leak since
> >> bargs wasn't correctly freed in one of the condition which are now moved
> >> in btrfs_try_lock_balance.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>
> >> V2:
> >>   * Removed extra call to kfree(bargs) which resulted in a double free
> > 
> > Where does this patch apply to? It's using btrfs_try_lock_balance but that
> > does not exist in code nor in the patch.
> 
> Well this is v2 2/2 so it's part of the same series just an update to 
> the 2nd patch.

Ah sorry, I had moved the thread to archive and then this patch did not
thread in properly. Added to misc-next, thanks.

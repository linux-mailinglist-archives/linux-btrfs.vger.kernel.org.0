Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035051A40F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbiEDPc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352500AbiEDPcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 11:32:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B6B44A24
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 08:29:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B213210E0;
        Wed,  4 May 2022 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651678153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmcD1HVeDlPuiP2JWAPNKYnR67FZtqtFB0wr7iXHqec=;
        b=Rnx0OX3p9BlOFDtYl8nGTg08TV29N2ptyMCSFCC1u4oWK+MJihUuw7aaXKFE0EYOSUxyXX
        EjMFGUvnnBNr3ykFAtLFjjSzWaf79Ty9d1KzxxZu7++JAA7dLPihX+l0gatv4K59bqEzGj
        df1hCD1AjEr4cCGBIqDratJKgEj/2mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651678153;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmcD1HVeDlPuiP2JWAPNKYnR67FZtqtFB0wr7iXHqec=;
        b=+IR++/SgmdIakfwSghcjirGaG4ZiEU6Rm+bgnn3aF1wGKmpx/+qWsYihN3BzDAlFwCmEu0
        O1CGPZVQ8NaavgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40840132C4;
        Wed,  4 May 2022 15:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rL/GDsmbcmLrMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 15:29:13 +0000
Date:   Wed, 4 May 2022 17:25:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        lkp@intel.com, kbuild-all@lists.01.org
Subject: Re: [kbuild] Re: [PATCH 2/2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Message-ID: <20220504152501.GQ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        lkp@intel.com, kbuild-all@lists.01.org
References: <202205041423.NVVJIHSj-lkp@intel.com>
 <82030643-9b19-1422-6fed-dae04abad165@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82030643-9b19-1422-6fed-dae04abad165@suse.com>
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

On Wed, May 04, 2022 at 11:44:51AM +0300, Nikolay Borisov wrote:
> 
> 
> On 4.05.22 г. 9:46 ч., Dan Carpenter wrote:
> > Hi Nikolay,
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/Refactor-btrfs_ioctl_balance/20220503-163837
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  for-next
> > config: i386-randconfig-m021-20220502 (https://download.01.org/0day-ci/archive/20220504/202205041423.NVVJIHSj-lkp@intel.com/config )
> > compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > fs/btrfs/ioctl.c:4493 btrfs_ioctl_balance() error: double free of 'bargs'
> > 
> > vim +/bargs +4493 fs/btrfs/ioctl.c
> 
> 
> Yep, a genuine braino, the fix is to remove either of the calls. I 
> personally would go with the one before mnt_drop_write so that we drop 
> the write ASAP but in the end I doubt it makes any practical difference. 
> David care to fold this or shall I resend?

Please resend, thanks.

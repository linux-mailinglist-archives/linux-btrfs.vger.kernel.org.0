Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3399F711A89
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEYXWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYXWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:22:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A5E7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 16:22:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1535821BE4;
        Thu, 25 May 2023 23:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685056920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjkyuRTiVMwieZv07yEpiS3J60BcZ+bljODjGAbFGUY=;
        b=SAcvfjyU1ASnNba9vAKSJDIJcga9SfprzEL51mz6AycgYYEhJiEND9Mdw7d5HdMlausYce
        MAXJ7NVCu+w7Km7eHF3IVmyxCahTXSJhzRtqul4leZUXsHwQIKvYki0UwIaMVRCxcJDvBU
        TbPMnNCLaWi/lzlEvUYQzQ3vIuKB+Rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685056920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjkyuRTiVMwieZv07yEpiS3J60BcZ+bljODjGAbFGUY=;
        b=V5j++DTMvhFwuca5gEmfJEcjMFa2w0QK03KyDMvhcF/tNz4d0UwYA51W//yXjIO9X60JxV
        itP4e47xG/92piCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFEE4134B2;
        Thu, 25 May 2023 23:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vRkwNZftb2TuWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 23:21:59 +0000
Date:   Fri, 26 May 2023 01:15:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Message-ID: <20230525231551.GN30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523084020.336697-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523084020.336697-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 10:40:18AM +0200, Christoph Hellwig wrote:
> btrfs_grab_root returns either the root or NULL, and the callers of
> btrfs_get_global_root expect it to return the same.  But all the more
> recently added roots instead return an ERR_PTR, so fix this.
> 
> Fixes: bcef60f24903 ("Btrfs: quota tree support and startup")
> Fixes: f7a81ea4cc6b ("Btrfs: create UUID tree if required")
> Fixes: 70f6d82ec73c ("Btrfs: add free space tree mount option")
> Fixes: 14033b08a029 ("btrfs: don't save block group root into super block")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

1-3 added to misc-next, thanks. I dropped the Fixes: lines here,
replaced by CC:stable 6.1+.

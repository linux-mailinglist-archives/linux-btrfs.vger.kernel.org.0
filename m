Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A726FDE40
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjEJNLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEJNLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 09:11:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171D3AA6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 06:11:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A721F21A0C;
        Wed, 10 May 2023 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683724274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeVZsrwkHifcteOKzWSyL2Bto+fWc81EY/1kjXXrvCk=;
        b=R2Ui11Qq27BiCwuvU8DdH3zBiqKhTLFWbF28/Zkk5PzBdVzn+myknpcPuwEMPanptwgwMe
        CjPoTVt/fhCZLWr82UCgzvPJkB0ZHmDhgPjo1G730G2EySkh234lsiB0cCru/QWHgrCDnk
        xo6TSbd+gh1I7d+zQIOkjqcG+VDFd0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683724274;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeVZsrwkHifcteOKzWSyL2Bto+fWc81EY/1kjXXrvCk=;
        b=Zd33J9kKlrYHtOBb9JMkEaV/XoOLtnPYtDN1kkcN6U+iCfyeD4RoD9Nw4/or4gpoU9Pmse
        3scS/mggJc4wY/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F5AA13519;
        Wed, 10 May 2023 13:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EuNBHvKXW2TmCAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 13:11:14 +0000
Date:   Wed, 10 May 2023 15:05:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: don't BUG_ON on allocation failure in
 btrfs_csum_one_bio
Message-ID: <20230510130515.GP32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 01:58:13PM +0200, Johannes Thumshirn wrote:
> Since f8a53bb58ec7 ("btrfs: handle checksum generation in the storage
> layer") the failures of btrfs_csum_one_bio() are handled via
> bio_end_io().
> 
> This means, we can return BLK_STS_RESOURCE from btrfs_csum_one_bio() in
> case the allocation of the ordered sums fails.
> 
> This also fixes a syzkaller report, where injecting a failure into the
> kvzalloc() call results in a BUG_ON().
> 
> Reported-by: syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.

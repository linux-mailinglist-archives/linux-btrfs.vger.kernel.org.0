Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2254F9A24
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiDHQMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiDHQMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 12:12:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7A354D31
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 09:10:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E91AA1F862;
        Fri,  8 Apr 2022 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649434202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7V4E/u0HaqDct5L19mq8bSV33An6PLQp4fOi0Ro6iw=;
        b=G5cyQUiFqP4m4L824uRc3NPwkHEz/ZFsWmft7LHxEyWbDbceET9kFYretZ9SClbEoJWizg
        84ZoBa3uG9cDk56Febtxp8sAJmFroZEGFHfOearfhoaEz/Xss7CSyFDcr4ddufmNtUYT4B
        WQLkUICqkJlcfmSp6tKnHGVvCqAaa5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649434202;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7V4E/u0HaqDct5L19mq8bSV33An6PLQp4fOi0Ro6iw=;
        b=EQqeteZlMr7c0Vn3tWHAyMz3wJPjGqdE21q9Zbo0+4PFztCB3GmW8/+9xvEXheo0TjqHyH
        Ui0yhegAYxv4sECg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AB6C4A3B9A;
        Fri,  8 Apr 2022 16:10:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 200F0DA832; Fri,  8 Apr 2022 18:05:59 +0200 (CEST)
Date:   Fri, 8 Apr 2022 18:05:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] btrfs: move common inode creation code into
 btrfs_create_new_inode()
Message-ID: <20220408160559.GT15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel-team@fb.com
References: <cover.1647306546.git.osandov@fb.com>
 <da6cfa1b8e42db5c8954680cac1ca322d463b880.1647306546.git.osandov@fb.com>
 <5029eef8-cdd7-20ef-ec89-34c8b685ed00@dorminy.me>
 <Yk3cejA34sSukoH7@relinquished.localdomain>
 <Yk31ln4fk4BvfzFT@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk31ln4fk4BvfzFT@relinquished.localdomain>
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

On Wed, Apr 06, 2022 at 01:18:30PM -0700, Omar Sandoval wrote:
> > I _think_ this fix is fine, though. The only thing I'm concerned about
> > is if btrfs_init_inode_security() changes the inode, then we won't write
> > out those changes to disk. But I don't see any code paths in
> > btrfs_init_inode_security() that change the inode.
> > 
> > I'd say that if this fixes Naohiro's issue, we should go with it.
> 
> As I just discussed with Sweet Tea offline, property inheritance also
> needs to move after inode creation for the same reason.

Can you please resend the full updated patch, based on the one that's in
misc-next once it's tested? Thanks.

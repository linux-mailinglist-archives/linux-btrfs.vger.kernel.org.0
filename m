Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000084B157C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 19:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiBJSqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 13:46:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiBJSqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 13:46:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E83F47
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 10:46:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21DAF21121;
        Thu, 10 Feb 2022 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644518768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFvcoeF3CUfyb+vke/jJtURj14yUYLwp8ZQ5fplYNi4=;
        b=MyrEZbOjA9dQ+HLN3IaaxoBZeiDv4flH/q3BaI+eV8UbLUfWwEgAKICiob+gMksLNyfCKC
        /d2sYEkEG0BbaQEX90vPUARDj/abTtQ5SgE2YA03xXzRw+IBw7772RlF1p021dXLDNL5zh
        scrrNu8gpBBsoori1PT5D+jgJIKiBfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644518768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFvcoeF3CUfyb+vke/jJtURj14yUYLwp8ZQ5fplYNi4=;
        b=hAey3wxBTmEDIT7el2vd4+/MxtGQlTg0X7BUPCNerj04KnrwYHDElF6uZ2PjqMiggnYXhl
        7usjgbfp5vfTQ7DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 18383A3B87;
        Thu, 10 Feb 2022 18:46:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85D02DA9BA; Thu, 10 Feb 2022 19:42:26 +0100 (CET)
Date:   Thu, 10 Feb 2022 19:42:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 09/17] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <20220210184226.GW12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <111c7aadb3fa218b7926a49acf3fb34654d89a75.1637179348.git.osandov@fb.com>
 <20220124222632.GL14046@twin.jikos.cz>
 <YfBq/aXT4D/fm3ae@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBq/aXT4D/fm3ae@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 01:26:21PM -0800, Omar Sandoval wrote:
> On Mon, Jan 24, 2022 at 11:26:32PM +0100, David Sterba wrote:
> > On Wed, Nov 17, 2021 at 12:19:19PM -0800, Omar Sandoval wrote:
> > > +
> > > +	inode_lock_shared(inode);
> > 
> > We have helpers for inode locking now, btrfs_inode_lock, that take
> > additional parameter for cases where we want to exclude certain
> > locking combinations.
> > 
> > Which also brings the question if the encoded read/write should be
> > excluded against some other operations like eg. deduplication has to do
> > against mmap.
> 
> I _think_ we want to exclude mmap, but I need to think some more about
> it. Other than this comment, I believe I've addressed your other
> outstanding comments and rebased my branches:
> 
> https://github.com/osandov/linux/tree/btrfs-send-encoded
> https://github.com/osandov/btrfs-progs/tree/send-encoded
> 
> I'm guessing you're still looking at the send parts, so I'll figure out
> mmap and await further comments before resending.

First I want to get the encoded ioctl, so please send v13.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E92711A83
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjEYXSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjEYXSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:18:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CA12E
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 16:18:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 246D721984;
        Thu, 25 May 2023 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685056711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWnI1h4LWEmdIztxPBTteA30LwMWg4NW7UlZPJxfMlg=;
        b=TGObNzge14tY1XARLNn7DpygnKXcC7JdN4Ed25H5aw1t66JsMFbRO3ELQCRWjDJEW1FuMu
        vWLyshZnls/C02F1ByE+hghkpdBVdTymflctJpf0ObuV3MIifFnZkvh2MLrb9TEtJ+eVKW
        +99nX9/Frw8RXjLKi+JBBoAoHv93FWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685056711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWnI1h4LWEmdIztxPBTteA30LwMWg4NW7UlZPJxfMlg=;
        b=oqyifuS6Gz6QOL8tWDwaWOCLVTrr9zdap11Ymq4DDwyJLpgnTavMt76R11D6tD68ZpdwVr
        PykybX7+7V5k4qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0D9F134B2;
        Thu, 25 May 2023 23:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tS8YNsbsb2ShWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 23:18:30 +0000
Date:   Fri, 26 May 2023 01:12:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anand Jain <anand.jain@oracle.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Message-ID: <20230525231222.GM30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523084020.336697-1-hch@lst.de>
 <4031cd58-dd4c-a0cb-79d4-38c7f03ceaf3@oracle.com>
 <20230523114827.GA29348@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523114827.GA29348@lst.de>
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

On Tue, May 23, 2023 at 01:48:27PM +0200, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 07:37:23PM +0800, Anand Jain wrote:
> > On 23/05/2023 16:40, Christoph Hellwig wrote:
> >> btrfs_grab_root returns either the root or NULL, and the callers of
> >> btrfs_get_global_root expect it to return the same.  But all the more
> >> recently added roots instead return an ERR_PTR, so fix this.
> >>
> >
> > Fix looks good. However, I'm curious about the Fixes commit
> > you're referring to as the one this fix addresses...
> >
> >> Fixes: bcef60f24903 ("Btrfs: quota tree support and startup")
> >
> > btrfs_read_fs_root_no_name() return value used at that commit.
> 
> Indeed. open_ctree also used to check IS_ERR after the NULL check.
> So while this commit was really odd in that it added the first ERR_PTR
> return to the otherwise NULL as failure btrfs_read_fs_root_no_name,
> that was actually handled.  Looks like the first fixes would be for
> whoever dropped that check, but finding code removals in git-blame
> tends to be a bit hard.  I'll see if I can track down the culprit.
> 
> Otherwise I'm fine with just dropping the extra Fixes tags.

No need to track it down to the specific commits in this case, it could
be tricky and without much use. I'll add a CC:stable for 6.1 which is
relevant, 5.15 might be also relevant but the patch does not apply
cleanly. The global roots are a recent abstraction of direct root
pointers that are not unique in the extent tree v2 design.

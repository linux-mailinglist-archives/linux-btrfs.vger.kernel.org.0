Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B06FC440
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjEIKxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjEIKxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 06:53:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DE3C3A;
        Tue,  9 May 2023 03:53:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1441F8B3;
        Tue,  9 May 2023 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683629583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDPM3qUPBDa2INbOMljJWJ4/Vm6/sLG+TQlD9T6LdcE=;
        b=MU1HdgE+giuWSuwYEqM1HFzE5jNevquwjcECZRD+u2PIs5u5bCYJaHFKmBch3qViI1Oofj
        gXNIAMB1CmVasARLYpsah14YuTg9XtR9buao76ZGXEHEuTXaTxUSgaPyrq86do8/iEBxnD
        PPLAZ9749IMW3g8zwWWUBAPOdIqRrVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683629583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDPM3qUPBDa2INbOMljJWJ4/Vm6/sLG+TQlD9T6LdcE=;
        b=jirQAsl8l2RYRGKqXVMrFAi0yhH36pstqV1o2CS9efwkUNjtunSgbkbDnc7EfxDlNhOWcm
        WhahHaoYvIqG3vCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FE2E13581;
        Tue,  9 May 2023 10:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RoiiBg8mWmSdFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 10:53:03 +0000
Date:   Tue, 9 May 2023 12:47:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        git@vladimir.panteleev.md, Filipe Manana <fdmanana@suse.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix backref walking not returning all inode
 refs
Message-ID: <20230509104704.GA7087@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
 <b04cbeb31e221edea8afa75679e4a55633748af7.1683194376.git.fdmanana@suse.com>
 <20230505100301.GJ6373@twin.jikos.cz>
 <CAL3q7H5mBWMRnOMfHQBJ6icLEn4-saN7nsdFJfnSV_4_SZR5jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5mBWMRnOMfHQBJ6icLEn4-saN7nsdFJfnSV_4_SZR5jA@mail.gmail.com>
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

On Mon, May 08, 2023 at 08:51:06PM +0100, Filipe Manana wrote:
> On Fri, May 5, 2023 at 11:09 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, May 04, 2023 at 11:12:03AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When using the logical to ino ioctl v2, if the flag to ignore offsets of
> > > file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> > > backref walking code ends up not returning references for all file offsets
> > > of an inode that point to the given logical bytenr. This happens since
> > > kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for extent
> > > offset in backref walking functions"), as it mistakenly skipped the search
> > > for file extent items in a leaf that point to the target extent if that
> > > flag is given. Instead it should only skip the filtering done by
> > > check_extent_in_eb() - that is, it should not avoid the calls to that
> > > function (or find_extent_in_eb(), which uses it).
> > >
> > > So fix this by always calling check_extent_in_eb() and find_extent_in_eb()
> > > and have check_extent_in_eb() do the filtering only if the flag to ignore
> > > offsets is set.
> > >
> > > Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in backref walking functions")
> > > Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > > Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> > > Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > > CC: stable@vger.kernel.org # 6.2+
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >
> > > V2: Remove wrong check for a non-zero extent item offset.
> > >     Apply the same logic at find_parent_nodes(), that is, search for file
> > >     extent items on a leaf if the ignore flag is given - the filtering
> > >     will be done later at check_extent_in_eb(). Spotted by Vladimir Panteleev
> > >     in the thread mentioned above.
> >
> > Replaced in misc-next, thanks for the quick fix.
> 
> Can you please remove it in the meanwhile?
> I noticed this isn't quite right and there's still two cases not
> working as they should be.
> I'll send a v3 after finishing some more tests, probably tomorrow if
> everything goes fine.

Ok, removed and pushed.

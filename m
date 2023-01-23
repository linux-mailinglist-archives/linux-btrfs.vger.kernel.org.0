Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50729677CC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAWNlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAWNlo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 08:41:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885EC14B
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 05:41:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0AC711F385;
        Mon, 23 Jan 2023 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674481299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8RV0+kemjr4RDhPay8p8AkdcEbLLf4ZA6KBzaEneUM=;
        b=zrsaAosVE0C7HkODS2d3Z98bSgcjOlPbGKZHWLKlsf1B+3eL6NE2URYZxA4Fytpt7aY76C
        R5cVFJuhzTim+deXyrMejHcTxeb4fPDtBP8JyYLqScC3fe2i9jKqv1dEaGBMBtq3fCx2IZ
        Pyf+ItySkDusDxYdyU3VBPn5NiQD6es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674481299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8RV0+kemjr4RDhPay8p8AkdcEbLLf4ZA6KBzaEneUM=;
        b=I0c4XjF3HUSKoYSgZIfq+ZKpUpb7YHSTLiK9usedgO2tljoiMtRPJttt5unCNnaF9VH3nQ
        Jc2jL648KKM/K4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB5071357F;
        Mon, 23 Jan 2023 13:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 10K6LJKOzmOxFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Jan 2023 13:41:38 +0000
Date:   Mon, 23 Jan 2023 14:35:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: btrfs corruption, extent buffer leak
Message-ID: <20230123133557.GO11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <Y8voyTXdnPDz8xwY@mail.gmail.com>
 <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
 <e08376e2-0722-b8b0-fe72-645a08972fcf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08376e2-0722-b8b0-fe72-645a08972fcf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 23, 2023 at 08:50:38PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/23 18:39, Filipe Manana wrote:
> > On Sat, Jan 21, 2023 at 1:59 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
> >>
> [...]
> >>
> >> Opening filesystem to check...
> >> Checking filesystem on /dev/mapper/root
> >> UUID: ********-****-****-****-************
> >> [1/7] checking root items
> >> [2/7] checking extents
> >> [3/7] checking free space tree
> >> [4/7] checking fs roots
> >> [5/7] checking only csums items (without verifying data)
> >> [6/7] checking root refs
> >> [7/7] checking quota groups
> >> ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
> >> ERROR: loading qgroups from disk: -2
> >> ERROR: failed to check quota groups
> > 
> > This is a different issue, it's the first time I see it, nothing
> > related to the previous one. I'm adding Qu to CC since he knows
> > qgroups much better than I do, and so he may have an idea.
> 
> This looks like that, we have a relation key, but there is no such qgroup.
> 
> Not a big deal, you can disable qgroup, and re-enable qgroup.
> Which would rebuild the whole qgroup tree, although it means you lost 
> the qgroup relationship, and need to re-add them.

We should have an easy way to dump and restore the relation tree and
limits. The 'qgroup show' command can now do the json output so it's a
bit easier to gnerate the list of commands to recreate the relations,
but such tool does not exist yet.

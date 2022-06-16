Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E646B54E5B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376442AbiFPPIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377884AbiFPPIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:08:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5CE3EABE
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:08:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA25B21B3C;
        Thu, 16 Jun 2022 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655392109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjXXtWFmc3z6h7LTd52bXT7NC+Ex6iDz+jyUPTCtm6Q=;
        b=LOjL69YIA+34+rcxAwGGaMQAerByWNgmErDyfa4eVycopMRvEPVI61Jd5THsAMetc0Y18V
        dykachKv4GssMjlEdZBPSQ9Vy7vqERbVEApZfgoZ7ZbxRKHv77l3pt15UUKr+rP/ettOCK
        bffyLX+/oQ06D8/6IpGsy8V2Ug5sYb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655392109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjXXtWFmc3z6h7LTd52bXT7NC+Ex6iDz+jyUPTCtm6Q=;
        b=So5qjdYXyH1n5e0r7gBqU209kihAeu9C7J6WFLQNQJ7U9yP1ZWw6bCgUEcdXcSKg4iaqJL
        t3eMkKBy332bMgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80A941344E;
        Thu, 16 Jun 2022 15:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ylhHm1Hq2LyPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Jun 2022 15:08:29 +0000
Date:   Thu, 16 Jun 2022 17:03:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: warn about dev extents that are inside the
 reserved range
Message-ID: <20220616150355.GC20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
 <YqeKZuET4MDe0D5w@zen>
 <7d764668-cb95-f410-4846-9a1a98e3b861@gmx.com>
 <Yqiprewvw0q6OYza@zen>
 <4ee22ab7-6597-b254-d85d-fc8268fbfcd2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee22ab7-6597-b254-d85d-fc8268fbfcd2@gmx.com>
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

On Wed, Jun 15, 2022 at 06:12:29AM +0800, Qu Wenruo wrote:
> On 2022/6/14 23:30, Boris Burkov wrote:
> > On Tue, Jun 14, 2022 at 03:48:06PM +0800, Qu Wenruo wrote:
> >> On 2022/6/14 03:05, Boris Burkov wrote:
> >>> On Mon, Jun 13, 2022 at 03:06:35PM +0800, Qu Wenruo wrote:
> >>>> Btrfs has reserved the first 1MiB for the primary super block (at 64KiB
> >>>> offset) and legacy programs like older bootloaders.
> >>>>
> >>>> This behavior is only introduced since v4.1 btrfs-progs release,
> >>>> although kernel can ensure we never touch the reserved range of super
> >>>> blocks, it's better to inform the end users, and a balance will resolve
> >>>> the problem.
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>>    fs/btrfs/volumes.c | 10 ++++++++++
> >>>>    1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>> index 051d124679d1..b39f4030d2ba 100644
> >>>> --- a/fs/btrfs/volumes.c
> >>>> +++ b/fs/btrfs/volumes.c
> >>>> @@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
> >>>>    		goto out;
> >>>>    	}
> >>>>
> >>>> +	/*
> >>>> +	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
> >>>> +	 * space. Although kernel can handle it without problem, better to
> >>>> +	 * warn the users.
> >>>> +	 */
> >>>> +	if (physical_offset < BTRFS_DEFAULT_RESERVED)
> >>>> +		btrfs_warn(fs_info,
> >>>> +"devid %llu physical %llu len %llu is inside the reserved space, balance is needed to solve this problem.",
> >>>
> >>> If I saw this warning, I wouldn't know what balance to run, and it's
> >>> not obvious what to search for online either (if it's even documented).
> >>> I think a more explicit instruction like "btrfs balance start XXXX"
> >>> would be helpful.
> >>
> >> Firstly, the balance command needs extra filters, thus the command can
> >> be pretty long, like:
> >>
> >> # btrfs balance start -mdrange=0..1048576 -ddrange=0..1048576
> >> -srange0..1048576 <mnt>
> >>
> >> I'm not sure if this is a good idea to put all these into the already
> >> long message.
> >>
> >>>
> >>> If it's something we're ok with in general, then maybe a URL for a wiki
> >>> page that explains the issue and the workaround would be the most
> >>> useful.
> >>
> >> URL can be helpful but not always. Imagine a poor sysadmin in a noisy
> >> server room, seeing a URL in dmesg, and has to type the full URL into
> >> their phone, if the server has very limited network access.
> >
> > I don't see how the poor sysadmin would be any better off with "you need
> > to do a balance" vs "you need to do a balance: <URL>" or "you need to do
> > a balance using mdrange and ddrange to move the affected extents" etc..
> >
> > My high level point is that you clearly have something in mind that the
> > person needs to do in the unlikely event they hit this, but I have no
> > idea how they are supposed to figure it out. Send a mail to our mailing
> > list and hope you notice it?
> 
> I guess you miss the point here.
> 
> First, this is really rare case, it need older mkfs.btrfs and never
> balanced the fs.
> 
> Second, the warning message itself is fine, kernel is 100% fine handling
> it. The warning message can be ignored as long as there is no usage of
> legacy bootloader.
> 
> >
> >>
> >> In fact, this error message for now will be super rare already.
> >>
> >> The main usage of this message is for the incoming feature, which will
> >> allow btrfs to reserve extra space for its internal usage.
> >>
> >> In that case, we will allow btrfstune to set the reservation (even it's
> >> already used by some dev extent), and btrfstune would give a commandline
> >> how to do the balance.
> 
> In fact, that would be where the detailed balance command line to be shown.
> 
> Btrfs check and btrfstune would output the detailed command line to do that.

I don't think this is a good place either. There's a WIP page
file:///home/ds/x/btrfs-progs/Documentation/_build/html/trouble-index.html

that should be the starting point to explain errors or error messages in
greater detail than what can be fit to one line. There is/was a similar
page on wiki but not was used or lacked details.

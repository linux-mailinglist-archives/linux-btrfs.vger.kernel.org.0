Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFC4B1442
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiBJRbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 12:31:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBJRbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 12:31:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7842647
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 09:31:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 49AB41F391;
        Thu, 10 Feb 2022 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644514293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kwOr7Dau3h1j9tqLxpErarcpb9cmSUf4sWGjubtvhs=;
        b=YwvBPNlUm0HJe3TrFfPVhv4W76RqGJNHrhhPhPywxKkppZXmTLM2T2+ukXCHuMGKnUJC/a
        dWWQ46GTyYh2S4FezS0TmHJQPLREeijli6wnXPKcXpkfydRKExTLbBNXt+p6bA49QjKb5y
        8DkBNZpEy7zgFW3KwtZBBT8FyII/WwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644514293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kwOr7Dau3h1j9tqLxpErarcpb9cmSUf4sWGjubtvhs=;
        b=pxFGcwbkkE1XGjr38FRJJFnyMJ1k48iIJrNowTD9CFgyjqsfem5DK2qNB1JyYj6Brqr9UC
        pWCO1aCQ9jczeLCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 40A04A3B83;
        Thu, 10 Feb 2022 17:31:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E560DA9BA; Thu, 10 Feb 2022 18:27:51 +0100 (CET)
Date:   Thu, 10 Feb 2022 18:27:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs: store details about first setget bounds check
 failure
Message-ID: <20220210172751.GS12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1643904960.git.dsterba@suse.com>
 <79c2eac1b0c7f0a1769bbe9b9ee4ca8b23ef0132.1643904960.git.dsterba@suse.com>
 <Yf0OqgnMCFNmNkbl@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0OqgnMCFNmNkbl@debian9.Home>
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

On Fri, Feb 04, 2022 at 11:31:54AM +0000, Filipe Manana wrote:
> On Thu, Feb 03, 2022 at 06:26:29PM +0100, David Sterba wrote:
> > +
> > +	/* Count events and record more details about the first one */
> > +	fs_info = eb->fs_info;
> > +	atomic_inc(&fs_info->setget_failures);
> > +	if (test_and_set_bit(BTRFS_FS_SETGET_COMPLAINS, &eb->fs_info->flags))
> > +		return;
> > +
> > +	fs_info->setget_eb_start = eb->start;
> > +	fs_info->setget_ptr = ptr;
> > +	fs_info->setget_off = member_offset;
> > +	fs_info->setget_size = size;
> 
> These new fields at fs_info are set here, but then never read, neither in this
> patch nor in the remaining of this patchset.
> 
> Do you plan to use them somewhere else? If not, it seems they could go away.

The original idea was to print them at some later point, eg. at umount
time or when transaction commit is attempted and the error bit is set.
But as the error message is printed for each detected out of bounds it's
probably not necessary to store it. I'll drop it unless I find a better
reason.

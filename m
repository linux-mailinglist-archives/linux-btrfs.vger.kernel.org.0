Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835AD559DA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiFXPtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFXPtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 11:49:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1474AE18
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 08:49:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5474B21A5B;
        Fri, 24 Jun 2022 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656085755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9emSbOo2BbJrk5i6dfyOK7q9UTAJdcelXAG8LisgtY4=;
        b=ZPz7cdpREUJm21cv/NwLjaYdQPsY7qncOcTrKGLsSEuJ/y2BOyO9fglLrI/nAuC56OeZL5
        zt4HL09mo0Jsxdx/gi+1WIx3vREVjDw3jKxRaiAQeAypTA+wRLmbBxYRR86knXNabDRlph
        Xhz6Vvw43+eMbUwyZSOSMyawhz9/P6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656085755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9emSbOo2BbJrk5i6dfyOK7q9UTAJdcelXAG8LisgtY4=;
        b=1BoyoO4DAdHG2EdTBkv/cATfAOOnrZgsHDn074wvewfJZMd7g60rfkAzqh3LVLTp7aJrMK
        4LSRElCpaYfpWVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24B2113480;
        Fri, 24 Jun 2022 15:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZRj0B/vctWIeRgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 24 Jun 2022 15:49:15 +0000
Date:   Fri, 24 Jun 2022 17:44:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Message-ID: <20220624154436.GW20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
 <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
 <20220624134706.GV20633@twin.jikos.cz>
 <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
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

On Fri, Jun 24, 2022 at 10:02:43PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/24 21:47, David Sterba wrote:
> > On Fri, Jun 24, 2022 at 07:46:12PM +0800, Qu Wenruo wrote:
> >> On 2022/6/24 19:32, Nikolay Borisov wrote:
> >>> On 24.06.22 г. 11:13 ч., Qu Wenruo wrote:
> >>>>
> >>>> I don't think that's the correct way to go.
> >>>>
> >>>> In fact, I think sysfs should have everything, no matter how long
> >>>> supported it is.
> >>>
> >>> I disagree, for things which are considered stand alone features - yes.
> >>> Like free space tree 2, but for something like backrefs, heck I think
> >>> we've even removed code which predates mixed backrefs so I'm not
> >>> entirely use the filesystem can function with that feature turned off,
> >>> actually it's not possible to create a non-mixedbackref file system
> >>> since this behavior is hard-coded in btrfs-progs. Also the commit for
> >>> the backrefs states:
> >>>
> >>>
> >>> This commit introduces a new kind of back reference for btrfs metadata.
> >>> Once a filesystem has been mounted with this commit, IT WILL NO LONGER
> >>> BE MOUNTABLE BY OLDER KERNELS.
> >>
> >> That means we're hiding incompat features from the user.
> >>
> >> Even if it's not tunable and should always be enabled, we still need to
> >> add that.
> > 
> > I think the mixed_backref is an exception because it's been part of the
> > default format for so long that we don't even remember there was
> > something else. For users it does not mean anything today, moreover it
> > could be confused with mixed block groups.
> 
> Then after some time, there will be some "smart" users find that we have 
> one incompat bit without any explanation.

Removed functionality is documented, the sysfs feature files are in
manual pages and we can add a notice in which version it was removed.

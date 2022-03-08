Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120784D1F23
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349197AbiCHRbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349180AbiCHRbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 12:31:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33145574F
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 09:30:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 89FE01F388;
        Tue,  8 Mar 2022 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646760646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uh/ELPO4gkwu2+vXo0rSf6UMbIgD+cNHWXmGrxp6pMg=;
        b=QjzKuby5K090gqcKT8moUrJt4QJg1ytzSWjW7dCnavX8aNcbsJTsiN64B/Hges6VbMgibw
        fVI9RZvhmcuQgDl6k2v1Irqn9q/qQCJ3QUMuhz1krlOXiBtT0EnYyb2862OVJM7TbI28DY
        hAcI9/8FtUYkc6ycMuIiZDA29WGzNjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646760646;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uh/ELPO4gkwu2+vXo0rSf6UMbIgD+cNHWXmGrxp6pMg=;
        b=uRCKNEJqNM6B9VfYrEWAukjLcOLTV6HGB+70LFWeS+2kAIoZJOay95OX4xS5gY5BH7Hehg
        UXh7X2HkwxEuaTBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 84239A3B88;
        Tue,  8 Mar 2022 17:30:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D9D8DA7DA; Tue,  8 Mar 2022 18:26:51 +0100 (CET)
Date:   Tue, 8 Mar 2022 18:26:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/7] btrfs-progs: properly populate missing trees
Message-ID: <20220308172651.GQ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645567860.git.josef@toxicpanda.com>
 <0acd92a3b95f21b89e249fdf2f78e914b6b9c1c0.1645567860.git.josef@toxicpanda.com>
 <20220304221829.GB12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304221829.GB12643@twin.jikos.cz>
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

On Fri, Mar 04, 2022 at 11:18:29PM +0100, David Sterba wrote:
> On Tue, Feb 22, 2022 at 05:22:39PM -0500, Josef Bacik wrote:
> > With my global roots prep patches I regressed us on handling the case
> > where we didn't find a root at all.  In this case we need to return an
> > error (prior we returned -ENOENT) or we need to populate a dummy tree if
> > we have OPEN_CTREE_PARTIAL set.  This fixes a segfault of fuzz test 006.
> 
> This unfortunatelly breaks test fsck/001-bad-file-extent-bytenr, seems
> that the image can't be properly restored before the test starts.

Fixed by reordering patches.

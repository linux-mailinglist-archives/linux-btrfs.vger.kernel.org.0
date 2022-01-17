Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40544909C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 14:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiAQNun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 08:50:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiAQNul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 08:50:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A8AB1F399;
        Mon, 17 Jan 2022 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642427440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hSvlvAdwNliN3ZPKsWy7ts+RHWYPp4ftGHanllRz0M=;
        b=IzjstHsm4padus4r6I69abHCuM5kxMag+LldaMxkESBIA4/3kZvDAf/WNs++Ba+Z82vBLu
        +JcodTmduXnXHwkqz0Q7+UhM03kssNeUoNx4aSvoiRSkTvm2dZSwkQpuBAcaV7HZknLxrz
        i+Z8IEbBeY1IQ5nbjQ45zDGD0wQA+q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642427440;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hSvlvAdwNliN3ZPKsWy7ts+RHWYPp4ftGHanllRz0M=;
        b=B6xxmyJLpOdYSpsJjSYTka0RqTZ3+wOavy1NMWtP/s480zikKGJGw1BQUGLfacmyvnE9Lu
        lbpQfuhYSNSEbUBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3236CA3B83;
        Mon, 17 Jan 2022 13:50:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0E1BDDA781; Mon, 17 Jan 2022 14:50:03 +0100 (CET)
Date:   Mon, 17 Jan 2022 14:50:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs-progs: fsck-tests: add test case for
 init-csum-tree
Message-ID: <20220117135003.GH14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220114005123.19426-1-wqu@suse.com>
 <20220114005123.19426-6-wqu@suse.com>
 <20220114164059.GD14046@twin.jikos.cz>
 <550b61f3-2e3e-3c5a-17fa-0be8b63269bf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550b61f3-2e3e-3c5a-17fa-0be8b63269bf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 15, 2022 at 07:40:16AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/1/15 00:40, David Sterba wrote:
> > On Fri, Jan 14, 2022 at 08:51:23AM +0800, Qu Wenruo wrote:
> >> +run_check $SUDO_HELPER "$TOP/btrfs" check --force \
> >> +	--init-csum-tree "$TEST_DEV"
> >> +
> >> +# No error should be found
> >> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> >> +btrfs ins dump-tree "$TEST_DEV" > /tmp/dump
> >
> > Is this some leftover from debugging?
> 
> Oh, sorry.
> 
> Mind to remove it when merging?

No.

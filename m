Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCB486649
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiAFOqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 09:46:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiAFOqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 09:46:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 866301F37F;
        Thu,  6 Jan 2022 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641480401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSgCJjT/+JqgjuUkmWlvDLv09tqgclB9LO+QRS3XF14=;
        b=wEF+1BqJQD7328YWLZXC9HGVh7Rs1Tsl4somCNcF2eczAT1dxNKRSYo68Tj3teh4h9NRxH
        iTbPIOsYvOFQUEQxdSNLY+Qd4tFSZZt8FGypJWm8A2H/YLbte1M1QhQLZV+b0nktQmTV1i
        ncErI2DTgnsjWccA+rr64z7hkmY6HFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641480401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSgCJjT/+JqgjuUkmWlvDLv09tqgclB9LO+QRS3XF14=;
        b=7hBPi5udKkUE5n/qo25vgrk8mj2Se5TSxqZy8tAuMVW6H/c6eaJ0NUCP7+QFaPMlhWpCHK
        pGtkRTnYMV/eVZCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E4E9A3B83;
        Thu,  6 Jan 2022 14:46:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B0EDDA7A9; Thu,  6 Jan 2022 15:46:11 +0100 (CET)
Date:   Thu, 6 Jan 2022 15:46:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     anand.jain@oracle.com
Subject: Re: [PATCH] btrfs-progs: remove redundant fs uuid validation from
 make_btrf
Message-ID: <20220106144610.GA14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, anand.jain@oracle.com
References: <20211216100012.911835-1-nborisov@suse.com>
 <20220104184802.GW28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104184802.GW28560@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 07:48:02PM +0100, David Sterba wrote:
> On Thu, Dec 16, 2021 at 12:00:12PM +0200, Nikolay Borisov wrote:
> > cfg->fs_uuid is either 0 or set to the value of the -U parameter
> > passed to mkfs.btrfs. However the value of the latter is already being
> > validated in the main mkfs function. Just remove the duplicated checks
> > in make_btrfs as they effectively can never be executed.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> Added to devel, thanks.

And removed again, tests don't pass:

 $ make TEST=002-uuid-rewrite test-misc
 FAIL: current UUID mismatch
 test failed for case 002-uuid-rewrite
 make: *** [Makefile:457: test-misc] Error 1

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86C3AB366
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhFQMUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 08:20:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFQMUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 08:20:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 349921FDD7;
        Thu, 17 Jun 2021 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623932322;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0yf1DoNB8JbQufC/elbJIN8rSWeD/yoCNXlvS/1ZeI=;
        b=iTgYgUz/hy2Dwco/RbxKAUM5iMCWW1IZSKVQNZtuVrlUc13JE+AeQw2FLw6zM7Nh3s9c2F
        1qp4DiWy9KgJigeJUOfcp/LzKQInNHsnf0NlAgnfRxlzzIsBtpbJ+piG1hvmcS6r+dlrKX
        tR63OWT18GrYCHo7upxpWGjxI0m97tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623932322;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0yf1DoNB8JbQufC/elbJIN8rSWeD/yoCNXlvS/1ZeI=;
        b=qKqMGfGnKQ67nV9v981A/gALV2h+/7pu5dYE+WRL/3skCtvJnH5pmpM3TK64T3152mihNT
        k6TMN8OhlO5jAVDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2AFFCA3B99;
        Thu, 17 Jun 2021 12:18:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BB562DB22E; Thu, 17 Jun 2021 14:15:52 +0200 (CEST)
Date:   Thu, 17 Jun 2021 14:15:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Combining nodatasum + compression
Message-ID: <20210617121550.GV28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
 <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
 <01020179fab66f82-98bc2232-7461-42ea-8194-ec5d1670d9f6-000000@eu-west-1.amazonses.com>
 <016d413c-a4fe-6259-6bb8-b16cb4aa592a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016d413c-a4fe-6259-6bb8-b16cb4aa592a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 07:15:29PM +0800, Qu Wenruo wrote:
> On 2021/6/11 下午6:55, Martin Raiber wrote:
> > On 11.06.2021 02:18 Qu Wenruo wrote:
> >> On 2021/6/10 下午10:32, Martin Raiber wrote:
> 
> But this still means, all other regular end user can hit a case where
> they set nodatasum for a directory and later corrupt their data.

So this where I'd say give users what they ask for, like the usecase
where the data correctness is done on another layer or solved by
completely different approach like reprovisioning in case of errors.

I would certainly not recommend to turning off nodatasum in general but
if thre's a usecase with known pros and cons then I'm for allowing it
(if feasible on technical grounds).

An example from past is (not)allowing DUP on a single device for data.
The counterargument for that was something like "but it won't help on SD
cards anyway", but we're not choosing hw or usecase for users.

I had a prototype to do "nometasum", it's obviously simple but with lack
of usecase I did not push it for a merge. If there's an interest for a
checksum-free usecase we can do that.

> This will increase the corruption loss, if user just migrate from older
> kernel to newer one.
> 
> Yeah, you can blame the users for doing that, but I'm still not that
> sure if such behavior change is fine.
> 
> Especially when this increase the chance of data loss.
> It may be fine for ceph, but btrfs still have a wider user base to consider.

So the silent change would make a difference, but it's still after a
decision to do nodatasum, that gets on a directory and inherited.
That it actually happens is not what user asked for, so from that point
I think it's the other way around.

> > Furthermore it depends on the use-case if corruption affecting
> > one page, or a whole compressed block is something one can live with.
> 
> That's true, but my point is, at least we shouldn't increase the data
> loss possibility for the end users.
> 
> If in the past, we allowed NODATASUM + compression, then converting to
> current situation, I'm more or less fine, since it reduce the
> possibility of data loss.

I'm going to read the reasoning again.

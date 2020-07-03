Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFC213770
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgGCJQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 05:16:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgGCJQy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 05:16:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E53C2AD78;
        Fri,  3 Jul 2020 09:16:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23CA2DA87C; Fri,  3 Jul 2020 11:16:36 +0200 (CEST)
Date:   Fri, 3 Jul 2020 11:16:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Alberto Bursi <bobafetthotmail@gmail.com>
Cc:     dsterba@suse.cz, Lukas Straub <lukasstraub2@web.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200703091635.GV27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Alberto Bursi <bobafetthotmail@gmail.com>,
        Lukas Straub <lukasstraub2@web.de>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <20200701172218.01c0197d@luklap>
 <20200701153919.GD27795@twin.jikos.cz>
 <17ef97b5-ef27-f56c-7b86-c22f9036d253@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ef97b5-ef27-f56c-7b86-c22f9036d253@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 09:16:55PM +0200, Alberto Bursi wrote:
> On 01/07/20 17:39, David Sterba wrote:
> > On Wed, Jul 01, 2020 at 05:22:18PM +0200, Lukas Straub wrote:
> >>> I'm not married to the rescue=onlyfs name, if we can think of something better
> >>> I'm good.
> >>
> >> Maybe you could go a step further and automatically switch to rescue
> >> mode if something is corrupt. This is easier for the user than having
> >> to remember the mount flags.
> > 
> > We don't want to do the auto-switching in general as it's a non-standard
> > situation.  It's better to get user attention than to silently mount
> > with limited capabilities and then let the user find out that something
> > went wrong, eg. system services randomly failing to start or work.
> 
> Eh. I'm sure stopping boot and dropping to initramfs shell is a great 
> way to get someone's attention.

I'm not saying it's pretty and these rescue tasks are only chosing
lesser evil. As I understand it, users want a single option to do the
magic, aka. fix all problems and continue, but the hard part is how to
implement that. The analysis is a necessary step, and it cannot be
always automated to the point where autor-repair will not cause more
harm than good.

> Afaik in mdadm or hardware raid the main way to notify the administrator 
> of issues is sending an email, or send the error through the server 
> fleet management software.

That's for monitoring tools, I'm not familiar with that topic but seems
that hat it could be done. Let's say there's a problem during mount,
auto-repair tries something, system boots but is not in ideal state.
The status is saved in system log and perhaps in some sysfs file to be
grabbed any time later. And the monitoring tools can read that and react
(send email).

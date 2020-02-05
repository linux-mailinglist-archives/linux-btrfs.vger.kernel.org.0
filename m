Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B11531E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBENdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 08:33:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:46530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBENdI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 08:33:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2CD8AFBB;
        Wed,  5 Feb 2020 13:33:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6DD3DA7E6; Wed,  5 Feb 2020 14:32:52 +0100 (CET)
Date:   Wed, 5 Feb 2020 14:32:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3][v2] Add comments describing how space reservation
 works
Message-ID: <20200205133251.GJ2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200204181856.765916-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204181856.765916-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 04, 2020 at 01:18:53PM -0500, Josef Bacik wrote:
> v1->v2:
> - Fixed spelling mistakes, discovered you can use ':set spell' for files other
>   than git commit messages.
> - Reworked some of the explanations to be more visual to describe the general
>   flow.
> 
> --------------- Original email ------------------
> In talking with Nikolay about the data reservation patches it became clear that
> there's way more about the space reservation system that exists soley in my head
> than I thought.  I've written three big comments on the different sections of
> the space reservation system to hopefully help people understand how the system
> works generally.  Again this is from my point of view, and since I'm the one who
> wrote it I'm not sure where the gaps in peoples understanding is, so if there's
> something that is not clear here now is the time to bring it up.  Hopefully this
> will make reviewing patches I submit to this system less scary for reviewers.
> Thanks,
> 

Thanks, added to misc-next.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A587124DC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLRQeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:34:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:51538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfLRQeu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:34:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2271AB71;
        Wed, 18 Dec 2019 16:34:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DEBA3DA730; Wed, 18 Dec 2019 17:34:46 +0100 (CET)
Date:   Wed, 18 Dec 2019 17:34:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     Paul Richards <paul.richards@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs wiki appears to be down
Message-ID: <20191218163446.GO3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Edmund Urbani <edmund.urbani@liland.com>,
        Paul Richards <paul.richards@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMosweh1AsdGg2CNPiA7uUYS5FMUkTP5c6RcNdrDwu+VkmfV+g@mail.gmail.com>
 <a7c9f543-0e51-e34b-be24-63cc3c38ced1@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c9f543-0e51-e34b-be24-63cc3c38ced1@liland.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 18, 2019 at 05:03:48PM +0100, Edmund Urbani wrote:
> On 12/18/19 3:08 PM, Paul Richards wrote:
> > I'm not sure who to route this to, but the Btrfs wiki pages appear to
> > be down.  Various URLs are returning HTTP 503 for me.  Tested from
> > different machines and connections.
> >
> > https://btrfs.wiki.kernel.org/index.php/Main_Page
> >
> > https://btrfs.wiki.kernel.org/index.php/FAQ
> 
> It's not just the Btrfs wiki. The entire kernel wiki seems to be down.
> 
> (503 Service Unavailable: Back-end server is at capacity)

I have reported it to kernel.org admins. There were some other problems
in the k.org infrastructure in the past week, so this could be related.

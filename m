Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB32D688A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 21:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393750AbgLJUTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 15:19:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:36558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390014AbgLJUTR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 15:19:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03C95AC6A;
        Thu, 10 Dec 2020 20:18:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4336CDA842; Thu, 10 Dec 2020 21:16:55 +0100 (CET)
Date:   Thu, 10 Dec 2020 21:16:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Message-ID: <20201210201655.GG6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20201205184929.22412-1-realwakka@gmail.com>
 <e9fbdfc9-f522-0fde-ac82-91101454365d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9fbdfc9-f522-0fde-ac82-91101454365d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 10:00:50AM +0200, Nikolay Borisov wrote:
> On 5.12.20 г. 20:49 ч., Sidong Yang wrote:
> > Warn if scurb stared on a device that has mq-deadline as io-scheduler
> > and point documentation. mq-deadline doesn't work with ionice value and
> > it results performance loss. This warning helps users figure out the
> > situation. This patch implements the function that gets io-scheduler
> > from sysfs and check when scrub stars with the function.
> 
> NAK, use applications should be oblivious to what scheduler the admin
> has set up. It's the responsibility of the admin to configure their
> system properly, at most there could be a note that scrub is an
> io-intensive process and leave the rest to the admin.

If the admin is user of the machine, eg. on a desktop and starts a
weekly scrub job that renders the machine unusable, then the warning
makes sense. And actually this is the situation that happened and
prompted updates to documentation and also the warning to make it more
visible.

That mq-deadline scheduler lacks ionice support is not nice, we're
trying to minimize the impact at least.

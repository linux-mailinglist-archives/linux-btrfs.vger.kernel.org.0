Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAC2124B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgGBNaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:30:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgGBNaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:30:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76853BBD2;
        Thu,  2 Jul 2020 13:30:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF607DA781; Thu,  2 Jul 2020 15:25:03 +0200 (CEST)
Date:   Thu, 2 Jul 2020 15:25:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: Make get_state_failrec return failrec directly
Message-ID: <20200702132503.GM27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-2-nborisov@suse.com>
 <3114fd28-4c62-8e76-457e-f475f3a8f076@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3114fd28-4c62-8e76-457e-f475f3a8f076@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 09:07:51AM -0400, Josef Bacik wrote:
> On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> > +struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
> > +					    u64 start)
> >   {
> >   	struct rb_node *node;
> >   	struct extent_state *state;
> > -	int ret = 0;
> > +	struct io_failure_record *failrec;
> 
> Seems we can just do
> 
> struct io_failure_record *failrec = ERR_PTR(-ENOENT);
> 
> here and avoid the extra stuff below, as we only ever return -ENOENT on failure. 

I'm not a fan of this pattern, setting the error code just before the
label is IMHO more clear and one does not have to look up the initial
value.

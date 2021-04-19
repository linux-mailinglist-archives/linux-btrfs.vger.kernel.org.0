Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385D364908
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 19:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhDSRbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 13:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:48824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhDSRbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 13:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D092EB30F;
        Mon, 19 Apr 2021 17:31:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62F7EDA732; Mon, 19 Apr 2021 19:28:49 +0200 (CEST)
Date:   Mon, 19 Apr 2021 19:28:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     20210419124541.148269-1-l@damenly.su, linux-btrfs@vger.kernel.org,
        l@damenly.su, Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v2] btrfs-progs: fi resize: fix false 0.00B sized output
Message-ID: <20210419172849.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        20210419124541.148269-1-l@damenly.su, linux-btrfs@vger.kernel.org,
        l@damenly.su, Chris Murphy <lists@colorremedies.com>
References: <20210419130549.148685-1-l@damenly.su>
 <YH25FlnQ4nHg57bm@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH25FlnQ4nHg57bm@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 10:08:50AM -0700, Boris Burkov wrote:
> On Mon, Apr 19, 2021 at 09:05:49PM +0800, Su Yue wrote:
> > @@ -1158,6 +1158,16 @@ static int check_resize_args(const char *amount, const char *path) {
> >  		}
> >  		old_size = di_args[dev_idx].total_bytes;
> >  
> > +		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
> > +		if (mod == 0) {
> > +			new_size = diff;
> > +			diff = max(old_size, new_size) - min(old_size, new_size);
> > +			if (new_size > old_size)
> > +				mod = 1;
> > +			else if (new_size < old_size)
> > +				mod = -1;
> > +		}
> > +
> >  		if (mod < 0) {
> >  			if (diff > old_size) {
> >  				error("current size is %s which is smaller than %s",
> 
> This fix seems correct to me, but it feels a tiny bit over-complicated.
> Personally, I think it would be cleaner to do something like:
> 
> if (mod == 0) {
> 	new_size = diff;
> } else if (mod < 0) {
> 	// >0 check
> 	new_size = old_size - diff
> } else {
> 	// overflow check
> 	new_size = old_size + diff
> }

Right, this looks much better and shares a lot of with the code that
follows the original fix.

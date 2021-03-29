Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953834D6ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhC2SWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:22:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhC2SWk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:22:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A267AFEB;
        Mon, 29 Mar 2021 18:22:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AD7BDA842; Mon, 29 Mar 2021 20:20:31 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:20:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 01/13] btrfs: add sysfs interface for supported
 sectorsize
Message-ID: <20210329182031.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210325071445.90896-2-wqu@suse.com>
 <b1a7aaf1-80ea-afa6-5bc3-a348ee0149a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a7aaf1-80ea-afa6-5bc3-a348ee0149a2@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 25, 2021 at 10:41:43PM +0800, Anand Jain wrote:
> On 25/03/2021 15:14, Qu Wenruo wrote:
> > +static ssize_t supported_sectorsizes_show(struct kobject *kobj,
> > +					  struct kobj_attribute *a,
> > +					  char *buf)
> > +{
> > +	ssize_t ret = 0;
> > +
> > +	/* Only support sectorsize == PAGE_SIZE yet */
> > +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n",
> > +			 PAGE_SIZE);
> > +	return ret;
> > +}
> 
>    ret can be removed completely here.

You mean to do 'return scnprintf(...)' ? For now it's just a single
value returned but with further support there will be a pattern like is
eg. in supported_checksums_show, so it's ok as a preparatory work.

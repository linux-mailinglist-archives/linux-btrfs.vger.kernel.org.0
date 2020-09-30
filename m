Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081727EF2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgI3Q3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 12:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Q3L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 12:29:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86C88B011;
        Wed, 30 Sep 2020 16:29:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED252DA781; Wed, 30 Sep 2020 18:27:50 +0200 (CEST)
Date:   Wed, 30 Sep 2020 18:27:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs-progs: subvolume: Add warning on deleting default
 subvolume
Message-ID: <20200930162750.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20200928150729.2239-1-realwakka@gmail.com>
 <blhogiac.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blhogiac.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 09:33:31AM +0800, Su Yue wrote:
> On Mon 28 Sep 2020 at 23:07, Sidong Yang <realwakka@gmail.com> 
> > +	err = btrfs_util_get_default_subvolume_fd(fd, 
> > &default_subvol_id);
> > +	if (fd < 0) {
> >
> Should it be
> "     if (err) { 
> |
>          error_btrfs_util(err);
>          ...
> "?

> > +		err = btrfs_util_subvolume_id(path, &target_subvol_id);
> > +		if (fd < 0) {
> >
> And here.

Thanks for catching it, I missed it too.

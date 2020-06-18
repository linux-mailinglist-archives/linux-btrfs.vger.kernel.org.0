Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5D1FF1EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgFRMeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgFRMea (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 126EDACA7;
        Thu, 18 Jun 2020 12:34:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD5EFDA728; Thu, 18 Jun 2020 14:34:18 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:34:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Greed Rong <greedrong@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: BTRFS: Transaction aborted (error -24)
Message-ID: <20200618123418.GV27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
 <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
 <20200612171315.GW27795@twin.jikos.cz>
 <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 08:50:28PM +0800, Greed Rong wrote:
> Does that mean about 2^20 subvolumes can be created in one root btrfs?

No, subvolume ids are assigned incrementally, the amount is 2^64 so this
shouldn't be a problem in practice.

> The snapshot delete service was stopped a few weeks ago. I think this
> is the reason why the id pool is exhausted.
> I will try to run it again and see if it works.

The patches to reclaim the anon bdevs faster is small enough to be
pushed to older stable kernels, so you should be able to use it
eventually.

As a workaround, you can still delete the old subvolumes to get the
space back but perhaps at a slower rate and wait until the deleted
subvolumes are cleaned. That there's no way to get the number of used
anon bdevs makes it harder unfortunatelly.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577752EBDD2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbhAFMkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 07:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAFMkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 07:40:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C478ADCD;
        Wed,  6 Jan 2021 12:39:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F295CDA6E9; Wed,  6 Jan 2021 13:37:38 +0100 (CET)
Date:   Wed, 6 Jan 2021 13:37:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Question about btrfs and XOR offloading
Message-ID: <20210106123738.GS6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <20210104144437.GE6430@twin.jikos.cz>
 <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
 <20210105153312.GM6430@twin.jikos.cz>
 <CAKxU2N9XkG72T0pUb2iSeATXB-Sh9j+rBpSogfAVH0Zccui_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N9XkG72T0pUb2iSeATXB-Sh9j+rBpSogfAVH0Zccui_mg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 05, 2021 at 02:40:28PM -0800, Rosen Penev wrote:
> > What's the raw speed of the hw offload? Measured on large data so that
> > the overhead is negligible.
> I have no idea how to benchmark such a thing. I assume it could be
> done indirectly.
> >
> > It might make sense to add the async support in case the speed is
> > comparable or better to the CPU, but also to reduce the CPU load.
> I think the latter is the reason Marvell added hardware support for
> doing parity calculations.

The support seems to be in NAS boxes and besides xor and raid5/6
calculations the engine can also do a memcpy offload. This could gain a
lot of performance and be cheap in terms of code. Full page copies are
wrapped under copy_page so we'd need to insert the offload code. Similar
for the raid5/6 calculations.

The MD-RAID already supports offloading so we have code to stea^Wcopy.
Overall it sounds worth to add the async support to btrfs as it would
help with the metadata updates too, there's a lot of memcpy/memmove.

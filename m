Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F122F69F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhANStl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 13:49:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:40980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbhANStl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 13:49:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7C9AB77D;
        Thu, 14 Jan 2021 18:48:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7150BDA7EE; Thu, 14 Jan 2021 19:47:06 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:47:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stefano Babic <sbabic@denx.de>
Cc:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: btrfs-progs license
Message-ID: <20210114184706.GD6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefano Babic <sbabic@denx.de>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <X8/pUT3B1+uluATv@relinquished.localdomain>
 <20201210112742.GC6430@twin.jikos.cz>
 <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 01:03:04PM +0100, Stefano Babic wrote:
> I read this, thanks.
> 
> I was quite confused about the license for libbtrfsutil due to both
> "COPYING" and "COPYING.LESSER" in the library path. COPYING reports
> GPLv3. But headers in file set LGPLv3, sure, and btrfs.h is GPLv2.
> 
> 
> > I'd like to understand what's the problem with LGPLv3 before we'd
> > consider switching to LGPLv2, which I'd rather not do.
> > 
> 
> Please forgive me ig I am not correct because I am just a developer and
> not a lawyer.
> 
> The question rised already when QT switched from LGPv2 to LGPLv3, and
> after the switch what companies should do to be license compliant. Based
> on information given by qt.io and from lawyers (I find again at least
> this link https://www.youtube.com/watch?v=lSYDWnsfWUk), it is possible
> to link even close source SW to libraries, but to avoid the known
> "tivoization", the manufacturer or user of a library must provide
> instruction to replace the running code. This is an issue for embedded
> devices, specially in case the device is closed with keys by the
> manufacturer to avoid attacks or replacement with malware - for example,
> medical devices. This means that such a keys to be licence compliant
> (anyone please correct me if I am wrong) must be provided, making the
> keys itself without sense. The issue does not happen with LGPv2.1, and
> this is the reason why many manufacturers are strictly checking to not
> have (L)GPLv3 code on their device.

I haven't forgotten about this, but haven't researched that enough to
make the decision. I need to do the 5.10 release and that will be
without change to the license. There are no new changes to libbtrfsutil
so the number of people who'd need to agree with the potential
relicensing remains the same.

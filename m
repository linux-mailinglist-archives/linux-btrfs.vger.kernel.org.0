Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7838D10B6A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 20:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK0TXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 14:23:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:35914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0TXc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 14:23:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A225ABE8;
        Wed, 27 Nov 2019 19:23:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 23F59DA733; Wed, 27 Nov 2019 20:23:29 +0100 (CET)
Date:   Wed, 27 Nov 2019 20:23:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
Message-ID: <20191127192329.GA2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
 <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 06:41:49PM +0800, Qu Wenruo wrote:
> On 2019/11/19 下午6:05, Anand Jain wrote:
> > On 11/7/19 2:27 PM, Qu Wenruo wrote:
> >> [PROBLEM]
> >> Btrfs degraded mount will fallback to SINGLE profile if there are not
> >> enough devices:
> > 
> >  Its better to keep it like this for now until there is a fix for the
> >  write hole. Otherwise hitting the write hole bug in case of degraded
> >  raid1 will be more prevalent.
> 
> Write hole should be a problem for RAID5/6, not the degraded chunk
> feature itself.
> 
> Furthermore, this design will try to avoid allocating chunks using
> missing devices.
> So even for 3 devices RAID5, new chunks will be allocated by using
> existing devices (2 devices RAID5), so no new write hole is introduced.

That this would allow a 2 device raid5 (from expected 3) is similar to
the reduced chunks, but now hidden because we don't have a detailed
report for stripes on devices. And rebalance would be needed to make
sure that's the filesystem is again 3 devices (and 1 device lost
tolerant).

This is different to the 1 device missing for raid1, where scrub can
fix that (expected), but the balance is IMHO not.

I'd suggest to allow allocation from missing devices only from the
profiles with redundancy. For now.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7557433867
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFCSmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 14:42:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:49196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfFCSmp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 14:42:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 929C1AD3E;
        Mon,  3 Jun 2019 18:42:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B8C4DA85E; Mon,  3 Jun 2019 20:43:36 +0200 (CEST)
Date:   Mon, 3 Jun 2019 20:43:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
Message-ID: <20190603184335.GT15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 01:36:11PM -0400, Josef Bacik wrote:
> > For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
> > But at that patch (upstream commit
> > 302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to 25/25.
> > 
> > Any idea for that ENOSPC problem?
> > As it looks really wired for the 2nd full balance to fail even we have
> > enough unallocated space.
> > 
> 
> I've been running this all morning on kdave's misc-next and not had a single
> failure.  I ran it a few times on spinning rust and a few times on my nvme
> drive.  I wouldn't doubt that it's failing for you, but I can't reproduce.  It
> would be helpful to know where the ENOSPC was coming from so I can think of
> where the problem might be.  Thanks,

That's interesting because the test btrfs/156 hasn't succesfully
finished a single run on my VM testing setup since qemu 4.0 implemented
discard on virtio devices several weeks ago. It's 4cpu/2g, file-backed
virtio-scsi devices, files are on a spinning disk.

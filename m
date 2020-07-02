Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9121227C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 13:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGBLoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 07:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgGBLoG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 07:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C249BAE4;
        Thu,  2 Jul 2020 11:44:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB3A2DA781; Thu,  2 Jul 2020 13:43:48 +0200 (CEST)
Date:   Thu, 2 Jul 2020 13:43:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: FIEMAP ioctl gets "wrong" address for the extent
Message-ID: <20200702114348.GJ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 09:11:20AM +0000, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote:
> Hi all,
> 
> I'm collecting file extents for our application from BtrFs filesystem image.
> I've noticed that for some files a get the "wrong" physical offset for
> start of the extent. I verified it using hexdump of the filesystem
> image: when dump the content starting from the address returned from
> FIEMAP ioctl, I see that the content is absolutely different from the
> content of the file itself. Also, the FIEMAP ioctl reports regular
> extent, it is not inline.

There are 3 address spaces:

- device physical offsets
- filesystem physical offsets
- filesystem logical offsets

What you seem to expect is that device physical and filesystem physical
and the same. This is not true in general in btrfs and fiemap will
return only the filesystem offsets. To get to the device offsets you'd
need to do the reverse mapping.

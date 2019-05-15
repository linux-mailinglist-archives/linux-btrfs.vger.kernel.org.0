Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960D01F950
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEOR0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 13:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfEOR0X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 13:26:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 296FDAEBD
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 17:26:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF564DA8E5; Wed, 15 May 2019 19:27:21 +0200 (CEST)
Date:   Wed, 15 May 2019 19:27:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190515172720.GX3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 01:15:30PM +0200, Johannes Thumshirn wrote:
> This patchset add support for adding new checksum types in BTRFS.
> 
> Currently BTRFS only supports CRC32C as data and metadata checksum, which is
> good if you only want to detect errors due to data corruption in hardware.
> 
> But CRC32C isn't able cover other use-cases like de-duplication or
> cryptographically save data integrity guarantees.
> 
> The following properties made SHA-256 interesting for these use-cases:
> - Still considered cryptographically sound
> - Reasonably well understood by the security industry
> - Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
>   format
> - Small enough collision space to make it feasible for data de-duplication
> - Fast enough to calculate and offloadable to crypto hardware via the kernel's
>   crypto_shash framework.
> 
> The patchset also provides mechanisms for plumbing in different hash
> algorithms relatively easy.

Once the code is ready for more checksum algos, we'll pick candidates
and my idea is to select 1 fast (not necessarily strong, but better
than crc32c) and 1 strong (but slow, and sha256 is the candidate at the
moment).

The discussion from 2014 on that topic brought a lot of useful
information, though some algos have could have evolved since.

https://lore.kernel.org/linux-btrfs/1416806586-18050-1-git-send-email-bo.li.liu@oracle.com/

In about 5 years timeframe we can revisit the algos and potentially add
more, so I hope we'll be able to agree to add just 2 in this round.

The minimum selection criteria for a digest algorithm:

- is provided by linux kernel crypto subsystem
- has a license that will allow to use it in bootloader code (grub at
  lest)
- the implementation is available for btrfs-progs either as some small
  library or can be used directly as a .c file

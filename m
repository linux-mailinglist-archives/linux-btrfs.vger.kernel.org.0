Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973A332D03
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfFCJim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 05:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfFCJim (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 05:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CCA3AE56;
        Mon,  3 Jun 2019 09:38:41 +0000 (UTC)
Date:   Mon, 3 Jun 2019 11:38:40 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 00/13] Add support for other checksums
Message-ID: <20190603093840.GC4044@x250>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190527171954.GP15290@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527171954.GP15290@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 27, 2019 at 07:19:54PM +0200, David Sterba wrote:
> 1-5 are reviewed and ok, 6 and 13 should be reworked, 7-12 is ok. I
> can't put the branch to next yet due to the csum formatting "issues" but
> will do once you resend. Should be ok just 6 and 13 as they're
> independent.

I'd still like to hold back 13/13. SHA-256 doesn't seem to be well received by
the community as the "slow" hash and using a plain SHA-256 is not sufficient
for the dm-verity/fs-verity like approach I intend to implement in subsequent
patches.

For the record, the current idea is to use a HMAC(SHA-256) as checksum
algorithm with a key provided at mkfs and mount time.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

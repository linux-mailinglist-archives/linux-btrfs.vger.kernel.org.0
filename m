Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD301B0B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfEMHEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:04:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfEMHEp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:04:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 315D2AE44;
        Mon, 13 May 2019 07:04:44 +0000 (UTC)
Date:   Mon, 13 May 2019 09:04:43 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Chris Mason <clm@fb.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/17] btrfs: use btrfs_crc32c() instead of
 btrfs_name_hash()
Message-ID: <20190513070443.GA12653@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-5-jthumshirn@suse.de>
 <AC9DC8F5-8DE8-4BF1-BC7A-814CC4DA0FED@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC9DC8F5-8DE8-4BF1-BC7A-814CC4DA0FED@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 12:56:54PM +0000, Chris Mason wrote:
> It groups together everyone using crc32c as a directory name hash (or 
> extref hash), so that if we ever want to add different hashes later down 
> the line, it's really clear what needs to change for what purpose.  With 
> everyone calling into btrfs_crc32c directly, you have to spend more time 
> looking through history to figure out how to change it.
> 
> Also, sprinkling (u32)~1 makes the code less readable imho.

Fair enough, thanks for the review.

	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

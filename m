Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB8A5A6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfIBPUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 11:20:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729902AbfIBPUJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 11:20:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA8EFB671;
        Mon,  2 Sep 2019 15:20:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FCCEDA796; Mon,  2 Sep 2019 17:20:28 +0200 (CEST)
Date:   Mon, 2 Sep 2019 17:20:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 11/12] btrfs-progs: move crc32c implementation to
 crypto/
Message-ID: <20190902152028.GX2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190830113234.16615-1-jthumshirn@suse.de>
 <20190830113234.16615-12-jthumshirn@suse.de>
 <f7a30c93-58f0-c6db-9325-ed2933c11be4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7a30c93-58f0-c6db-9325-ed2933c11be4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 02, 2019 at 03:40:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 30.08.19 г. 14:32 ч., Johannes Thumshirn wrote:
> > With the introduction of xxhash64 to btrfs-progs we created a crypto/
> > directory for all the hashes used in btrfs (although no
> > cryptographically secure hash is there yet).
> > 
> > Move the crc32c implementation from kernel-lib/ to crypto/ as well so we
> > have all hashes consolidated.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> Although in the future we might want to collapse everything to a single
> crypto.h/hash.h/whatever.h header and include only that.

I did that in my prototype code, Johannes is peeling off the bits to the
series so we'll get there eventually.

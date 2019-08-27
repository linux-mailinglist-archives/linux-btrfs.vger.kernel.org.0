Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942799F003
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfH0QUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 12:20:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfH0QUg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 12:20:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 406A8AF41
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 16:20:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D1D7DA8D5; Tue, 27 Aug 2019 18:20:58 +0200 (CEST)
Date:   Tue, 27 Aug 2019 18:20:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] btrfs-progs: add xxhash sources
Message-ID: <20190827162058.GT2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-10-jthumshirn@suse.de>
 <31238c84-9a3d-08cf-ee7e-5c8647bbf661@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31238c84-9a3d-08cf-ee7e-5c8647bbf661@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 04:05:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 26.08.19 г. 14:48 ч., Johannes Thumshirn wrote:
> > From: David Sterba <dsterba@suse.com>
> > 
> > git://github.com/Cyan4973/xxHash
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>> ---
> >  crypto/xxhash.c | 1024 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  crypto/xxhash.h |  445 ++++++++++++++++++++++++
> >  2 files changed, 1469 insertions(+)
> 
> 
> Existing crc32c implementation is under kernel-lib/, whereas the xxhash
> will be under crypto. I think we should have some consistency among the
> various hashes we might be implementing in the future. I don't have
> strong preferences either way. I guess crypto/ makes more sense.

The kernel-lib contains 99%-copies of the kernel files and they're
mostly unrelated. The crc32 files could be moved to crypto/ as we'll
have more than that and xxhash there.

The idea with the local versions of hashes is to provide a fallback
implementations of everything we need but the preferred option will be
linking to some existing crypto library like openssl. So we'll need some
glue code etc. This isn't entirely suitable for kerne-lib.

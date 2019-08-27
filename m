Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2081E9EFD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfH0QL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 12:11:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfH0QL6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 12:11:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2671AF06
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 16:11:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3430DDA8D5; Tue, 27 Aug 2019 18:12:21 +0200 (CEST)
Date:   Tue, 27 Aug 2019 18:12:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] btrfs-progs: add xxhash64 as checksum algorithm
Message-ID: <20190827161220.GS2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-11-jthumshirn@suse.de>
 <8fcda19d-bb77-5ad4-da05-723995c3a039@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcda19d-bb77-5ad4-da05-723995c3a039@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 05:16:31PM +0300, Nikolay Borisov wrote:
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -385,6 +385,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
> >  {
> >  	if (strcasecmp(s, "crc32c") == 0) {
> >  		return BTRFS_CSUM_TYPE_CRC32;
> > +	} else if (strcasecmp(s, "xxhash64") == 0 ||
> > +		   strcasecmp(s, "xxhash") == 0) {
> 
> Don't we want to be very explicit about only supporting xxhash64, and
> not aliasing xxhash to mean xxhash64? I.e remove the xxhash comparison
> and consider it invalid.

The aliases are for user convenience, I believe xxhash is widely
understood as xxhash64 so '64' is not strictly necessary. If we
ever introduce the 128bit version of xxhash, then it'll be probably
called XXH3 anyway.

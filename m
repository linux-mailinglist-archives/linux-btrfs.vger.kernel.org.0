Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35FF1B67E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfEMMzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 08:55:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfEMMzB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 08:55:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9690CAD4F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 12:55:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 60B85DA95A; Mon, 13 May 2019 14:55:56 +0200 (CEST)
Date:   Mon, 13 May 2019 14:55:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/17] btrfs: add sha256 as another checksum algorithm
Message-ID: <20190513125556.GB20156@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-18-jthumshirn@suse.de>
 <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 03:30:36PM +0300, Nikolay Borisov wrote:
> >  
> >  #define BTRFS_EMPTY_DIR_SIZE 0
> >  
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 2be8f05be1e6..bdcffa0d6b13 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -390,6 +390,8 @@ static bool btrfs_supported_super_csum(struct btrfs_super_block *sb)
> >  	switch (btrfs_super_csum_type(sb)) {
> >  	case BTRFS_CSUM_TYPE_CRC32:
> >  		return true;
> > +	case BTRFS_CSUM_TYPE_SHA256:
> > +		return true;
> 
> nit: case BTRFS_CSUM_TYPE_CRC32:
>      CASE BTRFS_CSUM_TYPE_SHA256:
>            return true;

I'm not sure if the -Wimplicit-fallthrough accepts that without the
annotation or not.

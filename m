Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3353B33536
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfFCQto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 12:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfFCQto (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 12:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CE5EAF1B;
        Mon,  3 Jun 2019 16:49:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EC09DA85E; Mon,  3 Jun 2019 18:50:35 +0200 (CEST)
Date:   Mon, 3 Jun 2019 18:50:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 11/13] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190603165034.GR15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <20190603145859.7176-12-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603145859.7176-12-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 04:58:57PM +0200, Johannes Thumshirn wrote:
> +		crypto_shash_init(shash);
>  
>  		kaddr = kmap_atomic(page);
> -		csum = btrfs_csum_data(kaddr, csum, PAGE_SIZE);
> -		btrfs_csum_final(csum, (u8 *)&csum);
> +		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> +		crypto_shash_final(shash, (u8 *)&csum);
>  		kunmap_atomic(kaddr);

I've noticed the code below doing the kmap/hash/kunmap places the
mapping just around the update phase so I reordered it in this function
too like:

	crypto_shash_init(shash);
	kaddr = kmap_atomic(page);
	crypto_shash_update(shash, kaddr, PAGE_SIZE);
	kunmap_atomic(kaddr);
	crypto_shash_final(shash, (u8 *)&csum);

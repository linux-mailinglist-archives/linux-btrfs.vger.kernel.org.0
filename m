Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75672FA04
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfE3KNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 06:13:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfE3KNJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 06:13:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50DCAAF05;
        Thu, 30 May 2019 10:13:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35C75DA85E; Thu, 30 May 2019 12:14:02 +0200 (CEST)
Date:   Thu, 30 May 2019 12:14:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Gstir <david@sigma-star.at>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Richard Weinberger <richard@nod.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 11/13] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190530101401.GB15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Gstir <david@sigma-star.at>,
        Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Richard Weinberger <richard@nod.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-12-jthumshirn@suse.de>
 <13AD00D3-9804-4C6A-BF98-CCED1C974EF5@sigma-star.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13AD00D3-9804-4C6A-BF98-CCED1C974EF5@sigma-star.at>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 29, 2019 at 09:32:59PM +0200, David Gstir wrote:
> If you aim for using as many of the hardware drivers as possible,
> it might be better to use the ahash API, since some drivers
> (eg. CAAM on NXP's i.MX) only implement that API and not shash.
> Looking at crypto_ahash_init_tfm(...) in crypto/ahash.c using
> drivers that implement shash through the ahash API should work
> fine though.
> 
> I just found that out myself today [1]. ;)
> 
> - David
> 
> [1] https://lore.kernel.org/linux-crypto/729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at/T/#u

The thread says otherwise. Using SHASH interface for AHASH does not
work. Besides checksumming in btrfs is called from atomic contexts so
the sleeping part of the async API can't work at all (crypto_wait_req
indirectly calls schedule).

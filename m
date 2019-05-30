Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746C12FA3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfE3K1L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 May 2019 06:27:11 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:52594 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE3K1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 06:27:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5FD0C18029EE6;
        Thu, 30 May 2019 12:27:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 11/13] btrfs: directly call into crypto framework for
 checsumming
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <20190530101401.GB15290@suse.cz>
Date:   Thu, 30 May 2019 12:27:06 +0200
Cc:     Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Richard Weinberger <richard@nod.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6E722EA8-EBFB-45DC-8058-048F5133FA64@sigma-star.at>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-12-jthumshirn@suse.de>
 <13AD00D3-9804-4C6A-BF98-CCED1C974EF5@sigma-star.at>
 <20190530101401.GB15290@suse.cz>
To:     David Sterba <dsterba@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> On 30.05.2019, at 12:14, David Sterba <dsterba@suse.cz> wrote:
> 
> On Wed, May 29, 2019 at 09:32:59PM +0200, David Gstir wrote:
>> If you aim for using as many of the hardware drivers as possible,
>> it might be better to use the ahash API, since some drivers
>> (eg. CAAM on NXP's i.MX) only implement that API and not shash.
>> Looking at crypto_ahash_init_tfm(...) in crypto/ahash.c using
>> drivers that implement shash through the ahash API should work
>> fine though.
>> 
>> I just found that out myself today [1]. ;)
>> 
>> - David
>> 
>> [1] https://lore.kernel.org/linux-crypto/729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at/T/#u
> 
> The thread says otherwise. Using SHASH interface for AHASH does not
> work.

Correct, but that's not what I wrote. I suggested that you can use the ahash API
instead of the shash API.

> Besides checksumming in btrfs is called from atomic contexts so
> the sleeping part of the async API can't work at all (crypto_wait_req
> indirectly calls schedule).

Yeah, you're right. I overlooked that. So the ahash API is generally not an option
in this case here.

- David

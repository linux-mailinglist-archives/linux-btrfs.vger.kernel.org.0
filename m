Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E832012C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPIUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbfEPIUu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D77C6AE1F;
        Thu, 16 May 2019 08:20:48 +0000 (UTC)
Date:   Thu, 16 May 2019 10:20:48 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190516082048.GC3922@x250.microfocus.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <SYCPR01MB5086D225BE48AD0AD9BBA4B69E0A0@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <4db81b36-a2ac-f954-abad-f020e42120ca@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4db81b36-a2ac-f954-abad-f020e42120ca@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 11:16:38AM +0300, Nikolay Borisov wrote:
> It is labelled non-cryptographic, and is not meant to avoid intentional
> collisions (same digest for 2 different messages), or to prevent
> producing a message with predefined digest.
> 
> This doesn't disqualify it, however we need to be aware its limitations.
> Perhahps it could be used as a replacement for crc32c but definitely not
> as secure crypto hash.

Agreed, but David's plan was to have 3 hashes and xx seems like a good fit for
the 3rd fast, stronger than crc32c but not cryptographically secure option.

I'll be looking into it for v3.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

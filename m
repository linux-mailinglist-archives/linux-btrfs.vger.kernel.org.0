Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2925F01
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfEVIGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfEVIGN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:06:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65F5CAE13;
        Wed, 22 May 2019 08:06:11 +0000 (UTC)
Date:   Wed, 22 May 2019 10:06:10 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190522080610.GA3776@x250>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-12-jthumshirn@suse.de>
 <20190521142259.GD15290@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521142259.GD15290@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 04:22:59PM +0200, David Sterba wrote:
> This reverts changed done in 9678c54388b6a6b309ff7ee5c8d23fa9eba7c06f,
> using LIBCRC32C adds the module dependency so this is automatically picked
> when building the initrd. CRYPTO_CRC32C needed workarounds to manually
> pick crc32c when btrfs was detected.
> 
> But we'll need some way to add the dependencies for all the other crypto
> modules, that do not have the lib.

Fixed thanks

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

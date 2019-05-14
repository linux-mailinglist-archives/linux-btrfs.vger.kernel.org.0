Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2181C8FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENMq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 08:46:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfENMq3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 08:46:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 784D6AE55;
        Tue, 14 May 2019 12:46:27 +0000 (UTC)
Date:   Tue, 14 May 2019 14:46:26 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Chris Mason <clm@fb.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190514124626.GA14840@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
 <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 01:45:47PM +0000, Chris Mason wrote:
> I'm a little concerned about about btrfs_csum_data() and 
> btrfs_csum_final() below.  We're using two different 
> SHASH_DESC_ON_STACK() and then overwriting internals (shash_desc_ctx()) 
> with the assumption that whatever we're doing is going to be the same as 
> using the same shash_desc struct for both the update and final calls.  I 
> think we should be either using or adding a helper to the crypto api for 
> this.  We're digging too deep into cryptoapi private structs with the 
> current usage.
 
I think I found the solution. Instead of doing memset() + memcpy() +
crypto_shash_update() + crypto_shash_final(), I could call
crypto_shash_digest() which would wrap all of them for me in both the crc32c
and sha256 case.

Let me have a look and throw it in some testing.

> Otherwise, thanks for doing this, it looks great overall.

Thanks :)
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3E32CF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFCJda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 05:33:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfFCJd3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 05:33:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC150AE5A;
        Mon,  3 Jun 2019 09:33:28 +0000 (UTC)
Date:   Mon, 3 Jun 2019 11:33:28 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 06/13] btrfs: format checksums according to type for
 printing
Message-ID: <20190603093327.GB4044@x250>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-7-jthumshirn@suse.de>
 <20190527165719.GN15290@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527165719.GN15290@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 27, 2019 at 06:57:19PM +0200, David Sterba wrote:
> I think the helper is not needed at all, the format "%*phN" can be used
> for crc32c too without the intermediate buffers. For better readability,
> some macros can be added like
> 
> 	"this is wrong csum " CSUM_FORMAT " end of string",
> 	CSUM_FORMAT_VALUE(csum_size, csum_bytes)
> 
> with CSUM_FORMAT "0x%*phN" and
> CSUM_FORMAT_VALUE(size, bytes)	size, bytes
> 
> ie. just for the explict requirement of the variable length required by
> "*".

Good idea, will be updating the patch.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

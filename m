Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B115B377FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfFFPc3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 11:32:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729045AbfFFPc3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 11:32:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84883AE65;
        Thu,  6 Jun 2019 15:32:28 +0000 (UTC)
Date:   Thu, 6 Jun 2019 17:32:28 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Eryu Guan <guaneryu@gmail.com>, Filipe Manana <fdmanana@gmail.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH fstests v2] btrfs: add validation of compression options
 to btrfs/048
Message-ID: <20190606153228.GD4172@x250>
References: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
 <20190606113907.17551-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606113907.17551-1-jthumshirn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 01:39:07PM +0200, Johannes Thumshirn wrote:
[...]

> +echo -e "\nTesting argument validation with options"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo:9'

Please don't take this patch yet, setting lzo with a compression level should
fail but doesn't. I'll be addressing this soon (and update the test
accordingly)

Thanks,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6EE03B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbfJVMP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:15:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388555AbfJVMP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 886E7B29F;
        Tue, 22 Oct 2019 12:15:54 +0000 (UTC)
Message-ID: <885fd62f9fcf91fac6c37ac5d9d9ba2c7079f87b.camel@suse.de>
Subject: Re: [PATCH 1/2] btrfs-progs: utils: Replace
 __attribute__(fallthrough)
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Tue, 22 Oct 2019 09:18:02 -0300
In-Reply-To: <b49378ba-486f-1354-ef9e-fa8151eeffe7@suse.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
         <20191022020228.14117-2-marcos.souza.org@gmail.com>
         <b06b57f8-09da-0f86-2957-4caf1ec13606@suse.com>
         <b49378ba-486f-1354-ef9e-fa8151eeffe7@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2019-10-22 at 10:01 +0300, Nikolay Borisov wrote:
> 
> On 22.10.19 г. 9:59 ч., Nikolay Borisov wrote:
> > 
> > 
> > On 22.10.19 г. 5:02 ч., Marcos Paulo de Souza wrote:
> >> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >>
> >> When compiling with clang, this warning is shown:
> >>
> >> common/utils.c:404:3: warning: declaration does not declare
> anything [-Wmissing-declarations]
> >>                 __attribute__ ((fallthrough));
> >>
> >> This attribute seems to silence the same warning in GCC. Changing
> this
> >> attribute with /* fallthrough */ fixes the warning for both gcc
> and
> >> clang.
> >>
> >> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Which clang version are you using? According to
> > https://clang.llvm.org/docs/AttributeReference.html#fallthrough
> this
> > attribute is supported even with the GNU syntax.
> 
> Looking at the documentation the gnu syntax is supported in the
> 'current' / 10, unreleased version. All others, up to version 9 does
> not
> support this syntax.

I'm using the default clang in Tumbleweed (20191009):
clang --version
clang version 8.0.1 (tags/RELEASE_801/final 366581)

> 
> > 
> >> ---
> >>  common/utils.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/common/utils.c b/common/utils.c
> >> index 2cf15c33..a88336b3 100644
> >> --- a/common/utils.c
> >> +++ b/common/utils.c
> >> @@ -401,15 +401,15 @@ int pretty_size_snprintf(u64 size, char
> *str, size_t str_size, unsigned unit_mod
> >>  	case UNITS_TBYTES:
> >>  		base *= mult;
> >>  		num_divs++;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case UNITS_GBYTES:
> >>  		base *= mult;
> >>  		num_divs++;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case UNITS_MBYTES:
> >>  		base *= mult;
> >>  		num_divs++;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case UNITS_KBYTES:
> >>  		num_divs++;
> >>  		break;
> >> @@ -1135,14 +1135,14 @@ int test_num_disk_vs_raid(u64
> metadata_profile, u64 data_profile,
> >>  	default:
> >>  	case 4:
> >>  		allowed |= BTRFS_BLOCK_GROUP_RAID10;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case 3:
> >>  		allowed |= BTRFS_BLOCK_GROUP_RAID6;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case 2:
> >>  		allowed |= BTRFS_BLOCK_GROUP_RAID0 |
> BTRFS_BLOCK_GROUP_RAID1 |
> >>  			BTRFS_BLOCK_GROUP_RAID5;
> >> -		__attribute__ ((fallthrough));
> >> +		/* fallthrough */
> >>  	case 1:
> >>  		allowed |= BTRFS_BLOCK_GROUP_DUP;
> >>  	}
> >>


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1313A2EA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFJOwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 10:52:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8321 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhFJOwQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 10:52:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G16Mt6NybzBBTQ;
        Thu, 10 Jun 2021 16:50:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IgLzEJiZ-597; Thu, 10 Jun 2021 16:50:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G16Mt5QJzzBB9r;
        Thu, 10 Jun 2021 16:50:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 375368B81B;
        Thu, 10 Jun 2021 16:50:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DzO9RJN6YzIB; Thu, 10 Jun 2021 16:50:18 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B07968B80F;
        Thu, 10 Jun 2021 16:50:17 +0200 (CEST)
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
To:     Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
Date:   Thu, 10 Jun 2021 16:50:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 10/06/2021 à 15:54, Chris Mason a écrit :
> 
>> On Jun 10, 2021, at 1:23 AM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>>
>> With a config having PAGE_SIZE set to 256K, BTRFS build fails
>> with the following message
>>
>> include/linux/compiler_types.h:326:38: error: call to '__compiletime_assert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0
>>
>> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
>> 256K pages at the time being.
>>
>> There are two platforms that can select 256K pages:
>> - hexagon
>> - powerpc
>>
>> Disable BTRFS when 256K page size is selected.
>>
> 
> We’ll have other subpage blocksize concerns with 256K pages, but this BTRFS_MAX_COMPRESSED #define is arbitrary.  It’s just trying to have an upper bound on the amount of memory we’ll need to uncompress a single page’s worth of random reads.
> 
> We could change it to max(PAGE_SIZE, 128K) or just bump to 256K.
> 

But if 256K is problematic in other ways, is it worth bumping BTRFS_MAX_COMPRESSED to 256K ?

David, in below mail, said that 256K support would require deaper changes. So disabling BTRFS 
support seems the easiest solution for the time being, at least for Stable (I forgot the Fixes: tag 
and the CC: to stable).

On powerpc, 256k pages is a corner case, it requires customised binutils, so I don't think disabling 
BTRFS is a issue there. For hexagon I don't know.


https://lkml.org/lkml/2021/6/9/978

Le 09/06/2021 à 17:22, David Sterba a écrit :
 > On Wed, Jun 09, 2021 at 04:01:20PM +0200, Christophe Leroy wrote:
 >> Le 09/06/2021 à 15:55, kernel test robot a écrit :
 >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
 >>> head:   368094df48e680fa51cedb68537408cfa64b788e
 >>> commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
 >>> date:   4 months ago
 >>> config: powerpc-randconfig-r012-20210609 (attached as .config)
 >>> compiler: powerpc-linux-gcc (GCC) 9.3.0
 >>
 >> That's a BTRFS issue, and not directly linked to the above mentioned commit. Before that commit the
 >> problem was already present.
 >>
 >> Problem is that with 256k PAGE_SIZE, following BUILD_BUG() pops up:
 >>
 >> BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0)
 >
 > A 256K page is a problem for btrfs, until now I was not even aware
 > there's an architecture supporting that so. That the build fails is
 > probably best thing. Maximum metadata nodesize supported is 64K and
 > having that on a 256K page would need deeper changes, no top of the
 > currently developed subpage changes (that do 4K blocks on 64K pages).
 >

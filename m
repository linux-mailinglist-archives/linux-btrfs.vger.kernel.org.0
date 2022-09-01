Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A615A9F70
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiIASwv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiIASwu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 14:52:50 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09B95E59
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 11:52:48 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd78be.dip0.t-ipconnect.de [93.221.120.190])
        by mail.itouring.de (Postfix) with ESMTPSA id 0E774103762;
        Thu,  1 Sep 2022 20:52:45 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id AEEB7F01605;
        Thu,  1 Sep 2022 20:52:44 +0200 (CEST)
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
To:     Omar Sandoval <osandov@osandov.com>,
        Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
 <Yv2A+Du6J7BWWWih@relinquished.localdomain>
 <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
 <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
 <467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org>
 <751cc484a56fc0bbe3838929feae3c214c297001.camel@scientia.org>
 <YxD3iM29bDpnxeNg@relinquished.localdomain>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <a4de8453-780f-3483-724f-a97a692fe3e5@applied-asynchrony.com>
Date:   Thu, 1 Sep 2022 20:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <YxD3iM29bDpnxeNg@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2022-09-01 20:18, Omar Sandoval wrote:
> On Thu, Sep 01, 2022 at 06:59:05PM +0200, Christoph Anton Mitterer wrote:
>> Hey.
>>
>> Now that the first stable kernel with the fix is out,... is there going
>> to be any more information on how people can asses the impact of this
>> issue on their data integrity?
>>
>> I had asked some questions below, but I guess for me, personally, it
>> would also be okay to just recreate the potentially affected
>> filesystems from backups, if it cannot be determined for sure whether
>> any corruptions have happened (especially in both data or metadata).
>>
>>
>> Also anything expectations on when the announced tool for this might
>> become available?
>>
>> Thanks,
>> Chris.
> 
> The tool is here for now:
> https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_check_space_cache.c
> 
> Please try it out with:
> 
> git clone https://github.com/osandov/osandov-linux.git
> cd osandov-linux/scripts
> make btrfs_check_space_cache
> sudo ./btrfs_check_space_cache $MOUNTED_FILESYSTEM_PATH
> 
> It'll print out a diagnosis and some advice. Please let me know what
> output it gives you and any suggestions you have.
> 

Thank you! Got two warnings though, with both gcc-12 and clang-14:

gcc $(echo $CFLAGS) -Wall btrfs_check_space_cache.c -o btrfs_check_space_cache
btrfs_check_space_cache.c: In function 'check_free_space_tree':
btrfs_check_space_cache.c:346:58: warning: taking address of packed member of 'struct btrfs_free_space_info' may result in an unaligned pointer value [-Waddress-of-packed-member]
   346 |                         expected_extent_count = get_le32(&info->extent_count);
       |                                                          ^~~~~~~~~~~~~~~~~~~
btrfs_check_space_cache.c:347:45: warning: taking address of packed member of 'struct btrfs_free_space_info' may result in an unaligned pointer value [-Waddress-of-packed-member]
   347 |                         bitmaps = (get_le32(&info->flags)
       |                                             ^~~~~~~~~~~~

I know this will work on Intel but don't remember what might happen on other arches.
Anyway it seems to work fine:

--snip--
$./btrfs_check_space_cache /mnt/backup
Space cache checker 1.0
retries = 2, freeze = 0
Running on Linux 5.19.6 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 13:34:50 CEST 2022 x86_64
Free space tree is enabled

No corruption detected :)

You should install a kernel with the fix as soon as possible and avoid
rebooting until then.

Once you are running a kernel with the fix:

1. Run this program again.
2. Run btrfs scrub.
--snip--

cheers
Holger

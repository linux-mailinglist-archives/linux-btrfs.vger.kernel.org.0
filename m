Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06906A8DC2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 01:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCCANl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 19:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCCANk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 19:13:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149513DD6
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 16:13:39 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs4Z-1qK5pe2GMj-00mobp; Fri, 03
 Mar 2023 01:13:28 +0100
Message-ID: <cb26ea54-a0b8-2102-6899-521ca8028b9c@gmx.com>
Date:   Fri, 3 Mar 2023 08:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <ZACrzUh82/9HPDV2@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ZACrzUh82/9HPDV2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jEq28SIan6uel5Z/eWRwQJ1KxtzDa2OsGeX8VFYpnWyTVp8J1PK
 Hb2iQ2rv/FjzmyZJ2xvTjvQ3Sf2Bl0Fu16+q4CYWNvrFq+vZWGCrn0GPVJ7y1KWQ4DUv5aR
 SDufPdWXG75KBk1yfIg7/piW0YYDBT+UIe3LDUF1+AvzPv9aTq9LyXWJZMrvoYqJ9oA6hRl
 qFIlHiAKH532jo2D/2ugQ==
UI-OutboundReport: notjunk:1;M01:P0:io84sh/AoAc=;KKXAZamzR5stRBS2whduHJTxbyn
 gzChbBn99Bc/sKIJ/EQu7wapkZGZZY8NSP0vMRL9ah2FrVH00AsclZ07X3IyMRoEfB9fKez7n
 JFEW0ooVF3IDQMv7mRvSIK10+irHCkIQ7BiyfrEwgX4YS1BCbb8+z6YmDYiq4Di5A9PcMZHlN
 qcm56eWXYqb2fyx7pCjYpxwDeDKY1liMa/VxA2VCu7kGrsD9InWMi4e8D1UX+rlh0gkyN9hVu
 IIDO7Z6+nkzmcN2x8mXIxsIYIEomo0DGdtmlTwTIsfwwgG+5H5QlQi3KZfV+6PhVLJvsQWJ0W
 36SH+CAUAYIUP1zcu/oNJSslhR/6usWkq7eK/pm51kABVuyuRCzr1pVkcGWOxP10rYxYSooLj
 vSTIJnbQm5aL8z1UkvJZYZhhPTT7ylkE2uH7d2+fexCCR/v6/+lP+KLjQmCvXvuRkexbB0kxS
 B4luV7rvgB0qkf9EqHwIsx/770Yqx823WT8p2XfcRP5YCj4PmMPrvhFSKrdgpzGPv44UtvGqz
 5UA+iWYRlvRVHpdaWZHvH2KqBNT/eHMQmSTCn91ZcWZ5OWM2WEh06Up7SeJD4W1hCCRfMEgy+
 hr7Ig6f4qAt6Oh64wG4nX62fB++UclAH7q+VlC5F1Q4nDX9w7ux/hkMrdXLGVXSUQN4Wr0f1d
 hQxbpybePdyfqlb59mCz/48vZSyZaW7Yjt+tf4Z9DY/hDBAd9UT6SbPlLVuDUQfUsocrX/Gr5
 B6wQd83X0tLK1A75ONeu+gsCC603uP8tgJEkKVwLVeLjI1S1shlLg6NVqoPMI0Qj11QaKAkaR
 AEouuKzNdwVJtE2Rsa4n100ebL39E+FiXHk6KKbnNV0tGzQNVIvBXPFxBVpZxNCCqzabJvNuq
 1mm7TVDmtRgFv6t14GpleQBTVihMnEMYiLV6VMZ6LDaOgn8cWqiG60BDgQIysDISG0LzWaS7s
 +7bLzYuAHbg6dvIOiPFHysEXFgQ=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 21:59, Christoph Hellwig wrote:
> On Thu, Mar 02, 2023 at 11:25:22AM +0000, Johannes Thumshirn wrote:
>>> The main concern may be the bioc <-> ordered extent mapping, but IIRC
>>> for zoned mode one bioc is one ordered extent, thus this shouldn't be a
>>> super big deal?
>>
>> Yep, but I want to be able to use RST for non-zoned devices as well
>> to attack the RAID56 problems and add erasure coding RAID.
> 
> I have a series in my queue the limits every btrfs_bio (and thus bioc)
> to a single ordered_extent.  The bio spanning ordered_extents is a very
> strange corner case that rarely happens but causes a lot of problems.

Really?

A not-so-large write (e.g. 4MiB) for RAID0 (64K stripe len) can easily 
lead to that situation.

If we really split ordered extents to that stripe len, it can cause a 
lot of small file extents thus bloat the size of subvolume trees.

Thanks,
Qu

> With that series we'll also gain a pointer to the ordered_extent from
> the btrfs_bio, which will remove all the ordered_extent lookups from
> the fast path.
> 
> So I think you can rework your series to also limit the bio to a single
> ordered extent, and if needed split the ordered extent for anything that
> uses the raid stripe tree and we'll nicely converge there.

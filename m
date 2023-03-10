Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D76B338F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 02:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCJBPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 20:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJBPJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 20:15:09 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 17:15:08 PST
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692FE1937
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 17:15:08 -0800 (PST)
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1678410462; bh=IgCMagAfkB2ymWBS0sK0550d7cnQz78CHNI/zNyDF6E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m45sjIeNHRzRyNBQTNV3udCkKgOetkYblV9Aa73nqFJsY3cq1Z38Pz125CpaXVC4l
         JV6bH7aqGElpm4a1C/Cfdn94FVVx1isx8KjvG6zDfn8wf6xqR3ycZvzd3WRirWkVPx
         uEBKNELnmg/JU3aVJhWFlVqkdugiqVOPvuZO8eos=
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20221214021125.28289-1-robbieko@synology.com>
 <Y5oA3qBk+qMSyAR/@localhost.localdomain>
 <20221214180718.GF10499@twin.jikos.cz>
 <f1971de4-5355-6f57-46df-0a6cefb9ee95@synology.com>
 <20230110150818.GD11562@twin.jikos.cz> <20230309184741.GN10580@twin.jikos.cz>
From:   robbieko <robbieko@synology.com>
Message-ID: <13e53380-5b7b-c32f-4a34-13fa0473b882@synology.com>
Date:   Fri, 10 Mar 2023 09:07:40 +0800
MIME-Version: 1.0
In-Reply-To: <20230309184741.GN10580@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David Sterba 於 2023/3/10 上午2:47 寫道:
> On Tue, Jan 10, 2023 at 04:08:18PM +0100, David Sterba wrote:
>>> Sorry for the late reply, I've been busy recently.
>>> This modification will not affect the original btrfs_drew_lock behavior,
>>> and the framework can also provide future scenarios where memory
>>> needs to be allocated in init_fs_root.
>> With the conversion to atomic_t the preallocation can remain unchanged
>> as there would be only the anon bdev preallocated, then there's not much
>> reason to have the infrastructure.
>>
>> I'm now testing the patch below, it's relatively short an can be
>> backported if needed but it can potentially make the performance worse
>> in some cases.
> I forgot to CC you, the patch implementing the switch to atomic has been
> sent and merged to misc-next.
>
> https://lore.kernel.org/linux-btrfs/20230301204708.25710-1-dsterba@suse.com/
OK, Thank you so much.

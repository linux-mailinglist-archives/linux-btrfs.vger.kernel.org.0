Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7257AD50
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiGTBnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 21:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbiGTBnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 21:43:37 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BDC70
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 18:43:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 52EC080406;
        Tue, 19 Jul 2022 21:43:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658281415; bh=nb41v5pUq0/hxqIF6s4cjwL+QYqR9clK/soLPHLoKrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E6BKSjPSz+U/Bsh8MiNeRgKV9mpm/o4nNZdu8953EEErXPkI3oYXZtKzpUloj9mtp
         jLYrNAXjUJ/+dBiklogCQs/9ovs9m6XH2Sa1dHGLBjA/6iTe/LDx1oDszfNDxmFdfh
         KUIJqbqu00PoRq0ttlNkznJiNwOQ2asJS1Ct9O3KFUIGK1L0Cg/FAKwxRLkWTw99I7
         tTUdTtYLwxZiG2QjEYFqAv4JJbHpOM0B8pwiPMnZfiSxG5AxMot54k7eQLyT6dZI3L
         ywnQ6YIQ7q2B53OIbZHuSUv8JxW03jCRthHmJfNdSgk1/8YsETFV504KDQwjW6dC1e
         lnHQG6Y1aZ5LA==
Message-ID: <e3f6275a-5f4c-f6d6-6a19-a53af8dc12e2@dorminy.me>
Date:   Tue, 19 Jul 2022 21:43:33 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <621654191a02dc3cbc5c3b03f6c00963b7e6f382.1658207325.git.wqu@suse.com>
 <4b4b9f52-9c40-2f91-d8a3-a6ed29c379ee@dorminy.me>
 <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <8d2c653a-eddf-e9b4-7912-d46993705680@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>> +}
>> This function looks similar to btrfs_dump_space_info(), and the name and
>> callsite doesn't help distinguish it very much to me. It seems
>> potentially useful to print all the space_infos when one space_info
>> encounters a problem,
> 
> This is fine for trans abort dump, but may not be a good idea for
> enospc_debug output.
> 
> enospc_debug can be triggered way more frequent than trans abort, and
> the extra info of unrelated space info may just be noise.
>> and it seems potentially useful to print the block
>> group infos when we're dumping all the space infos already, so maybe the
>> two functions could be combined.
> 
> You mean block group infos? That can be very large for large fses.
> Thus it's avoided for most call sites other than btrfs_reserve_extent().

I appreciate the explanation, I now agree it makes sense to keep the 
dump-all function separate.
Maybe you could move the new dump-all function up beside the dump-one 
function, and name it btrfs_dump_all_space_infos()? I still find the 
name btrfs_dump_fs_space_info() a little hard to distinguish from the 
others, and prefer 'all' being in the function name, but it's only a 
mild preference.

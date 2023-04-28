Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4756F1A6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjD1OZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1OZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 10:25:30 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 07:25:28 PDT
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB2C2719
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 07:25:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A83373F93D;
        Fri, 28 Apr 2023 16:17:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KGLCn5LZ2Jj1; Fri, 28 Apr 2023 16:17:17 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 00C6C3F8EB;
        Fri, 28 Apr 2023 16:17:16 +0200 (CEST)
Received: from 90-224-97-87-no521.tbcn.telia.com ([90.224.97.87]:39081 helo=[192.168.1.27])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1psOuR-0005i3-IK; Fri, 28 Apr 2023 16:17:16 +0200
Message-ID: <b9381bf5-2ce0-d8e3-6446-9bf7c072325f@tnonline.net>
Date:   Fri, 28 Apr 2023 16:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: /sys/devices/virtual/bdi/btrfs-* entries
Content-Language: sv-SE
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <75de58ce-0c16-9fd0-dd64-a8d4a7214aa8@tnonline.net>
 <20230428140610.GA2654@twin.jikos.cz>
From:   Forza <forza@tnonline.net>
In-Reply-To: <20230428140610.GA2654@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-04-28 16:06, David Sterba wrote:
> On Fri, Apr 28, 2023 at 12:08:24PM +0200, Forza wrote:
>> Hi,
>>
>> How do I find out to what Btrfs filesystem the entries in
>> /sys/devices/virtual/bdi belong to?
> 
> Each filesystem has a symlink to the BDI /sys/fs/btrfs/FSID/bdi, the
> linked path is e.g. "bdi -> ../../../devices/virtual/bdi/btrfs-2/".

Oh, I missed that link. Thanks =)

# ll /sys/fs/btrfs/*/bdi
lrwxrwxrwx 1 root root 0 Apr 23 17:20 
/sys/fs/btrfs/558ec0b4-869e-4f8e-a143-258d4d380847/bdi -> 
../../../devices/virtual/bdi/btrfs-1/

lrwxrwxrwx 1 root root 0 Apr 23 17:20 
/sys/fs/btrfs/7745e2f7-5c67-4b18-844b-8e93399f7b0b/bdi -> 
../../../devices/virtual/bdi/btrfs-3/

lrwxrwxrwx 1 root root 0 Apr 23 17:20 
/sys/fs/btrfs/d34c187e-c57d-44b9-ac08-203bbe00a56a/bdi -> 
../../../devices/virtual/bdi/btrfs-4/

lrwxrwxrwx 1 root root 0 Apr 23 17:20 
/sys/fs/btrfs/ee555e98-07ac-491b-9f15-fd7b5d42427b/bdi -> 
../../../devices/virtual/bdi/btrfs-2/

Have a nice weekend :)


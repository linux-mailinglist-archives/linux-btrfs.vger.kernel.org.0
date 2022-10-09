Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E95F8AB9
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJIKpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJIKpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 06:45:06 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 03:45:04 PDT
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6DA1758C
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 03:45:03 -0700 (PDT)
Received: from smtp.vodafone.de (unknown [10.0.0.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mr4.vodafonemail.de (Postfix) with ESMTPS id 4Mldj33Sdkz1xy3
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-mb-mr2-21dec; t=1665311703;
        bh=ZMFXck0FiO6h9GKFi9tubxV5XVetd4bg4T1kwpyMpWc=;
        h=Message-ID:Date:User-Agent:Content-Language:To:From:Subject:
         Content-Type:From;
        b=FD+anh+cdQfghRuQ+SZuQJCk8LXHPfLAb69a+OQh51tbErGoXnBLg8qKD5T6TlQSk
         LKWdNZ5+hRt1uzH5wz2RBx0QhAyjn4M/NnD1CoCjQN96e4zuMXj+D0GKAmrb+9F2mC
         a1FqlZzlrWQzMBZbVGqRpTha7szh8WrgXSq8q6os=
Received: from [10.0.2.6] (p54afaf98.dip0.t-ipconnect.de [84.175.175.152])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4Mldj25ckCzKm4q
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 10:34:59 +0000 (UTC)
Message-ID: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
Date:   Sun, 9 Oct 2022 12:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Ochi <ochi@arcor.de>
Subject: RAID5 on SSDs - looking for advice
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1389
X-purgate-ID: 155817::1665311702-53FFE4F8-2B9F3C39/0/0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I'm currently thinking about migrating my home NAS to SSDs only. As a 
compromise between space efficiency and redundancy, I'm thinking about:

- using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or 
4 for now, with the option to expand later),
- using compression to get the most out of the relatively expensive SSD 
storage,
- encrypting each drive seperately below the FS level using LUKS (with 
discard enabled).

The NAS is regularly backed up to another NAS with spinning disks that 
runs a btrfs RAID1 and takes daily snapshots.

I have a few questions regarding this approach which I hope someone with 
more insight into btrfs can answer me:

1. Are there any known issues regarding discard/TRIM in a RAID5 setup? 
Is discard implemented on a lower level that is independent of the 
actual RAID level used? The very, very old initial merge announcement 
[1] stated that discard support was missing back then. Is it implemented 
now?

2. How is the parity data calculated when compression is in use? Is it 
calculated on the data _after_ compression? In particular, is the parity 
data expected to have the same size as the _compressed_ data?

3. Are there any other known issues that come to mind regarding this 
particular setup, or do you have any other advice?

[1] https://lwn.net/Articles/536038/

Best regards
Ochi

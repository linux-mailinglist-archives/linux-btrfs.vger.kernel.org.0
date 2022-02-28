Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412474C7020
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiB1OzV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 09:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiB1OzV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 09:55:21 -0500
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 06:54:42 PST
Received: from mail02.aqueos.net (mail02.aqueos.net [94.125.164.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF28424AA
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 06:54:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail02.aqueos.net (Postfix) with ESMTP id F26FF66CFB8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 15:48:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail02.aqueos.net
Received: from mail02.aqueos.net ([127.0.0.1])
        by localhost (mail02.aqueos.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CoJ4S-ENkJP3 for <linux-btrfs@vger.kernel.org>;
        Mon, 28 Feb 2022 15:48:31 +0100 (CET)
Received: from [10.10.10.12] (unknown [185.63.173.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail02.aqueos.net (Postfix) with ESMTPSA id 5CAD466CFAB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 15:48:31 +0100 (CET)
Message-ID: <c58f6d6d-fb95-5a6b-7028-4640ab5d1fee@aqueos.com>
Date:   Mon, 28 Feb 2022 15:48:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-btrfs@vger.kernel.org
Content-Language: fr
From:   Ghislain Adnet <gadnet@aqueos.com>
Subject: how to not loose all production when one disk fail in a raid1 btrfs
 pool
Organization: AQUEOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi,

   All the raid i know since btrfs are made so you dont loose data and dont loose uptime when just one drive in a raid1 system fails.
   you can check the failure and replace the drive.

   I just had a btrfs raid 1 that lost a ssd and the system immediatly stopped functionning (was the root FS). Seems the way it works


   As far as i can see when i search on the net it seems that btrfs is not made for that, it just protect data loss but fail the system and wait for you to change the disk.

   After some googling i find no way to make it work like all other raid works, to protect uptime and have transparent crash/recovery, it seems that running in degraded mode all the time is not usable and dangerous.


   Is there a way to make Btrfs function like all other raid system or is it a special case   ?


https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices


-- 
cordialement,
Ghislain ADNET.
AQUEOS.

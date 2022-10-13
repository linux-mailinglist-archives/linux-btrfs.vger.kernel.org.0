Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD525FDE4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJMQgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMQgh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 12:36:37 -0400
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2523147077
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 09:36:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 0A102A2385B;
        Thu, 13 Oct 2022 18:36:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2wVK4Aglj27b; Thu, 13 Oct 2022 18:36:31 +0200 (CEST)
Received: from [192.168.55.112] (unknown [185.174.112.221])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id B8522A23856;
        Thu, 13 Oct 2022 18:36:31 +0200 (CEST)
Message-ID: <2375742d-6e20-fa52-f524-04588dc4594c@dubiel.pl>
Date:   Thu, 13 Oct 2022 18:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: btrfs send -> receive -> snapshot read only but files missing =>
 strange behaviour while btrfs delete on source system
Content-Language: pl-PL
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <6c4676e3-45de-af5f-2064-67ebdb1d95a9@dubiel.pl>
 <af72b31.b561b447.183d1f92292@tnonline.net>
From:   Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <af72b31.b561b447.183d1f92292@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> My opinion is that, "/var/lib/samba/wins.dat" dissapeared due to "btrfs
>> device delete" process on server "beta".
>>
>>
>> I can't reproduce that bug.
>>
> Have you ever used "btrfs property set" to change a subvolume/snapshot from ro to rw or vice versa on either computer? This can cause issues like this, even after a while.

No... I have never changed property.



On serwer "gamma" file is missing:

      /mnt/gammabackup/001/var/lib/samba/wins.dat    <-- file OK
      /mnt/gammabackup/002                         <--- file missing
      /mnt/gammabackup/003/var/lib/samba/wins.dat    <--- file OK again
    

On serwer "alfa" file is OK:

      /mnt/snaps/001/var/lib/samba/wins.dat
      /mnt/snaps/002/var/lib/samba/wins.dat
      /mnt/snaps/003/var/lib/samba/wins.dat


Whole transfer alfa -> beta -> gamma is fully automatic.
It runs day after day, month after month...

    

But it struck me yesterday.


As if there was a tiny moment in time that file dissappeared from some readonly snapshot on server "beta" while disk on "beta" was beeing removed.





On real system it looks like this:


# for f in 2022-10-12\ *; do echo; echo $f; ls "$f/var/lib/samba/wins.dat"; done

2022-10-12 12:13:02 283755833
-rw-r--r-- 1 root root 1477 Oct 12 12:12 '2022-10-12 12:13:02 283755833/var/lib/samba/wins.dat'

2022-10-12 12:59:01 818041485
-rw-r--r-- 1 root root 1477 Oct 12 12:58 '2022-10-12 12:59:01 818041485/var/lib/samba/wins.dat'

2022-10-12 14:23:01 333153709
-rw-r--r-- 1 root root 1477 Oct 12 14:22 '2022-10-12 14:23:01 333153709/var/lib/samba/wins.dat'

2022-10-12 14:58:02 153281259
-rw-r--r-- 1 root root 1477 Oct 12 14:57 '2022-10-12 14:58:02 153281259/var/lib/samba/wins.dat'

2022-10-12 15:40:01 214143404
-rw-r--r-- 1 root root 1477 Oct 12 15:39 '2022-10-12 15:40:01 214143404/var/lib/samba/wins.dat'

2022-10-12 15:59:02 125049599
-rw-r--r-- 1 root root 1477 Oct 12 15:58 '2022-10-12 15:59:02 125049599/var/lib/samba/wins.dat'

2022-10-12 16:30:02 220288932
-rw-r--r-- 1 root root 1477 Oct 12 16:30 '2022-10-12 16:30:02 220288932/var/lib/samba/wins.dat'

2022-10-12 17:41:02 065032258
-rw-r--r-- 1 root root 1477 Oct 12 17:40 '2022-10-12 17:41:02 065032258/var/lib/samba/wins.dat'

2022-10-12 18:20:01 321146890
-rw-r--r-- 1 root root 1477 Oct 12 18:19 '2022-10-12 18:20:01 321146890/var/lib/samba/wins.dat'

2022-10-12 19:19:01 958914798
ls: cannot access '2022-10-12 19:19:01 958914798/var/lib/samba/wins.dat': No such file or directory

2022-10-12 19:59:01 521289195
-rw-r--r-- 1 root root 1477 Oct 12 19:58 '2022-10-12 19:59:01 521289195/var/lib/samba/wins.dat'






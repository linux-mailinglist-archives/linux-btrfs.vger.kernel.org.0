Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30BD649E16
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 12:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLLLmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 06:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiLLLlm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 06:41:42 -0500
X-Greylist: delayed 4493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 03:37:46 PST
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA00E0E3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 03:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202112; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Reply-To:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FBo4a7+Y2DOdEmwMZw55uHypYlciXyMULg5LqlE34+s=; b=ek9nZ6zv7QP73mLbhNH/9FguRH
        HfBYpL7uveZ+hTOXDK0278+uisX/NnjLGgcPo0UQnhL2JW+TiBC4yozFcmXl3y2KLaw5ueny/cXC6
        RGef54FHyjUULRwaTpk6lhwT+Iz5aifHLoyopi6a3av8qp+H8zOcxBNzBUbIFva7CH6Bv9xbTCf3+
        slTQs8Z0FxmudegxK+uuaoURIh6m3Ffy46b+5sh8Vx8e3RQj3n+QyQcrknrmjOCUmp1JMhbVJISV4
        qFUFfvTtff3ZYOCKYTfbcYjpVG2MP/ATGWNo0Ov4AIxa8tWAwH6INRZBVMVxMmtiQ2aMVsF7LdCY6
        ngDEAVFw==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:51187 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1p4fxP-00BMeM-HH
        for linux-btrfs@vger.kernel.org;
        Mon, 12 Dec 2022 11:22:47 +0100
Reply-To: waxhead@dirtcellar.net
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   waxhead <waxhead@dirtcellar.net>
Subject: Metadata RAID1c4 balance issue
Message-ID: <0c1d274f-a917-9b12-1915-8a8346ebfa0c@dirtcellar.net>
Date:   Mon, 12 Dec 2022 11:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 SeaMonkey/2.53.14
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

I have just recently fired up a clean fs (kernel 6.0 (current in Debian 
testing)) and have started rsyncing files to it.
The system has 24 x 3TB drives e.g. same size devices.

Not that it matters much from a practical point of view, but I notice 
that metadata seems to be quite unbalanced. As shown below there are 
some drives which does not have metadata at all yet, and other drives 
that have several chunks allocated. I would expect that metadata was 
allocated more evenly across the drives.

I do however realize what is going on (at least I think so) , when 
data-chunks are allocated the they of course consume space, and 
therefore the metadata allocation simply picks the drives with the most 
free space which is optimal as far as the unallocated space is concerned.

Would it not make more sense for the metadata allocation to try to 
allocate space on the drive with the LEAST metadataspace used first (at 
least up until a certain point), and if that fails, then fall back to 
allocating from the device with the most free space?.

As I see it - that would help spreading out metadata and reducing the 
risk / amount of data that needs to be repaired if something goes 
haywire. Also the chance of hitting a idle device to read metadata off 
(as in the example below) might be higher which may be good for speed.

So I am not searching for a solution, this is just an observation.

btrfs fi us -T /mnt

Overall:
     Device size:                  65.50TiB
     Device allocated:             13.09TiB
     Device unallocated:           52.41TiB
     Device missing:                  0.00B
     Device slack:                    0.00B
     Used:                         13.08TiB
     Free (estimated):             26.21TiB      (min: 13.10TiB)
     Free (statfs, df):            26.21TiB
     Data ratio:                       2.00
     Metadata ratio:                   4.00
     Global reserve:              512.00MiB      (used: 64.00KiB)
     Multiple profiles:                  no

              Data      Metadata System
Id Path      RAID1     RAID1C4  RAID1C4   Unallocated Total    Slack
-- --------- --------- -------- --------- ----------- -------- -----
  1 /dev/sdb1 556.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
  2 /dev/sdu1 556.00GiB  2.00GiB  32.00MiB     2.18TiB  2.73TiB     -
  3 /dev/sdw1 556.00GiB  2.00GiB  32.00MiB     2.18TiB  2.73TiB     -
  4 /dev/sdv1 554.00GiB  4.00GiB  32.00MiB     2.18TiB  2.73TiB     -
  5 /dev/sdq1 553.00GiB  5.00GiB         -     2.18TiB  2.73TiB     -
  6 /dev/sdx1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
  7 /dev/sdr1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
  8 /dev/sds1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
  9 /dev/sdt1 559.00GiB        -         -     2.18TiB  2.73TiB     -
10 /dev/sdm1 559.00GiB        -         -     2.18TiB  2.73TiB     -
11 /dev/sdn1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
12 /dev/sdo1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
13 /dev/sdp1 554.00GiB  4.00GiB  32.00MiB     2.18TiB  2.73TiB     -
14 /dev/sdi1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
15 /dev/sdj1 554.00GiB  4.00GiB         -     2.18TiB  2.73TiB     -
16 /dev/sdk1 559.00GiB        -         -     2.18TiB  2.73TiB     -
17 /dev/sdl1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
18 /dev/sdg1 559.00GiB        -         -     2.18TiB  2.73TiB     -
19 /dev/sdf1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
20 /dev/sdc1 557.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
21 /dev/sdh1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
22 /dev/sda1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
23 /dev/sdd1 555.00GiB  3.00GiB         -     2.18TiB  2.73TiB     -
24 /dev/sde1 557.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
-- --------- --------- -------- --------- ----------- -------- -----
    Total       6.53TiB 10.00GiB  32.00MiB    52.41TiB 65.50TiB 0.00B
    Used        6.52TiB  9.57GiB 928.00KiB

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE160596E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 10:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJTIOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJTIOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 04:14:39 -0400
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1D14D27
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 01:14:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 791F49E6B73
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 10:14:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JkPgRptnJ58R for <linux-btrfs@vger.kernel.org>;
        Thu, 20 Oct 2022 10:14:31 +0200 (CEST)
Received: from [192.168.18.35] (unknown [157.25.148.26])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id D20AA9EBFEE
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 10:14:31 +0200 (CEST)
Message-ID: <424c5ba1-2b02-fa18-d273-ecf7db314bd3@dubiel.pl>
Date:   Thu, 20 Oct 2022 10:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     linux-btrfs@vger.kernel.org
Content-Language: pl-PL
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Deleting missing device 4.93 TiB took 7 days.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



 From wiki:    "If you find any behavior .... performance issues, or 
have any questions about using Btrfs, please email the Btrfs mailing list "






Here is performance report:





Current debian stable distribution:

# cat /etc/issue
Debian GNU/Linux 11 \n \l

# uname -a
Linux pegaz 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02) x86_64 
GNU/Linux

# btrfs --version
btrfs-progs v5.10.1



It is backup server. It has 50 subvolumes:

# btrfs sub list / | wc -l
50



While removing misssing device server was not doing any other tasks.



=========================
STARTING TO REMOVE
2022-10-12 15:26:02

missing, ID: 1
    Device size:               0.00B
    Device slack:              0.00B
    Data,RAID1:              4.93TiB
    Metadata,RAID1:         46.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            -4.98TiB

/dev/sda3, ID: 2
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              2.42TiB
    Metadata,RAID1:         23.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.16TiB

/dev/sdb3, ID: 3
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              2.51TiB
    Metadata,RAID1:         23.00GiB
    Unallocated:             1.08TiB

/dev/sdc3, ID: 4
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Unallocated:             5.43TiB





=========================
2022-10-16:

nie, 16 paź 2022, 09:45:42 CEST
missing, ID: 1
    Device size:               0.00B
    Device slack:              0.00B
    Data,RAID1:              2.60TiB
    Metadata,RAID1:         24.00GiB
    System,RAID1:           32.00MiB
    Unallocated:            -2.62TiB

/dev/sda3, ID: 2
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.90TiB
    Metadata,RAID1:         21.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.69TiB

/dev/sdb3, ID: 3
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.90TiB
    Metadata,RAID1:         19.00GiB
    Unallocated:             1.69TiB

/dev/sdc3, ID: 4
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.19TiB
    Metadata,RAID1:         16.00GiB
    Unallocated:             4.22TiB





=================
2022-10-19 21:47

missing, ID: 1
    Device size:               0.00B
    Device slack:              0.00B
    Data,RAID1:              1.00GiB
    Unallocated:            -1.00GiB

/dev/sda3, ID: 2
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.72TiB
    Metadata,RAID1:         14.00GiB
    Unallocated:             1.87TiB

/dev/sdb3, ID: 3
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.72TiB
    Metadata,RAID1:         19.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.87TiB

/dev/sdc3, ID: 4
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              3.44TiB
    Metadata,RAID1:         33.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.95TiB




====================
THE END OF REMOVAL:
2022-10-19 21:48

/dev/sda3, ID: 2
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.72TiB
    Metadata,RAID1:         14.00GiB
    Unallocated:             1.87TiB

/dev/sdb3, ID: 3
    Device size:             3.61TiB
    Device slack:            3.50KiB
    Data,RAID1:              1.72TiB
    Metadata,RAID1:         19.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.87TiB

/dev/sdc3, ID: 4
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,RAID1:              3.44TiB
    Metadata,RAID1:         33.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.95TiB






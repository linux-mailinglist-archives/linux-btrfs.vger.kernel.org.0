Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719F2C6C93
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 21:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbgK0UdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 15:33:12 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:62317 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgK0Ubj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 15:31:39 -0500
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 15:31:38 EST
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 4CB743FC9E
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 21:20:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gb7vaeflj_yx for <linux-btrfs@vger.kernel.org>;
        Fri, 27 Nov 2020 21:20:42 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 218773FA60
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 21:20:41 +0100 (CET)
Received: from [192.168.0.10] (port=62705)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <mail@lechevalier.se>)
        id 1kikEw-00033p-Iz
        for linux-btrfs@vger.kernel.org; Fri, 27 Nov 2020 21:21:10 +0100
From:   A L <mail@lechevalier.se>
Subject: Change Btrfs defaults on LUKS container on SSDs to dup metadata
 profile
To:     linux-btrfs@vger.kernel.org
Message-ID: <bc280edd-873c-4197-940b-03c6f86b740d@lechevalier.se>
Date:   Fri, 27 Nov 2020 21:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

By default, Btrfs is using 'single' metadata profile at mkfs time for 
non-rotational devices. I've seen many discussions on that topic before 
on the pros and cons of that choice. However, during testing of LUKS I 
noticed that Btrfs is still choosing to use 'single' metadata profile.

Here is an example:

    # mkfs.btrfs -L luks /dev/mapper/luks
    btrfs-progs v5.9
    See http://btrfs.wiki.kernel.org for more information.

    Detected a SSD, turning off metadata duplication.  Mkfs with -m dup
    if you want to force metadata duplication.
    Label:              luks
    UUID:               867d9303-ef43-4770-b24c-6819350a0084
    Node size:          16384
    Sector size:        4096
    Filesystem size:    7.98GiB
    Block group profiles:
       Data:             single            8.00MiB
       Metadata:         single            8.00MiB
       System:           single            4.00MiB
    SSD detected:       yes
    Incompat features:  extref, skinny-metadata
    Runtime features:
    Checksum:           crc32c
    Number of devices:  1
    Devices:
        ID        SIZE  PATH
         1     7.98GiB  /dev/mapper/luks

I think that Btrfs should choose 'dup' mode instead of 'single' on 
encrypted devices since there is no chance that data can be 
de-duplicated by any SSD firmware when running on LUKS. Is there any way 
that Btrfs could detect this scenario? I have also noted a couple of 
people on the #btrfs IRC channel having issues that could have been 
helped with the dup profile.

Thanks.

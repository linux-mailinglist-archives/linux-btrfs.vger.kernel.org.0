Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0109D78CA10
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjH2RB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbjH2RBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 13:01:48 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 10:01:44 PDT
Received: from taz.dbb.computer (taz.dbb.network [45.77.147.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF20107
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 10:01:44 -0700 (PDT)
Received: from taz.dbb.computer (localhost [IPv6:::1])
        by taz.dbb.computer (Postfix) with ESMTP id 5CA4C5E1F1
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 16:54:41 +0000 (UTC)
Authentication-Results: taz.dbb.network; dmarc=pass (p=quarantine dis=none) header.from=dbb.io
Authentication-Results: taz.dbb.network; spf=pass smtp.mailfrom=dbb.io
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dbb.io; s=jul08;
        t=1693328081; bh=EZwch8cUbuSDDAbJ3K51fS37h6TfFw6MfdG45d3mkHQ=;
        h=Date:From:Subject:To;
        b=hY5/trzhO8Zz9GcYAOmqc7K5PpKyLsFCkDRl36vZDkGdahaZ4J9GvYi7kjt28YTA3
         WCNP7NuQAKApRe3hg9KAzM6W68kvvgTMCXoC4OCNzU/EkxL5qvjzzRnMnwAD0pteIE
         8WMCaxxCKLRQoTsb/45lSwf43cMPt4CZXlD00cRE=
Received: from [10.0.2.15] ([68.192.91.77])
        by taz.dbb.computer with ESMTPSA
        id qH0xFNEi7mTvvgAArUmV4g
        (envelope-from <dbb@dbb.io>)
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 16:54:41 +0000
Message-ID: <1be85e08-f692-4d2c-afad-ad8d84bf3ada@dbb.io>
Date:   Tue, 29 Aug 2023 12:54:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Dwayne Bent <dbb@dbb.io>
Subject: btrfs check errors: no inode item
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I noticed my backup program logging lstat errors when trying to access 
two directories in my home directory:

~/.config/Code/blob_storage/7041c6fd-aabe-4a62-9854-05cb9f6474da
~/.config/Code/blob_storage/ad2b2790-79ce-40af-bff9-8cb656d4021c

Both are part of the internal data for Visual Studio code. Looking at my 
logs this started a couple of days ago.

Running btrfs check on the unmounted filesystem resulted in the 
following output:


[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
root 263 inode 65508556 errors 1, no inode item
	unresolved ref dir 420020 index 887 namelen 36 name 
7041c6fd-aabe-4a62-9854-05cb9f6474da filetype 2 errors 5, no dir item, 
no inode ref
	unresolved ref dir 420020 index 887 namelen 36 name 
4b13ccfb-4a83-456a-b5ce-3db05241fc43 filetype 2 errors 2, no dir index
root 263 inode 65556437 errors 1, no inode item
	unresolved ref dir 420020 index 889 namelen 36 name 
ad2b2790-79ce-40af-bff9-8cb656d4021c filetype 2 errors 5, no dir item, 
no inode ref
	unresolved ref dir 420020 index 889 namelen 36 name 
aad892bc-f6a7-4232-a5ca-229e73921171 filetype 2 errors 2, no dir index
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 8cff7b30-6f09-4121-9daf-42d88ac9b7c0
found 1917817171968 bytes used, error(s) found
total csum bytes: 1841302936
total tree bytes: 5577195520
total fs tree bytes: 2834448384
total extent tree bytes: 565526528
btree space waste bytes: 821124398
file data blocks allocated: 2223625146368
  referenced 2255431008256


The directories in the original errors are there 
('7041c6fd-aabe-4a62-9854-05cb9f6474da' and 
'ad2b2790-79ce-40af-bff9-8cb656d4021c') but two additional entries as 
well ('4b13ccfb-4a83-456a-b5ce-3db05241fc43' and 
'aad892bc-f6a7-4232-a5ca-229e73921171').

I don't particularly care about these directories (from looking at how 
they're used they're probably empty anyway) so I'm mainly just 
interested in fixing the file system and getting rid of the errors. Is 
--repair safe to use in this instance?


System information:

Distro: Arch Linux
Kernel: linux 6.4.12-arch1-1
btrfs-progs: 6.3.3-1
Device: Sabrent Rocket 4 Plus Gaming (4TB, FW: R4P47G.1)


scrub status output:

UUID:             8cff7b30-6f09-4121-9daf-42d88ac9b7c0
Scrub started:    Mon Aug 28 08:11:23 2023
Status:           finished
Duration:         0:29:51
Total to scrub:   1.75TiB
Rate:             1018.36MiB/s
Error summary:    no errors found


file system usage:

Overall:
     Device size:                   3.64TiB
     Device allocated:              1.83TiB
     Device unallocated:            1.81TiB
     Device missing:                  0.00B
     Device slack:                    0.00B
     Used:                          1.75TiB
     Free (estimated):              1.88TiB      (min: 994.87GiB)
     Free (statfs, df):             1.88TiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:1.80TiB, Used:1.74TiB (96.33%)
    /dev/nvme0n1p1          1.80TiB

Metadata,DUP: Size:12.00GiB, Used:5.20GiB (43.31%)
    /dev/nvme0n1p1         24.00GiB

System,DUP: Size:8.00MiB, Used:240.00KiB (2.93%)
    /dev/nvme0n1p1         16.00MiB

Unallocated:
    /dev/nvme0n1p1          1.81TiB


Let me know if any additional information is needed.

Thanks.

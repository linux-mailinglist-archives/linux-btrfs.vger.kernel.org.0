Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55FF75A486
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTCu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGTCu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 22:50:57 -0400
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397B11BFC
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 19:50:56 -0700 (PDT)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 7387340508;
        Wed, 19 Jul 2023 22:00:39 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 3268D8037796;
        Wed, 19 Jul 2023 21:50:55 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 201EC8036906;
        Wed, 19 Jul 2023 21:50:55 -0500 (CDT)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bfn15UvHKufU; Wed, 19 Jul 2023 21:50:55 -0500 (CDT)
Received: from [10.4.2.11] (unknown [191.96.227.24])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id B1C9F8036FBA;
        Wed, 19 Jul 2023 21:50:54 -0500 (CDT)
Date:   Wed, 19 Jul 2023 22:50:48 -0400
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <OKQ2YR.1O44EDSAXJ853@ericlevy.name>
In-Reply-To: <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
        <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Jul 20 2023 at 10:26:57 AM +0800, Anand Jain 
<anand.jain@oracle.com> wrote:
> On 20/07/2023 09:13, Eric Levy wrote:
>> I recently performed a routine update on a Linux Mint system, 
>> version 21.2 (Victoria). The update moved the kernel from 5.19.0 to 
>> 6.2.0. The system includes a non-root mount that is Btrfs with 
>> RAID, which no longer mounts. Error reporting is rather limited and 
>> opaque.
>> 
>> I am assuming the file system is healthy from the standpoint of the 
>> old kernel, but I may need help understanding how to make it viable 
>> for the new one.
>> 
>> Mounting from the command line prints the following:
>> 
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdg, 
>> missing codepage or helper program, or other error.
>> 
>> The following is extracted from the boot sequence recorded in the 
>> kernel ring:
>> 
>> kernel: BTRFS error: device /dev/sdd belongs to fsid 
>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
>> kernel: BTRFS error: device /dev/sdf belongs to fsid 
>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
>> kernel: BTRFS info (device sde): using crc32c (crc32c-intel) 
>> checksum algorithm
>> kernel: BTRFS info (device sde): turning on async discard
>> kernel: BTRFS info (device sde): disk space caching is enabled
>> kernel: BTRFS error (device sde): devid 7 uuid 
>> 2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
>> kernel: BTRFS error (device sde): failed to read the system array: -2
>> kernel: BTRFS error (device sde): open_ctree failed
>> mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock 
>> on /dev/sde, missing codepage or helper program, or other error.
>> systemd[1]: mnt.mount: Mount process exited, code=exited, 
>> status=32/n/a
> 
> 
> Looks like the fsid is already mounted. Could you please help check?
> 
>     cat /proc/self/mounts | grep btrfs
> 
> You could try a fresh scan and mount.
> 
>     umount  ..
>     btrfs device scan
>     mount ...
> 
> If this doesn't help. Can you share the output of:
> 
>     btrfs filesystem dump-super /dev/sd[a-g]  <-- basically all 
> devices
> 
> Thanks.


The unmount command followed by rescan does enable a successful mount, 
but the suggestion that the volume was mounted already had not been 
validated by the dump of the mount table. Based on the mount table, the 
volume appeared as unmounted even before the command.

Do you have any suggestions for how to resolve why the volume would be 
registered as having been mounted?





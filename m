Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0958CCB0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiHHReP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHReO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 13:34:14 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 10:34:12 PDT
Received: from mail-out-02.servage.net (mail-out-02.servage.net [93.90.146.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E959DBC82
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 10:34:12 -0700 (PDT)
X-Halon-ID: 2905bef0-1740-11ed-a59e-005056913d2d
Authorized-sender: u1m2114@blauwurf.info
Received: from [10.2.10.3] (firewall1a.robinson.cam.ac.uk [193.60.93.97])
        by mail-out-01.servage.net (Halon) with ESMTPSA
        id 2905bef0-1740-11ed-a59e-005056913d2d;
        Mon, 08 Aug 2022 19:33:08 +0200 (CEST)
Message-ID: <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
Date:   Mon, 8 Aug 2022 17:33:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-GB
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
From:   Michael Zacherl <mz01@bluemole.com>
In-Reply-To: <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/8/22 16:57, Chris Murphy wrote:
> mount -o ro,rescue=all
> 
> If that works you can umount and try again adding all the rescue options except idatacsums.> It's nice to have datacsum warnings (unless there's just to many errors.)

rescue=all mounts.

dmesg from   mount -o ro,rescue=usebackuproot,rescue=nologreplay,rescue=ignorebadroots /dev/mapper/luks-test /mnt :

[20680.066631] BTRFS info (device dm-1): flagging fs with big metadata feature
[20680.066641] BTRFS info (device dm-1): trying to use backup root at mount time
[20680.066646] BTRFS info (device dm-1): disabling log replay at mount time
[20680.066650] BTRFS info (device dm-1): ignoring bad roots
[20680.066652] BTRFS info (device dm-1): using free space tree
[20680.066654] BTRFS info (device dm-1): has skinny extents
[20680.072359] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[20680.072571] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[20680.073296] BTRFS info (device dm-1): enabling ssd optimizations

A brief look shows I can access data!

When also omitting nologreplay the FS wouldn't mount and dmesg shows

[20837.557120] BTRFS info (device dm-1): flagging fs with big metadata feature
[20837.557138] BTRFS info (device dm-1): trying to use backup root at mount time
[20837.557148] BTRFS info (device dm-1): ignoring bad roots
[20837.557152] BTRFS info (device dm-1): using free space tree
[20837.557156] BTRFS info (device dm-1): has skinny extents
[20837.567354] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[20837.567809] BTRFS error (device dm-1): parent transid verify failed on 334692352 wanted 14761 found 14765
[20837.569387] BTRFS info (device dm-1): enabling ssd optimizationsquite understans
[20837.569403] BTRFS info (device dm-1): start tree-log replay
[20837.637057] BTRFS error (device dm-1): parent transid verify failed on 337412096 wanted 5492 found 14764
[20837.637223] BTRFS error (device dm-1): parent transid verify failed on 337412096 wanted 5492 found 14764
[20837.656541] BTRFS error (device dm-1): parent transid verify failed on 334643200 wanted 14761 found 14765
[20837.656670] BTRFS error (device dm-1): parent transid verify failed on 334643200 wanted 14761 found 14765
[20837.656676] BTRFS: error (device dm-1: state A) in btrfs_run_delayed_refs:2151: errno=-5 IO failure
[20837.656682] BTRFS: error (device dm-1: state EA) in btrfs_replay_log:2567: errno=-5 IO failure (Failed to recover log tree)
[20837.675238] BTRFS error (device dm-1: state EA): open_ctree failed

Is this FS repairable to a usable state?

Thanks a lot, Michael.




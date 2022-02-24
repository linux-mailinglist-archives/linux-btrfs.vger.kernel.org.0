Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2B4C2F2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiBXPPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiBXPPE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 10:15:04 -0500
Received: from eu-shark2.inbox.eu (eu-shark2.inbox.eu [195.216.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECC293A16
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 07:14:33 -0800 (PST)
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id AEE311E00456;
        Thu, 24 Feb 2022 17:14:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645715671; bh=mLhlkC7mYVE+CM0J0w+cml8ahxXe62LD97H3igrahe4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=hZ/MIgZ9wkpjSpxwd+AwAsQfUTo104v85D1xtDNq8eZiQY+yWRNOJ4gwQZ6rGNbD1
         WowXTxvjOK46Go8WDqWPYMFsB5V2PPC3nZ0VswnHb5XaeGJj68/mMkcHoeft9utISD
         8eHowWEc2TaPzhwH5CMWceEwAOdyslCZ4ZhHxERk=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id A6D4D1E000BE;
        Thu, 24 Feb 2022 17:14:31 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 9Fi3Lpv8x6qN; Thu, 24 Feb 2022 17:14:31 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 4A0F51E000DC;
        Thu, 24 Feb 2022 17:14:31 +0200 (EET)
References: <20220222084207.1021-1-l@damenly.su>
 <20220224143344.GU12643@twin.jikos.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: save item data end in u64 to avoid
Date:   Thu, 24 Feb 2022 23:13:57 +0800
In-reply-to: <20220224143344.GU12643@twin.jikos.cz>
Message-ID: <7d9ks3e8.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABA82s1k3Ua26u/vYoxBagAiJPFTkYip5XRGxnW10RX+5ujkX
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Thu 24 Feb 2022 at 15:33, David Sterba <dsterba@suse.cz> wrote:

> On Tue, Feb 22, 2022 at 04:42:07PM +0800, Su Yue wrote:
>> User reported there is an array-index-out-of-bounds access 
>> while
>> mounting the crafted image:
>>
>> =======================================================================
>> [  350.411942 ] loop0: detected capacity change from 0 to 
>> 262144
>> [  350.427058 ] BTRFS: device fsid 
>> a62e00e8-e94e-4200-8217-12444de93c2e
>> devid 1 transid 8 /dev/loop0 scanned by systemd-udevd (1044)
>> [  350.428564 ] BTRFS info (device loop0): disk space caching 
>> is enabled
>> [  350.428568 ] BTRFS info (device loop0): has skinny extents
>> [  350.429589 ]
>> [  350.429619 ] UBSAN: array-index-out-of-bounds in
>> fs/btrfs/struct-funcs.c:161:1
>> [  350.429636 ] index 1048096 is out of range for type 'page 
>> *[16]'
>> [  350.429650 ] CPU: 0 PID: 9 Comm: kworker/u8:1 Not tainted 
>> 5.16.0-rc4
>> [  350.429652 ] Hardware name: QEMU Standard PC (Q35 + ICH9, 
>> 2009), BIOS
>> 1.13.0-1ubuntu1.1 04/01/2014
>> [  350.429653 ] Workqueue: btrfs-endio-meta btrfs_work_helper 
>> [btrfs]
>> [  350.429772 ] Call Trace:
>> [  350.429774 ]  <TASK>
>> [  350.429776 ]  dump_stack_lvl+0x47/0x5c
>> [  350.429780 ]  ubsan_epilogue+0x5/0x50
>> [  350.429786 ]  __ubsan_handle_out_of_bounds+0x66/0x70
>> [  350.429791 ]  btrfs_get_16+0xfd/0x120 [btrfs]
>> [  350.429832 ]  check_leaf+0x754/0x1a40 [btrfs]
>> [  350.429874 ]  ? filemap_read+0x34a/0x390
>> [  350.429878 ]  ? load_balance+0x175/0xfc0
>> [  350.429881 ]  validate_extent_buffer+0x244/0x310 [btrfs]
>> [  350.429911 ]  btrfs_validate_metadata_buffer+0xf8/0x100 
>> [btrfs]
>> [  350.429935 ]  end_bio_extent_readpage+0x3af/0x850 [btrfs]
>> [  350.429969 ]  ? newidle_balance+0x259/0x480
>> [  350.429972 ]  end_workqueue_fn+0x29/0x40 [btrfs]
>> [  350.429995 ]  btrfs_work_helper+0x71/0x330 [btrfs]
>> [  350.430030 ]  ? __schedule+0x2fb/0xa40
>> [  350.430033 ]  process_one_work+0x1f6/0x400
>> [  350.430035 ]  ? process_one_work+0x400/0x400
>> [  350.430036 ]  worker_thread+0x2d/0x3d0
>> [  350.430037 ]  ? process_one_work+0x400/0x400
>> [  350.430038 ]  kthread+0x165/0x190
>> [  350.430041 ]  ? set_kthread_struct+0x40/0x40
>> [  350.430043 ]  ret_from_fork+0x1f/0x30
>> [  350.430047 ]  </TASK>
>> [  350.430047 ]
>> [  350.430077 ] BTRFS warning (device loop0): bad eb member 
>> start: ptr
>> 0xffe20f4e start 20975616 member offset 4293005178 size 2
>> =======================================================================
>>
>> btrfs check reports:
>>   corrupt leaf: root=3 block=20975616 physical=20975616 slot=1, 
>>   unexpected
>>   item end, have 4294971193 expect 3897
>>
>> The 1st slot item offset is 4293005033 and the size is 1966160.
>> In check_leaf, we use btrfs_item_end() to check item boundary 
>> versus
>> extent_buffer data size. However, return type of 
>> btrfs_item_end() is u32.
>> (u32)(4293005033 + 1966160) == 3897, overflow happens and the 
>> result 3897
>> equals to leaf data size reasonably.
>>
>> Fix it by use u64 variable to store item data end in 
>> check_leaf() to
>> avoid u32 overflow.
>>
>> This commit does solve the invalid memory access showed by the 
>> stack trace.
>> However, its metadata profile is DUP and another copy of the 
>> leaf is fine.
>> So the image can be mounted successfully. But when umount is 
>> called,
>> the ASSERT btrfs_mark_buffer_dirty() will be trigered becase 
>> the the only node
>> in extent tree has 0 item and invalid owner. It's solved by 
>> another commit
>> "btrfs: check extent buffer owner against the owner rootid".
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215299
>> Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
>> Signed-off-by: Su Yue <l@damenly.su>
>
> Added to misc-next, thanks. The patch does not apply to older 
> stable
> kernels due to some cleanups, should be easy to backport though.

Right. Will do it.

--
Su

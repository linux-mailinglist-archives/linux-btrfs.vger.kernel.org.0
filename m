Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC76A3B4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 07:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjB0Get (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 01:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Ges (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 01:34:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C727D32D
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 22:34:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1owdyS0Trx-00aidL; Mon, 27
 Feb 2023 07:34:29 +0100
Message-ID: <6dbb0207-efc2-10eb-990c-cfea6275f09c@gmx.com>
Date:   Mon, 27 Feb 2023 14:34:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] btrfs: fix the mount crash caused by confusing return
 value
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <2de92bdcebd36e4119467797dedae8a9d97a9df3.1677314616.git.wqu@suse.com>
 <6de919ad-6576-c96d-35f1-cdf09c19dfdc@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6de919ad-6576-c96d-35f1-cdf09c19dfdc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PeiH6bzSmd3h/EgVx4GEw3vpN42UHxjaTPPMIiaaatD5RIWrxzG
 QiWn7cq4zmBkfvXT8Tz4YtsRbfS1heXhSiDwo1gayGEjSp76qwQtHf3QUDKgfERF10G5FHc
 U16wNr50HVSf+XAaCXQp1lhLIpAsLAum+WsBKXM4uhMSjRxHcS7+PI63X892Y8mDwyPUOoh
 yYt1fkdDtH5M+ZQVQ6//g==
UI-OutboundReport: notjunk:1;M01:P0:upUjEPOXcoU=;dOuk3k29OFMceHKex+66AEhHmC9
 MHpgQ+gzILhXb/4Bzk7zFU4HhfC/uE0XqDqrzK3zz26aXzfKaDeCW35YrRWpakGloMpeQpKT3
 L6tx/Q7p46XRSNv+biW1MMkA+xvrfqtdwgn6AtkfOMFp1qkBAmrOZ+rEshung+C2o8zlAGEeb
 9cWZ2JikrpYIWeGLwf0qXJVRfvifcKq18U5+nSJoAc2ltaH46i4jwc8Sk4Ix2LECj1WJke3Jm
 2vbS5oGqbJYQ+/lwelDNmvJPtksblhr/y6NCxaNx2MChX4+9OsRHrgLfkEVGAUk1b3x5t0nQT
 NWPMlurugwlAY6emR0Vd5By9t68BsivUlL4p63XeFOPT8aQIG4nZASYfzCJDVDxcvntX8gEvA
 KVCpL2XBm6EAvpadryZVVIULI045YioK2l5ndHNi+M4ADEpYIUnYRufw+ltN9bU4PESSeUybw
 8oyWhhI/cOnuq8tYBU00slRchMRXHIyduaVT6/j7DfHmL7tK9xXHSY1x/HO82jVbVraXfyVHu
 1J2tmd4KDFsajt4WVRfG3TE/tXqxH3AWRSfHCjeIQDGoTLmsgN1hEOvsHA1MfUfyfxNkhpYf+
 QnyAmnUQ+h44ErgMhwf6+JG46y4B8pDMqI3wE+BtnIgMHAl3wIBUgYrzLHsiY5y4NqtMh9MOm
 XO5XN6pK34r0RlLRFykdNRFsyh2n010iUNI6lUijYfE0OZMV8vfm5nEgYG4btnqJj91RSjvRE
 AI/Rznl0QPWArXt7cW9Q7BokF76DqTv+PsMxVrxnRwBT8MU7B86RDUh/ihdiBZrjz1OiEkCja
 wtM+kcLZ9rz5SgOlB2JbF1SRp+4OhlPEOprdQ2YAme4vCo8oMa8VIjqk0Gry3tmPTWN1YnKW7
 Rp77qrRlY1zU4Fpl81eL//3NgNsSjnExIJR7h7UKRtmeM0/TGNsj7dJRgLENxXNmj46FE/QI+
 SN0xl4xEEwrmdg1ZOrtumecifbg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/27 14:14, Anand Jain wrote:
> On 2/25/23 16:44, Qu Wenruo wrote:
>> [BUG]
>> Btrfs mount can lead to crash if the fs has critical trees corrupted:
>>
>>   # mkfs.btrfs  -f /dev/test/scratch1
>>   # btrfs-map-logical -l 30588928 /dev/test/scratch1 # The bytenr is 
>> tree root
>>   mirror 1 logical 30588928 physical 38977536 device /dev/test/scratch1
>>   mirror 2 logical 30588928 physical 307412992 device /dev/test/scratch1
>>   # xfs_io -f -c "pwrite 38977536 4" -c "pwrite 307412992 4" 
>> /dev/test/scratch1
>>   # mount /dev/test/scratch1 /mnt/btrfs
>>
>> And the above mount would crash with the following dmesg:
>>
>>   BTRFS warning (device dm-4): checksum verify failed on logical 
>> 30588928 mirror 1 wanted 0xcdcdcdcd found 0x6ca45898 level 0
>>   BTRFS warning (device dm-4): checksum verify failed on logical 
>> 30588928 mirror 2 wanted 0xcdcdcdcd found 0x6ca45898 level 0
>>   BTRFS warning (device dm-4): couldn't read tree root
>>   ==================================================================
>>   BUG: KASAN: null-ptr-deref in btrfs_iget+0x74/0x160 [btrfs]
>>   Read of size 8 at addr 00000000000001f7 by task mount/4040
>>
>> [CAUSE]
>> In open_ctree(), we have two variables to indicates errors: @ret and
>> @err.
>>
>> Unfortunately such confusion leads to the above crash, as in the error
>> handling of load_super_root(), we just goto fail_tree_roots label, but
>> at the end of error handling, we return @err instead of @ret.
>>
>> Thus even we failed to load tree root, we still return 0 for
>> open_ctree(), thus later btrfs_iget() would fail.
> 
> 
>   There are many child functions in open_ctree() that rely on the default
>   value of @err, which is -EINVAL, to return an error instead of ret.

That's even more bug prone.

After the first call site assigning @err, there is no more default value 
for @err.

And this is not the first bug involving two error indicating numbers.
Thus unless definitely needed, I strongly recommend not to use two error 
values.

Thanks,
Qu

> 
>   The decoupling of @ret and the actual error returned by open_ctree()
>   is intentional. IMO.
> 
>   However, the bug is that btrfs_init_btree_inode() return value is
>   assigned to @err instead of @ret.
> 
>   ret = btrfs_init_btree_inode(sb);
> 
>   And the regression is caused by the following commit:
> 
>   commit 097421116e288dd3f5baaf1dd7e86035db60336f
>    btrfs: move all btree inode initialization into btrfs_init_btree_inode
> 
>   This commit is still in misc-next. We can fold a fix as below:
> 
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 48368d4bc331..0e0c30fe6df6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3360,9 +3360,11 @@ int __cold open_ctree(struct super_block *sb, 
> struct btrfs_fs_devices *fs_device
>                  goto fail;
>          }
> 
> -       err = btrfs_init_btree_inode(sb);
> -       if (err)
> +       ret = btrfs_init_btree_inode(sb);
> +       if (ret) {
> +               err = ret;
>                  goto fail;
> +       }
> 
>          invalidate_bdev(fs_devices->latest_dev->bdev);
> 
> 

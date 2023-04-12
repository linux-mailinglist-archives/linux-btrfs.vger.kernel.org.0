Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D36DE979
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDLCeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 22:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLCeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 22:34:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B14225
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 19:34:35 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1qYSfH0h8s-00vvPE; Wed, 12
 Apr 2023 04:34:21 +0200
Message-ID: <a9290e40-8b99-7c8e-2bc7-3206bf041efe@gmx.com>
Date:   Wed, 12 Apr 2023 10:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Content-Language: en-US
To:     Neal Gompa <neal@gompa.dev>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
 <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8yzjBuQ7ZPynOY9gh66OZqr/PgtsMwekhf701E/IucmYDUz/IM/
 zYfWtMdPPbw1hAOL/QyLEQbV1+PuyKKnc3lcIfb21ArKqC8AUNg8e7R1mBK3vhn4AYlbBEi
 Wnv1LaCi+Yg+YSK0pzGWXAd4Vy2h3k2QxCiE+f6mI6S6uh/17bvQjC10hO/8myeAM3+THnK
 NBG+41k2S1RjAQf+pDLNA==
UI-OutboundReport: notjunk:1;M01:P0:4OFq+pR82sE=;sCWbLqy6iuDMQzDv7/WUSuGIr94
 NAcWz0SFKDJTWBiTTw3V5KW8OdQT83L6HS6/tq/QppTpOEURCWdC3wzQDMB7PwWIcIYEpBrsa
 vh0EeDXfsTFddwR/akZ9iimOIpJE+W2SR09dU+Ryo5hLM4p6H4ZuuvzHz5Qz8j8Q/gBVGinXs
 cIrWhFJrH65I6jdarwuCeRfDyn6unv9whDa6XohNug1FoaRPhiex67o062AuFZtcZ1tCduNI0
 +mMWXgrpeRR1mabnWMIuwqQjTx2g3cRvRg6ElUih/BNm2zEyfCxgQtdBTnO0qdrRuE9NYvIsf
 RmyiuOAP1YBxqslLopqrS4i8Et4R7ScWIgeVDNUuvZ/5OcqWv4cxfGz5HbpeZm5vuVq94CjFW
 sNba5R2siAA8XvOvJarZdyvoqaYbbMsAOBECxcvNAP8wtKIa42AJSU1OUhE2e0riS6Bklx58Z
 XqSnhdMxKGr86mOiycaufuB0zm9UCfuxuzOuooj8MbIpBmQykE/65dEN4qHrr//3AVGrfiRV3
 xSmaRw3+7gJw5xAJRjUskRHGuqc2VLSmUiBD5MAJs8K9tlYLJdkDGsP5v4ruKBkjpS2wEk0P2
 Wp5ps/e6RajOOzNGQIEGkfImNkzQxjt2Lcw7QRC38TCKllrRlzjYTZgjSSmr6MyyYeYDe9OgR
 d3BJ3PLqhxo3yN/OD5+1u9GQ8KIoG44u+nNbAlQQ0eJWJ0pB53nthqcYN7angr8X6SHA1ls/w
 mBB5Ee3gUkgJbKEhHhkCcLEtPPmoAeoDPje19lvtODWs/kAP1Pa6jZ2Z9ljbVdZS5ZEyGoNRI
 CjYpVg4R0440IK31VPwQQiVU65Xq7+v734Ec4W5t9fTk5icRLjg/JKkvuFuxVZfeHb+8kDovF
 Iaj8YFiwtu7RygkrFuiUUZxOEtGRCe1NMRuT46WISQpAEiC3cVSOpjdtkZJIxUIZgOkx7DPEM
 Mhmxve3+e57eoTHkPV/ahHlKLKg=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/12 09:45, Neal Gompa wrote:
> On Tue, Apr 11, 2023 at 3:22 PM Sweet Tea Dorminy
> <sweettea-kernel@dorminy.me> wrote:
>>
>> Recently a Meta-internal workload encountered subvolume creation taking
>> up to 2s each, significantly slower than directory creation. As they
>> were hoping to be able to use subvolumes instead of directories, and
>> were looking to create hundreds, this was a significant issue. After
>> Josef investigated, it turned out to be due to the transaction commit
>> currently performed at the end of subvolume creation.
>>
>> This change improves the workload by not doing transaction commit for every
>> subvolume creation, and merely requiring a transaction commit on fsync.
>> In the worst case, of doing a subvolume create and fsync in a loop, this
>> should require an equal amount of time to the current scheme; and in the
>> best case, the internal workload creating hundreds of subvols before
>> fsyncing is greatly improved.
>>
>> While it would be nice to be able to use the log tree and use the normal
>> fsync path, logtree replay can't deal with new subvolume inodes
>> presently.
>>
>> It's possible that there's some reason that the transaction commit is
>> necessary for correctness during subvolume creation; however,
>> git logs indicate that the commit dates back to the beginning of
>> subvolume creation, and there are no notes on why it would be necessary.
>>
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>> ---
>>   fs/btrfs/ioctl.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 25833b4eeaf5..a6f1ee2dc1b9 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -647,6 +647,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>>          }
>>          trans->block_rsv = &block_rsv;
>>          trans->bytes_reserved = block_rsv.size;
>> +       /* tree log can't currently deal with an inode which is a new root */
>> +       btrfs_set_log_full_commit(trans);
>>
>>          ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
>>          if (ret)
>> @@ -755,10 +757,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>>          trans->bytes_reserved = 0;
>>          btrfs_subvolume_release_metadata(root, &block_rsv);
>>
>> -       if (ret)
>> -               btrfs_end_transaction(trans);
>> -       else
>> -               ret = btrfs_commit_transaction(trans);
>> +       btrfs_end_transaction(trans);
>>   out_new_inode_args:
>>          btrfs_new_inode_args_destroy(&new_inode_args);
>>   out_inode:
>> --
>> 2.40.0
>>
> 
> Wouldn't the consequence of this mean that we lose some guarantees
> around subvolume creation? That is, without it being committed, we
> would have a window in which the subvolume and data can be written
> without being written to disk? If so, how large is that window?

That can be avoided in btrfs-progs, by adding some -C|-c options just 
like subvolume deletion to ensure the case.


If you're really concern about the window size, it's no smaller than 
commit interval (by default 30s).


But that's not the full story, if you do fsync() on any inode of the new 
subvolume, it should cause a full commit transaction, which would write 
every needed metadata, including the subvolume itself, to the disk.

So the end result is, you don't really need to bother the subvolume 
itself, just do your usual fsync() work on the inode you're really 
concerned, no need to bother the subvolume itself.

Thanks,
Qu

> 
> 

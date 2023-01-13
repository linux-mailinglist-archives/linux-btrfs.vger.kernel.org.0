Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4730D6693A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 11:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjAMKGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 05:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAMKGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 05:06:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2B1BEA8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 02:06:42 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1p0OGQ3pu2-00JMEQ; Fri, 13
 Jan 2023 11:06:37 +0100
Message-ID: <92b702ba-8323-7acd-6e41-a307387325d9@gmx.com>
Date:   Fri, 13 Jan 2023 18:06:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] btrfs: update fs features sysfs directory
 asynchronously
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <86ceb095fdfec9fe86dfb8efdd354a298fb685ff.1673583926.git.wqu@suse.com>
 <60287dfa-10bc-0e29-c152-5facaf548065@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <60287dfa-10bc-0e29-c152-5facaf548065@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fmjIn+jkgO7V06SZG7eqEgerb6iL1Od7RaY/R0MK9Jl92Tufcc0
 fywqQC0Kw5GmYdIEVTywNWGTf5IrK/q4Nl0ETG8DZkko/4x0gsOYCtxvDzrZBlwwFLbQBcs
 4kdxSl2+ZAWavYg4/41jPX+T7fhNIPec2vroBrKJrJSo3hmxjpUkCjxZmhFzK4DjV5pK+qe
 Gt/9ycSlT8p4GkI46tzQQ==
UI-OutboundReport: notjunk:1;M01:P0:1e2FH9MXcVc=;nUJaZIhtvQ/JgnyhRBGfHZ6iUCz
 0oWyLzTwPq6qW+kpQEl8K7I45Mi4z+CgVv5TEd9oscZXihW8TfLcHKWPPANKaD1/yz7b2UQC8
 U/CTlLDSbBx2jXOV5jl//M5RBSmM/Kx/1MewfKg1vQ9mK3FhpSz+dcEdcUZKUHqwKe3zie25V
 0tU+w6o4sd4nBXKAeiaJZkMR86mAZnPXJkuHzBBAz33R3uPKu6yep6dwkndmHXs8Da2xzSbcs
 4ScVHe+B9MWF+h9ztm5hkkqbUve9VmMKDFSB2/k0hKIQkKK7wPDqVuvo0Gtm/m+EynovWSZJ1
 IwOW5VFBoquet2mbfzzwpVUdmZAvdpjwfoqcXZSQeyz9qBctj8thKzX8DWRzHWsTj1Q/2dcex
 gJfUiCUfrkVvVfAh9FQSaHeBO4NEKVdffZRClhbUdfr8brUPwzgM5Lpiw0Cg6gUsulDSUVsGk
 jPfo7gHDtACSX3yUmuNUuDBoqVw1BLXWve/UZimDiahKscGz/sr84PC2ONT8qsHX7wcpK45rB
 cQiLKOyxGPgqZe3TPw6jvNsWVqOcPpzIRnWtZDiik5vBaZOUt3I5AWaldSgauV7s9cDs0mPD6
 yN7YfFZ4eaiMQLsy0JA1PDQbjUC/KPLnqY5Ltbgb/BHGUYX2am5QIwFfajwAO84ZVmFFz7mCC
 aj3voPScOaSGpts0cNwyQ5Uc7OJg8PhMdJDjFmolE1dH4OEnYe4wC1SCLhkx2Op2RIaHlijb9
 nF5Kef7yixd3MKTrEL/tj4sshjqgQO7WHkmO3hHe/KvvD5DpV1GCNAT4POLUMbNWqRcTjJNvq
 U0GeHsAMUibgcqxrJEy5YPjwNKVV3z5uxKH8/ykOGiDrUWzSvqJUmzESePBgELed1QqVYIcv1
 4v0kDTlRBA62S+Pe8WAPemgpRXS0Y7Vmyi9OMktw0EEB0BRLcEFDPxopDVbCoBS3lS+70yjET
 me6KTxjfjFe7nhmeNIpCmgo6jvk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/13 17:24, Anand Jain wrote:
[...]
>>           spin_lock(&fs_info->super_lock);
>>           features = btrfs_super_incompat_flags(disk_super);
>>           if (!(features & flag)) {
>> @@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info 
>> *fs_info, u64 flag,
>>           }
>>           spin_unlock(&fs_info->super_lock);
>>       }
>> +    return changed;
>>   }
> 
> 
>   Why not something like below
> 
>   if there is something changed
>   ::
>      set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags)
> 
>   and return void.

That indeed sounds better.
> 
> 
> 
[...]
>> +    if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
>> +        fs_info->cleaner_kthread)
>> +        wake_up_process(fs_info->cleaner_kthread);
>> +
> 
> Why not just wake cleaner_kthred at the end of super writes if 
> successful? Would it be too delayed?

Because at UNBLOCKED state, it's no difference, no matter if it's at 
super writeback or just like this timing.

In fact, doing it earlier is better, as it makes us to have higher 
chance to get the update reflected before btrfs_commit_transaction() to 
return.

> 
> And
> 
> How does it behave in simultaneous or consecutive feature change 
> requests? Would it be consistent?

The change only happens at cleaner thread (which is either woken at the 
interval, or woken up by the commit transaction).

And the update itself is checking all features, thus even if there is 
concurrency, either we updated multiple changes at once, or the change 
missed the current transaction and went to the next one.

> 
> 
> 
>>       ret = btrfs_write_and_wait_transaction(trans);
>>       if (ret) {
>>           btrfs_handle_fs_error(fs_info, ret,
>>
> 
> -Anand
> 
> 

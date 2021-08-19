Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F73F1386
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 08:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhHSG2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 02:28:18 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:36464 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhHSG2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 02:28:17 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 24FC61E00597;
        Thu, 19 Aug 2021 09:27:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629354460; bh=W6H7IldJZiMFgyFodbVWks9d1b/NVu7Wls5WnpktkA4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=Xh4TAGH6PZuQKl0CyA078zccJMCNgV0k7PSpNp4bMoHNwIoJdLOsSUwwrgFhiOPAx
         7pY9DmQtIoZD4Yv8GwwF+hZx7MPC5LaiNT2ZLvwLuSSYqk9pMC+8eb6WBzYd/IcmUq
         EnCL5w1cW7RTH48jIiK5RD8nKH3Blx42SzFq4mw8=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1932D1E0075C;
        Thu, 19 Aug 2021 09:27:40 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id IG8_gJ1GDBFV; Thu, 19 Aug 2021 09:27:39 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 800D11E00597;
        Thu, 19 Aug 2021 09:27:39 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 1A0CA1BE00AB;
        Thu, 19 Aug 2021 09:27:37 +0300 (EEST)
References: <20210818041944.5793-1-l@damenly.su>
 <1b42b3aa-0363-36ad-df5c-4d9d86b8cc97@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V2] btrfs: traverse seed devices if fs_devices::devices
 is empty in show_devname
Date:   Thu, 19 Aug 2021 14:18:28 +0800
Message-ID: <4kbmez1p.fsf@damenly.su>
In-reply-to: <1b42b3aa-0363-36ad-df5c-4d9d86b8cc97@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1qoXX3bGwE0sS5BQI+R9ua80BxblHj7NSiYDTsAI26r/x97T2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 18 Aug 2021 at 14:48, Anand Jain <anand.jain@oracle.com> 
wrote:

> On 18/08/2021 12:19, Su Yue wrote:
>> while running btrfs/238 in my test box, the following warning 
>> occurs
>> in high chance:
>>
>> ------------[ cut here  ]------------
>> WARNING: CPU: 3 PID: 481 at fs/btrfs/super.c:2509 
>> btrfs_show_devname+0x104/0x1e8 [btrfs]
>> CPU: 2 PID: 1 Comm: systemd Tainted: G        W  O 
>> 5.14.0-rc1-custom #72
>> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>> Call trace:
>>    btrfs_show_devname+0x108/0x1b4 [btrfs]
>>    show_mountinfo+0x234/0x2c4
>>    m_show+0x28/0x34
>>    seq_read_iter+0x12c/0x3c4
>>    vfs_read+0x29c/0x2c8
>>    ksys_read+0x80/0xec
>>    __arm64_sys_read+0x28/0x34
>>    invoke_syscall+0x50/0xf8
>>    do_el0_svc+0x88/0x138
>>    el0_svc+0x2c/0x8c
>>    el0t_64_sync_handler+0x84/0xe4
>>    el0t_64_sync+0x198/0x19c
>> ---[ end trace 3efd7e5950b8af05  ]---
>>
>
>> It's also reproducible by creating a sprout filesystem and 
>> reading
>> /proc/self/mounts in parallel.
>
>   ok. This explains.
>
>>
>> The warning is produced if btrfs_show_devname() can't find any 
>> available
>> device in fs_info->fs_devices->devices which is protected by 
>> RCU.
>
>
>> The warning is desirable to exercise there is at least one 
>> device in the
>> mounted filesystem. However, it's not always true for a 
>> sprouting fs.
>
>
> Right. When the code is running from line 2596 (including) until 
> line
> 2607, there are chances that the fs_info->fs_devices->devices 
> list is
> empty. Or those devices are moving to 
> fs_info->fs_devices->seed_list.
>
>
> 2596                 ret = btrfs_prepare_sprout(fs_info);
> 2597                 if (ret) {
> 2598                         btrfs_abort_transaction(trans, 
> ret);
> 2599                         goto error_trans;
> 2600                 }
> 2601         }
> 2602
> 2603         device->fs_devices = fs_devices;
> 2604
> 2605         mutex_lock(&fs_devices->device_list_mutex);
> 2606         mutex_lock(&fs_info->chunk_mutex);
> 2607         list_add_rcu(&device->dev_list, 
> &fs_devices->devices);
>
>
>>
>> While a new device is being added into fs to be sprouted, call 
>> stack is:
>>   btrfs_ioctl_add_dev
>>    btrfs_init_new_device
>>      btrfs_prepare_sprout
>>        list_splice_init_rcu(&fs_devices->devices, 
>>        &seed_devices->devices,
>>        synchronize_rcu);
>>      list_add_rcu(&device->dev_list, &fs_devices->devices);
>>
>> Looking at btrfs_prepare_sprout(), every new RCU reader will 
>> read a
>> empty fs_devices->devices once synchronize_rcu() is called.
>> After commit 4faf55b03823 ("btrfs: don't traverse into the seed 
>> devices
>> in show_devname"), btrfs_show_devname() won't looking into
>> fs_devices->seed_list even there is no device in 
>> fs_devices->devices.
>>
>> And since commit 88c14590cdd6 ("btrfs: use RCU in 
>> btrfs_show_devname for
>> device list traversal"), btrfs_show_devname() only uses RCU 
>> without mutex
>> lock taken for device list traversal. The function read an 
>> empty
>> fs_devices->devices and found no device in the list then 
>> triggers the
>> warning. The commit just enlarged the window that the fs device 
>> list
>> could be empty. Even btrfs_show_devname() uses mutex_lock(), 
>> there is a
>> tiny chance to read an empty devices list between 
>> mutex_unlock() in
>> btrfs_prepare_sprout() and next mutex_lock() in 
>> btrfs_init_new_device().
>>
>> So take device_list_mutex then traverse fs_devices->seed_list 
>> to seek
>> for a seed device if no device was found in 
>> fs_devices->devices.
>> Since a normal fs always has devices in fs_device->devices and 
>> the
>> window is small enough, the mutex lock is not too heavy.
>>
>> Signed-off-by: Su Yue <l@damenly.su>
>>
>> ---
>> Changelog:
>> v2:
>>      Try to traverse fs_devices->seed_list instead of removing 
>>      the
>>        WARN_ON().
>>      Change the subject.
>>      Add description of fix.
>> ---
>>   fs/btrfs/super.c | 41 
>>   ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index d07b18b2b250..31e723eb2ccf 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2482,7 +2482,9 @@ static int btrfs_unfreeze(struct 
>> super_block *sb)
>>   static int btrfs_show_devname(struct seq_file *m, struct 
>>   dentry *root)
>>   {
>>   	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
>> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>   	struct btrfs_device *dev, *first_dev = NULL;
>> +	struct btrfs_fs_devices *seed_devices;
>>
>>   	/*
>>   	 * Lightweight locking of the devices. We should not need
>> @@ -2492,7 +2494,7 @@ static int btrfs_show_devname(struct 
>> seq_file *m, struct dentry *root)
>>   	 * least until the rcu_read_unlock.
>>   	 */
>>   	rcu_read_lock();
>> -	list_for_each_entry_rcu(dev, 
>> &fs_info->fs_devices->devices, dev_list) {
>> +	list_for_each_entry_rcu(dev, &fs_devices->devices, 
>> dev_list) {
>>   		if (test_bit(BTRFS_DEV_STATE_MISSING, 
>>   &dev->dev_state))
>>   			continue;
>>   		if (!dev->name)
>> @@ -2503,9 +2505,42 @@ static int btrfs_show_devname(struct 
>> seq_file *m, struct dentry *root)
>>
>>   	if (first_dev)
>>   		seq_escape(m, rcu_str_deref(first_dev->name), " 
>>   \t\n\\");
>> -	else
>> -		WARN_ON(1);
>>   	rcu_read_unlock();
>> +
>> +	if (first_dev)
>> +		return 0;
>> +
>> +	/*
>> +	 * While the fs is sprouting, above fs_devices->devices 
>> could be empty
>> +	 * if the RCU read happened in the window between when
>> +	 * fs_devices->devices was spliced into 
>> seed_devices->devices in
>> +	 * btrfs_prepare_sprout() and new device is not added to
>> +	 * fs_devices->devices in btrfs_init_new_device().
>> +	 *
>> +	 * Take device_list_mutex to make sure seed_devices has 
>> been added into
>> +	 * fs_devices->seed_list then we can traverse it.
>> +	 */
>> +	mutex_lock(&fs_devices->device_list_mutex);
>
>
> possible fix:
>   As the problem is from line 2596 to 2607 (above) can we move
>      list_add_rcu(&device->dev_list, &fs_devices->devices);
>   into btrfs_prepare_sprout() so that it shall reduce the racing 
>   window.
>
Oh..no. It should not work after doing some code pastes.
btrfs_show_devname(), the RCU reader doesn't take the mutex lock.
So there is always a short peroid between the list_add_rcu() and 
the
list_splice_init_rcu() updaters. Or is there another adavnaced RCU 
API?

Thanks.

--
Su

> And,
>   We have learned that taking device_list_mutex in this thread 
>   will end
>   up with a lockdep warning. We might need a new fs_info state 
>   to
>   indicate that FS is sprouting.
>
> Thanks, Anand
>
>> +	list_for_each_entry(seed_devices, &fs_devices->seed_list, 
>> seed_list) {
>> +		list_for_each_entry(dev, &seed_devices->devices, 
>> dev_list) {
>> +			if (test_bit(BTRFS_DEV_STATE_MISSING, 
>> &dev->dev_state))
>> +				continue;
>> +			if (!dev->name)
>> +				continue;
>> +			if (!first_dev || dev->devid < first_dev->devid)
>> +				first_dev = dev;
>> +		}
>> +	}
>> +
>> +	if (first_dev) {
>> +		rcu_read_lock();
>> +		seq_escape(m, rcu_str_deref(first_dev->name), " 
>> \t\n\\");
>> +		rcu_read_unlock();
>> +	} else {
>> +		WARN_ON(1);
>> +	}
>> +	mutex_unlock(&fs_devices->device_list_mutex);
>> +
>>   	return 0;
>>   }
>>
>>

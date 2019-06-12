Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445D742860
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436921AbfFLOGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:06:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:32811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436899AbfFLOGI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560348356;
        bh=Dx13+ITLVRFMc/UVnQED7iPvBunOfMJnTlHJDTi+nZY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kKULCoe7Hg1eOiHb0q0zGV95ggxCyP+7PKFz1mU4wq8pQGvLBZS+HIAL9drFIy3j+
         hYQTs//8+usO3xFpwobsxXtIJJkgL6AhWFRnkSI0VhPpOXqBXiwlqWjofkXaaWHygX
         U5tl6+Nfx0o228EvQIxYIsx8l4hRFOa+QNcQlG0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1iYxlx3IRX-00yOEd; Wed, 12
 Jun 2019 16:05:56 +0200
Subject: Re: [PATCH] btrfs: qgroup: Don't hold qgroup_ioctl_lock in
 btrfs_qgroup_inherit()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20190612075745.25024-1-wqu@suse.com>
 <20190612135324.GJ3563@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <225c5141-c7d4-83ab-89a1-bd341fe8ece4@gmx.com>
Date:   Wed, 12 Jun 2019 22:05:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612135324.GJ3563@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O003AyECLYTSgygle+oTULfqnBuLOYdElkHxiKt76I0bRusp1tA
 RdcdCmg3h/2M8FULGjSngrtFL3cHniHxgotbsqUgjuPwOjVcHCU2A+ZLr/WNM3TNMjfHEJw
 UnELSFb3uOahUBZNnCpwr0ZYcMiZIsAQCgb86v8/8YTIdfe3DhCTjPT//Otf4T0Tk5+Fjni
 zNROvI2TMb+sOul/xLmxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y1yejX5m9MU=:2dutaX0M8q1CxydxjNdEry
 2CzodyFEhw/MRjyQ5goRMVXMahrQc51UZGY/AdOZlTSf4rGtJFycYhhKgLmaafVhh1+s43Mxt
 SM6SS4eDUT6rMM8hdIqAXQX8MgYrY1+5jRUQrbXqQU05SdINS1f+7w3ejhZqK+dnTwefD6uCC
 LsVlqK4R2MOyjuubCmEUWMrkOR3NuXiK4GV1YDo+Wcgo3nyb+RbXWdl98PuCE9wN+Dr8GJqur
 tf2tkLQ4kyvKnEUjj2VIyMMgEfcnSZ6LjDXzl4O5b1GrAqYxzO1s0ihQOHDyZPnKgPMzXM8SJ
 csQ1K/gK/1HAibwOz/CQniIR41+S6qTlCRCFP75nOh2OxZ6akKOriLHI36fcicqRWvzblv9QQ
 FR8aLBX6q5ap4MmGv43VRwfqB/8LQaJnGIOecv9qsvNoQ2UUzPRhbI3yAffoJcVgstFYFoczZ
 VL0IeNo8/czzl6MHYedjIc4ODtL1Ika+ggkH4DW9wX/Nou3Vjk2nmcLMvL2nr5TB1lxGSTead
 6WL6g5EDJcjmRYZnxsbRFH+y6Z0Q3k+I7csIAqYI+RtF4dTOIOe12eN0KsZwLeaQhTuCcoQHZ
 QOHt8DVAAdU/bk3PzzUE6cm8fU9gwI/BzxY3NYTp4HDZO7pcl/M4H1tbnyD09l57LVjwawUr7
 pDEpoG5Do+pePRcDJjTh/GKvLXzfHOu6fDO0YWSRtcLUGBAPnvcx6or3gwON2ZtplTPH1JT1i
 q+Cbbak+SH7hV4Q2f7u9Ve3LOlyK/zB2p0LLivdYQG5qk0MSGsw3DTeD9/widQFnivWOHPlbh
 bkhYN+k58q79c+5WlHnBUsVM2r2Qh5duF3RxSN8/P6XLBKoyUJPMmlNVc7wlwPZdzELOoaqUf
 Q/UgFw3skitOavff71hOGmcrv/MuPMIia1uYfNrOL7FSoAeeq/tL7T24XI9uDOg6ZFTmr4iMp
 BwrZ7OqJLboqdCR8FEk/awv9RYtcoCLEbVHOvy3VxAm+dupupWTKo
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/12 =E4=B8=8B=E5=8D=889:53, David Sterba wrote:
> On Wed, Jun 12, 2019 at 03:57:45PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Lockdep will report the following circular locking dependency:
>>
>>   WARNING: possible circular locking dependency detected
>>   5.2.0-rc2-custom #24 Tainted: G           O
>>   ------------------------------------------------------
>>   btrfs/8631 is trying to acquire lock:
>>   000000002536438c (&fs_info->qgroup_ioctl_lock#2){+.+.}, at: btrfs_qgr=
oup_inherit+0x40/0x620 [btrfs]
>>
>>   but task is already holding lock:
>>   000000003d52cc23 (&fs_info->tree_log_mutex){+.+.}, at: create_pending=
_snapshot+0x8b6/0xe60 [btrfs]
>>
>>   which lock already depends on the new lock.
>>
>>   the existing dependency chain (in reverse order) is:
>>
>>   -> #2 (&fs_info->tree_log_mutex){+.+.}:
>>          __mutex_lock+0x76/0x940
>>          mutex_lock_nested+0x1b/0x20
>>          btrfs_commit_transaction+0x475/0xa00 [btrfs]
>>          btrfs_commit_super+0x71/0x80 [btrfs]
>>          close_ctree+0x2bd/0x320 [btrfs]
>>          btrfs_put_super+0x15/0x20 [btrfs]
>>          generic_shutdown_super+0x72/0x110
>>          kill_anon_super+0x18/0x30
>>          btrfs_kill_super+0x16/0xa0 [btrfs]
>>          deactivate_locked_super+0x3a/0x80
>>          deactivate_super+0x51/0x60
>>          cleanup_mnt+0x3f/0x80
>>          __cleanup_mnt+0x12/0x20
>>          task_work_run+0x94/0xb0
>>          exit_to_usermode_loop+0xd8/0xe0
>>          do_syscall_64+0x210/0x240
>>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>>   -> #1 (&fs_info->reloc_mutex){+.+.}:
>>          __mutex_lock+0x76/0x940
>>          mutex_lock_nested+0x1b/0x20
>>          btrfs_commit_transaction+0x40d/0xa00 [btrfs]
>>          btrfs_quota_enable+0x2da/0x730 [btrfs]
>>          btrfs_ioctl+0x2691/0x2b40 [btrfs]
>>          do_vfs_ioctl+0xa9/0x6d0
>>          ksys_ioctl+0x67/0x90
>>          __x64_sys_ioctl+0x1a/0x20
>>          do_syscall_64+0x65/0x240
>>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>>   -> #0 (&fs_info->qgroup_ioctl_lock#2){+.+.}:
>>          lock_acquire+0xa7/0x190
>>          __mutex_lock+0x76/0x940
>>          mutex_lock_nested+0x1b/0x20
>>          btrfs_qgroup_inherit+0x40/0x620 [btrfs]
>>          create_pending_snapshot+0x9d7/0xe60 [btrfs]
>>          create_pending_snapshots+0x94/0xb0 [btrfs]
>>          btrfs_commit_transaction+0x415/0xa00 [btrfs]
>>          btrfs_mksubvol+0x496/0x4e0 [btrfs]
>>          btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>>          btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>>          btrfs_ioctl+0xa90/0x2b40 [btrfs]
>>          do_vfs_ioctl+0xa9/0x6d0
>>          ksys_ioctl+0x67/0x90
>>          __x64_sys_ioctl+0x1a/0x20
>>          do_syscall_64+0x65/0x240
>>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>>   other info that might help us debug this:
>>
>>   Chain exists of:
>>     &fs_info->qgroup_ioctl_lock#2 --> &fs_info->reloc_mutex --> &fs_inf=
o->tree_log_mutex
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(&fs_info->tree_log_mutex);
>>                                  lock(&fs_info->reloc_mutex);
>>                                  lock(&fs_info->tree_log_mutex);
>>     lock(&fs_info->qgroup_ioctl_lock#2);
>>
>>    *** DEADLOCK ***
>>
>>   6 locks held by btrfs/8631:
>>    #0: 00000000ed8f23f6 (sb_writers#12){.+.+}, at: mnt_want_write_file+=
0x28/0x60
>>    #1: 000000009fb1597a (&type->i_mutex_dir_key#10/1){+.+.}, at: btrfs_=
mksubvol+0x70/0x4e0 [btrfs]
>>    #2: 0000000088c5ad88 (&fs_info->subvol_sem){++++}, at: btrfs_mksubvo=
l+0x128/0x4e0 [btrfs]
>>    #3: 000000009606fc3e (sb_internal#2){.+.+}, at: start_transaction+0x=
37a/0x520 [btrfs]
>>    #4: 00000000f82bbdf5 (&fs_info->reloc_mutex){+.+.}, at: btrfs_commit=
_transaction+0x40d/0xa00 [btrfs]
>>    #5: 000000003d52cc23 (&fs_info->tree_log_mutex){+.+.}, at: create_pe=
nding_snapshot+0x8b6/0xe60 [btrfs]
>>
>> [CAUSE]
>> Due to the delayed subvolume creation, we need to call
>> btrfs_qgroup_inherit() inside commit transaction code, with a lot of
>> other mutex hold.
>> This hell of lock chain can lead to above problem.
>>
>> [FIX]
>> On the other hand, we don't really need to hold qgroup_ioctl_lock if
>> we're in the context of create_pending_snapshot().
>> As in that context, we're the only one being able to modify qgroup.
>>
>> All other qgroup functions which needs qgroup_ioctl_lock are either
>> holding a transaction handle, or will start a new transaction:
>>   Functions will start a new transaction():
>>   * btrfs_quota_enable()
>>   * btrfs_quota_disable()
>>   Functions hold a transaction handler:
>>   * btrfs_add_qgroup_relation()
>>   * btrfs_del_qgroup_relation()
>>   * btrfs_create_qgroup()
>>   * btrfs_remove_qgroup()
>>   * btrfs_limit_qgroup()
>>   * btrfs_qgroup_inherit() call inside create_subvol()
>>
>> So we have a higher level protection provided by transaction, thus we
>> don't need to always hold qgroup_ioctl_lock in btrfs_qgroup_inherit().
>>
>> Only the btrfs_qgroup_inherit() call in create_subvol() needs to hold
>> qgroup_ioctl_lock, while the btrfs_qgroup_inherit() call in
>> create_pending_snapshot() is already protected by transaction.
>>
>> So the fix is to manually hold qgroup_ioctl_lock inside create_subvol()
>> while skip the lock inside create_pending_snapshot.
>
> Would it be possible to add that as a run-time assertion? Eg. check the
> state of the transaction if it's inside commit, and if not then check
> the locks?
>

Oh, that's a much better solution!

Thank you very much for the hint,
Qu

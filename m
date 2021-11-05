Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C764463F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKENTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 09:19:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:53555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhKENTG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 09:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636118176;
        bh=LbtuZVSyPZbfGEFwVAPtZ9xDFh5GRJnkd1nnD9PtQGE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HwTc5el3faf4ggoh+y16Z3bsvKTwNxuboUsHBqV+bQIHLURVmAjpqOSNvU5BuRnIf
         9qLr3rVVmr4l+iTe/bVdOxN0XjpUOPnhPUqqNDQyjlN8S69kQsjqmbet2WI+duhE+f
         bufgH8+C3UHsD1BsqlEY9M7UZKTn6J70OMP8mJsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJqN-1mNNZk2OxP-00nROI; Fri, 05
 Nov 2021 14:16:16 +0100
Message-ID: <e1651d3b-e556-9f12-18f0-1d5728f33bb7@gmx.com>
Date:   Fri, 5 Nov 2021 21:16:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: btrfs reflink take too long time(21s)
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20211103184134.631B.409509F4@e16-tech.com>
 <20211105210854.9367.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211105210854.9367.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vsWMGs11a9j3/tjdPPnfN5Puv4MVN3IqYUpXEG35S04SEQMTVqE
 9WPLot0LkOTOSRujZCDAHw2EbTqba7cIVV1KHgSWxVKOahPqd7lhUBVTi+w8I6zUFy3ljlG
 RwWpw5HATzI5Fm0epNlTPu9jS8KExQNUv7pTPpn5yFU0uLzMsxgvoPC1rS88vFNUwoI4Ekw
 /nsvLHwkG9Amgjsh+/rxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RC4jAhVJ9D4=:5o4mtWl6x4AQI2ZSE92nml
 1vJKIC9U/DkSksQsbCCt4aTTzxlDti8Mrr54f4a+8Q4plaMlD3WCiRpFPZhyDNmSQA8YR3vmI
 6PbqctPnFURDDiKddo1IjkyVUAxybuB3iTurKeIHVkMp1b9IGQz8O6t3LqbPH7bIiWaUtU5z7
 NDFqnKa+1OBhviLWGB1xpsKoe+GiyhDA0YuMK10+hnz4qRyCjD66Ja+zZtz6MO3TmPhgM3Qwo
 mESSWT8F5aqrxhMXCVF8MRn78VdSB8b9K1Rp6VHPCjFRW3RAsS7fyUeLG+NEPQrbfK0gIc5Ax
 /LeJ8SHKFJykSX1ntm2oOqMbcbB68DvhJEb2cIlLOjjsESKIFjBabugWp8Mc12vxydKt0SmI9
 8dbCb30an6NRW+J9TzxJNRjrSjc7InFy+G1WxGp4fF+VRRy/l/7szJ7VjDen+A8r6bqHDLfSE
 Y3v0ZItz4x9vVois15I33VDhIs0d3aMfEoehRGd9tgtic2HVvN/xiYEeoZZ+9te3kk0uP7PnI
 1+ZCiFMaHCoX3feRV1bx9POCzU5EQMTMoPJ4a8qkhzO+1CdJ+cvv5Fm9p6mtotjqTCdHtxAmM
 4lcx6U/IMQvG5jqx+b8mvzsp7Rfoo2KKvNxai4+BfIINTPjD3qF57dbN6pGPAdHR28S9JFEy1
 P5daWHA1o727KRSyjSrs7addLaC7oq6ex0ukdJSQ/XaNPSoNXklJ61iu2w95rvtArw+1edfEr
 68IvIJT9X/YR0cALi5ZAknG3trpN7lJhp0H/bV1mS2jtptde0zjzapuJ0J3bfpqh7PmtNIuoG
 BUauNdUgwbDpfn0Hnd5wtEkHDZrpYBj9jEJZebJTm9Pxq/qsrHO4o9zqioURdZUNn2BTFyeKK
 hZ6kK26ajLPPsSXK8XmJOtZvH90LuEtuUQ1CabeW2m2ZT2R7PZ5fCIWGei5SOnUYN7LELBKFx
 wLemtmL8FsgV5jejmWvFbJ3fKehxcpi+jlaF2kBTAbgQcpLclFd2EnJtE184fxPVPN0GQbQgn
 p/Vez9VzSO6CZ/Ake1fM/amBTSz6lUgjOsNlv6mU6Clo1JHS016yxhfcMV7t4KnG7IbvOwXtE
 3K3qbBq82nyV8E=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/5 21:08, Wang Yugui wrote:
> Hi, David Sterba
>
> Is this problem reproduced by other people?
>
> It seems a blocker kernel  issue for the coming btrfs-progs 5.15 release=
.
> becase  DUP metadata become default for single SSD in the coming btrfs-p=
rogs 5.15 release.

Just to be clear, it's purely -m DUP causing the problem? No other
features like free-space-tree involved?

If using v5.14.2 progs, just with -m DUP, it can still reproduce the
problem?

Thanks,
Qu
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/11/05
>
>> Hi,
>>
>> fstests(generic/297) report that btrfs reflink take too long time(21s)
>>     reflink didn't stop in time, n=3D17179869184 t=3D21
>>
>> reproduce frequency:
>>    DUP metadata(mkfs.btrfs -m DUP): about 20%
>>    single metadata(mkfs.btrfs -m single): < 3%
>>
>> kernel/btrfs: 5.15
>> 	I just begin to test DUP metadata(mkfs.btrfs -m DUP) recently,
>> 	so it may NOT a problem introduced in 5.15
>>
>> DUP metadata is useful to reproduce.
>> --- a/tests/generic/297
>> +++ b/tests/generic/297
>> @@ -29,7 +32,7 @@ _require_command "$TIMEOUT_PROG" "timeout"
>>   test $FSTYP =3D=3D "nfs"  && _notrun "NFS can't interrupt clone opera=
tions"
>>
>>   echo "Format and mount"
>> -_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mkfs -m DUP > $seqres.full 2>&1
>>   _scratch_mount >> $seqres.full 2>&1
>>
>>   testdir=3D$SCRATCH_MNT/test-$seq
>>
>>
>> I used 'hung_task_timeout_secs=3D2' to gather some call trace
>>
>> [  572.942085] INFO: task btrfs-transacti:8203 blocked for more than 2 =
seconds.
>> [  572.943264]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  572.944391] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  572.945516] task:btrfs-transacti state:D stack:    0 pid: 8203 ppid:=
     2 flags:0x00004000
>> [  572.946653] Call Trace:
>> [  572.947789]  __schedule+0x37c/0x7a0
>> [  572.948928]  schedule+0x3a/0xa0
>> [  572.950066]  btrfs_commit_transaction+0x200/0xac0 [btrfs]
>> [  572.951284]  ? finish_wait+0x80/0x80
>> [  572.952422]  transaction_kthread+0x13d/0x190 [btrfs]
>> [  572.953613]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [  572.954807]  kthread+0x118/0x140
>> [  572.955954]  ? set_kthread_struct+0x40/0x40
>> [  572.957091]  ret_from_fork+0x1f/0x30
>>
>> [  572.958231] INFO: task xfs_io:8398 blocked for more than 2 seconds.
>> [  572.959385]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  572.960539] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  572.961723] task:xfs_io          state:D stack:    0 pid: 8398 ppid:=
  8397 flags:0x00004004
>> [  572.962873] Call Trace:
>> [  572.964006]  __schedule+0x37c/0x7a0
>> [  572.965142]  schedule+0x3a/0xa0
>> [  572.966277]  wait_current_trans+0xc2/0x120 [btrfs]
>> [  572.967475]  ? finish_wait+0x80/0x80
>> [  572.968595]  start_transaction+0x490/0x590 [btrfs]
>> [  572.969745]  btrfs_replace_file_extents+0xfd/0x880 [btrfs]
>> [  572.970898]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
>> [  572.972051]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x=
1e
>> [  572.973180]  btrfs_clone+0x796/0x7f0 [btrfs]
>> [  572.974366]  ? __btrfs_add_free_space+0x8c/0x4c0 [btrfs]
>> [  572.975552]  btrfs_clone_files+0xfc/0x150 [btrfs]
>> [  572.976918]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
>> [  572.978111]  do_clone_file_range+0xea/0x230
>> [  572.979250]  vfs_clone_file_range+0x37/0x110
>> [  572.980384]  ioctl_file_clone+0x7d/0xb0
>> [  572.981512]  do_vfs_ioctl+0x47d/0x7f0
>> [  572.982639]  __x64_sys_ioctl+0x62/0xc0
>> [  572.983766]  do_syscall_64+0x37/0x80
>> [  572.984869]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  572.985958] RIP: 0033:0x7fe48946c62b
>> [  572.987037] RSP: 002b:00007ffff68bb648 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
>> [  572.988145] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe=
48946c62b
>> [  572.989259] RDX: 00007ffff68bb680 RSI: 000000004020940d RDI: 0000000=
000000003
>> [  572.990382] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
0000d5f2c
>> [  572.991501] R10: 00007ffff690d080 R11: 0000000000000246 R12: 0000000=
000000000
>> [  572.992621] R13: 0000000000000000 R14: 0000562c0a4f29c8 R15: 0000000=
400000000
>>
>> [  575.054091] INFO: task btrfs-transacti:8203 blocked for more than 4 =
seconds.
>> [  575.055252]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  575.056391] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  575.057540] task:btrfs-transacti state:D stack:    0 pid: 8203 ppid:=
     2 flags:0x00004000
>> [  575.058704] Call Trace:
>> [  575.059864]  __schedule+0x37c/0x7a0
>> [  575.061026]  schedule+0x3a/0xa0
>> [  575.062157]  btrfs_commit_transaction+0x200/0xac0 [btrfs]
>> [  575.063352]  ? finish_wait+0x80/0x80
>> [  575.064463]  transaction_kthread+0x13d/0x190 [btrfs]
>> [  575.065628]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [  575.066796]  kthread+0x118/0x140
>> [  575.067924]  ? set_kthread_struct+0x40/0x40
>> [  575.069029]  ret_from_fork+0x1f/0x30
>> [  575.070112] INFO: task xfs_io:8398 blocked for more than 4 seconds.
>> [  575.071207]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  575.072303] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  575.073424] task:xfs_io          state:D stack:    0 pid: 8398 ppid:=
  8397 flags:0x00004004
>> [  575.074566] Call Trace:
>> [  575.075688]  __schedule+0x37c/0x7a0
>> [  575.076799]  schedule+0x3a/0xa0
>> [  575.077893]  wait_current_trans+0xc2/0x120 [btrfs]
>> [  575.079036]  ? finish_wait+0x80/0x80
>> [  575.080110]  start_transaction+0x490/0x590 [btrfs]
>> [  575.081239]  btrfs_replace_file_extents+0xfd/0x880 [btrfs]
>> [  575.082378]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
>> [  575.083506]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x=
1e
>> [  575.084609]  btrfs_clone+0x796/0x7f0 [btrfs]
>> [  575.085765]  ? __btrfs_add_free_space+0x8c/0x4c0 [btrfs]
>> [  575.086920]  btrfs_clone_files+0xfc/0x150 [btrfs]
>> [  575.088072]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
>> [  575.089226]  do_clone_file_range+0xea/0x230
>> [  575.090328]  vfs_clone_file_range+0x37/0x110
>> [  575.091419]  ioctl_file_clone+0x7d/0xb0
>> [  575.092505]  do_vfs_ioctl+0x47d/0x7f0
>> [  575.093575]  __x64_sys_ioctl+0x62/0xc0
>> [  575.094628]  do_syscall_64+0x37/0x80
>> [  575.095670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  575.096722] RIP: 0033:0x7fe48946c62b
>> [  575.097773] RSP: 002b:00007ffff68bb648 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
>> [  575.098845] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe=
48946c62b
>> [  575.099923] RDX: 00007ffff68bb680 RSI: 000000004020940d RDI: 0000000=
000000003
>> [  575.101002] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
0000d5f2c
>> [  575.102080] R10: 00007ffff690d080 R11: 0000000000000246 R12: 0000000=
000000000
>> [  575.103155] R13: 0000000000000000 R14: 0000562c0a4f29c8 R15: 0000000=
400000000
>>
>>
>> [  577.166111] INFO: task btrfs-transacti:8203 blocked for more than 6 =
seconds.
>> [  577.167209]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  577.168289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  577.169385] task:btrfs-transacti state:D stack:    0 pid: 8203 ppid:=
     2 flags:0x00004000
>> [  577.170499] Call Trace:
>> [  577.171601]  __schedule+0x37c/0x7a0
>> [  577.172709]  schedule+0x3a/0xa0
>> [  577.173812]  btrfs_commit_transaction+0x200/0xac0 [btrfs]
>> [  577.175005]  ? finish_wait+0x80/0x80
>> [  577.176118]  transaction_kthread+0x13d/0x190 [btrfs]
>> [  577.177281]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [  577.178446]  kthread+0x118/0x140
>> [  577.179576]  ? set_kthread_struct+0x40/0x40
>> [  577.180683]  ret_from_fork+0x1f/0x30
>>
>>
>> [  577.181823] INFO: task xfs_io:8398 blocked for more than 6 seconds.
>> [  577.182977]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  577.184087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  577.185216] task:xfs_io          state:D stack:    0 pid: 8398 ppid:=
  8397 flags:0x00004004
>> [  577.186364] Call Trace:
>> [  577.187492]  __schedule+0x37c/0x7a0
>> [  577.188611]  schedule+0x3a/0xa0
>> [  577.189711]  wait_current_trans+0xc2/0x120 [btrfs]
>> [  577.190862]  ? finish_wait+0x80/0x80
>> [  577.191941]  start_transaction+0x490/0x590 [btrfs]
>> [  577.193073]  btrfs_replace_file_extents+0xfd/0x880 [btrfs]
>> [  577.194220]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
>> [  577.195355]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x=
1e
>> [  577.196464]  btrfs_clone+0x796/0x7f0 [btrfs]
>> [  577.197627]  ? __btrfs_add_free_space+0x8c/0x4c0 [btrfs]
>> [  577.198790]  btrfs_clone_files+0xfc/0x150 [btrfs]
>> [  577.199947]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
>> [  577.201105]  do_clone_file_range+0xea/0x230
>> [  577.202212]  vfs_clone_file_range+0x37/0x110
>> [  577.203308]  ioctl_file_clone+0x7d/0xb0
>> [  577.204398]  do_vfs_ioctl+0x47d/0x7f0
>> [  577.205470]  __x64_sys_ioctl+0x62/0xc0
>> [  577.206527]  do_syscall_64+0x37/0x80
>> [  577.207573]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  577.208627] RIP: 0033:0x7fe48946c62b
>> [  577.209679] RSP: 002b:00007ffff68bb648 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
>> [  577.210755] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe=
48946c62b
>> [  577.211834] RDX: 00007ffff68bb680 RSI: 000000004020940d RDI: 0000000=
000000003
>> [  577.212913] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
0000d5f2c
>> [  577.213992] R10: 00007ffff690d080 R11: 0000000000000246 R12: 0000000=
000000000
>> [  577.215066] R13: 0000000000000000 R14: 0000562c0a4f29c8 R15: 0000000=
400000000
>>
>>
>> [  579.278098] INFO: task btrfs-transacti:8203 blocked for more than 8 =
seconds.
>> [  579.279201]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  579.280278] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  579.281373] task:btrfs-transacti state:D stack:    0 pid: 8203 ppid:=
     2 flags:0x00004000
>> [  579.282486] Call Trace:
>> [  579.283590]  __schedule+0x37c/0x7a0
>> [  579.284698]  schedule+0x3a/0xa0
>> [  579.285801]  btrfs_commit_transaction+0x200/0xac0 [btrfs]
>> [  579.286991]  ? finish_wait+0x80/0x80
>> [  579.288104]  transaction_kthread+0x13d/0x190 [btrfs]
>> [  579.289270]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [  579.290435]  kthread+0x118/0x140
>> [  579.291553]  ? set_kthread_struct+0x40/0x40
>> [  579.292661]  ret_from_fork+0x1f/0x30
>> [  579.293764] INFO: task xfs_io:8398 blocked for more than 8 seconds.
>> [  579.294880]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  579.295990] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  579.297120] task:xfs_io          state:D stack:    0 pid: 8398 ppid:=
  8397 flags:0x00004004
>> [  579.298264] Call Trace:
>> [  579.299388]  __schedule+0x37c/0x7a0
>> [  579.300503]  schedule+0x3a/0xa0
>> [  579.301601]  wait_current_trans+0xc2/0x120 [btrfs]
>> [  579.302747]  ? finish_wait+0x80/0x80
>> [  579.303828]  start_transaction+0x490/0x590 [btrfs]
>> [  579.304959]  btrfs_replace_file_extents+0xfd/0x880 [btrfs]
>> [  579.306103]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
>> [  579.307235]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x=
1e
>> [  579.308341]  btrfs_clone+0x796/0x7f0 [btrfs]
>> [  579.309500]  ? __btrfs_add_free_space+0x8c/0x4c0 [btrfs]
>> [  579.310661]  btrfs_clone_files+0xfc/0x150 [btrfs]
>> [  579.311817]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
>> [  579.313144]  do_clone_file_range+0xea/0x230
>> [  579.314251]  vfs_clone_file_range+0x37/0x110
>> [  579.315350]  ioctl_file_clone+0x7d/0xb0
>> [  579.316441]  do_vfs_ioctl+0x47d/0x7f0
>> [  579.317516]  __x64_sys_ioctl+0x62/0xc0
>> [  579.318576]  do_syscall_64+0x37/0x80
>> [  579.319623]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  579.320682] RIP: 0033:0x7fe48946c62b
>> [  579.321736] RSP: 002b:00007ffff68bb648 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
>> [  579.322812] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe=
48946c62b
>> [  579.323895] RDX: 00007ffff68bb680 RSI: 000000004020940d RDI: 0000000=
000000003
>> [  579.324980] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
0000d5f2c
>> [  579.326061] R10: 00007ffff690d080 R11: 0000000000000246 R12: 0000000=
000000000
>> [  579.327139] R13: 0000000000000000 R14: 0000562c0a4f29c8 R15: 0000000=
400000000
>>
>>
>> [  581.390104] INFO: task btrfs-transacti:8203 blocked for more than 10=
 seconds.
>> [  581.391207]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  581.392290] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  581.393391] task:btrfs-transacti state:D stack:    0 pid: 8203 ppid:=
     2 flags:0x00004000
>> [  581.394513] Call Trace:
>> [  581.395621]  __schedule+0x37c/0x7a0
>> [  581.396733]  schedule+0x3a/0xa0
>> [  581.397841]  btrfs_commit_transaction+0x200/0xac0 [btrfs]
>> [  581.399040]  ? finish_wait+0x80/0x80
>> [  581.400160]  transaction_kthread+0x13d/0x190 [btrfs]
>> [  581.401331]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
>> [  581.402502]  kthread+0x118/0x140
>> [  581.403626]  ? set_kthread_struct+0x40/0x40
>> [  581.404741]  ret_from_fork+0x1f/0x30
>>
>>
>> [  581.405848] INFO: task xfs_io:8398 blocked for more than 10 seconds.
>> [  581.406966]       Not tainted 5.15.0-1.el7.x86_64 #1
>> [  581.408082] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
>> [  581.409220] task:xfs_io          state:D stack:    0 pid: 8398 ppid:=
  8397 flags:0x00004004
>> [  581.410373] Call Trace:
>> [  581.411507]  __schedule+0x37c/0x7a0
>> [  581.412632]  schedule+0x3a/0xa0
>> [  581.413739]  wait_current_trans+0xc2/0x120 [btrfs]
>> [  581.414893]  ? finish_wait+0x80/0x80
>> [  581.415977]  start_transaction+0x490/0x590 [btrfs]
>> [  581.417116]  btrfs_replace_file_extents+0xfd/0x880 [btrfs]
>> [  581.418438]  ? btrfs_search_slot+0x8e3/0x900 [btrfs]
>> [  581.419577]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x=
1e
>> [  581.420691]  btrfs_clone+0x796/0x7f0 [btrfs]
>> [  581.422025]  ? __btrfs_add_free_space+0x8c/0x4c0 [btrfs]
>> [  581.423199]  btrfs_clone_files+0xfc/0x150 [btrfs]
>> [  581.424364]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
>> [  581.425528]  do_clone_file_range+0xea/0x230
>> [  581.426640]  vfs_clone_file_range+0x37/0x110
>> [  581.427743]  ioctl_file_clone+0x7d/0xb0
>> [  581.428839]  do_vfs_ioctl+0x47d/0x7f0
>> [  581.429919]  __x64_sys_ioctl+0x62/0xc0
>> [  581.430983]  do_syscall_64+0x37/0x80
>> [  581.432121]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  581.433302] RIP: 0033:0x7fe48946c62b
>> [  581.434368] RSP: 002b:00007ffff68bb648 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
>> [  581.435457] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe=
48946c62b
>> [  581.436547] RDX: 00007ffff68bb680 RSI: 000000004020940d RDI: 0000000=
000000003
>> [  581.437636] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000=
0000d5f2c
>> [  581.438722] R10: 00007ffff690d080 R11: 0000000000000246 R12: 0000000=
000000000
>> [  581.439808] R13: 0000000000000000 R14: 0000562c0a4f29c8 R15: 0000000=
400000000
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2021/11/03
>>
>
>

Return-Path: <linux-btrfs+bounces-18073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E193BF297F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B93C63423B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF942284881;
	Mon, 20 Oct 2025 17:03:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from ts201-relay01.ddc.teliasonera.net (ts201-relay01.ddc.teliasonera.net [81.236.60.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8611D6187
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.236.60.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979828; cv=none; b=AAVeB78lT7DHo5AA4pJ7jQLjPpe8lR3uEf3BPVjeE77iqfPXULmnsSpQfoJ/n1RZvZCxyxhV082uNwR74MJc1Uxs0F1AFkRrXERvVvZnJdmscwtm7muYi2kEEwUbt5grzwad2c0njQOOUQGCIFoiXvzbc7zx+EOTVMcBXGNpHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979828; c=relaxed/simple;
	bh=PaxKymO5EwhMNt0YgeIR5BqSCLyPlLiyQWSMwVPavLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JprhLChi9qTfxZOIQ4FkKbfdcPMp1u10576/hC7TgG2L9XaDTX0D53+MytramXMCwqTnPP3sYxV5XC8gjPlrORPY5R09Sl3csR6Sx0QqpSPNY+D5hgg6W9zTa+Xy2aFhG7EFpPuprGlRs1F8DxMVjBPNsO/sYrwws0oP6JGo2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansson.tech; spf=pass smtp.mailfrom=jansson.tech; arc=none smtp.client-ip=81.236.60.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansson.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jansson.tech
Received: from gammdatan.home.lan (78-71-145-33-no600.tbcn.telia.com [78.71.145.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by ts201-relay01.ddc.teliasonera.net (Postfix) with ESMTPS id 4cr1wC1cq8z1DRk1;
	Mon, 20 Oct 2025 19:03:22 +0200 (CEST)
Received: from [192.168.9.3] ([192.168.9.3])
	by gammdatan.home.lan (8.17.1/8.17.1) with ESMTP id 59KH3MCK093060;
	Mon, 20 Oct 2025 19:03:22 +0200
Message-ID: <db8e80cb-3fa1-43bf-8ad9-ba6969a16112@jansson.tech>
Date: Mon, 20 Oct 2025 19:03:22 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem lockup during backup
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <4e2d3143-5383-491d-86c2-6b3eb7e21c3e@jansson.tech>
 <974df153-cbdf-443a-aa3b-0a30c121928d@suse.com>
 <a13db09c-a6c8-4029-a5b6-1ba0aee728e2@jansson.tech>
 <d715c901-d6b0-4edf-bc72-e0770d6ddce0@gmx.com>
Content-Language: en-US
From: =?UTF-8?Q?Torbj=C3=B6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <d715c901-d6b0-4edf-bc72-e0770d6ddce0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-20 00:48, Qu Wenruo wrote:
> 
> 
> 在 2025/10/20 08:25, Torbjörn Jansson 写道:
>> On 2025-10-19 22:42, Qu Wenruo wrote:
>>>
>>>
>>> 在 2025/10/19 20:43, Torbjörn Jansson 写道:
>>>> Hello.
>>>>
>>>> i have a btrfs filesystem on two 18tb disks that i use as backup destination for my proxmox cluster.
>>>> the filesystem is using btrfs raid1 mirroring and is exported over nfs to the other nodes.
>>>>
>>>> because this is used primarily for backups there are periods of heavy writes (several backups running at the same time) and when this happens it is very likely the filesystem and nfsd locks up completely.
>>>> this then starts a chain reaction due to the default hard mount blocking processes then eventually ceph also becomes unhappy and then the vms goes down.
>>>>
>>>> below is the hung task output from dmesg on the computer with the disks.
>>>>
>>>> any idea whats going on and what i can do about it?
>>>>
>>>>
>>>>
>>>> [1560204.654347] INFO: task nfsd:5136 blocked for more than 122 seconds.
>>>> [1560204.654351]       Tainted: P           O       6.14.11-2-pve #1
>>>
>>> v6.14 is EOL, you're completely on the vendor to provide any fix/ backport.
>>>
>>> Recommended to go either LTS kernels or latest upstream one.
>>>
>>
>> ok, not sure i can easily fix that.
>> i can go back to 6.8 but i think thats not an lts release.
>> i believe proxmox just released a 6.17 kernel but thats still in the test repo and if i enable that i might accidentally end up with test versions of other packages and i dont want that.
> 
> In that case, I'm afraid you have to ask PVE for support.
> 
> Neither 6.8 bir 6.14 are supported upstream, thus there must be some PVE specific backports there.
> 

i will wait a bit for the 6.17 kernel to be moved from testing to stable repo, then apply that and see what happens.
but i've had this problem for a while with a couple of kernel updates in between.

> Or you may want to explore how to install upstream kernels on your distro.
>>
>>
>>>> [1560204.654353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> [1560204.654355] task:nfsd            state:D stack:0     pid:5136 tgid:5136  ppid:2      task_flags:0x200040 flags:0x00004000
>>>
>>> The only message? No more other tasks?
>>>
>>
>> the same (or very similar) message is repeated 10 times, all related to nfsd and then it stops with:
>> "Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings"
>>
>> if you want i can provide all 10
> 
> Please provide full dmesg when reporting kernel related bugs.
> 
> It may seem the same to you, but a lot of time important details are hidden inside the full dmesg.
> 
> Thanks,
> Qu
> 
see below.
after this there is a steady stream of nfs server not responding timeout until the morning when i rebooted (had to reset since reboot got stuck)

[25437.763066] perf: interrupt took too long (2527 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
[37095.677795] perf: interrupt took too long (3185 > 3158), lowering kernel.perf_event_max_sample_rate to 62000
[60724.129687] perf: interrupt took too long (3988 > 3981), lowering kernel.perf_event_max_sample_rate to 50000
[123184.509512] hrtimer: interrupt took 37743 ns
[1434766.861092] perf: interrupt took too long (5082 > 4985), lowering kernel.perf_event_max_sample_rate to 39000
[1560204.623162] INFO: task nfsd:5123 blocked for more than 122 seconds.
[1560204.623175]       Tainted: P           O       6.14.11-2-pve #1
[1560204.623181] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.623185] task:nfsd            state:D stack:0     pid:5123  tgid:5123  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.623201] Call Trace:
[1560204.623206]  <TASK>
[1560204.623216]  __schedule+0x466/0x1400
[1560204.623239]  schedule+0x29/0x130
[1560204.623251]  io_schedule+0x4c/0x80
[1560204.623263]  folio_wait_bit_common+0x122/0x2e0
[1560204.623275]  ? __pfx_wake_page_function+0x10/0x10
[1560204.623294]  __folio_lock+0x17/0x30
[1560204.623307]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.623655]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.623900]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.624176]  do_writepages+0xde/0x280
[1560204.624201]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.624217]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.624237]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.624254]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.624267]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.624299]  filemap_fdatawrite_range+0x13/0x30
[1560204.624311]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.624697]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.625109]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.625501]  ? list_lru_del_obj+0xad/0xe0
[1560204.625526]  vfs_fsync_range+0x42/0xa0
[1560204.625545]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.625836]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.626120]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.626330]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.626497]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.626692]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.626853]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.627070]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.627252]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.627480]  nfsd+0x90/0xf0 [nfsd]
[1560204.627649]  kthread+0xf9/0x230
[1560204.627659]  ? __pfx_kthread+0x10/0x10
[1560204.627668]  ret_from_fork+0x44/0x70
[1560204.627679]  ? __pfx_kthread+0x10/0x10
[1560204.627687]  ret_from_fork_asm+0x1a/0x30
[1560204.627706]  </TASK>
[1560204.627712] INFO: task nfsd:5124 blocked for more than 122 seconds.
[1560204.627720]       Tainted: P           O       6.14.11-2-pve #1
[1560204.627726] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.627730] task:nfsd            state:D stack:0     pid:5124  tgid:5124  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.627744] Call Trace:
[1560204.627748]  <TASK>
[1560204.627755]  __schedule+0x466/0x1400
[1560204.627768]  ? blk_mq_flush_plug_list+0x198/0x670
[1560204.627786]  schedule+0x29/0x130
[1560204.627797]  io_schedule+0x4c/0x80
[1560204.627808]  folio_wait_bit_common+0x122/0x2e0
[1560204.627820]  ? __pfx_wake_page_function+0x10/0x10
[1560204.627835]  __folio_lock+0x17/0x30
[1560204.627843]  lock_delalloc_folios+0x1c9/0x2b0 [btrfs]
[1560204.628145]  ? submit_bio_noacct+0x28c/0x580
[1560204.628174]  find_lock_delalloc_range+0x10a/0x220 [btrfs]
[1560204.628420]  writepage_delalloc+0x141/0x530 [btrfs]
[1560204.628654]  ? __lruvec_stat_mod_folio+0x8b/0xf0
[1560204.628673]  extent_write_cache_pages+0x28f/0x7f0 [btrfs]
[1560204.628922]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.629187]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.629419]  do_writepages+0xde/0x280
[1560204.629434]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.629444]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.629458]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.629470]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.629479]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.629504]  filemap_fdatawrite_range+0x13/0x30
[1560204.629513]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.629749]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.629985]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.630364]  ? list_lru_del_obj+0xad/0xe0
[1560204.630390]  vfs_fsync_range+0x42/0xa0
[1560204.630406]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.630686]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.630968]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.631278]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.631556]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.631871]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.632156]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.632463]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.632764]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.633047]  nfsd+0x90/0xf0 [nfsd]
[1560204.633310]  kthread+0xf9/0x230
[1560204.633323]  ? __pfx_kthread+0x10/0x10
[1560204.633335]  ret_from_fork+0x44/0x70
[1560204.633350]  ? __pfx_kthread+0x10/0x10
[1560204.633361]  ret_from_fork_asm+0x1a/0x30
[1560204.633387]  </TASK>
[1560204.633393] INFO: task nfsd:5126 blocked for more than 122 seconds.
[1560204.633402]       Tainted: P           O       6.14.11-2-pve #1
[1560204.633407] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.633411] task:nfsd            state:D stack:0     pid:5126  tgid:5126  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.633425] Call Trace:
[1560204.633429]  <TASK>
[1560204.633435]  __schedule+0x466/0x1400
[1560204.633455]  schedule+0x29/0x130
[1560204.633466]  io_schedule+0x4c/0x80
[1560204.633477]  folio_wait_bit_common+0x122/0x2e0
[1560204.633492]  ? __pfx_wake_page_function+0x10/0x10
[1560204.633510]  __folio_lock+0x17/0x30
[1560204.633521]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.633933]  ? __local_bh_enable_ip+0x6a/0x70
[1560204.633967]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.634381]  do_writepages+0xde/0x280
[1560204.634402]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.634414]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.634436]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.634451]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.634463]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.634499]  filemap_fdatawrite_range+0x13/0x30
[1560204.634512]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.634905]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.635301]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.635669]  ? list_lru_del_obj+0xad/0xe0
[1560204.635693]  vfs_fsync_range+0x42/0xa0
[1560204.635710]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.636008]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.636288]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.636556]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.636827]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.637144]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.637408]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.637708]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.638018]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.638288]  nfsd+0x90/0xf0 [nfsd]
[1560204.638538]  kthread+0xf9/0x230
[1560204.638551]  ? __pfx_kthread+0x10/0x10
[1560204.638564]  ret_from_fork+0x44/0x70
[1560204.638578]  ? __pfx_kthread+0x10/0x10
[1560204.638590]  ret_from_fork_asm+0x1a/0x30
[1560204.638615]  </TASK>
[1560204.638623] INFO: task nfsd:5127 blocked for more than 122 seconds.
[1560204.638633]       Tainted: P           O       6.14.11-2-pve #1
[1560204.638641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.638646] task:nfsd            state:D stack:0     pid:5127  tgid:5127  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.638665] Call Trace:
[1560204.638671]  <TASK>
[1560204.638679]  __schedule+0x466/0x1400
[1560204.638706]  schedule+0x29/0x130
[1560204.638720]  io_schedule+0x4c/0x80
[1560204.638736]  folio_wait_bit_common+0x122/0x2e0
[1560204.638751]  ? __pfx_wake_page_function+0x10/0x10
[1560204.638773]  __folio_lock+0x17/0x30
[1560204.638784]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.639232]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.639627]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.640025]  do_writepages+0xde/0x280
[1560204.640047]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.640061]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.640081]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.640096]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.640108]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.640143]  filemap_fdatawrite_range+0x13/0x30
[1560204.640156]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.640544]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.640918]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.641295]  ? list_lru_del_obj+0xad/0xe0
[1560204.641319]  vfs_fsync_range+0x42/0xa0
[1560204.641336]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.641615]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.641899]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.642185]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.642453]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.642758]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.643038]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.643340]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.643640]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.643903]  nfsd+0x90/0xf0 [nfsd]
[1560204.644163]  kthread+0xf9/0x230
[1560204.644178]  ? __pfx_kthread+0x10/0x10
[1560204.644191]  ret_from_fork+0x44/0x70
[1560204.644206]  ? __pfx_kthread+0x10/0x10
[1560204.644217]  ret_from_fork_asm+0x1a/0x30
[1560204.644241]  </TASK>
[1560204.644247] INFO: task nfsd:5128 blocked for more than 122 seconds.
[1560204.644259]       Tainted: P           O       6.14.11-2-pve #1
[1560204.644266] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.644272] task:nfsd            state:D stack:0     pid:5128  tgid:5128  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.644288] Call Trace:
[1560204.644293]  <TASK>
[1560204.644302]  __schedule+0x466/0x1400
[1560204.644320]  ? blk_mq_flush_plug_list+0x198/0x670
[1560204.644344]  schedule+0x29/0x130
[1560204.644360]  io_schedule+0x4c/0x80
[1560204.644376]  folio_wait_bit_common+0x122/0x2e0
[1560204.644393]  ? __pfx_wake_page_function+0x10/0x10
[1560204.644412]  __folio_lock+0x17/0x30
[1560204.644424]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.644855]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.645262]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.645655]  do_writepages+0xde/0x280
[1560204.645676]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.645689]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.645708]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.645723]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.645735]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.645769]  filemap_fdatawrite_range+0x13/0x30
[1560204.645781]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.646088]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.646420]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.646623]  ? list_lru_del_obj+0xad/0xe0
[1560204.646633]  vfs_fsync_range+0x42/0xa0
[1560204.646641]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.646762]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.646884]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.647008]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.647123]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.647253]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.647368]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.647497]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.647627]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.647739]  nfsd+0x90/0xf0 [nfsd]
[1560204.647846]  kthread+0xf9/0x230
[1560204.647852]  ? __pfx_kthread+0x10/0x10
[1560204.647858]  ret_from_fork+0x44/0x70
[1560204.647864]  ? __pfx_kthread+0x10/0x10
[1560204.647868]  ret_from_fork_asm+0x1a/0x30
[1560204.647879]  </TASK>
[1560204.647882] INFO: task nfsd:5130 blocked for more than 122 seconds.
[1560204.647886]       Tainted: P           O       6.14.11-2-pve #1
[1560204.647890] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.647892] task:nfsd            state:D stack:0     pid:5130  tgid:5130  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.647899] Call Trace:
[1560204.647902]  <TASK>
[1560204.647906]  __schedule+0x466/0x1400
[1560204.647917]  schedule+0x29/0x130
[1560204.647923]  io_schedule+0x4c/0x80
[1560204.647929]  folio_wait_bit_common+0x122/0x2e0
[1560204.647936]  ? __pfx_wake_page_function+0x10/0x10
[1560204.647945]  __folio_lock+0x17/0x30
[1560204.647950]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.648143]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.648313]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.648478]  do_writepages+0xde/0x280
[1560204.648486]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.648492]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.648500]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.648507]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.648512]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.648527]  filemap_fdatawrite_range+0x13/0x30
[1560204.648532]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.648698]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.648856]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.649005]  ? list_lru_del_obj+0xad/0xe0
[1560204.649023]  vfs_fsync_range+0x42/0xa0
[1560204.649030]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.649147]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.649265]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.649381]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.649496]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.649623]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.649736]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.649863]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.649998]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.650109]  nfsd+0x90/0xf0 [nfsd]
[1560204.650217]  kthread+0xf9/0x230
[1560204.650222]  ? __pfx_kthread+0x10/0x10
[1560204.650228]  ret_from_fork+0x44/0x70
[1560204.650234]  ? __pfx_kthread+0x10/0x10
[1560204.650239]  ret_from_fork_asm+0x1a/0x30
[1560204.650249]  </TASK>
[1560204.650253] INFO: task nfsd:5131 blocked for more than 122 seconds.
[1560204.650257]       Tainted: P           O       6.14.11-2-pve #1
[1560204.650260] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.650263] task:nfsd            state:D stack:0     pid:5131  tgid:5131  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.650271] Call Trace:
[1560204.650274]  <TASK>
[1560204.650277]  __schedule+0x466/0x1400
[1560204.650285]  ? blk_mq_flush_plug_list+0x198/0x670
[1560204.650295]  schedule+0x29/0x130
[1560204.650302]  io_schedule+0x4c/0x80
[1560204.650309]  folio_wait_bit_common+0x122/0x2e0
[1560204.650316]  ? __pfx_wake_page_function+0x10/0x10
[1560204.650324]  __folio_lock+0x17/0x30
[1560204.650329]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.650514]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.650682]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.650847]  do_writepages+0xde/0x280
[1560204.650856]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.650861]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.650869]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.650876]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.650882]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.650897]  filemap_fdatawrite_range+0x13/0x30
[1560204.650902]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.651074]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.651235]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.651390]  ? list_lru_del_obj+0xad/0xe0
[1560204.651401]  vfs_fsync_range+0x42/0xa0
[1560204.651408]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.651529]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.651653]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.651750]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.651847]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.651955]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.652056]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.652164]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.652270]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.652365]  nfsd+0x90/0xf0 [nfsd]
[1560204.652454]  kthread+0xf9/0x230
[1560204.652459]  ? __pfx_kthread+0x10/0x10
[1560204.652463]  ret_from_fork+0x44/0x70
[1560204.652468]  ? __pfx_kthread+0x10/0x10
[1560204.652472]  ret_from_fork_asm+0x1a/0x30
[1560204.652481]  </TASK>
[1560204.652484] INFO: task nfsd:5134 blocked for more than 122 seconds.
[1560204.652487]       Tainted: P           O       6.14.11-2-pve #1
[1560204.652490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.652492] task:nfsd            state:D stack:0     pid:5134  tgid:5134  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.652498] Call Trace:
[1560204.652500]  <TASK>
[1560204.652503]  __schedule+0x466/0x1400
[1560204.652513]  schedule+0x29/0x130
[1560204.652518]  io_schedule+0x4c/0x80
[1560204.652524]  folio_wait_bit_common+0x122/0x2e0
[1560204.652530]  ? __pfx_wake_page_function+0x10/0x10
[1560204.652537]  __folio_lock+0x17/0x30
[1560204.652541]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.652691]  ? __local_bh_enable_ip+0x6a/0x70
[1560204.652702]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.652846]  do_writepages+0xde/0x280
[1560204.652853]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.652857]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.652864]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.652870]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.652874]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.652887]  filemap_fdatawrite_range+0x13/0x30
[1560204.652891]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.653036]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.653171]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.653302]  ? list_lru_del_obj+0xad/0xe0
[1560204.653311]  vfs_fsync_range+0x42/0xa0
[1560204.653317]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.653417]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.653517]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.653613]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.653710]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.653819]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.653913]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.654026]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.654132]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.654227]  nfsd+0x90/0xf0 [nfsd]
[1560204.654317]  kthread+0xf9/0x230
[1560204.654321]  ? __pfx_kthread+0x10/0x10
[1560204.654326]  ret_from_fork+0x44/0x70
[1560204.654331]  ? __pfx_kthread+0x10/0x10
[1560204.654335]  ret_from_fork_asm+0x1a/0x30
[1560204.654344]  </TASK>
[1560204.654347] INFO: task nfsd:5136 blocked for more than 122 seconds.
[1560204.654351]       Tainted: P           O       6.14.11-2-pve #1
[1560204.654353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.654355] task:nfsd            state:D stack:0     pid:5136  tgid:5136  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.654361] Call Trace:
[1560204.654363]  <TASK>
[1560204.654366]  __schedule+0x466/0x1400
[1560204.654376]  schedule+0x29/0x130
[1560204.654381]  io_schedule+0x4c/0x80
[1560204.654387]  folio_wait_bit_common+0x122/0x2e0
[1560204.654393]  ? __pfx_wake_page_function+0x10/0x10
[1560204.654400]  __folio_lock+0x17/0x30
[1560204.654404]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.654559]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.654703]  do_writepages+0xde/0x280
[1560204.654710]  ? __pfx_ip_finish_output+0x10/0x10
[1560204.654715]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.654721]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.654726]  ? __ip_queue_xmit+0x19b/0x4e0
[1560204.654731]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.654744]  filemap_fdatawrite_range+0x13/0x30
[1560204.654748]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.654889]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.655029]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.655159]  ? list_lru_del_obj+0xad/0xe0
[1560204.655168]  vfs_fsync_range+0x42/0xa0
[1560204.655174]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.655275]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.655367]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.655427]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.655486]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.655553]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.655611]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.655675]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.655741]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.655798]  nfsd+0x90/0xf0 [nfsd]
[1560204.655852]  kthread+0xf9/0x230
[1560204.655855]  ? __pfx_kthread+0x10/0x10
[1560204.655858]  ret_from_fork+0x44/0x70
[1560204.655862]  ? __pfx_kthread+0x10/0x10
[1560204.655864]  ret_from_fork_asm+0x1a/0x30
[1560204.655871]  </TASK>
[1560204.655873] INFO: task nfsd:5137 blocked for more than 122 seconds.
[1560204.655875]       Tainted: P           O       6.14.11-2-pve #1
[1560204.655877] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1560204.655878] task:nfsd            state:D stack:0     pid:5137  tgid:5137  ppid:2      task_flags:0x200040 flags:0x00004000
[1560204.655883] Call Trace:
[1560204.655884]  <TASK>
[1560204.655886]  __schedule+0x466/0x1400
[1560204.655891]  ? blk_mq_flush_plug_list+0x198/0x670
[1560204.655897]  schedule+0x29/0x130
[1560204.655902]  io_schedule+0x4c/0x80
[1560204.655907]  folio_wait_bit_common+0x122/0x2e0
[1560204.655913]  ? __pfx_wake_page_function+0x10/0x10
[1560204.655919]  __folio_lock+0x17/0x30
[1560204.655923]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
[1560204.656084]  btrfs_writepages+0x75/0x130 [btrfs]
[1560204.656226]  ? __pfx_end_bbio_data_write+0x10/0x10 [btrfs]
[1560204.656340]  do_writepages+0xde/0x280
[1560204.656344]  ? __ip_finish_output+0xb6/0x180
[1560204.656348]  ? ip_finish_output+0x2b/0x140
[1560204.656351]  ? wbc_attach_and_unlock_inode+0xd1/0x130
[1560204.656356]  filemap_fdatawrite_wbc+0x58/0x80
[1560204.656360]  ? common_interrupt+0x64/0xe0
[1560204.656364]  __filemap_fdatawrite_range+0x6d/0xa0
[1560204.656373]  filemap_fdatawrite_range+0x13/0x30
[1560204.656376]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
[1560204.656464]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
[1560204.656583]  btrfs_sync_file+0xa9/0x610 [btrfs]
[1560204.656683]  ? list_lru_del_obj+0xad/0xe0
[1560204.656688]  vfs_fsync_range+0x42/0xa0
[1560204.656692]  nfsd_commit+0x9f/0x180 [nfsd]
[1560204.656759]  nfsd4_commit+0x60/0xa0 [nfsd]
[1560204.656825]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
[1560204.656889]  nfsd_dispatch+0xce/0x220 [nfsd]
[1560204.656952]  svc_process_common+0x464/0x6f0 [sunrpc]
[1560204.657058]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[1560204.657120]  svc_process+0x136/0x1f0 [sunrpc]
[1560204.657191]  svc_recv+0x7bb/0x9a0 [sunrpc]
[1560204.657262]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[1560204.657324]  nfsd+0x90/0xf0 [nfsd]
[1560204.657383]  kthread+0xf9/0x230
[1560204.657386]  ? __pfx_kthread+0x10/0x10
[1560204.657389]  ret_from_fork+0x44/0x70
[1560204.657392]  ? __pfx_kthread+0x10/0x10
[1560204.657395]  ret_from_fork_asm+0x1a/0x30
[1560204.657401]  </TASK>
[1560204.657402] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings




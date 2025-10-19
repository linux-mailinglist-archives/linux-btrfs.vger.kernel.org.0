Return-Path: <linux-btrfs+bounces-18018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD9BEEDE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 00:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC96F4E27FF
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E55231845;
	Sun, 19 Oct 2025 22:01:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from ts201-relay02.ddc.teliasonera.net (ts201-relay02.ddc.teliasonera.net [81.236.60.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C96B67E
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.236.60.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760911301; cv=none; b=s89+k7OfHQ5xmDIKKJZXCIudBJDpIU0ytFTVx3sO1MbW3bK66iSCNvFpkkbmlTeqQ4vULEINVg93Q11wLgmB+2DN3Zf+4emPPJIAVvbWzuQ8o29U39Biub0N49NulOCLCdejHNMhnAHj4lMDrksIcD2Q0KkisjHTKzYeAgwHCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760911301; c=relaxed/simple;
	bh=+xfiMTb3oooeDxrKSCifIhQwZm3c+6Gm7nIqUHLcWJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V/NzjMcGpsevFHPjnuHpcee+A1ATFM8ej8q+o8Rd0cu0cEzXaxORUTv1FYiL+qNG+W9aXRt7e1P5KjbLF3+d71rKNsJFpkZkmbpT8f3B6CikURrgCz7TX541kvZbcMBoPD08h4J1wbP1tEF9arxZ0/+PONjg2cAmn1mz9pT7/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansson.tech; spf=pass smtp.mailfrom=jansson.tech; arc=none smtp.client-ip=81.236.60.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansson.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jansson.tech
Received: from gammdatan.home.lan (78-71-145-33-no600.tbcn.telia.com [78.71.145.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by ts201-relay02.ddc.teliasonera.net (Postfix) with ESMTPS id 4cqXRk1W3rz1DRk8;
	Sun, 19 Oct 2025 23:55:29 +0200 (CEST)
Received: from [192.168.9.3] ([192.168.9.3])
	by gammdatan.home.lan (8.17.1/8.17.1) with ESMTP id 59JLtTmG027721;
	Sun, 19 Oct 2025 23:55:29 +0200
Message-ID: <a13db09c-a6c8-4029-a5b6-1ba0aee728e2@jansson.tech>
Date: Sun, 19 Oct 2025 23:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem lockup during backup
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4e2d3143-5383-491d-86c2-6b3eb7e21c3e@jansson.tech>
 <974df153-cbdf-443a-aa3b-0a30c121928d@suse.com>
Content-Language: en-US
From: =?UTF-8?Q?Torbj=C3=B6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <974df153-cbdf-443a-aa3b-0a30c121928d@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-19 22:42, Qu Wenruo wrote:
> 
> 
> 在 2025/10/19 20:43, Torbjörn Jansson 写道:
>> Hello.
>>
>> i have a btrfs filesystem on two 18tb disks that i use as backup destination for my proxmox cluster.
>> the filesystem is using btrfs raid1 mirroring and is exported over nfs to the other nodes.
>>
>> because this is used primarily for backups there are periods of heavy writes (several backups running at the same time) and when this happens it is very likely the filesystem and nfsd locks up completely.
>> this then starts a chain reaction due to the default hard mount blocking processes then eventually ceph also becomes unhappy and then the vms goes down.
>>
>> below is the hung task output from dmesg on the computer with the disks.
>>
>> any idea whats going on and what i can do about it?
>>
>>
>>
>> [1560204.654347] INFO: task nfsd:5136 blocked for more than 122 seconds.
>> [1560204.654351]       Tainted: P           O       6.14.11-2-pve #1
> 
> v6.14 is EOL, you're completely on the vendor to provide any fix/backport.
> 
> Recommended to go either LTS kernels or latest upstream one.
> 

ok, not sure i can easily fix that.
i can go back to 6.8 but i think thats not an lts release.
i believe proxmox just released a 6.17 kernel but thats still in the test repo and if i enable that i might accidentally end up with test versions of other packages and i dont want that.


>> [1560204.654353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [1560204.654355] task:nfsd            state:D stack:0     pid:5136 tgid:5136  ppid:2      task_flags:0x200040 flags:0x00004000
> 
> The only message? No more other tasks?
> 

the same (or very similar) message is repeated 10 times, all related to nfsd and then it stops with:
"Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings"

if you want i can provide all 10


>> [1560204.654361] Call Trace:
>> [1560204.654363]  <TASK>
>> [1560204.654366]  __schedule+0x466/0x1400
>> [1560204.654376]  schedule+0x29/0x130
>> [1560204.654381]  io_schedule+0x4c/0x80
>> [1560204.654387]  folio_wait_bit_common+0x122/0x2e0
>> [1560204.654393]  ? __pfx_wake_page_function+0x10/0x10
>> [1560204.654400]  __folio_lock+0x17/0x30
> 
> This hangs at folio locking, which normally means another process has locked the data folio, but no more hanging messages to further debug it.
> 
> Thanks,
> Qu
> 
>> [1560204.654404]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
>> [1560204.654559]  btrfs_writepages+0x75/0x130 [btrfs]
>> [1560204.654703]  do_writepages+0xde/0x280
>> [1560204.654710]  ? __pfx_ip_finish_output+0x10/0x10
>> [1560204.654715]  ? wbc_attach_and_unlock_inode+0xd1/0x130
>> [1560204.654721]  filemap_fdatawrite_wbc+0x58/0x80
>> [1560204.654726]  ? __ip_queue_xmit+0x19b/0x4e0
>> [1560204.654731]  __filemap_fdatawrite_range+0x6d/0xa0
>> [1560204.654744]  filemap_fdatawrite_range+0x13/0x30
>> [1560204.654748]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
>> [1560204.654889]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
>> [1560204.655029]  btrfs_sync_file+0xa9/0x610 [btrfs]
>> [1560204.655159]  ? list_lru_del_obj+0xad/0xe0
>> [1560204.655168]  vfs_fsync_range+0x42/0xa0
>> [1560204.655174]  nfsd_commit+0x9f/0x180 [nfsd]
>> [1560204.655275]  nfsd4_commit+0x60/0xa0 [nfsd]
>> [1560204.655367]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
>> [1560204.655427]  nfsd_dispatch+0xce/0x220 [nfsd]
>> [1560204.655486]  svc_process_common+0x464/0x6f0 [sunrpc]
>> [1560204.655553]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>> [1560204.655611]  svc_process+0x136/0x1f0 [sunrpc]
>> [1560204.655675]  svc_recv+0x7bb/0x9a0 [sunrpc]
>> [1560204.655741]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> [1560204.655798]  nfsd+0x90/0xf0 [nfsd]
>> [1560204.655852]  kthread+0xf9/0x230
>> [1560204.655855]  ? __pfx_kthread+0x10/0x10
>> [1560204.655858]  ret_from_fork+0x44/0x70
>> [1560204.655862]  ? __pfx_kthread+0x10/0x10
>> [1560204.655864]  ret_from_fork_asm+0x1a/0x30
>> [1560204.655871]  </TASK>
>>




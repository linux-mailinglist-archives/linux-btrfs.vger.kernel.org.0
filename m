Return-Path: <linux-btrfs+bounces-18016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E675FBEEC58
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 22:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8135218985CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33037236A8B;
	Sun, 19 Oct 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FdJJHVss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF682B67E
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760906554; cv=none; b=tqAtrNqBTeL6DRBuYbwcRu/d8s+fQQ5O8cPUHNgsJ3j+zHFj4CWJ638jjJFBqOn6/uWgK9WvfZwD4AUEIYZPTxf7VGlQaV+QP5fOR3NDngtqbeQobmz0dLyL/SUkHqCfqn3ws3cAiG8oIgKebko+/PtQ9lrHGhpZZ/bmdQH3+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760906554; c=relaxed/simple;
	bh=y2fHbDme783zulw2FNuZ0Voh2vTzcfW2c8LJTBZVWOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rXK2wjCFapFR6Zn/nJPNMl6oC+SDNz45Es3U0Hg2dXKBIw/uyjBVtH0d0/w7uSf0QzGWk4Y9xEH51jWI7HPNLAV9G7xXd4MOOmn8AI7bU4H8sBslUpThOh9CvwKxNp/74vZbwHweU1ib7jcKCTvzUQ8kro/5ginANBpwIeUPw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FdJJHVss; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4270a0127e1so1355316f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760906550; x=1761511350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCcUJVokCLDZSewQr0NWUfGLufirP1aO/ikQ8yOy100=;
        b=FdJJHVssY98qpcWpMAKZkQ/4JrpyW8m0fe6DaAgue3He58W6uUrhUBbRfO8bqKsAnd
         MTOSZMcRMZN8+YX+IuGFJrBF9wA0QAv4FnM78/PaoOP28HXYvBwPOho3Y71Gvs+i9u8k
         wYU30Lqbsu28xzxjTwOUwlUpyYjOf1ziBJL+RWrWiIc+Bl1hWh3w+MW3yLL827BVYgap
         BlnjU1PDvxOCzmKO41qpv763fJcTCtkBA+iAPja2lZWMD+ZYlj8WWfD6hM70cgFzhqEh
         c7hUzPuLgFdl2ljv50qvuwf7WhWmfcaXyhS2eL/f0wxAlco/DeE5QM+SeTCdLFKfXyyw
         4TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760906550; x=1761511350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCcUJVokCLDZSewQr0NWUfGLufirP1aO/ikQ8yOy100=;
        b=KvSUfoMnPBAAItP1/Y990prL0ad270Ec4pGyqL8a2wjIC9vJoCoSkwHX8E3BU1Zq4I
         Sh5w8xU7a99ljz/bKjoxV7+tk3KbPiloX7p+Nb59I7ppeQGWQts2BOFjw3j7siSiDBIA
         8ljUtj+Lmurdq63HnP8Gl3XOAoSwSgd47TEeLSAjofD6SeOKxifWaLs6SjJpVz/zsqeI
         F3dHeQFYqf4WK2x8Y1PjUMBQ/BxUAYNLSVjj4TcCy2vJZXWoXXfr8YKkUQawGPs3jk6Y
         vaq00prAUQ2kgxRtYWV9DoEffUMxmpo3HwagcxtCKHKkeiHoHUb1x3dkm5cB5aB0sOJy
         ByPg==
X-Forwarded-Encrypted: i=1; AJvYcCX7mKAzV0hqYUxOXC6O+6h8ueB24Oh+9bCzIaFkXzTIIDYtlvqcwsThJ1EshGGap1Y67MtCinCkD1mWoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXauWchlHXTc8ZZIjhS1zEgJS/bwVDCXC8MCGJbuHtBxRMjau
	DnN6vhGfutSlAqxPvzxuXJ3bCSpTar9OOc5sN8zIpJjdNF1lAxo0xZgyppuI1Axe3/IfB1k2aor
	qEt7d
X-Gm-Gg: ASbGncuU13HQZEYpJeolveCAI2lEAQImZoKgvZxP7vwnG0NL1gCjrMbFGeydoFJLso/
	kFf2KpFrhNjdFiLPi7HlBUYhk5ZJumg5Qd61ig3J1wkTEWf1D5m6+Vsh1aRijuiU0YDVBC/5Ric
	oarMhd1njMcBK9tDMJnWziZD14ep+jNqD4PDtzCqbkuij8Z8rAz/BYBrc4jGY+cRdqN/fmgJkM5
	JnAmMmX5kkBd9Iq+MxbjhLC2PmhCAU/6iW0gA98ifGJgmSGX3uWilOW3AEKU65ZzdMImjEnc/61
	AnslVeHJ5WTKrA10n3FZGC+VCg5i/DmW+9SN9/lxmfmupYIcyfMUUkiPXlQfrzxasjU8bTEozUg
	zD7Iufa5XuOu4VeWtSfS+43g4jeGzRP2RdP2AydV2vnCL889qJowVvAqb8eOm5A45MrB/ZcJJEw
	yK0NYkv7scGC6iLt6qhvGE+aQSERlC1DlG6Vg3SEe54eD5U2xsww==
X-Google-Smtp-Source: AGHT+IHS9kYTbitv3XLp2YQmRyCSifhG4PRPaIyPAUC3+uM5dZxkUyLDY4RbVOmGOFavg2V6/FNUtw==
X-Received: by 2002:a05:6000:2301:b0:428:3e62:3221 with SMTP id ffacd0b85a97d-4283e6236admr3593689f8f.51.1760906549944;
        Sun, 19 Oct 2025 13:42:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6209382b3a.59.2025.10.19.13.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 13:42:28 -0700 (PDT)
Message-ID: <974df153-cbdf-443a-aa3b-0a30c121928d@suse.com>
Date: Mon, 20 Oct 2025 07:12:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem lockup during backup
To: =?UTF-8?Q?Torbj=C3=B6rn_Jansson?= <torbjorn@jansson.tech>,
 linux-btrfs@vger.kernel.org
References: <4e2d3143-5383-491d-86c2-6b3eb7e21c3e@jansson.tech>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <4e2d3143-5383-491d-86c2-6b3eb7e21c3e@jansson.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/19 20:43, Torbjörn Jansson 写道:
> Hello.
> 
> i have a btrfs filesystem on two 18tb disks that i use as backup 
> destination for my proxmox cluster.
> the filesystem is using btrfs raid1 mirroring and is exported over nfs 
> to the other nodes.
> 
> because this is used primarily for backups there are periods of heavy 
> writes (several backups running at the same time) and when this happens 
> it is very likely the filesystem and nfsd locks up completely.
> this then starts a chain reaction due to the default hard mount blocking 
> processes then eventually ceph also becomes unhappy and then the vms 
> goes down.
> 
> below is the hung task output from dmesg on the computer with the disks.
> 
> any idea whats going on and what i can do about it?
> 
> 
> 
> [1560204.654347] INFO: task nfsd:5136 blocked for more than 122 seconds.
> [1560204.654351]       Tainted: P           O       6.14.11-2-pve #1

v6.14 is EOL, you're completely on the vendor to provide any fix/backport.

Recommended to go either LTS kernels or latest upstream one.

> [1560204.654353] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [1560204.654355] task:nfsd            state:D stack:0     pid:5136  
> tgid:5136  ppid:2      task_flags:0x200040 flags:0x00004000

The only message? No more other tasks?

> [1560204.654361] Call Trace:
> [1560204.654363]  <TASK>
> [1560204.654366]  __schedule+0x466/0x1400
> [1560204.654376]  schedule+0x29/0x130
> [1560204.654381]  io_schedule+0x4c/0x80
> [1560204.654387]  folio_wait_bit_common+0x122/0x2e0
> [1560204.654393]  ? __pfx_wake_page_function+0x10/0x10
> [1560204.654400]  __folio_lock+0x17/0x30

This hangs at folio locking, which normally means another process has 
locked the data folio, but no more hanging messages to further debug it.

Thanks,
Qu

> [1560204.654404]  extent_write_cache_pages+0x36e/0x7f0 [btrfs]
> [1560204.654559]  btrfs_writepages+0x75/0x130 [btrfs]
> [1560204.654703]  do_writepages+0xde/0x280
> [1560204.654710]  ? __pfx_ip_finish_output+0x10/0x10
> [1560204.654715]  ? wbc_attach_and_unlock_inode+0xd1/0x130
> [1560204.654721]  filemap_fdatawrite_wbc+0x58/0x80
> [1560204.654726]  ? __ip_queue_xmit+0x19b/0x4e0
> [1560204.654731]  __filemap_fdatawrite_range+0x6d/0xa0
> [1560204.654744]  filemap_fdatawrite_range+0x13/0x30
> [1560204.654748]  btrfs_fdatawrite_range+0x28/0x70 [btrfs]
> [1560204.654889]  start_ordered_ops.constprop.0+0x4e/0x90 [btrfs]
> [1560204.655029]  btrfs_sync_file+0xa9/0x610 [btrfs]
> [1560204.655159]  ? list_lru_del_obj+0xad/0xe0
> [1560204.655168]  vfs_fsync_range+0x42/0xa0
> [1560204.655174]  nfsd_commit+0x9f/0x180 [nfsd]
> [1560204.655275]  nfsd4_commit+0x60/0xa0 [nfsd]
> [1560204.655367]  nfsd4_proc_compound+0x3ad/0x760 [nfsd]
> [1560204.655427]  nfsd_dispatch+0xce/0x220 [nfsd]
> [1560204.655486]  svc_process_common+0x464/0x6f0 [sunrpc]
> [1560204.655553]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [1560204.655611]  svc_process+0x136/0x1f0 [sunrpc]
> [1560204.655675]  svc_recv+0x7bb/0x9a0 [sunrpc]
> [1560204.655741]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [1560204.655798]  nfsd+0x90/0xf0 [nfsd]
> [1560204.655852]  kthread+0xf9/0x230
> [1560204.655855]  ? __pfx_kthread+0x10/0x10
> [1560204.655858]  ret_from_fork+0x44/0x70
> [1560204.655862]  ? __pfx_kthread+0x10/0x10
> [1560204.655864]  ret_from_fork_asm+0x1a/0x30
> [1560204.655871]  </TASK>
> 



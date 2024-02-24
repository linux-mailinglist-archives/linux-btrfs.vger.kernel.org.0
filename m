Return-Path: <linux-btrfs+bounces-2703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C848623FA
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B15B22976
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BE17748;
	Sat, 24 Feb 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="Cu7Duple"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out2.mxs.au (h1.out2.mxs.au [110.232.143.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D81759E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767767; cv=none; b=BYC/BP8uL/OVNIOaUcCKMBPSr46zw9njr8PXDaKM2uZKYT9ozFCMyk1L5Kh395QFphgQLmRErhFJ9wU0wF1DDNmzbt8LugWTWygJ1InvDmbeIW6/XwtqOIuhkDOxHGTjlurno3Ne+28YfVlutphUkrJ1zrqiSL5WM+sGlsR7P8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767767; c=relaxed/simple;
	bh=6ZBbxWbi5JaCF/4EoeVZFvEtBGSvFsYX/v3Y3ynSL28=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RLcthqOWcBaFOagxnKNfN86wUxZIMgytjgmNvY46aC3xBfCXm+du/x4eAFDMyTuQd/c/4d8t7a/jRv12f0JXPLbIE5+H9z/lpicosCApRwVhb0aEI2LVL/U3U3IYD8Hl1h3YidOphPmuQp+f+tQKNhluYfAIoE8aZvgZNzen6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=Cu7Duple; arc=none smtp.client-ip=110.232.143.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out2.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id e2700a46-d2f8-11ee-9817-00163c1ebd60
	for <linux-btrfs@vger.kernel.org>;
	Sat, 24 Feb 2024 20:41:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ZBbxWbi5JaCF/4EoeVZFvEtBGSvFsYX/v3Y3ynSL28=; b=Cu7DuplexWzixNeOxH9kAupFLR
	74XpzG92LYGfraAHyZza+5/AqEXW+EEL1bZ0XJuQfl1xK8Sj3O05miEXKW1ek55E94uvuR9WAqxhA
	9GVhqz8s57Ix+T0g3edXrJndxJre6NdsLNFWt47gbxb5b8k5bsnot6rlvvWZdgydlQTpikRQE4N4e
	ED/qEM3O+4SJMASWwsB6b8Qz+yapwiPv/pjdWAPu/BZr09RldAskQHEVSIjLH5i8g8aHuCyvc7Iv5
	eNxyGmdAz5pdnp7/MQNom30jW58VvP3GJ9MBOF2JBCmnzwDw3iimDlwJvUEOvg7dTxrXGxe6xlGHx
	wMlRE2zw==;
Received: from [159.196.20.165] (port=45415 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <mjurgens@edcint.co.nz>)
	id 1rdoXA-001zlf-28;
	Sat, 24 Feb 2024 20:41:28 +1100
Message-ID: <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
Date: Sat, 24 Feb 2024 20:41:27 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Matthew Jurgens
 <default@edcint.co.nz>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
Content-Language: en-US
From: Matthew Jurgens <mjurgens@edcint.co.nz>
In-Reply-To: <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: mjurgens@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: mjurgens@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 


On 24/02/2024 2:15 pm, Qu Wenruo wrote:
>
>
> 在 2024/2/24 12:21, Matthew Jurgens 写道:
>>
>> On 24/02/2024 12:22 pm, Matthew Jurgens wrote:
>>> As I understand rescue=all, I don't need it for allowing me to mount
>>> (since I can already mount the file system) but it will allow me to
>>> copy damaged files out of the file system. However, I don't know what
>>> is damaged. I do have backups.
>>>
>>> Commands like  btrfs inspect-internal logical-resolve 20647087898624
>>> /export/shared
>>>
>>> just return
>>> ERROR: logical ino ioctl: No such file or directory
>
> The damaged ones are tree blocks, thus logical resolve won't give a data
> inode at all.
>
>>>
>> Having said this, I think I can find which files are damaged by trying
>> to read every single file on the file system.
>
> The problem is, since the corruption is in tree blocks, it can cover
> quite some files with a single tree block.
>
>>
>> I was just doing some space calculations using du and it started
>> throwing errors like:
>>
>> du: cannot access '/export/shared/backups/xyz': Input/output error
>>
>> which also resulted in entries in the messages file like:
>>
>> kernel: BTRFS warning (device sdg): checksum verify failed on logical
>> 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
>>
>> where 20647087931392 is a number that appears in other messages eg dmesg
>>
>> I figure I can then just run a du on the whole file system and any files
>> it complains about are probably problematic.
>>
>> If it turns out that I can do without the files, can I fix the problem
>> just by deleting them or is there something else I must do?
>
> Not really much you can do (at least safely).
>
> As mentioned, the corruption a tree block, not on-disk data of a file
> (which scrub can easily give you the path).
>
> Furthermore, a single corrupted tree block can lead to tons of
> cross-reference problem (that's why btrfs check is reporting tons of
> problems).
>
> It's hard to make the fs back to sane RW status.
> You can try "btrfs check --repair", and you may need to do it several
> times until no more repair or no more errors.
>
> And without a full memtest run, if it's really some runtime memory
> corruption, it will happen again.
>
> Thanks,
> Qu
>
I have run a memtest for 5 hours with 4 passes and 0 errors

Is it safe to run "btrfs check --repair" now?



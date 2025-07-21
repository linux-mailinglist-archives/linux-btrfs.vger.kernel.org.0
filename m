Return-Path: <linux-btrfs+bounces-15611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9AB0CA35
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27E13B5730
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2682E041C;
	Mon, 21 Jul 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ueiv97hW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FB522A
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121027; cv=none; b=Vx+X4s6h0ce0coL1ZQ5Ra1kxXa/xaZCIIKwczpQWC4Hm2CETiFsM7nqnEMnKr0C/qWLksUsZZxf3Ssm2Y57aAYGHwkujCBTuvkxMb9uFE2pCGEhA+4hIEm+Uph+uN4atYUikGj+geR/a9U8cUkvBzTUcVGKt0C7M0BTH05SnPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121027; c=relaxed/simple;
	bh=yrWnwPTqT1JFpIF88OF1/MzxGHpPK+0JsbBnPyA+Uh4=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWjOZxtkYnt7mq3rTMg8KDD+3p+sITPm0pugfppfycQBqNiISQpiAb19Qeq5WxhYzQ4GO5kOTfL67AuMuUyHrPUtlX0gPMWMxMRFGkoE0L2G6uDq+YhcSZy1ApWGVyQkQZdrcPqZLD/W2WNFk19FnldsI5Ji8XmQI5mX4JUqkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ueiv97hW; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 9474B29DF2E;
	Mon, 21 Jul 2025 19:03:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1753121017;
	bh=mLHwDNGDr3RgHFX4c6s45IUh3Zv3TJQOBCzbvNjHJDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ueiv97hWtIK0qGbuRK0LFvpTRzww69g4WJ4fozWswyROQ/VrT2ZhVAMYO3/EnFK6T
	 EKZ3J1+czVecCJmS42Ix8I5hyTRCmsUdDC/MggfFteqHPfFz+fZF4yiOvEYld+RzLT
	 uJAAr1R36X9+HDqbjeLtGwQhfmsPZjT0onoRLcLc=
Message-ID: <6c2dafc2-01e9-4035-84a7-c7ddace435cb@harmstone.com>
Date: Mon, 21 Jul 2025 19:03:37 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: log tree corrupted (and successfully fixed) -- anything I can do
 to diagnose why?
To: burneddi <burneddi@protonmail.com>, Boris Burkov <boris@bur.io>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com>
 <20250721154643.GA1839816@zen.localdomain>
 <hDedgabtauGBrte7Y8hOUixCdR-j255nc8o8sr_lYVIudj_zkd9WSRgJk1FSBYhnIwCMsbzc9ooFE1BL7VKjsLqHZasXEQpK6XQT3uH9XB0=@protonmail.com>
 <DBfdTFMu_U0whFCsYA-jAAzwYGCh6UYXTW-S9bd0NaFSE0LDzvNWL4Ix9JK8PZwm5tHGcFn3YdXPHSisMnDzTqDiymQCD6vDsKIcFOL7Ox8=@protonmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <DBfdTFMu_U0whFCsYA-jAAzwYGCh6UYXTW-S9bd0NaFSE0LDzvNWL4Ix9JK8PZwm5tHGcFn3YdXPHSisMnDzTqDiymQCD6vDsKIcFOL7Ox8=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Could you please give us the make and model of your NVMe drive, in case
it turns out to be relevant?

On 21/07/2025 6.41 pm, burneddi wrote:
> Oh, and I should mention that my kernel is currently tainted due to a leftover boot option (enable_guc) related to an out-of-tree i915 module (https://github.com/strongtz/i915-sriov-dkms) -- the module itself is currently inactive, but I forgot to remove the kernel options, and apparently this option is considered dangerous:
> 
> [    3.623122] Setting dangerous option enable_guc - tainting kernel
> 
> I doubt it's pertinent seeing that many others seem to have had the same issue and this isn't that common of a kernel option, but surely worth mentioning.
> 
> - Peter
> 
> 
> 
> On Monday, 21 July 2025 at 20:34, burneddi <burneddi@protonmail.com> wrote:
> 
>>
>>
>> Okay, that's too bad. Unfortunately I didn't even note down the full dmesg; only snapped photos of the top and bottom with my phone. Here are those photos anyway, on the off chance they are of any use: https://i.imgur.com/RJk0qaI.jpeg https://i.imgur.com/n6t5nGG.jpeg
>>
>> I am on kernel version 6.15.6-200.fc42.x86_64 on Fedora 42. My CPU is Intel i9 12900k on a Z690 platform motherboard. Mount options: subvol=subvol_root,compress=zstd,x-systemd.device-timeout=30.
>>
>> Perhaps it's worth adding a note suggesting users collect troubleshooting information in the documentation at https://btrfs.readthedocs.io/en/latest/btrfs-rescue.html. This is the documentation I read to find out how to fix the issue.
>>
>> Regards,
>> Peter
>>
>>
>> On Monday, 21 July 2025 at 18:45, Boris Burkov boris@bur.io wrote:
>>
>>> On Sun, Jul 20, 2025 at 09:19:42PM +0000, burneddi wrote:
>>>
>>>> Hi,
>>>> My system had a hard crash today (some AMD graphics instability), which resulted in the log tree on my boot drive becoming corrupt, giving me the error "open_ctree failed: -2".
>>>>
>>>> I managed to fix this successfully with "btrfs-rescue zero-log", but now I'm wondering if I should try to diagnose and report this somehow. I have been running this drive with btrfs for many years and have had a fair number of hard crashes during that time (AMD graphics instability...), but this is the first time the log tree has been corrupted, so I suspect it could be a kernel bug rather than an issue with my drive's firmware. I run Fedora, so my kernel is quite new; 6.15.6 right now.
>>>>
>>>> Is there anything I should or even can do after zeroing the log that could help btrfs developers narrow the cause down?
>>>
>>> Thank you for your report, and sorry for the instability. Unfortunately,
>>> after zeroing the log, there isn't much we can do, besides just collect
>>> basic information about your setup to try to correlate with other
>>> reporters:
>>>
>>> stuff like
>>> - hw architecture
>>> - exact kver
>>> - mount options
>>>
>>> While we're on the topic,
>>> https://lore.kernel.org/linux-btrfs/20250718185845.GA4107167@zen.localdomain/T/#t
>>>
>>> is another thread with more reports where I mentioned the information
>>> I'd be looking for to help debug. So if you do crash and hit it again
>>> going forward, and are able to run btrfs check or btrfs inspect-internal
>>> dump-tree before recovering with zero-log, that would be very helpful.
>>>
>>> Thanks,
>>> Boris
>>>
>>>> Best regards,
>>>> Peter Wedder
> 



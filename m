Return-Path: <linux-btrfs+bounces-3162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557828777F6
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 19:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032CE1F21270
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B439AE7;
	Sun, 10 Mar 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b="jQg9e0Fp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.tnonline.net (mx.tnonline.net [65.109.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A03984A
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094680; cv=none; b=g5cevmDQs+bOT+s3BryMaxG8tnL73jw4kFYQgMe1a1SDlw3qG58jrrrV3w3lHwKLYHJRttCaLhJyHSx1nIAgxW96SZyISM5kLUPcemIVMVTbJbMtoHh0pRuQoQXynxDWGGp4I76lKtHJq4f52x0exK7effNE9HErDGGam6AEfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094680; c=relaxed/simple;
	bh=a3lMIb9GWJpSGL7aoIlHcAJLFfk4BU2Fim3+4cFRAt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzc7cACSFTz3jGspvNazSgqR0NvVuYdDcgfuf+5DtlDEP98nMz1pO2FUVOxxmBrYOEgUcyBje/waOZ04w5AbUue4qETKpIFnprVcex5yra4vz2WuOZkFxa+11L4AwJmpkTNtKTbbnEqnRJw0H87s25XJC8mfpksRAEIAxb+t8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net; spf=pass smtp.mailfrom=tnonline.net; dkim=pass (2048-bit key) header.d=tnonline.net header.i=@tnonline.net header.b=jQg9e0Fp; arc=none smtp.client-ip=65.109.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tnonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnonline.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xwUEy5tagTrTc9terYHewyrWW2auSkXgZVVfP+9oPwg=; t=1710094678; x=1711304278; 
	b=jQg9e0FpL/4jf6GxGpPRcQA7bRjz3Jq765BUpK3KjfbTiRcSKmuowBd9Gl564qq/PRP0d+jk3YY
	igpHOdiON5FVrzhzboV83TMK5JKaCVdgoxC2/wO7DP5uXbtQeHLddbMiEHbqCh5OUL6BtMhkiLXlk
	EiOGs8RJWk7wGJhWYC0l8h/O3LXM1hC7Srk1y9ozqMfNnRbT0nsVINLcPgifnQd+2ljizdPcmsgta
	+DdklFBVdYQvoKGGI6dn2j2QJcJ4DvsoAChj0FqcxOCqvXIv/8cxBF3fzTOOhSNZw2AzCgT94hJxy
	Zy2fWnEPOJ69Bm+9U4ZsToQ8g2uosfFHoPyA==;
Received: from tnonline.net ([2001:470:28:704::1]:60892)
	by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <postmaster@tnonline.net>)
	id 1rjNQ4-00000000121-2zRU;
	Sun, 10 Mar 2024 17:57:09 +0000
Received: from [192.168.0.122] (port=41184)
	by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <forza@tnonline.net>)
	id 1rjNQ4-000000005SX-2VXx;
	Sun, 10 Mar 2024 18:57:08 +0100
Message-ID: <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
Date: Sun, 10 Mar 2024 18:57:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: raid1 root device with efi
Content-Language: sv-SE, en-GB
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Matthew Warren <matthewwarren101010@gmail.com>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
From: Forza <forza@tnonline.net>
In-Reply-To: <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.8 (---)



On 2024-03-08 22:58, Matt Zagrabelny wrote:
> On Fri, Mar 8, 2024 at 3:54 PM Matthew Warren
> <matthewwarren101010@gmail.com> wrote:
>>
>> On Fri, Mar 8, 2024 at 4:48 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>>>
>>> Hi Qu and Matthew,
>>>
>>> On Fri, Mar 8, 2024 at 3:46 PM Matthew Warren
>>> <matthewwarren101010@gmail.com> wrote:
>>>>
>>>> On Fri, Mar 8, 2024 at 3:46 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>>>>>
>>>>> Greetings,
>>>>>
>>>>> I've read some conflicting info online about the best way to have a
>>>>> raid1 btrfs root device.
>>>>>
>>>>> I've got two disks, with identical partitioning and I tried the
>>>>> following scenario (call it scenario 1):
>>>>>
>>>>> partition 1: EFI
>>>>> partition 2: btrfs RAID1 (/)
>>>>>
>>>>> There are some docs that claim that the above is possible...
>>>>
>>>> This is definitely possible. I use it on both my server and desktop with GRUB.
>>>
>>> Are there any docs you follow for this setup?
>>>
>>> Thanks for the info!
>>>
>>> -m
>>
>> The main important thing is that mdadm has several metadata versions.
>> Versions 0.9 and 1.0 store the metadata at the end of the partition
>> which allows UEFI to think the filesystem is EFI rather than mdadm
>> raid.
>> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-versions_of_the_version-1_superblock
>>
>> I followed the arch wiki for setting it up, so here's what I followed.
>> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_RAID1
> 
> Thanks for the hints. Hopefully there aren't any more unexpected issues.
> 
> Cheers!
> 
> -m
> 

An alternative to mdadm is to simply have separate ESP partitions on 
each device. You can manually copy the contents between the two if you 
were to update the EFI bootloader. This way you can keep the 'other' ESP 
as backup during GRUB/EFI updates.

This solution is what I use on one of my servers. GRUB2 supports Btrfs 
RAID1 so you do not need to have the kernel and initramfs on the ESP, 
though that works very well too.

Good Luck!

~Forza


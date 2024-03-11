Return-Path: <linux-btrfs+bounces-3197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B848788F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1D1F20C37
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC3555782;
	Mon, 11 Mar 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="TO8cWIMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8154F83
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185356; cv=none; b=XdP30TZ1F+7031wOD+WAwl0QsXFGShRh3cQtBcuTv+mOUDzZh7jJz8xRQIcvNr0Wj+upHxSUtSRgq0A6s1DBXWLCXulXqwggiBZBWZmzKOri+24ekvkSjEoESMC61WrI4gd/1jqvC4TcPjbrOp9uwbmkvOgUtSiQTLKbiPuQwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185356; c=relaxed/simple;
	bh=wpGiuyImpzQejV2S0CWam5lu9wbRualfvo3u7LoxIPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai6uP300iFFq4tWDdh0uay4U8K03DpBoir37ZwoVLliiUexO8jIdtHnx3iHkpgs/SHTH2MuNwo1dmGIxJ8YlPVH9d5/69+kIsy6jfZ6s/T+y9i1Olt8U3NMSZs2kmYDvnJ1uxLK3DiwWrnnSI7pZFJ7/lssaq07iQpCIR0gtlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=TO8cWIMi; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id jlI9rdIAawDoyjlIArzr4F; Mon, 11 Mar 2024 20:26:34 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1710185194; bh=J29m8Nr8kcQPxHAO+9ir4S8uX0lIDJ1pLW0sKg321sQ=;
	h=From;
	b=TO8cWIMiMLknJHtCoaNOYhx8gG5yQUvBIbTq7dee+iPyKSZ8QxjlarX+oUY0UXqY8
	 TP68BpFPyNDx/eIH4JJCuk166a73KTmm+IyHKMl4SPLA8I+2eD0DMrNsbXYlloYXxF
	 hTDTDvz4o9E9YTuT83J3xmt7DvsbtfCvcMPdf1FxwtkMSQ7B36ScvtANc1EgI3uE5T
	 yVauyhnd2vix4p69F/67pUYsBx44OrW/YN9jnbIC+tyNKrQ29Eh6OlZQqQNfAHzrM9
	 P6fswlKkAYha+SBUheVioV75mpyoS4/mibLsFZOa4sezAblRBMLKqoDMybWDzj4rJ9
	 /JBxvGifxYPqQ==
X-CNFS-Analysis: v=2.4 cv=N5qKFH9B c=1 sm=1 tr=0 ts=65ef5aea cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=O-dTtCbMAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=Br9LfDWDAAAA:8 a=4FwvDv67h4z814avhCcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YQZzFssXFEgA:10 a=p5snsyuY6O_wh2DS_HCF:22
 a=AjGcO6oz07-iQ99wixmX:22 a=gR_RJRYUad_6_ruzA8cR:22
Message-ID: <4feb955c-cc91-4f0b-8e62-b6a089eea7ae@libero.it>
Date: Mon, 11 Mar 2024 20:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: raid1 root device with efi
Content-Language: en-US
To: Kai Krakow <hurikhan77+btrfs@gmail.com>, Forza <forza@tnonline.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Matthew Warren <matthewwarren101010@gmail.com>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
 <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
 <CAMthOuO56J5OhCnedJLxTuFxTPq7ryCGP_TxMrcXS+4jLj0aiA@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CAMthOuO56J5OhCnedJLxTuFxTPq7ryCGP_TxMrcXS+4jLj0aiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFYtV+1tHrLo+Y09bD4c6C29+5EftHZANctBkxpxXPqP2usIqfahNGAYSbw/O/5nw/8WH9Wjj5VatOIUGKfqkTK0ohQ2JqZ6omLwyrjbRmXvv+jvJqZY
 lt7hmNkHRrpsWpDJ/Lceysh+7CK7nFLWFkQsDfo1tjitNFIZCHLne2bJgZclvI4FUdiX++vpDlJg2EtvwSjH7mQ/RBZbZEqWMJJI6HznASzsLuaDEJ0SbdFA
 kMLV33SpCVoDJLOlSrgFgk/jrdBh3nWXbfQ48sCHvNfNqFBwxebUyvjc3KPNqlNg0Cz8FCi/BKvMd40cxm+A0g==

On 11/03/2024 15.34, Kai Krakow wrote:
> Hello!
> 
> Am So., 10. März 2024 um 19:18 Uhr schrieb Forza <forza@tnonline.net>:
>>
>>
>>
>> On 2024-03-08 22:58, Matt Zagrabelny wrote:
>>> On Fri, Mar 8, 2024 at 3:54 PM Matthew Warren
>>> <matthewwarren101010@gmail.com> wrote:
>>>>
>>>> On Fri, Mar 8, 2024 at 4:48 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>>>>>
>>>>> Hi Qu and Matthew,
>>>>>
>>>>> On Fri, Mar 8, 2024 at 3:46 PM Matthew Warren
>>>>> <matthewwarren101010@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Mar 8, 2024 at 3:46 PM Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
>>>>>>>
>>>>>>> Greetings,
>>>>>>>
>>>>>>> I've read some conflicting info online about the best way to have a
>>>>>>> raid1 btrfs root device.
> 
> I think the main issue here that leads to conflicting ideas is:
> 
> Grub records the locations (or extent index) of the boot files during
> re-configuration for non-trivial filesystems. If you later move the
> files, or need to switch to the mirror, it will no longer be able to
> read the boot files. Grub doesn't have a full btrfs implementation to
> read all the metadata, nor does it know or detect the member devices
> of the pool.

I don't think that what you describe is really accurate. Grub (in the NON uefi version)
stores some code in the first 2MB of the disk (this is one of the reason why fdisk by
default starts the first partition at the 1st MB of the disk). This code is mapped as
you wrote. And if you mess with this disk area grub gets confused.

And the btrfs grub module is stored in this area. After this module is loaded, grub
has a full access to a btrfs partition.

The fact in some condition grub is not able to access anymore to a btrfs filesystem
is more related to a not mature btrfs implementation in grub.

I am quite sure that grub access a btrfs filesystem dynamically, without using a
pre-stored table with the location of a file.

To verify that, try to access a random file or directory in a btrfs location (e.g.
ls /bin) that is not related to a 'boot' process.

> So in this context, it supports btrfs raid1 under certain
> conditions, if, and only if, just two devices are used, and the grub
> device remains the same. If you add a third device, both raid1 stripes
> for boot files may end up on devices of the pool that grub doesn't
> consider. As an example, bees is known to mess up grub boot on btrfs
> because it relocates the boot files without letting grub know:
> https://github.com/Zygo/bees/issues/249
> 
> I'd argue that grub can only boot reliably from single-device btrfs
> unless you move boot file extents without re-configuring it. Grub only
> has very basic support for btrfs.
> 
> mdadm for ESP is not supported for very similar reasons (because EFI
> doesn't open the filesystem read-only): It will break the mirror.
> 
> The best way, as outlined in the thread already, is two have two ESP,
> not put the kernel boot files in btrfs but in ESP instead, and adjust
> your kernel-install plugins to mirror the boot files to the other ESP
> partition.
> 
> Personally, I've got a USB stick where I keep a copy of my ESP created
> with major configuration changes (e.g. major kernel update, boot
> configuration changes), and the ESP is also included in my daily
> backup. I keep blank reserve partitions on all other devices which I
> can copy the ESP to in case of disaster. This serves an additional
> purpose of keeping some part of the devices trimmed for wear-leveling.
> 
> 
>>>>>>>
>>>>>>> I've got two disks, with identical partitioning and I tried the
>>>>>>> following scenario (call it scenario 1):
>>>>>>>
>>>>>>> partition 1: EFI
>>>>>>> partition 2: btrfs RAID1 (/)
>>>>>>>
>>>>>>> There are some docs that claim that the above is possible...
>>>>>>
>>>>>> This is definitely possible. I use it on both my server and desktop with GRUB.
>>>>>
>>>>> Are there any docs you follow for this setup?
>>>>>
>>>>> Thanks for the info!
>>>>>
>>>>> -m
>>>>
>>>> The main important thing is that mdadm has several metadata versions.
>>>> Versions 0.9 and 1.0 store the metadata at the end of the partition
>>>> which allows UEFI to think the filesystem is EFI rather than mdadm
>>>> raid.
>>>> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-versions_of_the_version-1_superblock
>>>>
>>>> I followed the arch wiki for setting it up, so here's what I followed.
>>>> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_RAID1
>>>
>>> Thanks for the hints. Hopefully there aren't any more unexpected issues.
>>>
>>> Cheers!
>>>
>>> -m
>>>
>>
>> An alternative to mdadm is to simply have separate ESP partitions on
>> each device. You can manually copy the contents between the two if you
>> were to update the EFI bootloader. This way you can keep the 'other' ESP
>> as backup during GRUB/EFI updates.
>>
>> This solution is what I use on one of my servers. GRUB2 supports Btrfs
>> RAID1 so you do not need to have the kernel and initramfs on the ESP,
>> though that works very well too.
>>
>> Good Luck!
>>
>> ~Forza
> 
> Regards,
> Kai
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5



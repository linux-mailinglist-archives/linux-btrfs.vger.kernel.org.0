Return-Path: <linux-btrfs+bounces-10172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A349EA2FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 00:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B6A166973
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 23:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0A22489F;
	Mon,  9 Dec 2024 23:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FI2zywQG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9719B3EE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787745; cv=none; b=jkdgml5Gprjp4G0rTGPt1h2jSzOCbghLo8vrX5kN0VmZ6sSMDSkuRnqLLBxN3NYutd1SvSMMsWCw/paad/Kvh8na4XUgR5dYkr0RCmw7w6VFZQx0DsVHHSjWoT4RFnr1MW7C7MLZr/hxKbldlzetgiv50BxSjk417KM0I49d0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787745; c=relaxed/simple;
	bh=cXVVUY75VgZLjGJPBrhLYmXsIh6RSIG067rhpFnnCP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jItmFjOqGrHoBWxrQ8NplTaosZ0lzI4+k7jGpfOfuRa+5XhCWbc9K8QC7NOSVH2Q5MxbWwLoMkb0VrrnGDkUQCz4N3E1Zn2VIGOhyTrsLGksV6LqJVd1DcGJGV9fB/fPeu1cwiNebQrGuqvDrzPbEuOUKK3C1QZCcaQZdM5ghhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FI2zywQG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so18218205e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 15:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733787741; x=1734392541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=be6ij+YIkPLlhFoRW9//dfgwsWwpeMNajI9t+Ir/lY8=;
        b=FI2zywQGKN6R2CdiyaXlbkN6JETK3OEP2VMZhrwNkBj7SvBt4B+xxKv4H88V9I4f2F
         a6pYQrRzTghgHVKxdncIBcm3DC1AWKamc2bOHo9neudEAzH0UohIqaY3Te+RdPHXYkqp
         7Pe4Fg/hdwUW7K7TZ7Qhr9N+CxFKR7N94r9p2xJTErylSsIC2vyRjs/oKDovdlhsslWO
         545kTcOLA30MWJ4cnldVoshT7/zcf/1MmTsac6zVcFyJoVZMIsJlydchKOIGT0RwVeij
         iPkvOMOgPqRDJo2kH7ekc6NMCFFx6FqzYTLu2jnfQEd2hak7G9Yrw0hs5SJB+8ZgVR0F
         aINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787741; x=1734392541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be6ij+YIkPLlhFoRW9//dfgwsWwpeMNajI9t+Ir/lY8=;
        b=rs2UvDt2tWAxEnrs7dunLyGYs7glbVPI2LeZgXPqSXAEgbFABLiFshMKB6upwACV6l
         lGJ0NWWwKkgg0pjgDZHnz+AEAOklhaH0t+dcL2HBycq7YyDkO6ugErBxVVZZiyKk7bSA
         5liZ1WJm9+X7r0FFH9RHcNMaEBZls6MmWZhCtsG73rPWV+hdGtI0mYQmeKLHLMXpX6mC
         kEAy9E2nOK7EMj2AK6wzbwzM2Uk7XedsFIJV9+EVDrxTd5SvJJhlDTPu2ZiJ/Iz6boll
         0UvnsRLc5hrMhxAFQ4XQP7L8lTMn65XqyGnF4QqJO8Ouc/Wgty6QztbAN5yMteFjh3ai
         HySw==
X-Forwarded-Encrypted: i=1; AJvYcCWdvNi6G8t5hgxidn+NQh0XZYWFrXD0BpQX4A1XfQJ0ryZGki1oolubRNAL62rUG5CJNBqSqLV62GJffA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl+HAYn7K0i4mqwGqn/SK8dAgpXdbCq2zp+3Ui0XXb6bdwDLo
	yquiOrElSttTsBOlZ2ccq/M3KqIuzb71wcWxDc3m36yXbLr1Qsev9QLu9VkrOEDZh//TwyLRWI3
	O
X-Gm-Gg: ASbGncvGAN3Q/AKQvHeHELFQAoeB8758gL3gShk/OasaQtQOFgj1vO/yXFF0RFE/7Q5
	zO6yiGbhBpL7LXaqv9tgne2h4nLBmFRuxurHHWg0ptvwJVRPcs6hQbrb5+iXp8lDJknQK+CQ4lv
	sUYbEGKMDLQza19kKVpdGYaXJVTbxdGe47WCo5hCbXHZCjhRDULJa11i8/lXC9+VGkzqq2Nm3MV
	vEe0oueyNQ0EWrhUF/BnmcB8BwQJ0qk/LjDpw1N71C3sZITX3MDJsDXoca8iP4Lutes51dD61Rc
	vjbEfg==
X-Google-Smtp-Source: AGHT+IHpZo97xztNcCFysxJmAQhINLhX09QzqR3+VRbuU0NRQY0Nps9QEtCzjJJzlkE3X6Aig4kyMg==
X-Received: by 2002:a05:6000:18a5:b0:385:fb34:d5a0 with SMTP id ffacd0b85a97d-386453e1d5emr2553865f8f.29.1733787740903;
        Mon, 09 Dec 2024 15:42:20 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f63772sm76131295ad.281.2024.12.09.15.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:42:20 -0800 (PST)
Message-ID: <1067d68e-322a-4aa4-b72c-f07e21d3afdb@suse.com>
Date: Tue, 10 Dec 2024 10:12:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: super slow mounts and open_ctree failed
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org
References: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
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
In-Reply-To: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/10 03:03, Christoph Anton Mitterer 写道:
> Hey.
> 
> Maybe someone has an idea about the following:
> 
> We run a cluster of storage servers, quite recent ones from Dell with
> 24 HDDs that are exported to 15 logical drives (each 32 TiB or a bit
> less) by the controller, using (hardware) RAID6.
> 
> Distro is Debian stable with kernel 6.1.0-27-amd64.
> 
> One one of the nodes, a HDD failed during the weekend (replacement
> hasn't arrived yet), but (hardware) RAID6, there could of course fail
> even another one.

It's 100% the block group items lookup, it's a known problem, and that's 
exactly why we have block group tree feature to address it.

The open_ctree failure is mostly killed by systemd, as the mount takes 
too long time so systemd believe it's dead and interrupted the mount.


I believe we will move block group tree support into the next default 
mkfs option, but considering it's only introduced in v6.1 (thus your 
kernel should support), we may want to wait for some extra time.

And since your fs is totally fine, and is the perfect match for block 
group tree feature, I'd recommend to go with `btrfs-tune 
--convert-to-block-group-tree` to enable the feature.

Such conversion will take some time too, and it's strongly recommended 
to use the latest btrfs-progs for that conversion.

Thanks,
Qu
> 
> All the logical drives have btrfs.
> 
> 
> Now the weird thing is the following:
> 
> When I rebooted the server it mounted a few of them, but after ~5 mins
> or so failed to mount the others with:
> [   53.184591] BTRFS info (device sdb): first mount of filesystem f915afcd-3719-42e8-9969-c3208ac4a169
> [   53.195777] BTRFS info (device sdb): using crc32c (crc32c-intel) checksum algorithm
> [   53.204542] BTRFS info (device sdb): using free space tree
> [   54.237216] BTRFS info (device sdm): first mount of filesystem f10390bd-1cef-4e79-8848-64cb9ba035c8
> [   54.248601] BTRFS info (device sdm): using crc32c (crc32c-intel) checksum algorithm
> [   54.258155] BTRFS info (device sdm): using free space tree
> [   54.284450] BTRFS info (device sdn): first mount of filesystem e5eb00fe-af60-4560-8de4-23206b276f5f
> [   54.296441] BTRFS info (device sdn): using crc32c (crc32c-intel) checksum algorithm
> [   54.305012] BTRFS info (device sdn): using free space tree
> [   54.490924] BTRFS info (device sdl): first mount of filesystem 465ecad0-6f2d-4c82-8a97-534446d53603
> [   54.500669] BTRFS info (device sdl): using crc32c (crc32c-intel) checksum algorithm
> [   54.508991] BTRFS info (device sdl): using free space tree
> [   54.767514] BTRFS info (device sde): first mount of filesystem 6f96fa48-93e6-4b90-a94e-c24b899a9241
> [   54.776986] BTRFS info (device sde): using crc32c (crc32c-intel) checksum algorithm
> [   54.785013] BTRFS info (device sde): using free space tree
> [   54.791066] BTRFS info (device sda): first mount of filesystem 04bd35d7-97a1-4e02-b8bb-525ca25c5e8e
> [   54.791364] BTRFS info (device sdf): first mount of filesystem 1bd9f4a0-0d17-4e47-b4f0-9c6089f3d85c
> [   54.791552] BTRFS info (device sdj): first mount of filesystem 30a91258-8a7d-4874-b260-106d9eba14bb
> [   54.791581] BTRFS info (device sdj): using crc32c (crc32c-intel) checksum algorithm
> [   54.791591] BTRFS info (device sdj): using free space tree
> [   54.800494] BTRFS info (device sda): using crc32c (crc32c-intel) checksum algorithm
> [   54.810274] BTRFS info (device sdf): using crc32c (crc32c-intel) checksum algorithm
> [   54.810432] BTRFS info (device sdk): first mount of filesystem 4a7ff844-2ed7-4ab4-90ea-35ed1f302aad
> [   54.810446] BTRFS info (device sdk): using crc32c (crc32c-intel) checksum algorithm
> [   54.810452] BTRFS info (device sdk): using free space tree
> [   54.810780] BTRFS info (device sdg): first mount of filesystem 0babee90-f75e-490c-8a3b-98f77f4410a9
> [   54.810804] BTRFS info (device sdg): using crc32c (crc32c-intel) checksum algorithm
> [   54.810814] BTRFS info (device sdg): using free space tree
> [   54.810812] BTRFS info (device sdi): first mount of filesystem ce70f65b-7118-4fa3-8e28-0e2b8028ceb6
> [   54.810836] BTRFS info (device sdi): using crc32c (crc32c-intel) checksum algorithm
> [   54.810845] BTRFS info (device sdi): using free space tree
> [   54.819298] BTRFS info (device sda): using free space tree
> [   54.826970] BTRFS info (device sdf): using free space tree
> [   55.070783] BTRFS info (device sdd): first mount of filesystem b9fac730-ec13-4b70-9a84-78e9f9497cab
> [   55.080158] BTRFS info (device sdd): using crc32c (crc32c-intel) checksum algorithm
> [   55.088123] BTRFS info (device sdd): using free space tree
> [   55.094137] BTRFS info (device sdh): first mount of filesystem d3cde25e-b9b3-49c0-81e0-8b18b09f15ca
> [   55.094225] BTRFS info (device sdc): first mount of filesystem bd453578-8008-428d-ad7d-32f2da5cd7a9
> [   55.103561] BTRFS info (device sdh): using crc32c (crc32c-intel) checksum algorithm
> [   55.113032] BTRFS info (device sdc): using crc32c (crc32c-intel) checksum algorithm
> [   55.120690] BTRFS info (device sdh): using free space tree
> [   55.135355] BTRFS info (device sdc): using free space tree
> [  267.836887] BTRFS error (device sdj): open_ctree failed
> [  268.316577] BTRFS: device label data-a-3 devid 1 transid 231030 /dev/sdj scanned by mount (4175)
> [  268.355695] BTRFS info (device sdj): first mount of filesystem 30a91258-8a7d-4874-b260-106d9eba14bb
> [  268.367263] BTRFS info (device sdj): using crc32c (crc32c-intel) checksum algorithm
> [  268.375604] BTRFS info (device sdj): using free space tree
> [  270.914917] BTRFS error (device sdk): open_ctree failed
> [  271.014560] ens1f0 speed is unknown, defaulting to 1000
> [  271.265328] ice 0000:17:00.1 eth0: NIC Link is up 25 Gbps Full Duplex, Requested FEC: RS-FEC, Negotiated FEC: FC-FEC/BASE-R, Autoneg Advertised: Off, Autoneg Negotiated: False, Flow Control: None
> [  271.285199] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  286.072892] BTRFS error (device sdl): open_ctree failed
> [  295.934646] BTRFS error (device sdn): open_ctree failed
> [  301.649656] BTRFS error (device sdm): open_ctree failed
> [  485.912139] BTRFS error (device sdj): open_ctree failed
> 
> No other errors are printed, i.e. nothing from the megaraid_sas driver
> or any of the typical block layer errors.
> 
> Does it time out?
> 
> 
> When I later mount the filesystems one by one, it still takes extremely
> long, e.g.:
> # time mount /dev/sdj
> 
> real    3m45,153s
> user    0m0,001s
> sys     0m0,640s
> 
> but succeeds.
> Looking at iotop, mount, during that, only reads with about 400 KB/s.
> 
> Now you might argue the RAID controller is simply broken, and reads are
> super slow, but when doing:
> dd if=/dev/sdj  of=/dev/null status=progress bs=1M
> I get several 100MB/s.
> 
> mount also doesn't seem to reach any CPU limits, it's basically always
> in IO wait.
> 
> 
> btrfs check /dev/sdj also reads just with a few 100 KB/s, but gives no
> errors:
> # btrfs check /dev/sdj
> Opening filesystem to check...
> Checking filesystem on /dev/sdj
> UUID: 30a91258-8a7d-4874-b260-106d9eba14bb
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 29697098264576 bytes used, no error found
> total csum bytes: 28968443996
> total tree bytes: 33411612672
> total fs tree bytes: 131743744
> total extent tree bytes: 218857472
> btree space waste bytes: 3789582434
> file data blocks allocated: 29663686651904
>   referenced 29663503867904
> 
> It also reads very slowly first (few 100 KB/s) then, goes up to 70
> MB/s... but still all wait IO.
> 
> 
> Any ideas why btrfs - in contrast to dd - might read so slowly?
> 
> No rebuild or so is going on, so this shouldn't cost performance.
> 
> 
> I mean it could still be, that the controller is only fast when reading
> sequentially, but breaks in when doing random reads.
> 
> 
> Does any of this ring any bells?
> 



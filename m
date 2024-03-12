Return-Path: <linux-btrfs+bounces-3232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42171879BFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 19:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739261C203F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2651420CA;
	Tue, 12 Mar 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="ZVgdiLrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBD13A89F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269883; cv=none; b=hSIsTBCm2jdjS+gGBjX3i9jv/0kw8niSLaLa0izzRHzozLcZy6qKK6EKTpI5QZwKLrD3nMHJc7V2mbLZD2f6QNfLgpshEzCyWaNMywUe4Vq58keOu90y0/yvfOKEAIaRs0072sKEMUT0OWygo2C6Q6zZnrwOH5uyupCAiD2xX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269883; c=relaxed/simple;
	bh=IH7F26mMEDVHxSSQ/59sclVQWPoHcOnEEzinRTdWca8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0UAzVqUU3YzDhxDl+8/UFIt69Zz34zhclaXEnqeIRLFryT1WeC/6JQlcg2HwgvmNQkBEe5zII802ghWStV2J4F2p371/8CGP1fqXcHNcW68iRG+9i+uBJr2uqZyuOA6oxs1JI6I1PFZeYa3yHwzmf7Kwj08zmGE1QWguVO9R8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=ZVgdiLrg; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id k7HUr0kNvQc3jk7HVrIZuq; Tue, 12 Mar 2024 19:55:21 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1710269721; bh=KBP2olF/DX0pbYMNilkyBPbSF/hYpJzy3q+9JJNl/n4=;
	h=From;
	b=ZVgdiLrgjKjAM75fnYRsBK0dPbpWEynq2q6Kq8FoV/HrMchOLj6rgRQMJ7UozvxmT
	 JzkmuHYDsWJN5A4dsphXhnYXmXtvdfbnEjbvhgIM+o2lv/0yNVFxUKR/qKloerSQib
	 jV7n28u9PmgWGGQx4KOTOd+JJJoYg2Ek2V4VNlK7wf4ugVIr1XSY+uQOXFKsXpKGz0
	 /jTCVhryU19c4/zXSZSaaUgd02OYW/4hh06hG2VEXrfLDAklRo3fwu0hGVYZOdGIsu
	 peuIDOHfs31Iw4hj9P1O9je3xu1HW7Jt80bYuH5T8JTG6tipRz8lQ1dhhvPSoTCHug
	 NG0HgVugUsYOw==
X-CNFS-Analysis: v=2.4 cv=eux8zZpX c=1 sm=1 tr=0 ts=65f0a519 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=s_cqgyDIn9OVIfsKff4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <c8a4e4d4-8fed-4815-8cd0-fd6df354e99e@inwind.it>
Date: Tue, 12 Mar 2024 19:55:20 +0100
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
To: Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc: Forza <forza@tnonline.net>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Matthew Warren <matthewwarren101010@gmail.com>
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
 <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
 <CAMthOuO56J5OhCnedJLxTuFxTPq7ryCGP_TxMrcXS+4jLj0aiA@mail.gmail.com>
 <4feb955c-cc91-4f0b-8e62-b6a089eea7ae@libero.it>
 <CAMthOuPQDMWGOA9O+StwnmUhZXxsF3ePZKMBgDZdPZ8gxQ+sdg@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAMthOuPQDMWGOA9O+StwnmUhZXxsF3ePZKMBgDZdPZ8gxQ+sdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKxtBa0Zo4Fohnr940ff/4bPdih8ezU5tc1m/bU7hNdQh6Fu1YyocfrwkLiuOF2BNNh6Rde2iHw5UG5q1lKj8CMFnD2D0u3KEKePbBYTlbdMZ37XrJ5T
 nkm1gIhNKHuZI2F701M8R6E3AxqEG50tXRjKp6sGv3tqeZwcYkpuV6Gy15T3KFKr1YsxNasbezrP17bRxq1r3bOMnuHL9QsX8aKVF5F6dQvDLTh5ECD7he2p
 Qf4QYN33RofqvJzYKmsvW6sqa8qlHcAXq/CGeJcuF4l0gLfRQbF9UNqqCqjIkRwDFQ9kYfTbgVhanwrjYfvKwg==

On 12/03/2024 13.39, Kai Krakow wrote:
> Am Mo., 11. März 2024 um 20:26 Uhr schrieb Goffredo Baroncelli
> <kreijack@libero.it>:
[...]
>> I am quite sure that grub access a btrfs filesystem dynamically, without using a
>> pre-stored table with the location of a file.
> 
> Yes, it probably can work its way through the various trees but the
> extent resolver and reader is very basic.
> 
> This means, at least for now: do not let anything touch the boot files
> grub is using, and do not use compression, then it SHOULD work well
> most of the time.
> 
> I'd still avoid complex filesystems involved in the grub booting process.
> 
The other options are not better: using a dedicated filesystem is not without
shortcomings: do you think that the implementations of VFAT in the UEFI bioseS
are better ? The fact that the FAT filesystem is far simpler is a plus but...

As sd-boot user, I like the simplicity of this bootloader. But in some
context it is limited. My efi partition has a size of 1GB, but now the
kernel+initrd images are in the order of 100MB....so it can't contain more than
10-12 images. This is fine for the standard user, but it may be not enough
for some hobbyist...

grub is over-complicated, but it can withstand complex filesystem layout...

May be a kernel with a dedicated initrd which kexec the real kernel ?

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5



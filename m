Return-Path: <linux-btrfs+bounces-10740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D4A02623
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CF51650F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4AC1DC9BC;
	Mon,  6 Jan 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=rewolf-kernel-mail@online.de header.b="KGZ6bxsM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F81DB943
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168828; cv=none; b=Jeaxm0CjjpoieAKfVUS7SVz+ThK06UUWv73YXK9WYQcpDkJGm3oT4XNYOlMrWqjpKnA/WdBBYebsVhJLecvw4d4Fl4Ht9e8ovwBrX/KnZglh7WSxR7CTFq36wyKHkTj5rFgVQkQy4IY5uEF316+85951xgz0dy2CcWWtbhquYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168828; c=relaxed/simple;
	bh=tZDcBSJ8cT9r83kYuB91XcxAoH3nokn4s82/vXBYQ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vs0U693/YN4kpEMVGgZLEzg5cXrKbynkAoGeO9zIE8hogU5PWVYYLjjwB1Dh0mpzSLdIvdWd2AJJII+9LOkNUPoILIaVw0Spg5KjmyOkJXSlfV4mHn2LkLBcpXvWQpaLsh9GyUpr24W9NhL1zF2+xRbSBVRWeldREK5X9lHYKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=rewolf-kernel-mail@online.de header.b=KGZ6bxsM; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1736168824; x=1736773624;
	i=rewolf-kernel-mail@online.de;
	bh=xAVZ+2mGMUCy2HGhWeqkfs5a0CCU9UuD5DA/6mgQCf4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KGZ6bxsM+tpaUaHD5u9h4N3pb2v9bdUTEPLd0JXu28Ix8p6MSe56eXE1C4SpbdjP
	 ILsfMLDCyYJZqpj3rKFoPnCN1cGKu9oQtZw/82vxrXEZYt/iuu6Bj8BIerVV0cqIx
	 5yB+OgGt3p61Fra/lvcwzWNsfVwqTUYaKPHpGswDP7ufRxd11FWk62wTO/wOrYioP
	 sSX7BysSd7a7GkCLLuyilpZ8jH3So38Xvx+67yNFp/tO05YRy6hiX9y2VH2TPHLwr
	 XTRc+oge+174TzjMC8s0dJt3vYWp8g5hHjPqZtibfT6Gnhh9GsuFX3zkXlSwD2Hxv
	 rETbT8AJ/HVpl/eNqQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.6.211] ([92.117.232.113]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsDe-1tM0JI1B8C-001qv0; Mon, 06 Jan 2025 12:58:36 +0100
Message-ID: <ea3b8ea2-c832-46eb-9b4a-fc21ac452915@online.de>
Date: Mon, 6 Jan 2025 12:58:35 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs scrub fails / __btrfs_free_extent:3257: errno=-5 IO failure
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <8fc3f4fd-7b24-4367-9685-4b14598ce098@online.de>
 <84ff6f21-58b1-4899-ac81-32dd15d090d1@gmx.com>
Content-Language: en-US
From: Rene Wolf <rewolf-kernel-mail@online.de>
In-Reply-To: <84ff6f21-58b1-4899-ac81-32dd15d090d1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XKXkqZ276Va8mUg/ayX3RXddBR3kJYhNtglWdXrGfdf/qsuO5+x
 /XwrByzPZieu3re6TPqQIdpjy/XvhZ7m3QqFk4TtePX4ChX44SyFLXBZvmTjPi/9u2QTtxK
 VVC3wChPosStixRU8FIguFVKQSoe474rPCEsib6fZiTLyWcr6P7MRLMIOTlN1JuGKIO1NUW
 E42q9CzCvLZ3f4AaHwCXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZJd7pzW45Ak=;srr41n9nOEfiTPvu3ol75orAyOP
 NRZWxED3Op/u3hXxHPT5rdBJpORp2VJZ8ZAvlnqlUAmYrFZfTHuxMmjaI+VlVBLKcPWgqRd8s
 RAOQj4OGVycwspwmh1zCrSlYY9VL658Vm8EPw7H8twtH7Fvo+MSmXn/N/+VqM1ED5/hxmJap3
 SsCBNDf0dX5MqA8UwiuyGEfwHCYtb3WxP8xSCR99m/5ekzzhGOx/EBcH0w62jTCdTadRwEewf
 8yQODvD9F8NN3uOvzIkztfF6EfBg1he3DeTT+QDN1RAf2G6+/kRTtF3CrNkBVJb4hUM1Oir/3
 Gk5P1pJVisc78BuQvULSDNzCoPz58bVdJswBVoRJpf75WOcKEEmMy4oqOBAlBq9Dri6QIxalE
 Af/CV8naE0SorXSxf1P4KKTpbqDPMw83mtvWhcomF1uTRcetZNpcYBNMlk8TT9wgh4pE6Zmer
 OgNipx7uAdClpHf8zw5Nb+Qbaq2h1rt6UmjDL6AxBMfPiwAnyzexziF5djezKQ+mOjmT8ZpOb
 fARPSKnE3p8TnfM+6kYAB5vJJ5f1vX38fhDQ9Ddy0bPJ32k2xILIc/297Jk9WHHwjp45+P43y
 7Vc0SYbzATSwsf4OJxitKqo1ELdb6e2s78z/UE/d9XLFalq2YUX/W1jGgAPFeEd/OAOuKMsDQ
 Ipk0PiPP/Taz8fChxT7l1S+d+R4uXYFSuFyVVqlev5hze/Jdn4LW9nbJ72BHX32m+fe8od6hN
 6AyOxSUs+xj25SNuX/V/DU0GkamxB7riPtf6dFyF1cmL1nFx4HnlWW8OdQGI904PP9Dd+O7HU
 kOfm6snhX2zO6JwcugxTYq+8mhqyamFrCPPn+kyUAF6dxjRjgF6BqXaVpG42XWMq8OkWKgz/g
 jSoQPs9Z1mAp8FCjYKWM3z7A8tnslXzNVpDNf8eoDwWp4R8itEvXsouzqfqS9SdHgnIIZetHJ
 VMi8LcoFSZvdCgGiIOKTWVF2z81p/eZF6fvGYJ4tVAPi31k21m3jW9Po3U7fFzCg57913urR3
 sOTouFMgKSa1iNZfru9LyRw9DB7aNjEzFFaIXwy

Hi Qu

Thanks for the input!

> This is because scrub needs to insert an temporary item for resume usage=
.
> But due to extent tree corruption, it failed.
>
> It's not caused by scrub itself, but fully due to the already corrupted =
fs.

Ah I see, so scrub will basically never be able to do anything with such a=
 damaged FS then.

> Although I won't really just trust ATA selftest, especially when using
> with a SATA-to-USB convertor.

My thinking was, the SATA long self-test runs entirely on the drive (from =
what I understand).
So besides starting the test, the USB-to-SATA adapter does not interfere w=
ith it.
And I agree that SMART / ATA self-tests are to be taken with a big chunk o=
f salt :D, but at least the "long" one did give me useful indicators in th=
e past.

> All 3 of them can be the cause, but I suspect the converter more.

For the record, here are the HW components:
- 8TB drive (the problem one): "Seagate IronWolf" / model: ST8000VN004-2M2=
101 / firmware: "SC60"
- USB-to-SATA adapter: USB ID 152d:2338 / JMicron JM20337
- 80GB test drive (the one I did most of the following tests on): "Seagate=
 Barracuda" / model: ST3808110AS

> If possible I'd recommend to do several tests using raw btrfs directly
> on the device, and do hot-unplug to emulate a powerloss, to see if it
> can really corrupt the btrfs.
>
> If this setup is already enough to corrupted the fs (without physically
> crashing the HDD header), then you know what is the culprit.

As suggested I did a couple of tests. I used the 80GB drive that I had lyi=
ng around (see above). To produce writes, I used the following script (I l=
ater realized that I probably should have set bs to some prime number, to =
get worse alignement?):


dir=3D/mnt/write-here
mkdir -p $dir
cnt=3D0
round=3D0
file=3D0
TOTAL_FILES=3D$(( 1024 * 8 ))

while true ; do
   cnt=3D$(( $cnt + 1 ))
   round=3D$(( $cnt / $TOTAL_FILES ))
   file=3D$(( $cnt % $TOTAL_FILES ))

   echo "Round $round with file $file"
   dd if=3D/dev/zero of=3D${dir}/file.${file} bs=3D1M count=3D1 &>/dev/nul=
l
done


There were 2 setups:
Setup 1: no partitions, a direct btrfs file system on device (everything d=
efaults).
Setup 2: no partitions, a LUKS device (luksFormat with everything defaults=
), inside it a btrfs file system (everything defaults).

I tried the following tests:

Test 1:
- run script
- at about about 2 gigs written, usb hot un-plug
- a couple of seconds later, re-plug USB
- unmount, mount again, run scrub

Test 2:
- run script
- at about about 2 gigs written, pull power from drive (this also makes th=
e USB-to-SATA adapter drop from USB bus)
- a couple of seconds later, plug power back into drive
- unmount, mount again, run scrub

Test 3:
- run script
- at about about 2 gigs written, pull SATA cable from drive (the USB-to-SA=
TA adapter has a separate SATA cable)
- a couple of seconds later, plug SATA back into drive
- unmount, mount again, run scrub

Test 1 and 2 I tried 3 times each, with both setup 1 and 2. Test 3 I only =
tried 3 times with setup 2. All 15 iterations passed without a problem, sc=
rub always ran to completion without errors.
Then I thought it maybe could be the 8TB drive and did some searching:
- https://forums.servethehome.com/index.php?threads/read-errors-on-seagate=
-st8000vn004-firmware-update.31854/
- https://www.truenas.com/community/threads/synchronize-cache-command-time=
out-error.55067/page-7#post-580355

Unfortunately I ran a bit out of time, killed the FS on the 8TB drive, and=
 restored the data from original sources. This time I went with direct btr=
fs + ecryptfs, to remove one layer of uncertainty. I did check /sys/block/=
sda/device/queue_depth on the 8TB drive, in the target system with the USB=
-to-SATA adapter, and it seems to default to 1. With this 8TB I then did 2=
 final test runs of test 1 (usb hotplug) and test 2 (power failure). As th=
e drive is rather full I did not let scrub run to completion after the tes=
ts. However there was no problem with the super block, and also none withi=
n the first 30 min of the scrub.

A few final questions:
- Do you think the problems described in the above posts, related to NCQ /=
 "SYNCHRONIZE CACHE" could have caused the corruption? If yes, then I woul=
d probably buy another HDD for this setup...
- Maybe I just didn't trigger the problem in my tests, and would need to r=
epeat that more often? The HDD is on a SW controlled relais, so I could au=
tomate the power failure test.
- Are there any system settings I could change to improve reliability? Sac=
rificing performance would be ok (to some extend).

On 03.01.25 22:17, Qu Wenruo wrote:
> Thanks,
> Qu

Thanks again!
Rene


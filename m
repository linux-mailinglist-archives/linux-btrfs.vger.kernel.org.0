Return-Path: <linux-btrfs+bounces-12177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F134A5B9A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1494F189490B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEFF222572;
	Tue, 11 Mar 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.opensuse@gmx.com header.b="GSFJugUU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B72206B1
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677446; cv=none; b=f6mqMy/WrflvbArvJzvbK4PRheU/DQ/xJSmzt3T1fOFVE0KWfCK6dkUNzHuwd5KPrsPxz8ZqYe2zwoXr3Ce8LThXxbIFGZ+yO7DsWHpbFljbMV9/fBsz4cGrZVObITaLUByKvSyRtdyXY33Nu4GyFqHI+3/Ymzgv8T9haFzILVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677446; c=relaxed/simple;
	bh=pRU7j+YVSrkLcbqOmQCCtXWaPcy9vnP/rX4cVzGfZao=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=quTutjioOB3768IfKWgAT7rMy/RVU/tqyYxCPCYA/PHN5jxp7RQFHovHabkMOOd4S1upP93lKC0q6oQgKygvhfDP9Uf16lba5VsjF2NPrJmgo5+QKDJ1Z/1zJOIEAjyUIdxuP+u7ceLw59aS/5xcXjn4mUu+WAyHvtVZlhFgUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.opensuse@gmx.com header.b=GSFJugUU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741677442; x=1742282242; i=pj.opensuse@gmx.com;
	bh=pRU7j+YVSrkLcbqOmQCCtXWaPcy9vnP/rX4cVzGfZao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GSFJugUUf+PRccJYuBf+ui+6ExFRe6HFEKMjB/Swv7z9alcXWe13AqKfJrE5gbCs
	 19JnhbIUWyzFFSqUrD9UF5+TwlBKwIvJ856dY9Q1fEg/l9XAouw3vyYCrT25YzQ/l
	 L7RKQ28p1EfbheC1lHBvVo+P52frNmc4NCTjEwLfIKD5L1Wim/lAjXpQqq/yV2/7z
	 UUUPfWnMgi/TJSpPDVk1wK6YVHTQXeYvWmkHPK7NoXSCJo6z3EHhlUUkqN5T5zcAg
	 k4K7pxy4gE0+A7+HG6ORuiPwl8qXhuQ5yHEBLbwN91pKkm6O9DAom3pdXdx5TE5h2
	 m5z52XowH+bRyj7gaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.6] ([75.168.208.110]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1tPgKS0L1K-00lV2I for
 <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 08:17:22 +0100
Message-ID: <469ea2a1-c53a-46b5-a32c-9a69d60c4ce1@gmx.com>
Date: Tue, 11 Mar 2025 02:17:15 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: -pj <pj.opensuse@gmx.com>
Subject: btrfs filesystem mounting failure (bad superblock):
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S37bEgcNcvuz2yjrtI8AHJ27kUZtUunb7/+N2e01gWqSg/MwDoI
 hZmjl8hH8lLXfjyQ17xGqEUdMAA2BIWyLpT1a//wuIosD4VgJqsYfgXDjAC8T0Tr3tw/oOD
 yiBFyQMmiXfDtNiPxtOGCH1GdFSG1BQedjx8OAsWC70/8E02KEOfiiCbekQ/GSkMexw6467
 jHWUmtysQBbjc3hIq++rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/t7ZWal6M7M=;rdw/DT1dFrd6aPn5HSef4odxr4c
 CaP6Mttm9z8vSgI5SJu9pX4+Fjcqf7E2vqa3Jqq5+fzc15JeLRY07AVJifX934LqUhgu280Di
 hpYY5lCo6UaYozhRg9cWD5pvk6guWNvf2HwsZxHAyZ15vRA5Jy4X9hIgwgnm4azShnhlgk5Ti
 xVF0WPG4hDX6sHkIKRnOpFadLm5ifp5/pIqpeIcEpx7/dEpBcoRIV9eqmLa2Kkn9VwM9+/L8s
 IBRU6BJ4b5ZB3hMH/2zwGfOQOgeoGj/SoG4tZ0Onaa2za609PajH5p92xVB/rQPaW1LfIvazZ
 Gl0l4d+LAUTeUAok2oTd1e6JSfTxQ1TQeP/2+9K527ElCQA6LXTWlJzBTWhlM57TsPwU84+R1
 WfAmKlU6uU/uP0/XcOWenDJKS5K+e6d74BB0rvLBS6vUN/E5Z9Ngwn+VIxJQeDUHqworQfdGV
 GeDRYCoqlHgx9q8/Zg2R3XVs8rE6XB9w5m1aooh//2Inpc60jwa4uDuvGmUe1BV8/EBNbAPRE
 nj6xf2H/mCVfwpEGpnQY0VXFaVNzLCCH4MBTtEMXJc5EkbTAhOkob7/9+C6nluj68jesFSFoJ
 lhT09R+rxVNdfxTG6gOe59/D1la2P7+b/Akcjl7XOIGL2otr4f3u7JRBhHNBKkdNtqwZSUq/A
 YnbVhbjbCmxnqzHrVPP8Mwt2/+kSx0sBkMdmCHSOqLgAtyT4dLBG+sNJRPHyDzVsLmyH1GpET
 ialeIeq09YG+5x6BMRwenblx2oJA4AMZnmE4iuVnQRRqbvBdxj9VhVvHLAUbSEXjNfZYe6l0S
 pfZqRSuLZY7jwdDOKFUXHZEEQqpiEIxECrFgMBGl1KrpqoqWxGpyKBVZZ5t4tk/2JX3G945+X
 pFafPFs0rAN6vX7qD/8bSLUZndP5y4kv4qu+7qzqn22CsLTY1uW/7OW26+WIOuD2gQE8WqQUr
 3oa1ZLbltIepXr9r5Q0G34lo/TpRCV0Ad05Z0XVeawSfm5y//RkYAwyKIfiPYLSJfUFd6tQGp
 CPrPtYqRqrdTIxLMxYpFWK9t6xy2HrkRjhimfhLjgZHGvdXk8mRQ7mH0QXx4YqHreOBuSMXWL
 c8r5NEykN9b1viTfBQ3Ft4ZYv+3FQmNy1aUShWMOXAyxTQC1uJvj8cFCKnwergkvxG+42zEUl
 mzq77ZAA4mEcMoQUGhQuNe2tAZ9LcYUsfE4cSIh0/pzUd/hLj2aNjcMVWJd4/b9BIAAWipAVi
 MCPxi/P4+5Y4Iu5nLGFoRatQQ0rA2/GWBZeG00tki1FbDxHIl54T95PNPqjfrhU0g4oKHzZuX
 paXoHEQwTCixFR50uOU+3Tw0Io9tqaQ2+8GG8qbCjenpiQj1sk2DNHOJeERucK4LaO2Cyl8Dg
 SaVUOv6fkmJ4dQD2whevFyFMiQEVJ4ZtTU02ZSwFuJYH7evFFiR71Xa1KL

Original question on openSUSE Support Mailing List:
https://lists.opensuse.org/archives/list/support@lists.opensuse.org/thread=
/7KCP6RUP2PDN3ZBVHQTUVI764ZIRJRNE/

Hi, yesterday I used the machine here. I organized trash can, read
articles and decided to suspend machine and go to sleep.

Today I wokeup machine and inside KDE are errors of kioworker not able
to write to file. I powercycled the machine and it is unable to reach
graphical target instead it reaches emergency mode. I attempted to roll
back snapshot with no success.

I attempted to use openSUSE Rescue CD and perform chroot and there is
failure at step: 'mount -a' with many messages related to 'bad superblock'=
.

How to proceed with this situation if possible?

SystemD journal is here > https://termbin.com/pjhd
dmesg is here > https://termbin.com/w4jh

[ 9.572877] [ T852] BTRFS info (device dm-1): balance: resume -dusage=3D5

Using openSUSE Rescue CD I passed the following commands:
# mount -t btrfs -o skip_balance /dev/mapper/system-root /mnt
# btrfs balance cancel /mnt

The machine is able to boot into OS now. How to proceed if anything to
correct the initial issue?

Run "btrfs check" on the unmounted filesystem. Better to use Tumbleweed
which has more recent version.

I ran Tumbleweed System Rescue from bootable iso of downloaded snapshot
of today.

I took a picture of the btrfs check output for review >
https://paste.opensuse.org/pastes/c6b44a4e7ec3

Can you please tell me why this happened? Is there something left that
needs to be resolved in order to fix the problem?

-Regards



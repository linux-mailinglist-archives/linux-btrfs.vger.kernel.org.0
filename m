Return-Path: <linux-btrfs+bounces-16544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC6B3D6F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41761637B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 03:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779D2153FB;
	Mon,  1 Sep 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TzMWXPxk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACE1DE3C7;
	Mon,  1 Sep 2025 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756696038; cv=none; b=jLoMe5x2JYc5z8Y1pPA5R+UYS/9YZNpbq7fBKWWu29QIGTjzqsVB0kEP8QYZX/E6rxxxyeJWdK5+/wpQpBjgED49KBpjAmy9qMQ4av8LuSQc+jpl2T4IgzqfrXj6ZUC3ShTuQ7CVQCKBHeSx7xKiE0RcVqiH11tvJV5djxDcLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756696038; c=relaxed/simple;
	bh=15M/MiCOx5p5VN2v1DaLJnEXL/n3TAl5pfMVLULr9qY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cDJfHPUpp6c0q8t1P1Ayfj2XTSCbQ233FBLsZJ1jfykv7fcGg/fqL9hc+Z6MIDOzG4MH8K1FicmeGKLfEjTvT0KM1d/eNBC38CAAzLgWbDeMFFbp5g5789XFrz/fhBKe5ioE99qztJwBQvvSk6+P+j8Y6s6OunL/eS3KF/VGxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TzMWXPxk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756696034; x=1757300834; i=quwenruo.btrfs@gmx.com;
	bh=fszt6sGaqYJVG2B8tEnocz97bwP27lPgmdYENUwPWrk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TzMWXPxk2sxJX/Wq5cwPN6RkSjebBKWl34jcg9YfpjcDV1OEAbVMBKksIu4zAFmn
	 Ur0KMkLry4qfGk9MIBGjQmyT24+DIYZWUDvuoe0IypycAletTUyokD1sKteYD60bC
	 8UoWQRL64IrUH+V91xL53TReyUIohdO6j0lQuKbkH9EzObo5LMjz2wMiAWWiNei3j
	 iTlRpwVJOFdEyuRwcCgffOiDLvURDZxY/8fzDM9QDHybeYrQAyX17mFv0vOxnAjT5
	 G0KBFBUUEntlsfLOrBr+JBxvqdA5RGRYUXfSvujbyPTXDcnZIZMSbaHdSShqMUerK
	 I9LM0CRPtmJPLbm8kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGiJ-1v25w23ydP-00KCCU; Mon, 01
 Sep 2025 05:07:14 +0200
Message-ID: <db593e62-1d57-4d11-84b0-18d0f49cf0e4@gmx.com>
Date: Mon, 1 Sep 2025 12:37:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: generic/563 failure caused by losetup no longer handles block device
 anymore
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UW5jfl/tyTxuat1bS9GYcyHBlCB932k6XQK3WHJw1rZnmNGH2Wu
 OAnXDphaTjf8dNlL14Jzn+V9Euvi/TlD6uxN1xoWiZljfNH6BI5VR/ltB+6TpzRaxxsVeaZ
 p76U9gvDO5VJ4842pm+OU4yoZJQmMm0G+gU3KiOhTNqkr9Sg4xnXEnk8LF5I76itcuZpBo7
 ycJK7wxem/HsJweGsjDcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rOtvuMlm1MU=;zKKpmlJgiKCUYQfaIiBvX5n3pmB
 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

Hi,

Recently generic/563 is failing on btrfs and ext4, and it turns out the=20
losetup inside _create_loop_device_like_bdev() is not properly creating=20
a valid loopback device if a block device file is passed in:

E.g:

# lsblk  /dev/test/scratch1
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
test-scratch1 253:2    0  10G  0 lvm

# losetup -f --show /dev/test/scratch1
/dev/loop0

# lsblk /dev/loop0
NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
loop0   7:0    0   0B  0 loop

Thus all filesystems, not only btrfs is affected.
This looks like a regression in loopback device size handling.


What should we as the next step? Waiting for loopback fix or start using=
=20
files inside TEST_MNT as a workaround?

Thanks,
Qu


Return-Path: <linux-btrfs+bounces-7713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608A96764B
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6691F21982
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716416EB42;
	Sun,  1 Sep 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="XPX3H/8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395631C36
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191582; cv=none; b=FhL6UmZUEX3XPm+zlC4+ggMdCnQZYRZVAPXuM5ztQ+RgsfMWlz06jUTo94WCToqmdodrPyH1KFVVcyyhJ/03r9vwmJ+apYX9X+4scZan0wBQZgkuHqcY2VaS0XsGBRhvXHS+9ORTNDIFu6+++fGBQw1dFJiXKsXPG25O0F5ujN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191582; c=relaxed/simple;
	bh=mCBbJOPZjMEbqH6A9q6caL0EThHYtf5b3qFH9KccHV4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rVIvGloh5u61eoSdJP/a1PA0pj18aLaqIx+rvf0wKnCVge4W7W20aIq49eZWgk7LCnKkil6XHWmvRlGlugIrs+dTPuV9GMsot1/BW1hx5rCxDSM/DGNbA9fzro/kvts3bLlzKFr269ZSHQCG1g6BsomOmzhFL7ENrJdIYnnUqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=XPX3H/8N; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id B0CB89F27C
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 13:43:08 +0200 (CEST)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 481Bh1Xd1080573
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-btrfs@vger.kernel.org>; Sun, 1 Sep 2024 13:43:07 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 481Bh1Xd1080573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1725190987;
	bh=QNX0zOC2mNwda0Zb/1hbxDpURSABdP/K/7DlBsZ5eDU=;
	h=Date:To:From:Subject:From;
	b=XPX3H/8NER7r1L1AL8q94BmNxVSq4rmRgK70mmW4L9A5oAfzIgImW2tmsvT+tDGal
	 ckCAV9KW81MYPediRi36cN5m9vukKSUZqP3rgN0VjDa0dLi7+6qu45809SMecK0gFc
	 8Yi6bFn7FSl1w4NO3YWvNaU6mO/qiP8DWnahUE0a1easFU7xZlZqujpppc2lfv7CNp
	 9NDPGMVRg2lYT0TvA+HPiAigxMvZS8c4pH4/gal89so3MxuJH5+osyQmsgBOUmaAB2
	 od6t4kWcDgArG0hCuguhCup/m0TXgmzstDCbYC45EPtA3tcpc21Wl7ra+aeyFt2qoM
	 rGOW+mxwzYeJuQpKCr75VKCSDo01hX+qN2ZeXxqCWUW4OsMWy3gM+a0sqpwCAjklo+
	 TcYJaVZV1SmB6F7PSFzr79zLL8jQcLwOKFdzjrS97ihEPcbos71SGz03XjtpE54saW
	 ICSS1iLw5sa0ld2zMSqLW3VAwBYXttsKZjQg4EAY0AO9pm2nMRWBh56QjBTQWuXITT
	 lLF6kZAFOY3mRrPftUGWeRvA/0rK9WxnrR3y221R+jWa6SEJOT3ton1y8FcP0utzqK
	 AArzx/8unfgT7stTkjTvUGm0fE9OceviWdP9AfUxy8VXYyNDE6xlqKivgsxWSmYNMa
	 WgM1nFV1u5jNb0ogAVvNSKTo=
Message-ID: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
Date: Sun, 1 Sep 2024 13:43:01 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Corrupt BTRFS can't be get into a consistent state
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I'm having some Fedora Linux VMs (actual versions, latest updates) in a 
virtual test infrastructure on Virtualbox. There I run different VMs 
with different filesystems (ext4, xfs, zfs, bcachefs and btrfs).

I had a hardware problem on the underlying hardware where around 1000 4k 
blocks could not be read anymore. I migrated with ddrescure the whole 
disk which worked well.

Of course I was expecting some data loss in the VMs but wanted to get 
them in a consistent state.

The following file systems got very easy in a consistent state with the 
corresponding repair/scrub tools of the filesystems:
- ext4
- xfs
- zfs

Unfortunately 2 filesystem can't get into a state, where the filesystem 
repair tools report "everything fine" (of course with some loss data, 
but that's fine):
- btrfs
- bcachefs

btrfs --version
btrfs-progs v6.10.1
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=libgcrypt

commands run with btrfs:
btrfs check device
btrfs check --init-csum-tree device
btrfs check --init-extent-tree device

But btrfs never got into a consistent state, also with newer versions 
(have copies of original virtual disk, around 6 month ago). Also btrfs 
check runs for hours for around 4GB of data.

To reproduce the problem I created a new filesystem and copied some 
files there:
# Copy around 4GB
time cp -Rap /usr /mnt

Afterwards I created a (quick&dirty) script "corrupt_device.sh" to 
corrupt the device in the same manner as the original failure (1000 4k 
blocks will be randomly overwritten).
Script: see below

Result: It can be reproduced, that btrfs can't be brought into a 
consistent state even after several runs of the repair.
If the filesystem is modified in between (e.g. some further files are 
written) it gets even worser.

You can also try to reproduce it and create a testcase out of it.

Any ideas how to repair and what can be done to get it into a consistent 
state?

Thnx.

Ciao,
Gerhard

Script corrupt_device.sh:
#!/usr/bin/env bash

RANDOM_DEVICE=/dev/urandom
OUTPUT_DEVICE=/dev/sdb
COUNT=1000
BLOCK_SIZE=4096

MAX_BLOCK_SIZE=$(blockdev --getsize64 ${OUTPUT_DEVICE})

echo "# Configured maximum size=${MAX_BLOCK_SIZE}"
MAX_BLOCK_NUMBER=$((MAX_BLOCK_SIZE/BLOCK_SIZE))
echo "# Maximum block number=${MAX_BLOCK_NUMBER}"

for ((BLOCK_NUMBER=1; BLOCK_NUMBER<=${COUNT}; BLOCK_NUMBER++ )) do
   BLOCK=`shuf --input-range=0-${MAX_BLOCK_NUMBER} --head-count=1`
   dd if=${RANDOM_DEVICE} of=${OUTPUT_DEVICE} bs=${BLOCK_SIZE} 
seek=${BLOCK} count=1 > /dev/null 2>&1
done



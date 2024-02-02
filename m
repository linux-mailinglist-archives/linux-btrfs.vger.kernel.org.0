Return-Path: <linux-btrfs+bounces-2056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E98846A74
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D882AB2AA1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DF47F66;
	Fri,  2 Feb 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="f523w4/L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7B47A64
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861609; cv=none; b=DaIBYUSYpgDx415U8dwz6JIGsAjV6DXxKEzNCtP/o5LKIdjBPiByIz7p0IG+F4BUmlH9wnNcRKC8rVZr8W3HkNMlrYegdLx9srEn4VqyfLK9I85CSzsVt5LimkDlFo6GCdS+Blfjw2vBBi9jxpoUGkm47VIqjD9DIlY/aIv8rnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861609; c=relaxed/simple;
	bh=aYt9Hn4zD1N4ImryoaPXkIySHfMzr4L2xBy7l3iMg5E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PoLrprVfeQFKQfmkLm3F+N5DVuu44kO6QTze9rRnN1LDw4LYEs/1V9lVzNgo4NxB+HLLrJ2vWjQUKxZav/ZAzoxpUS0h8eA4otfZHfHNzPnHJ9wA4DTHiwHCNEMt4/gaoJ4bBX65fQSvcqwlAdEyRVCQCFYXJ7BejGkR40rInRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=f523w4/L; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1706861596;
	bh=I1ntGs8Jver+ywXBYgD9fKzQ4mQvVov0k2ePlvMHBkc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=f523w4/L/iIbff4ptbrX/GUO04hTJaD8B361m2WANCpML9XJOrTyfvTnG0Qbb7LiA
	 zm+AYPEPp8HjvyX8KGTzpzy596X9QROFxQsliLIyT8FHGoM1PKj68ApiG52E/Fd/gX
	 QKqBVk9uJNK1EohS5P8nmFDHEeS6TMkUbqWXO5WY=
X-QQ-mid: bizesmtpipv603t1706861595tz80
X-QQ-Originating-IP: AY/+DQ4PBsJVa2CCF0zAHPflrPtTkpFVyBrq7iF/tr4=
Received: from [IPV6:240e:381:70b1:9300:3433:b ( [255.222.223.15])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Feb 2024 16:13:14 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0000000
X-QQ-FEAT: 80XjNWQFvKyYrlPU38abxMIGHCcvwvSbgJZRHk8MS9akA+Xv2Nd64EyZXXBwf
	gwDlusJgj/FTGvs6Wt7W22gntOPX3qXi0Jp/bMzHVxxlSS463P33G9UXPQhQXLkq0CnzjeY
	kgMPbI6O4D0RQHUiFDOJd6bcT9dZ9/OY95mtMgkUfEeqowMQfnPnep1H6x9vSGmldyekJfw
	5dEsKKYnjyB6lGPVbSRb6lrQM3FUwUIUUIW7am7dFodJLFtcfw1YNfFpqK4PiwjiN4dVyfs
	9ar82YK/ZRzfFVAR95ORlJmT7ADPXilPNWv1kvK6XxP/7nqLWepaCcIiD/3HPkWSv5fwmEN
	S5VTEpwsPz1K8bMFuU=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16355086566597214813
Message-ID: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
Date: Fri, 2 Feb 2024 16:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Subject: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi All,

I have built a RAID1 volume on HC620 using kernel 6.7.2 with btrfs debug 
enabled.

Then I started BT download and sync, and it oops. dmesg in 
https://fars.ee/N4pJ

I am still keeping the drive's state.



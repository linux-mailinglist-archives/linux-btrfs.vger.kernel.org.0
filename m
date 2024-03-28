Return-Path: <linux-btrfs+bounces-3730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90096890260
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FFC292D17
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776887E56E;
	Thu, 28 Mar 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="qUFYMjjJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D47D41B
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637749; cv=none; b=VgBdg5z3OXJbj1EMPERbn9PHtOjqXVQzshlF8cKN58fWH/Lt12TqodtXm+A3uRN7Xe/NZneEoTKv8gwe3F+rs0WOkLS+Jtz5k+AJhB94x2If9hsTt7D6792OCrvAPu6wirjOKblAZmBAeqjTDNhG36udReI5RkGvU8toB1tm0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637749; c=relaxed/simple;
	bh=QYHCgSLjdhx1YM4bbdbUccP95C2ZmlHzL9gwglrhY5Q=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Q+/mIalEZt8DQxraIVEMsmwuVCSP2a4OrukorTFs/by9SZOscJ4RyLsO8rscQb4vVxqtpx9EnvvSpKu/Gca86fpZ26yc9E/j+VBUqcv2UxSrxIBWVHTynM1yiEYN/fur00yS3icwiEGxcFtqk4ANUhWnuFI5WIWzrVMQPNQuhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=qUFYMjjJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1711637745; x=1712242545; i=massimo.b@gmx.net;
	bh=fyEMO52Zjap6lywcay89PsqsAK141YA5ZZlaFECzVdY=;
	h=X-UI-Sender-Class:Subject:From:To:In-Reply-To:References:Date;
	b=qUFYMjjJqX3zeRBM2Lcn+pjHobEXPLnzTvZ0TzrdDM9MVUQC8p42z3UckPmnwokL
	 dgMPYvXR6j6TbL/CDzJTzCrnRwnWNAncNP+VUTjZ3ciQUncXIGx13UxlBBZYm3RuK
	 fNNaVFmKzvtE+EHxpCFaxizkZBGY7Gf7F3OPuNYego64ciBsps8UL6NDmBlciCFpj
	 MYhMfa7TF7lTf2mHuh8Qfi/vpjR3NgEXMNo7fYXocluKdLzunlllmn4iH2LAIhbDi
	 rJGjNGtGtkp+THAyMCEOrQ2bogIzQAOzqzf/4jXSIRB4NUewMgE9H+q6oSZ1mrv1Q
	 5bKQYkMAwMNFQGbQew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gentoo ([77.3.87.21]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHns-1sjLP03iTi-00tgfB; Thu, 28
 Mar 2024 15:55:44 +0100
Message-ID: <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
Subject: Re: I/O blocked after booting
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	 <linux-btrfs@vger.kernel.org>
In-Reply-To: <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
	 <22650868-6777-41ae-a068-37821929be7c@gmx.com>
	 <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 15:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Provags-ID: V03:K1:+amTk3dmmmMozgHq4Lgk8MhPGxnZvQhx1t0dTWMF0oc7vBdb5hG
 cHmUySIGkXw0yFKw015IeBQVgKpnSSMmz9ztelpqP/S+/hzoaHvghcbScWJCH/mTSwIUEXn
 U8JjlnShYtOs2IpluXtAx2/zkAMZSX41/B3ztD4RPTb0tK3/WtQ6SsVbLsm4ar5KKnpfaUr
 1rgyXOxQ30Elu12x3rOVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bvpqUg/YOOc=;qewJ8p13uEupGBatMEy613JITvh
 POXFf3QZnkhSwIDr0JKJwOZGghqT1XtaMkO9mmPE0tPTiMnsbHw5LeTxO+7vl5nPHbvmhVOJF
 kAWMeh3mKr9u8K829lDPmEcnD5YMRLEipHDpzHrItr+QrXoJzYi1f+YNuynCA21BwwSpea12D
 rpfCges/2aTsIXjaW8STYhtCSCgYLzBvb4GJCXugR6SUA6wokqsXNB82BSYnWVGdlJtnZWYkB
 8YFimM8hceiFKOYb2Udli4JVFbYxzzrQUMxlJVPRobUI/usEe6vx3/uQFH6zHJxmATd5wnrov
 l9bKVw+jH1ViSBS5CbyC/RooihIMFuzLBEBQUpSMphix24H4Im04Fdy8beoLNVf25Lnkv7KJE
 eeVYrDUVl88HLiOaZSuUXhQYVCHwntemT33c/4dlMc3qApBhs+0gXxzIc/epqzMIbUpySz07m
 eAzvFqvbRYgybOkl8OHdos1CL/MxlRhZGhXN7Ah020Crkn53csCKK/S+RW7NDpQca4bQprzuf
 IRXHGTHlZHQOXtHnKQMks7/W98jrY2+cBqhAvPv+xDyDlehjsNcNxkkel2eXPAalnGE8+Y7ht
 Mx/SP+CI7wSrTaI9F3e7NuBnOv+kg7Lvc6oQfhfJazSY8Pnuib4d9NKAAYjtmSgw5Q3ZeSCaf
 PixDKsizgKkyAI/i/duOdce7HTp+UaDG+pCZtV/+eJW2bAgrF6KsAGfwIualK8c+4Gd5Fx+aq
 PC1E763JSkmVJgrVKQFMtHh9PWnZ2a0fZ80ZiVwjegROsxM52rTMqAoJpmOZ+oNIMQjzO/b6j
 v6xUuizgrVlUUFUBdChd2Dc+BxrBg/J8xbpsxza0OY94Q=

On Thu, 2024-03-28 at 11:39 +0100, Massimo B. wrote:

> Mar 28 11:38:26 [kernel] [14826.740669] BTRFS warning (device dm-0): fail=
ed to
> trim 698 block group(s), last error -512
> Mar 28 11:38:26 [kernel] [14826.741731] BTRFS warning (device dm-0): fail=
ed to
> trim 1 device(s), last error -512


I have set nodiscard now on all my btrfs on SSDs...
For not rebooting I did  mount -o remount,nodiscard /
and I see in the syslog: turning off async discard

 Eventhough fstrim was finishing one time with
/: 157,3 GiB (168907370496 bytes) trimmed on /dev/mapper/luks-6745....

... now running again, it does not return, and in the syslog I see:
[kernel] BTRFS warning (device dm-0): failed to trim 143 block group(s), la=
st
error -512

dmsetup table
shows allow_discards on that device.


Again I did  mount -o remount,nodiscard /

But this time I don't see in the syslog  "turning off async discard"   so i=
t
seems to be still disabled.

grep " / " /proc/mounts
shows nothing about discard or nodiscard in the options.

What can I do about that failed to trim?
I have tried this on different disks like

Samsung SSD 970 EVO Plus 1TB NVMe
and
Samsung SSD 860 EVO 1TB SATA

Trying again after the failed to trim, I got it finished again with
156,8 GiB (168413265920 bytes) trimmed

Should fstrim be fast if it was just finished some minutes before? Why ther=
e are
again more than 100GiB to be trimmed shortly after the last run?

Is there anything broken with the trim on these devices?

Best regards,
Massimo


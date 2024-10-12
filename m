Return-Path: <linux-btrfs+bounces-8870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CE99AFE5
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 03:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D46B227E4
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46499DDA8;
	Sat, 12 Oct 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="n7f/fdnZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC958256E
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2024 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697541; cv=none; b=KHWD4XQ7V0GwAVl063Bs6lLF+yhpNzmePWTjaHGzO/zIgci3BAvhUj5l7CfCqQzrRO8WyCsI0/gUBBqVoVa49x6pD/Q7Qz3jumVQr+c8HsVZvB+LYXhciX5o5aA3DOkpYWGQQhcYOVEUT3YzI2G631E8+hJMMArGauPwEPZMezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697541; c=relaxed/simple;
	bh=Vfnx7NxFsgTQSCj4PbRf4JnNTpmKpEzt9gPC3ECsTP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sco4ZLCXD9xQ4HLJtwdNNyUtXaoHZmP6/sCvXjLAZBVqcAUYNtfwHxHVVLOzRtQjaVC0kXoBGPjnaCEzFsT6G2eED1JMYcAgf/hsHPi2twMoB+iMn8MfBNnMePmiIQWm5kBv3EtJTURbuygn4D4hGRloZAO6rCptkuUchEqYh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=n7f/fdnZ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728697517;
	bh=lifz+5DgLGHkSiqv7WwaZFQ3JXJw8NX5k3/bCDySo1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=n7f/fdnZr5DWl9Q0AyT+5BNk342yY43IKbNtIS1hC+CseLit/+XAyD03zHqjSVPyq
	 AB9ndXlkZvm0QaV+vlF9l6yDTCzis2oZ8ETN2dIatCdAAgOoeZZtpmwDXY4nFS/8qt
	 4IguipfB5ninCdyewbs1ebcwJIZWYjUsfz5QJoLI=
X-QQ-mid: bizesmtpip2t1728697512tspdwk9
X-QQ-Originating-IP: ZTTRRFyTnH6PLq+CDKuMWYuJOryRnfA0k9BX/0ssD6o=
Received: from [IPV6:2408:8214:5911:6ac0:4a3a: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 12 Oct 2024 09:45:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12466614862518242318
Message-ID: <6E699CEDFE43F10B+2a2372b2-b3d8-48b9-8ce5-c24167ff6e16@bupt.moe>
Date: Sat, 12 Oct 2024 09:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New ioctl to query deleted subvolumes
To: Roman Mamedov <rm@romanrm.net>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20241009180300.GN1609@twin.jikos.cz>
 <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
 <20241010170841.GR1609@twin.jikos.cz>
 <E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
 <20241011172043.122e81ff@nvm>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <20241011172043.122e81ff@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N4KH/PyO63QvaZzupwhxWNjksujIr5dIErFcO+QBInUC+0KCL2K+9Lj1
	rGFj8EvoVQKkq+iVHQpDWAyqnIYHrubO3Z+Wjy1+lByzGUNUMnhEZR8fZHvxaNyEtAt9ykQ
	tj9c5Iym4rMocPkPWTbYSomzPml0S9uPyQ11p8geqABMRQoBimydZb4Ef+ICWR8vb+rqL2e
	XKqnQrq8ub9aoqdoiH14orWaRDRrEK9Xi7Fx7uNdX9H/sEVU1/HlDYyFgsaoheDmUvxPiSq
	8mlSAkY3Qns0xIaLgNy07+JVyA8q2BTbBY8pbofu4Uj/9xpBe/lLTWMYx2aIUqUYzApWj/J
	OThM/QMGRsPwuYipM2+nFVH4ExqRgAgQE0Y5NiKEO5BCkVJTealxXMZyEKlPbH/VHP6ut/5
	e3nbqRjlmsAxbVSjZtI2gyo0NeUcqb9dSoI4pQn4wEg9C0bE4bKhhPW+rj6XmNOyH5Qd5g1
	1ri7Dcod9XA44PAewx7hSF+cio0eMcFYd1rrw7SK+xYYRAwv+kdr37K6pF5NCDTn9Kh5xpu
	JQSY0qEO5vP/cyqv8T+6/AuICWg/8UYM28xEHqXIfILCsl7DiOfloXRZ23F052mfcdsVnRj
	v7zTMAcqkKscM6s0VdVKlavY4PdTKn0qFNO5fvYPbZkIrek88B8hb2wHPeryFWB7QJTCe4b
	+4ez31lF486MMSGLH6ei7WW39lfcYOlw+DMHlxMVWpHVH2O5e3sMYvljR+ByOxgSRLRY7F0
	laOrx4RUYSj7G9J4P+e36XVrYFYlYfUJpmDDe1V79EJxZgTW4RajGudxcHuW4LhTE/RS9Lm
	HXL9YxypZH8R2DzCMrYBSi3+FdWlw7QNaO03q3SgPfFdqmv4FVJYeb/S1shPJLu72ttdrmh
	PJxfbY+L+0Sb7tVqk9ha9BDQ5mpCP/eiDwU83ntzbIikEdO+AhtTt5pVGtEpyQBKk93uxuE
	1Z51UnWvMJfc0ZQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



在 2024/10/11 20:20, Roman Mamedov 写道:
> On Fri, 11 Oct 2024 20:06:00 +0800
> Yuwei Han <hrx@bupt.moe> wrote:
> 
>> There is a misunderstanding. What I mean is that why users need to
>> "confirm" subvol is deleted? I can't come up with actual usage. Hope you
>> can help me with that.
> 
> A backup system may delete outdated subvolumes first, then wait until the
> space has actually freed up, before copying new data; otherwise it could run
> out of disk space. Especially considering that IO from starting to copy
> without such a wait would interfere with the cleaner process IO, resulting in
> it taking a longer time to finish.
> 
> Or in my case I also wait until deleted subvolumes have been freed up *after*
> a backup, to then record how much remaining space a backup disk actually has,
> before unmounting it and putting into storage.
> 
Much thanks. It turns the async deletion operation to sync. I think it's 
reasonable.
How about introduce an universal sync command to wait all background 
cleaner process (e.g. when deleting a bunch of files, which I encountered)?

HAN Yuwei



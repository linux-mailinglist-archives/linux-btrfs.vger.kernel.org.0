Return-Path: <linux-btrfs+bounces-8592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D6A99378F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 21:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16EBB2297D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C81DE3B7;
	Mon,  7 Oct 2024 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b="h8fgNTc4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9CE1DB52A
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330328; cv=none; b=i/kt8ash3fOj6Rn/uU9HLNXNcY2jzUVm9Ton0aS0+osU35zURPpGtyp8xcrrg/0BMjmd24n3lbnuXZlIozZzQqFrQyuA24AaKn8eIG48iQ2QxuEad7B1hQixbU9Un0J2kcneQTVLzo0x7N47tDWNC0McRRk/8qtnNlWh50IwHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330328; c=relaxed/simple;
	bh=MZVoAbJcLH924NM4byE3u28uloJDwv5X3bWQxUnR5yw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IeMAdf8fsPR6Ny0YaRQSlln/LIHwkB+kiekgtlt4g9MQC0cbhhFHFqlU2hY0t0PBq0GhCE0yJjJpjTWmmsEWi+IEICYjaCLPB5nvnWoXoN74G7urhFmMDbCTm1vNLKQUbrlgyEItVuWCOdh5lLwTH585jOPZ2e7UMZSRk5EZIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl; spf=pass smtp.mailfrom=dubielvitrum.pl; dkim=pass (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b=h8fgNTc4; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubielvitrum.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id C8155C0A220;
	Mon,  7 Oct 2024 21:45:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Authentication-Results: naboo.endor.pl (amavisd-new); dkim=pass (2048-bit key)
	header.d=dubielvitrum.pl
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ja3V4e36gc-v; Mon,  7 Oct 2024 21:45:17 +0200 (CEST)
Received: from orion.dubielvitrum.pl (unknown [157.25.148.26])
	(Authenticated sender: postmaster@dubielvitrum.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 4E329C0A169;
	Mon,  7 Oct 2024 21:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dubielvitrum.pl; s=dkim-2022; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=62BEUOOKdlWGqb/9snOrXlb+9jP5yRl3YWhw/PGk/jw=; b=h8fgNTc462RvAzBluI7RBDl/T0
	komDrw7geHbx/OvlUSxLTGobCaPr03eBxCL4kP1bTNAmpntZQY4KkiCEi+zBImmYfGSMOc1pYdd5O
	i4bjr2I1tEb28AFpPVh2r1glmaSlfTLPfe5URCdV0jc8jikYI7wNT19sFH/i0A6FtbICFYKZ7CQON
	k7ImDhUWiW9KKG+oRsa0Nu3n3BMFs+/+XTUgla2TCVuK12o638uFuM6uyfMVeGds6Xjwl5dqZXTFP
	WR6OoGtOvN5oZQCOLA48N8YPgm7tzqRNhfLfyHQfirr81aQFxjhecOtdwb2o5PuY/ahAfesChSt75
	eIlwJPkw==;
Received: from [176.100.193.184] (helo=[192.168.55.107])
	by orion.dubielvitrum.pl with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <leszek.dubiel@dubielvitrum.pl>)
	id 1sxtfP-00BYsw-3B;
	Mon, 07 Oct 2024 21:45:16 +0200
Message-ID: <7069125d-76e2-4e02-8162-80bc0c1b9eb5@dubielvitrum.pl>
Date: Mon, 7 Oct 2024 21:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to clone extents ... Invalid argument
From: Leszek Dubiel <leszek.dubiel@dubielvitrum.pl>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>
References: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
 <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com>
 <fda83046-98b0-408f-a1d5-0fc2f35c8dfb@dubielvitrum.pl>
Content-Language: en-US, pl-PL
In-Reply-To: <fda83046-98b0-408f-a1d5-0fc2f35c8dfb@dubielvitrum.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>
>> This is probably the same issue recently reported here:
>>
>> https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/ 
>>
>>
>>

>> In the meanwhile you can either use a v6.1.106 kernel



On Debian it solved the problem:


root@orion:~/Admin# uname -a

Linux orion 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 
(2024-08-26) x86_64 GNU/Linux



root@orion:~/Admin# dpkg -l | grep linux-ima

ii  linux-image-6.1.0-25-amd64 6.1.106-3                                 
amd64        Linux 6.1 for 64-bit PCs (signed)
ii  linux-image-6.1.0-26-amd64 6.1.112-1                                 
amd64        Linux 6.1 for 64-bit PCs (signed)
ii  linux-image-amd64 6.1.112-1                                 
amd64        Linux for 64-bit PCs (meta-package)




To boot previous kernel I edited /boot/grub/grub.cfg and moved menuentry 
to be the first:

                         menuentry 'Debian GNU/Linux, with Linux 
6.1.0-25-amd64'


Return-Path: <linux-btrfs+bounces-8583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5583992AA9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA1B23ECA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E01D1319;
	Mon,  7 Oct 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b="X6setXD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67618A6AD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301849; cv=none; b=AvYPD4Qn4tm9Ori2Y0rANGvlKJqS1YzzZTICPzk3cEmaKmzfHMPVMkJDecWPZ0vN9IGDX/ACO+LlhPezOQlIIBVh53fVjTRv2rSPYGBl8Z7vvWaxYM5htt7FkmjV5ztZ3Z40mVj69gwcqgloRuwLL7N77Vp4Uu4KAxnj1yQTVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301849; c=relaxed/simple;
	bh=8JWKGvrOf5he8IxSF8Dv4IVkL5amwhxpzpH+PDpK8wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lre+rru0heQIZD5uixS28o9XzCTNuypBg8hmsXSScXmCOLugFVseDjw+V1JYSemlGLVv45I1R0LoRN1qCD9G3eLmxgq2Qme90/kXZU7Q8RQWWdlYhF6Eyhu7Kh9974dLVWPDEQubgOXzsXK8P7D7knbzMJPpwbyLz0hdDszi4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl; spf=pass smtp.mailfrom=dubielvitrum.pl; dkim=pass (2048-bit key) header.d=dubielvitrum.pl header.i=@dubielvitrum.pl header.b=X6setXD9; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubielvitrum.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubielvitrum.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 8D59DC0AC46;
	Mon,  7 Oct 2024 13:50:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Authentication-Results: naboo.endor.pl (amavisd-new); dkim=pass (2048-bit key)
	header.d=dubielvitrum.pl
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BOJTbnYTaXnw; Mon,  7 Oct 2024 13:50:39 +0200 (CEST)
Received: from orion.dubielvitrum.pl (unknown [157.25.148.26])
	(Authenticated sender: postmaster@dubielvitrum.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id DE424C021E3;
	Mon,  7 Oct 2024 13:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dubielvitrum.pl; s=dkim-2022; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zCX9Btd8BQT1GF3hM0rOdS6YXoSIyHfYo4oYijilvCQ=; b=X6setXD99zFJwVLsjPMORzzYDE
	qbpk2qNAtpJvWgKQF8cZaJIc/t4o1CvZKRbD8RkxAJFJgmkh3cQeySn3n9POqUrPVDhhZ2rsw8GhX
	S+5etGQh5lAF5p7xLfrLnjvy8scWONp7SIym5BTCnL0KxhGS58rGezEwwZHm9+9+ST4OAXlw/rCjl
	5DHCAkmoGh9CD3yKnnjmL7FUuV1fMyXchcTjQsPgmi+ljSAf/tsZ0NTqU/oIJ8fm2oVtQ9rWvf1VU
	hhJPU2GFEQfWkIuVShfuZotDGHECZtx4Wo3Rmg12CwOV3ZIpVLdxpj3OKJnGqNiIsoxvEaJpVkQg4
	1Gp+oiOg==;
Received: from [176.100.193.184] (helo=[192.168.55.107])
	by orion.dubielvitrum.pl with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <leszek.dubiel@dubielvitrum.pl>)
	id 1sxmG6-0092lz-1p;
	Mon, 07 Oct 2024 13:50:38 +0200
Message-ID: <fda83046-98b0-408f-a1d5-0fc2f35c8dfb@dubielvitrum.pl>
Date: Mon, 7 Oct 2024 13:50:35 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to clone extents ... Invalid argument
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
 <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek.dubiel@dubielvitrum.pl>
In-Reply-To: <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Thank you for support.


> This is probably the same issue recently reported here:
>
> https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
>
> The corresponding fix was merged last friday to Linus' tree, and now
> in 6.12-rc2 as of yesterday.
> It will probably take some more days until it gets to the next 6.1
> stable release.
>
> In the meanwhile you can either use a v6.1.106 kernel or older, if
> it's an option for you, or apply the patch yourself to a kernel and
> build it.
> Or do a full send instead of an incremental send.
>


Do you think standard Debian kernel as below wolud be okey to solve the 
problem? Its "106-3"...


root@gamma:~/Admin# uname -a

Linux gamma 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 
(2024-08-26) x86_64 GNU/Linux










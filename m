Return-Path: <linux-btrfs+bounces-7477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9695E2BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66656B2163C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0B6F2F8;
	Sun, 25 Aug 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="UJZDjw/a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E553A1DB
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724575463; cv=none; b=p0uzuVFksnLAUIiDHQ3MtySfBddmx1SPDJLK6ad2GefaGsbP+3B6+FiYkFEZdkhfCjvzxin4Utdv9H6Wbylm9OvpfbFVzEYh33FttmpeGIDr92faRUj89bvTwmN2m2GJ9UQWUu+b00gun6Sf1aoUeazOMXRAFkFXjUKQZpRzN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724575463; c=relaxed/simple;
	bh=L5Xi0Ai9EeiKe3U0I2NLGMnPzCUmv6xHY+vdCSnmWtY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=h0BuFUMegzBryemMHuqB3oLuZ9cgWNaG0rTm+RcGOAT1r+64C/Bi473ciDztllPRQi7L7pjBrH3UitCLMOuGFtplWvwpCGUx65kF7b1wXqHYPyy+5/gAbiXnDiHG4MmZrjNylmYZa9XChIQEbb/dd+S8QTA8C6/SjQVxTlinj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=UJZDjw/a; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1724575455;
	bh=0nDERzzfez3/n73dj7J/+jBSjKj9b4R3GGO5ZY4qo6k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=UJZDjw/acEylj/0tiJZ0fj0KW4JyAv83EPJXs9YpyK/3jXgsw+iESzXGcCC9DYvCU
	 YjHIpoywRgz47cpxJED5hHMZUc8L3aBp4qot1oj5Mz5scGEKcmM8X2J2cv5x4NNvge
	 954sc0jo1YtCgInSweP7jZevMaXIgWvB9SjpIoow=
X-QQ-mid: bizesmtpip2t1724575454t49foxu
X-QQ-Originating-IP: PHnO+QDyBFLMbXhIoHJTdpD11eiDmrMUqmPgZ9sWzb8=
Received: from [IPV6:2409:8a3c:5937:7b50:aeeb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 16:44:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2118166513438807617
Message-ID: <EEF4303B52E6A560+21c563de-b84f-478e-897e-e88eb0ce4b94@bupt.moe>
Date: Sun, 25 Aug 2024 16:44:12 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Yuwei Han <hrx@bupt.moe>
Subject: oops on 6.11-rc4 loong64 with RST & subpage enabled.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,
There is a oops when I am testing RST & subpage support.
https://fars.ee/vTGd

# uname -a
Linux aosc3a6 6.11.0-rc4 #2 SMP PREEMPT_DYNAMIC Sun Aug 25 10:44:46 CST 
2024 loongarch64 GNU/Linux

Disk: HC620


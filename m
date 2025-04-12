Return-Path: <linux-btrfs+bounces-12961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CAA869C5
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 02:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60BF9A1B76
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 00:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0022134CF;
	Sat, 12 Apr 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b="Qe4VDFeB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE178D53C
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417751; cv=none; b=VrRVWz3f+zfEn71UNI1X+o0NsWEgjHApzJ+/kObqWW2jUtG5pWbFjTc3euUeG2sWii9MxlmWliVfjIM1fOqb0zJ49Xt55w1mx6s5fQ9LlxIuSLJfGLQyE77mkHkUW1rUWIsuVTVaxe6twi3RzdWvXmIsweLHPtpa7dybyu9Jkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417751; c=relaxed/simple;
	bh=K1d0797JMKFCpqjkvRe1uiNl2BYnpLHvOosq3NaVnoE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IsC8I5aq1Uw0X9G66zCljLY2GY9Us4NwGWGiTVUD2MTqrY+CCppby1v3Sdl7TXi5PFV+0SvpqAFq62ui095yRkz+MVOoMStFMknYXyAfg2CbPe1wke6D5g+Lgk/6KScZ6JQ9XTqdrZ7btmYCU7x2Otm/oUakQup61rwit8qJrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com; spf=pass smtp.mailfrom=olstad.com; dkim=pass (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b=Qe4VDFeB; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=olstad.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=olstad.com;
	s=ds202407; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:From:Sender:Reply-To:Subject
	:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MFKV4AOFLCbpEZKCudjvqIYvrqsY2ntbdp/Wc06dPFs=; b=Qe4VDFeB8uV+YjpBgjhMOQJdSY
	aiNbyi7pavROkMKj90vtmQjFxr+sfQ8xITtvsGwhr68fljDOQiEtOXtvi/hTW1n1sH7YJl+iNBLu9
	U820at2b6+ubc0R4vMJQkmzrUbqOdPdAr8vPvnQVwu4w2hr2/v0jRVX2M0AP8IwfykTkb3FDu0t7M
	8alz+BfF3tyFAL/KUJB3qM0id5KqAlh5erEmum3m2BIRbCNhSaAFzEnvBz1/jZUwQzLb8KemFs5Vm
	lqS667uZE+dS2VIBaBPohjZrwhHIlFZt6fPeb1cQxqGb/ZNUZPcvl5n287biz4GyYAYgHuizu3PuP
	JX1FzHBQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1u3Ok7-00Ch3U-QF;
	Sat, 12 Apr 2025 02:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Apr 2025 02:29:07 +0200
From: Kai Stian Olstad <btrfs+list@olstad.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: How to fix "BTRFS error (device dm-3): error writing primary
 super block to device 1"?
In-Reply-To: <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
References: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
 <084ef89e-7988-4d0a-9d63-cf0a5e0ef2af@suse.com>
Message-ID: <8783cfb2978ada01ae68d7ae4f9f7c06@olstad.com>
X-Sender: btrfs+list@olstad.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 12.04.2025 00:10, Qu Wenruo wrote:
> 在 2025/4/12 01:18, Kai Stian Olstad 写道:
>> Kubuntu 24.04
>> Kernel 6.8.0-57-generic
>> 
>> 2 day ago I got a sector error on one of the BTRFS disk
>> 
>> $ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): 
>> originator(PL), code(0x08), sub_code(0x0000)
>> Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): 
>> originator(PL), code(0x08), sub_code(0x0000)
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result: 
>> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key : 
>> Illegal Request [current]
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense: 
>> Logical block address out of range
>> Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16) 
>> 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
>> Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector 4224 
>> op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
> 
> This error is completely from the lower layer (the block device).
> 
> Btrfs nor the LUKS upon the disk can do anything to it.

Thank you for the response.

This disk support scterc

$ sudo smartctl -l scterc /dev/sdd
SCT Error Recovery Control:
            Read:     70 (7.0 seconds)
           Write:     70 (7.0 seconds)

Doesn't that mean that the disk gives up after 7 seconds, and then the 
sector i mapped to a spare.
So if Btrfs does a write to the sector again it will be written to the 
spare?

I've experienced numerous sector errors throughout the years with mdadm 
and they have been fixed with a check.
Also a few with Btrfs I think, but they have been fixed automatically.

So why not this time?
To me this looks like an ordinary faulty sector that can be "fixed" with 
a write?

-- 
Kai Stian Olstad


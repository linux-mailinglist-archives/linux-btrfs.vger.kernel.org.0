Return-Path: <linux-btrfs+bounces-1546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4883133B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458BE1C22831
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2AC126;
	Thu, 18 Jan 2024 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="a9/bxq2M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DBBA38;
	Thu, 18 Jan 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563644; cv=none; b=urMzdPOn2zV7gMfV9FkSxjkoe9HrHSZ8p/OlMrOk27r/7HcFIgN4RkUts8dgPMSUr7aTMjpwORH4245GmAMKbMaKVi9vJeF23Vr4/+4+tMzrz47ssB509hwwiUPF1bbYcDgG4R/gUZzKvZ48KJ6ycNEScuvmLXshHZBhwdV9Lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563644; c=relaxed/simple;
	bh=7JQyvRzNWYfRJcIsbdBzmlkrczBbL/WinpvRjcoi2Oo=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=JvYRrWS6yhusptILFQCW1Gbu1LnrOihWpOhFwHg5SZAXkkQDfXhLUnVxFD0OU6k7pPNINnpqiCTrpvzntdXRi6S3kQ1zGwsj9G/oCpcqku2fRNmUTs71t6lS/rJibEuEeBJaEmtoDGN4VNNPrn95d7iSM0DQZf8Ypde/N5owLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=a9/bxq2M; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1705563634;
	bh=kylbDysfqF5ohetm/y19pFh0ZtP2MHUY3xJkbvYpr7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a9/bxq2MSdg4CtIRULVKBU3qayaDhskOnUmTe+iOA05QI8tzp+dQADdOxP5RlPO29
	 1UVSURU9bKCxK+rcsqd19dMjP98A9CrJqs2CVgQaw1zVELrCMB3RcHaMuVZft8nkRk
	 ULF3nBCeqUl+manogIIoQPGRLiXBtW9f19v3L7N8=
Received: from [192.168.3.231] ([116.128.244.171])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C338E3E; Thu, 18 Jan 2024 15:27:03 +0800
X-QQ-mid: xmsmtpt1705562823tky6wqgm2
Message-ID: <tencent_9FA6F888DD53B910DFF4F2C0595A83825D06@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/3s7KsNLoKDUP59VtUIGVyOBkpFATdFDCgyKdhybTcb+DLLuAbS
	 032zWUSx4jwDd9DZaPKqQLrqKtDWCIFrIHoY+Uplo0s18yO1sABLWiQePUqngZSoQw/Fj6sXFC8W
	 0IpIWYPIzuC24N3E/G90ePA7bg5XkAJTXTNNAZUALRPlFk6TKYAcD1d4zNDzZxDDw4f/W8lhBntM
	 +JIRmenBYpkXpN45sonhpZso+zry2GlLmYSkUawbk7E+i+GSUuHdZ426s1ByLAYuVTxlv6wLkeLb
	 yX1Ouj/b5uI8okAV0iO8uhWLV726vWK3TGrgw5OMWeRQ8ccZkZfeAA2TReHw0r3yZ36TjJz7kR0n
	 knyq+ZbKHliOR1fte9z6jzfJG5RAVIl6a2et7XuM9WttN5fIJ0LvaxMTpgkjFPoEgIvG6TfPeFWt
	 Ep89chgDDWznJqdow2awjKzi/KyMafC8xjym6mgKaS5EKWc0hkIoFP8dVEu8fhmaNw+SyU5lM6tU
	 GrRtf91TUPJwNj3nWo0yPbUJtYWT4ZWnEP4XGAsIldi8QqsiiZ8SI+NGqDmGQ952bOuYOSzf25ik
	 mGIi/V3B9j9BnRPOZTxDH4Q7xQ5B+m3Nzr6hIh0WWaFDHB8XNsctGnlxHQ4MKSGWVbvyzvT9OMib
	 c9TMHQkVJwpPNy26/FKa4XbdGr6KpOIY55rPGvGnDtQof94baU2TIGCdee9rXIsMa5RR3IJ73UyZ
	 wCtQaBJfaBAUPaQmsXK35OLUBBIS3jdmiCrIbY+iBvVy7jRqnuLP/Ytjap5soknAcyi/9fDSN43M
	 hg0usQFYzG1NkwhGMFtfcFbUJtfHd7DZNc+hQETGfcAVIucD21o+LWOaSd4cyEOAtayQqVqqOVkI
	 VVWNbYZu1/d8Qm/o9da0COQq5h6NqAQTFXr1yYyNtsiIZ0MW52XokY8iq+LjInU6V5BVVK/L5goj
	 1jakjmfYtBQEgJh89AL3cXds7gapZjDKpt8BloiK1uhwguK+V0Ng==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <ac379de5-edbd-42d6-8b1e-ac3d5221b6c3@foxmail.com>
Date: Thu, 18 Jan 2024 15:27:03 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about btrfs no space left error and forced readonly
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
 liuyun01@kylinos.cn, zhangduo@kylinos.cn, liuzhucai@kylinos.cn,
 zhangshida@kylinos.cn
References: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
 <2870e41e-c0a8-4ab4-baaa-bbffbcd1e6a4@gmx.com>
From: ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <2870e41e-c0a8-4ab4-baaa-bbffbcd1e6a4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/18 15:07, Qu Wenruo wrote:
> 
> Full dmesg please (if there is any one before the call trace).
> 
> And `btrfs fi usage`, `btrfs fi df` output, along with `btrfs check
> --readonly` if possible.
> 
> Thanks,
> Qu

Thank you for your response.

I check the log again, there is 2 more lines log：

Dec  8 15:25:28 pjdhcpaasnap8pn kernel: [13439435.962898] BTRFS warning 
(device dm-9): Skipping commit of aborted transaction.
Dec  8 15:25:28 pjdhcpaasnap8pn kernel: [13439435.962902] BTRFS: error 
(device dm-9) in cleanup_transaction:1860: errno=-28 No space left

No other btrfs dmesg log.

Thanks,
ChenXiaoSong.



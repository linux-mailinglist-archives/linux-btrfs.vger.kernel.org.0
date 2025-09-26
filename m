Return-Path: <linux-btrfs+bounces-17203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C37BA2482
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 05:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F70A1C24D83
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 03:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3FC25DD0C;
	Fri, 26 Sep 2025 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="lScWdCJW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67C1A295
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758856358; cv=none; b=U8VSrks5Y+wqaPHCFz/u7W/kFgN/MLLGVoprp/FTF7Vuz2KdGkhPr8IWF9MHsu03T394xJkPzWfS2gGxWO2F9ZUDMuuWXxGJ7s70zqUKqK1FyU6ZF6VzQpmabFKryd3ZFcnsNKXl1t5+gZRCK+JKQ3JRQoucso/99ZAtVRGWNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758856358; c=relaxed/simple;
	bh=zlsE0P+MSFJwzxq52cjZ4jdyWD0hN5zgmy+NgnnOxc4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qT9YlZQ+doz3kuOZhEj2Qp5urvgl+LfQ9uE2d2+PjaoMJhUwc4RB6DyZmuGiad6OtxkLyXrQkDxP+RfCv39kb3eF2OTI05FLJKsjpUQCq/uNGBB9gb3p3V1nigRIe4/Znybj5nHT6D8hynlEiQUPi3auPtBz6/8XWMuRLITDbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=lScWdCJW; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1758856344;
	bh=iWYTzniVjJ6ivpl651mNPu5UG5+70klVbnqPpsLiT1c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=lScWdCJWcSAwWdTigRFhL034iwNFZPDbhEMXkDNo6ENValIsgPpdJW7TlHS3GkWUm
	 3uTmnVmTQ+jh9SzFXTsrpx0BDJ9K6g06//OT8+tPwIhBkz1S6EfixbTF3B1bbjCOtg
	 kM1TLTJpmwqfsHYTuVgZu2RiXQml6lyy1JHlaHP0=
X-QQ-mid: zesmtpsz8t1758856343t31116072
X-QQ-Originating-IP: GRci+e1rbmPDKFJebYjcSr0LD9wrSQ6j0U3jv8Wuh+Y=
Received: from [198.18.0.1] ( [123.134.104.63])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 11:12:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15342802415352007566
Message-ID: <C8FF75669DFFC3C5+5f93bf8a-80a0-48a6-81bf-4ec890abc99a@bupt.moe>
Date: Fri, 26 Sep 2025 11:12:22 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs <linux-btrfs@vger.kernel.org>
From: HAN Yuwei <hrx@bupt.moe>
Subject: Wrong SSD type detection on zoned device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MEB/GPYjqGH/pLLlMEHcR+oXP8YXNcXBB5gi8mV4edSXWs71Yg/a7g0W
	XIJo5StbG7REIqkY4DFGjNab6fm7zGPBWZz/ZDlMN8o7CB4+UadGLxrim1BMBRVHspFqJjo
	cmER5IFrEhlL+FDtWg1zwgqMdH/qJ+cwJo2p+7tc83Dzwspq2XRW27boffCw5nmmj+hzS9C
	G9t5HaxsrkZUlpzHg/duSnVERbZOnL3yLy0qcQbl7OQTz8LJpNwmCnFkEQFdCJbL2We58+R
	tUfmhv4Jh8kU+2Q/FF3zKKthhf7c/uhNqPbUoKr36JKO6MVRMHVjEzp3yTK1/SqjPyaWUet
	uik1+dEC9bps7VkvrwsK7pES8HPhH5jNtg1cge8eRvmFD+bW7aRffPqT0T75sH+5OerkKbR
	0M44nF1EhNZr3qCD+9PBd8+gtceHLYCRzthfUv5HD2cJe8F5FO9Hu/2zmru/fIr4QPAPelZ
	3hYzizcnMJHGFIZo/e6pJ5zZzftmGwqfycVOGr/4RWWoAqJWaGP6vWXWDte/W8QGX2ma1ia
	cq/ntj9yL7TAk4k2JFc0SvcRgLycx0AXcAt9VnsMiMTpwc+MYCHOctjquCSLr/Hk9NgCi4X
	LN3LymoX8GHGlONAMwdvEveP0BGV9H417W90Fclho/bvuqc2aQr2KW8Bncg30AmrbYgxHBX
	Y+xva3ib2GM4H83+2fnH5yOyrool4zYNCT743c+EBfvrnEUsFlZg0293tOg774pRTCguW/v
	9jEuR9n8teUF3QhCWmRRAM8eZYhNZO65s4wLvBaeD9zGLOsiEPEcEIbllOAQ6gfOUEh3BnC
	YdBBhJtlrIu6H0eLLwqBeJt+kKB6F26K0v9gBOc2aBYhAHtYZlyVbRjoJ7uTYLE0TB6OMpx
	7ROKdXVlAmcZ7rKrBUwcz4OfFYm9nI9bjvlkZt6/89jWqCgekLsliaqU4MqPrezu3ecoCO2
	Gab0=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi,

I just found that when mounting zoned device, it will have "ssd" mount 
option.

# cat /etc/fstab:
[...]
LABEL=DATA2     /data2  btrfs 
rw,relatime,space_cache=v2,subvolid=5,subvol=/,nofail,nosuid,nodev      0 0

# mount
[...]
/dev/sdd on /data2 type btrfs 
(rw,nosuid,nodev,relatime,ssd,space_cache=v2,subvolid=5,subvol=/)

# cat /sys/block/sdd/queue/rotational
1

Is this needed to be fixed?



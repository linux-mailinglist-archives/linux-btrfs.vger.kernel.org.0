Return-Path: <linux-btrfs+bounces-1545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C375831335
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D80F1F23A47
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFABE67;
	Thu, 18 Jan 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UzkzYM/O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4CBA30;
	Thu, 18 Jan 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563579; cv=none; b=Lgbgx3W6phJiywfttb7Pe4MbLq+Smk25+EFNLkR82byc8v7AYHSfN2+EiSaECKlhA86QGx7KZYOMFdFdZJYJyPsVrVn5xedqAtH/wNLfEZ+S4N0GlPIBwYNQCH3JiUJh6h42P0jwWihIwkLFSVeBH63xPz255hkp1F+ie1miudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563579; c=relaxed/simple;
	bh=Kx7sR29tnRaLNojoCF18ToW2lJnA5TVBRtwOfQmUQpQ=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=jcHSdIJuMByncI0LlrdgkQS9J6SEXL2aLuJ6AMqYb5tnQsUkmB07dl/6Um1rxVPKN2l2fjtArwgEEf7Noor4UyB/Y/0cqSteFLQCsrhEUdFMNwEKSN5DMVuiilsz6FHQenERb0ucY0YQYS0daBIGYAhzRNyXf3yxGSBDMQxCk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UzkzYM/O; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1705563568;
	bh=U1htK6EddZlHF9aOrwhZ47HPx0c/qh7tu7sPPx5SMf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UzkzYM/OBdlUAqZ05HD5yEKMS2O3wW6SOdMUnyRCFQteTChqnEuprnMfEm/55u7QP
	 llLHU9L75Bsr8MllGkBXHbqEw44xxfeT0Tq8iWemdxzO2qFcbPEjqGNJbsks48aN3j
	 OVFCJDD3rbTfPmPAnC0bQivD9iES/vSy7vG2MpJ4=
Received: from [192.168.3.231] ([116.128.244.171])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 852B3800; Thu, 18 Jan 2024 15:33:18 +0800
X-QQ-mid: xmsmtpt1705563198tlv6dervy
Message-ID: <tencent_0681F9CE96CDCF741BD6ECA4C401EC4CCB09@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTSDX7e0PNwbch0pg1bNQJWKJsIoeMvlDntNRnq0xc5R+pdmEKIf
	 gyJIIcZrgdv+pO0F1OBL8qUQC7t7CYHa9B1/U8G46DAaTdiha3Kyf4fCuxeJa5WiZ01Mi02tYM0r
	 VfuSRdSdl7gKtHMrRmoVJXUPfPGsDkbzeQh2X81MeF3/l6A8crTL2FrggZG+54dhj5RvBAWSv4TI
	 bcr1xbOeQv/a8VKYiCS9zRvSBLwUO/X1JxmBv+0g9ECbbnMR5lqHUEuyWt7K6/XRQ6aK/y3K6eza
	 cwuLXwU8lsIgzevz5Y2EejxmdX6DxOa2wtmXTHK7Bvc1Ofmr4b00pg9byZ281VGEtrvAB5lHyfh3
	 yeXkg/K9g6g8wPNow5McOQ8NCp6/hHlN9NfJerLbzU1yCGYrH46dNH0nk6EYx1/imwbWrcFllnYr
	 B7i5ZBSXbMr87SStkIiEKqjGs5PvCRLW5Yo0rMiGc3nMqhDIieI5HA8nWXN8mscOJY6SzCsYkszA
	 a4f8lgxG7GdU6IwGYrMuBKyQszAihuEeQgBbqRbH+dMUpc7EQhwB9cERszuzt54SoY/CIZz5LQ+m
	 TMd1VUKDMNAgnj2QQuAsbnsIv1lKkXHmmV7RSkK4fRDg5ap7Hh/vwY4xQ6E3bM7nzXvU8Vk7uu5O
	 RtaCth6a5jxqhuZOyt0HQO8bQH4NtXcsuVkAY0rxtbjROEn4mw5QnpV/J1vM3tgQ2fOj42PmDh+x
	 xCcNbWq1ybs+e3Wv1xZfr4jJAeTA/OA27yDhKGFaXp9Me3EAvjuk/vqoB3q2a5L/LuP5H5y1sLa+
	 wBGcJ/ceEWWE94ocjk7Vg10uiCmOVL1blD8t9m90K7sNTFUKSEnoJyG11Mw3hSKYhaxYFIrD4xE2
	 vCxC4+UKi5nxl2D8L+TaDDsyEH3LPhM13tafOf8HY8xnZINDtL/ob06mIM+b3R8XqvBHDmZvYW7a
	 zpqCj3MuIsZWbqNoL59nt14/TjTnsz4d/sK/J5DxJgd17qhFIU4o9dw2nbB9c8
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <fafc0369-639c-45aa-8eaa-5f67b86590ae@foxmail.com>
Date: Thu, 18 Jan 2024 15:33:17 +0800
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
Content-Transfer-Encoding: 7bit

On 2024/1/18 15:07, Qu Wenruo wrote:
> 
> And `btrfs fi usage`, `btrfs fi df` output, along with `btrfs check
> --readonly` if possible.

The environment has been restored by rebooting the system, and there is 
enough disk space after rebooting the system.



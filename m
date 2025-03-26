Return-Path: <linux-btrfs+bounces-12594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B8EA71A2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606C71889805
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240218785D;
	Wed, 26 Mar 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="OlN153iV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4883C1F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002420; cv=none; b=CBTEdbUvKo9r3Fb3S70EvMmEf8PgtLmMTSHU2wL9TMv4LdBGYPePfhmLH49n1KfTv2f6p0eg0ZwgXXP9R+yuO/oT8sM/tdaMvCnErAI6GBwa0D4vEVfYY2f/m8M0FRN1kRdNeLSZhzvEB8qTB5JaxVSmBiCUTm+MbX38U3w448o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002420; c=relaxed/simple;
	bh=dayZCmhxOEVwayOCmIxRPY3spDYvqFiI8WX3sjg7Fjg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dF60WwGUHG6VlrtKSk4Xv6k8u6UKEOWLU/FhVUtJAzOgBwAFGmHTl4CmJ9VqLkT9htTJk1ROTJDtXVSdlOGhB7gkSJ8v/hPPgHiwUDMP06pmj85k4lAh2p80MOFCkwENmNaeyQ2HIC8Hpp5tmS2nM5g2SU3W/X2kTQqIQPcQVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=OlN153iV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743002355; x=1743607155; i=jimis@gmx.net;
	bh=YHZnOZcEao++LQyN4Mifmk6HPWUgy5L/cQZ6FLNu5ls=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OlN153iV693iTSxywupQgKH+dLL5T0HoRE5fYyYVLj8IfrZJJYO+ULrtDS59/M5s
	 e6ArUGKya0yfIrcdzrg995jcgb51F39tDpUF7QMHwMCEhCTzTwHnkf4f6Ku65bc8e
	 hmUNFKBOaaU1CelDhNRtEkSf4kvbXNvDrFOUaXlbuf4Od5YOqFkgeKh874w7sh92W
	 +G5NRxLtrBaoXF0BAsmBQz7bH5ewZAP9Dlp77MxqiOWq8QWsnKie32fujvQNWpVWR
	 YfHhJz8f9WGSJVRIrxU9th6Ebm+8Q/nTyXxfnntjdSggbCoqrzq++BJTwXinxAoVk
	 0O0qEKyV1fkC8qdI2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQg6-1tBFat1sCO-013Zic; Wed, 26
 Mar 2025 16:19:15 +0100
Date: Wed, 26 Mar 2025 16:19:14 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Gerhard Wiesinger <lists@wiesinger.com>
cc: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <50f0a049-22a9-4732-8286-4443e92ae18c@wiesinger.com>
Message-ID: <7799a71a-1fb5-a670-5cb3-fa089b88d670@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <3ecd06ed-a1f1-595d-a7ce-c1018bc15baf@gmx.net>
 <50f0a049-22a9-4732-8286-4443e92ae18c@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:/62Bun5Q0PNSsm5A4Ziahiw6AxRAtS6N/dXINC7n2dGB5ID3gU/
 f42zJHOCwQuu9FZpedToCOWSHk9/6tuJIdljak3/K8pPIZF/Aac+SptolD66s6vQgD2Zmp3
 S+ZyDfryynZhBoBD45CwqARPWoFc3W/k4BW6TukcUZRFnMWkXPC4yR2ecpAOSBXpfMYuKYn
 76e8o7NoFMQcRx2LR1GfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cQXmTVDitnE=;SU8WElxYg1HsfSFtG32+s61DFZI
 ssxHhxKrbLcPjlz98r62nxvJ4+F5ur8Wsp8vBFpoQcQ+I8Yxo485Lg2jI4rHE9tuunnAgITvg
 MJSS/xssVCYevHmF9OdB8GVHtyBD3nYKzKpfdyhKfCLwU9fRZG6fSF0koyncrLV0Qo3K+6x9g
 aOZxE9uqFlq73otj0tl1IGRhUSfMBeThQDPy1MQS1Y7+XotSHFMZBuXM+tJHc0r4bGCcy2wDf
 tBTIOiBCAHTi4xGxQrwahTOoKk87vknBov71+fFGXJ/2eGjsTbjOV/BYCaFSYWDLwM6O9vmVb
 epU69FXnvC0085iZ2XJhhyJdT2N5rvVePiuxyN42rZf07Cscx0nVSlw55agdQeJvP26bwtnCL
 H+q4ZVJWD3JdwiUN6bizUi2cNJ7BlowP26JlIpLmiS/mD2UxwxHIQWATpQCa/Q9YA6pFJk+5Z
 yrznjF96HlA7HeET/MSDqTDoYdph1uxcztijwYBavTIFDiTN6xXF/V+8hktFG2B0Bgxpb3CE+
 SrI3659vHtLt4ctOUVvwDOzrPVUu+uLypzJvBIuZAwVSq2Zad5DsC5/6v1yfZayrZ7J5fR5oJ
 bu7KoQ8t/Bn2kzJjyVL+nCOoz675XXaEeM5hc+ax8Vbs3mA2SdJqgVmDrkAbFoKo5JHTAKuar
 R49pWM3qD8+iDM55Zk0Rr90gY4TkUoBwKsiOeacW7p6fSSXmS7D5NrvGsOTJnb9rvrW+lXWQJ
 yMn8V2ApgTvajfj9VRV4IJ+FA/7xfqebh33/4lif8+cAPK5OaB+MggsfMPMgmhdBiHPgP+G3K
 X+U0YoSzTCcBK3RchwIb3+W8JY2qmL6cJjA3VKHKqnr7w+Si8KgguqVpOfX95WgWc+7vOaWrO
 V4VXQ7ie0YTW08bI/f+69E4VKnoeIvBACW2738Bh6F8E0jpbAQ1YSUwGMmr4st5QdXm8AKYfE
 g1q7v2PR7BTSXZEFW9avdd6RBp2eb8YvKCkumbJoBZt/T2MwYoHi98cx1/kQT9j93orb87pkT
 eZYrrfEWR2QOzz0UR4vHNnAOTZ7jOadKvfrN/PkdGWnOUH4at8JuY0jr8NSO5wGFHo87eux30
 0ROakPCFK1tEgmuPvFQGeRtWxc73TWYfhRZOnKnuoe9AzxLzjh1BxFhuQbv6wr2HwWPjg90Mp
 Lo4bMIixItRtbxFiKaqaTjEtGVxVRqvdqOT6oUAw+hPxgR/l4i8QnMavb1DITI563ENSSkWmB
 hwGstntRNlC7lSyl+ur5wmkmB7+mx9WDPHUl2CVaKf/OLFB2UAkcX4tNhLHRQmzQmF7xftd9G
 QDO05VvX4nY0O/4l3xxcKzvQFZZBYT8tHHFjT+/JPxAc75JME1my/lo2yfjaJyHd8e7Ny1/jm
 zJQzaCceMZf8RsrGZvepxGety9MmeGUTBdAcvcSvW93rMGjI5KJNZignpYHZqDsS045rp2uAY
 8YIZLyw==
Content-Transfer-Encoding: quoted-printable



On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
>
> Are there compile options to disable usage of FALLOCATE at all?
>

I just tested, and the only thing that worked for compiling postgresql
without using fallocate, was this autoconf "hack":

   ./configure ac_cv_func_posix_fallocate=3Dno


It would be cool if you re-tested your scenario, and verified that
postgresql files are being compressed by btrfs after it. Note that the
files would need to be re-created, so most likely you would need to create
a new database.


Regards,
Dimitris



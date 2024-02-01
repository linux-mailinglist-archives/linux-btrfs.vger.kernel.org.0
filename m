Return-Path: <linux-btrfs+bounces-2018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3438458E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE74D1C23789
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493FB5B680;
	Thu,  1 Feb 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jdkCDg0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45F86658;
	Thu,  1 Feb 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794130; cv=none; b=TfReiM+VctDja+lBR1i7p68tk4YqyYV1GgEGrL9LK3ZSoooYt65+ovXbBuw1K5f9GHi7JmkW82Do41dS+msN8dAUcMykFBZ/wN8Ml160P7VjiZsMescMQfOEKU7M6eupLH6lyL/xurhyYSi9b+FV52MfB+cWzVtBiL9m6RRrcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794130; c=relaxed/simple;
	bh=SA4bfxfxzMyS4Uq6xSXql9EBB1rOpcQ3WFAI6CjVY3M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nXQ5WB7QdfZxVVPd0Q+/5D6hl5Kwma+kHI2XD3Wf0INmR9nkUC+2d7BwklbCyly2YMQvGAHozai1Z6ubLnVJYe2FhhhNfkfwF75tuSpYPoCK9imCyk6ps9oJlQpr1rOwSgCYGZQ5zUEGxdvn2ilOq/M5A3cby92jM/xoaxWE3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jdkCDg0K; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706794100; x=1707398900; i=markus.elfring@web.de;
	bh=SA4bfxfxzMyS4Uq6xSXql9EBB1rOpcQ3WFAI6CjVY3M=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=jdkCDg0K0jipMZSuFNQwxMeGM40WxNFcLkxyujHXg1qfgx3EduShl03BLo4bvEiU
	 VXi9+53+GeJErlEdji6RmW9vfH/PGDEa2rAvWC8f9V3sS5Yjw4hiK/AwnvKs6ciRE
	 OWuR3Lwtk+ihueY/xlyRZHO/5ymi0VjOXts299YB8jpz59NolUd9PAuoV3nWo0Iyn
	 x0FFlw0MVOmTgf7i3KpOaQNtSZglf1FLFJbR0kV+F1jEetgYybWGbFETYfeocOjsl
	 A/978FCQ+qG+qZHy4EoirDQEJmm5hbvdlfVTb+Dn2oQZe2ZzSgl+tSTO7MeK8ljIS
	 93pEReYixkHIGvD3/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1qssRE2Nka-00f7xJ; Thu, 01
 Feb 2024 14:28:20 +0100
Message-ID: <d14e1d0f-7463-45ce-a25e-2d80f7996934@web.de>
Date: Thu, 1 Feb 2024 14:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-btrfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20240201084406.202446-1-chentao@kylinos.cn>
Subject: Re: [v2] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240201084406.202446-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BqFjLRTgOa3kIpDHoOJgHrjuHTFWi9QzuakpdSBVn8oCUTV0HeJ
 7W5j/tsDmlcWXTmdop4L90Wb/FW2yUILcYA7gwtIg+tB+nmLVop2xUe9+oRfbkVwfRhtyYk
 cd0HgpVkI/x8Shvq1CiiOsnVk5MHnbS1LIZJKDNwS9hz7UOhwDYcO9EKsRcdVKj8jZdFcyn
 ediP1W0J9gUS9XquijnDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+gGUSgueFBk=;RkE7kyyY7SlFYfo50IzofGYDHOS
 iBMxatbrW9MQL3fPfM8oLUoULsAEQi0LArqcs7wDQvlKToT9Q1c93gpZRBFzG8xTps+al5M4g
 E7UjqOeonej8n5w8xPBoFD3sAIbrBMkFMUO2bLgkeaCw28An9Q+jAmjz6lF6GM0YjYf/Mlx7k
 jPe4j4TSFzyC4VAS4s2rUnP8GGXNs1r7AbpZusRDbcE2+xX4nX0Rs6lTIWWRx9m8cDR5Syl47
 FltDcn1Kah+SodyJggiOvKLfXQYp2oi8NP1e8WhLFIJYYRV4xaJcocxTPPgqcoWL8POv6XDdZ
 lSwOiu5ytcl3cKNOD+pBS8Cn+twtjhb/V2eoDj9RjmHHlrjSTf68g9JzxkegkVd9tNvCTm8Ef
 XxyLmIFFBLwbL4sJaDPOaDX2hRoLPfy9nwTMYvmHWgtl9TUxc7y69ONx9cRRjQEH8Hv9tla7y
 u4u/83PiB/j02vCoEUGdErXIw6NVcM2TZgZW+rHIE8TD7kSC9Pt2OtS3awq2IYRuIS6vVJbWF
 HIQ7rjPdRQPtraEXB3+eWr5QjxIcnSC/+dngYiO+2o9JL2gMoNPWYkIkO0K2Aisdc/IM9qnMK
 9WI3Peh1OtP0lyYz98yVdbpzSGLRoUmXudr/4Ok1GgoXcPfsuMeW2deSCXBOIGFkUNkN2MgeM
 SQg+0oDGPLwlT6ssl88NqDhCfbrFm0ywjPofAcHM4c5Xgr8OuAjSQhpEAIVMPwT4SL7aS4qPu
 jq5WocY1md27KgLRr53TddzgerNGw2IP9JHD8NLZd5+8oMsbJ/8oF6A6gjaTvRs+2SAVmcoPc
 yh7P79p6neplx+NpAFycz8GUV4fZv+YDe2ax3Dq2cBRCQ=

> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> Make the code cleaner and more readable.

* Please replace the word =E2=80=9Cnew=E2=80=9D by a reference to the comm=
it 8eb8284b412906181357c2b0110d879d5af95e52
  ("usercopy: Prepare for usercopy whitelisting").

  See also related background information from 2017-06-10.

* How does your response fit to the repetition of improvable change descri=
ptions?

  Example:
  [PATCH] btrfs: Simplify the allocation of slab caches in btrfs_transacti=
on_init
  https://lore.kernel.org/lkml/20240201093554.208092-1-chentao@kylinos.cn/
  https://lkml.org/lkml/2024/2/1/387

* Would you like to group similar source code transformations
  into patch series?


Regards,
Markus


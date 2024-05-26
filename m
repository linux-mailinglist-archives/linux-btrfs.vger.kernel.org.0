Return-Path: <linux-btrfs+bounces-5290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC88CF2F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F8281977
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E56944E;
	Sun, 26 May 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="WL+o5N0R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB66FD3;
	Sun, 26 May 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714486; cv=none; b=Kuv9obpduTNOBknwOcZjhvb0Ee1sQF3dqOMCiu9ck+3vvkZiIs7d6AHpumYnotElcAoEKEac+t7wA0fZ3c2FbvfAzGb20sUkactMhCIIsaMgiSwE0xM6XWTPaoSphAefqEqpvVpBaf+5jD1gJfU+KIluU/17J8EfSpUsM/KIEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714486; c=relaxed/simple;
	bh=qChTYHdKiktPVHGBGd4i1Bcb/tITVD4DvQJ8LX0W9K0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Qd58s7SP42oTngGzo4TYx3T1w7PjdJawr0n7rXzo36BI5bjgNlMY36sI+gmNOdBmF/Vnj8J1TsqBNhlRp5wH4pUSJgGtkENQ5dqAVEku9gH+9nkMbmh7A5W4LhVh3jLpTrhoMkbazKzbyi01XgdsgvZymBWVsFLjkSHwKzO+GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=WL+o5N0R; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716714482; x=1717319282; i=toralf.foerster@gmx.de;
	bh=qChTYHdKiktPVHGBGd4i1Bcb/tITVD4DvQJ8LX0W9K0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WL+o5N0ReIi7MoIMPUAeM+ab1A3QJ9/ycuneL9BpWwH94twUV1WNhL1HUdoNEhwR
	 WNhVpVxcS+mv6JT/LMVUR4GuVFkyMMyV/S2PNbSqXU5QPYPnD8cZL1F75XUrKZbmM
	 wqlIAUpAE1gJlg9WONBDnCeyAnMET7+vRq60y0cpehZlRZybvAgjwFmTuf1GNfx3Y
	 4XW35CS5114fUhOO/R0TYCxT7eDEfaTFa6SaaO3hLb6b56usSmlSSjF4iKmsbkTyc
	 qijhuskl89yJFHEMs5DPoPuECT2VQUwOk5yq1SFO/v8ZcPFQ9CyD/HuSu7kE1444p
	 DgTaGF8AC2OOFNPeIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.6.29.73]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUs7-1sQb8t2MVF-00wljU; Sun, 26
 May 2024 11:08:02 +0200
Message-ID: <e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de>
Date: Sun, 26 May 2024 11:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel <linux-kernel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: RIP: + BUG: with 6.8.11 and BTRFS
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G4/xikM3HbpDuUgFj5qYgY6lckIC2xop/1caifcUeUxeJ9e+om8
 fFrBsXYmuipLYLRi9FEE6pS/f9CHsG+nxt9H6qyKFxLPBz1BDukAUFCOa7pDHnhqC1msYnD
 81AS4DyhapDtsUvuO+NEGYO3gh/8/6rbytHHAxeXSyCvZ8P2Kj9k/GmLL4SHzfFYVBeR9xg
 45i193/aT0vuhPgsA7c7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X9AFn0fGzas=;9tYEb/mp874/6ml+Gj6VFntftjI
 dSAVc1Lb56jYKqcFC9t4wJcz8MjEnGV+Z/LFIzcHNq1lk5i+jWKjA1kNK0t1tyX+W52Oh+GL5
 W5ZsBYKIgWlQs4xUeIcGHMNN95xP303jRbZWHF95XAw5rDXPOqkjJSPbqVeTA9vaTU75raM2G
 ZuAxwbd//bhBLx0YJ1eEW6zrfF4hT0C7bL5vVGOj/m8UeDWCCQgUdXW5+NAwuVvDt8w0J7OW/
 iMcMkTnO/bQDD18lkJ0M/bSPIz16EIpS7mAEZh0D7c2rkcyBhrBYJvaIi4QF5ZG6tKZdkqy9p
 blLu+Mbc7R7PUjlbgCIZu4mKsj/Ybpg/dJc+stFMeKdPqH0KqniX2hAipV1zfUgInGooiyOeM
 EIKGCIa+UOKabFIE19F473O22TmLjbU4469OZeIxi9uXXi9p4XLyQ+8tv6Nb7qGo9XVhrurIn
 38BHFd9zyiU1N+iaCVe7hPIupSFB0kDSEPR713nLoMeIjsulGOWIYUmiBWgnK4lCU8lTKmuB1
 YTlqOVdXeVLqbMngC4M+oba9y94tSnN3CcjZ93yUoBj/LDjcyV6bDsviYdrn1Qd7KAhks83Nh
 FxEwz34UHURcSgfGJ6K8AJVypkNRclPYE5LCbf+1ecd1OCrjZV0W+3gc5g/Cu57Jk8KDRbMgz
 zVpSyCykom04a6t4eMYd2gTlLuruYfWJWBeezXAXcD5ovPTHICM5PQuLlcfiSvDxVORabQWVo
 GFVSmH7/HEudZ84NYjrBz9/bbtk42GtO13Fb3bVbJxja+c8HPIANlRViP7Rbb7vNYpB7Ib/pw
 zV3o5BQgdxs+6KNfMy0lQMCyhWCTr/ubpkoiMPP+KDMGY=

Attached is the output of

grep -A 200 -e BUG: -e RIP: messages > splats.txt

from a Gentoo hardened Linux server running at a bare metal server since
3 yrs. The system contained 2x 3.84 TiB NVMe drives, / was a raid1,
/data was configured as raid0.

I upgraded yesterday from kernel 6.8.10 to 6.8.11.

The system does not recover from reboot in moment.

=2D-
Toralf


Return-Path: <linux-btrfs+bounces-18756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3FC395F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB318C1AC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF98E2DC79A;
	Thu,  6 Nov 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gJVHNpk8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC7FBA2;
	Thu,  6 Nov 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413609; cv=none; b=TpV+vcX8vaIGxhI9CbYF2+9OU71IHIAFLWqEU1Tsrs73FMZo46JPDrM9Lau/Tgwqxh+7nA1P7IrBS6zVCLnn9buOUIrDVoAeBsO3HK6gdZ5a+SlLOre1+NVhif4teCXofCsbbi8RgfGi7sC7+OMTUPszZKv0M1AjXmkG0l+J1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413609; c=relaxed/simple;
	bh=6D6+Qn9PsA9nkT7qZ681UxT4R9kAntLbwFFRBrttOkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAHxQ/5r2DhhD1gThHCYGofHbBiRO3zGl62WCohFtwySSCJJkuix/w9sSnvHzMFxwVUJnYlLl53hoVtPYNMzD8bmfjfuv5F47apuN+1rtMsgcDogN+ehwu8rtYh8vs8W133dv4Ym9EGWF110Uz3MLdMyLr5Z9KEJCUPcU8fRvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gJVHNpk8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762413596; x=1763018396; i=markus.elfring@web.de;
	bh=6D6+Qn9PsA9nkT7qZ681UxT4R9kAntLbwFFRBrttOkE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gJVHNpk8xG7dYVgTFLup+k9rH69xTYAO6YXdl6CXgryD8EjHdYnXlAmkoLfSDz9i
	 Eb1EX99hVro5nqIVWyLUC/ZlYqB03ilVsww75b2I97Jsq6b4oXc4FpeZ85I3+Qa4b
	 ohuFpMs5HtL9Ecng+f+BkPjjkISD9/h/mlKuBuKYU4l4CVbaGBrZiuFRXYxZ/ylak
	 pY9v1rabP74Vu9gM8FCiMrtGv4iSF/lM9lbIIZqQtRu8oYkV3BK9mayHjHb0qdNW4
	 d7NK7N+TqG+WPGNK/tNpQaKLdYvAohjsRZL3UYXWXGwZdB4UNRTP6TRkE6OL3mrue
	 7TqgPMqV+Mx9S8QUvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mcpuy-1vqnKo2xqE-00blGs; Thu, 06
 Nov 2025 08:19:56 +0100
Message-ID: <ef114827-f5e4-454e-a267-055463b3c767@web.de>
Date: Thu, 6 Nov 2025 08:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: scrub: fix memory leak in scrub_raid56_parity_stripe()
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, LKML <linux-kernel@vger.kernel.org>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>, Zilin Guan <zilin@seu.edu.cn>
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
 <2603afff-0789-46d3-9872-3911132a53b1@web.de>
 <a2d629ab-9f21-4b98-a442-fd73cbbb2dcd@gmx.com>
 <c31de8ba-77d2-4d79-890a-c23f1797a735@web.de>
 <21a34072-7f09-4d4f-b490-43637996c91f@gmx.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21a34072-7f09-4d4f-b490-43637996c91f@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Jies9RtGK0K9sf0HtvtvGNHTbh/snFy2iBe3GBDJCmgrPUDcwk
 WzidbUrurtbnaDL1fvadMECCArpuTnApk7IIIgE+hlULSGAAuQ0q5c/CFQ3jCqb9YQfC47x
 o2ZmaFS7patDj/M9B72JUHZ/MBL27MuvwGkaeDELSSHfIAwDljX2Hqe+krkgFZwj5+qckhg
 Cau9eVKXnd7RxMKuhQusg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ud7xddg5fk=;W5UNZEuv9MIOlhd3Ev3W43BCPqO
 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
 JzEsglzZuTB5Ed/zs=

> That=C2=A0is=C2=A0handled=C2=A0in=C2=A0this=C2=A0patch,=C2=A0a=C2=A0dedi=
cated=C2=A0cleanup/refactor:
>=20
> https://lore.kernel.org/linux-btrfs/2d2cfb7729a65d88ea8b9d6408611d0cc76e=
1ab7.1762398098.git.wqu@suse.com/T/#u

Thanks for another bit of collateral evolution.
[PATCH] btrfs: extract the parity scrub code into a helper

Regards,
Markus


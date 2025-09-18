Return-Path: <linux-btrfs+bounces-16939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C293BB87059
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9516F1CC1B25
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6B2F83C3;
	Thu, 18 Sep 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AOUMRM/3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D02F7AAE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229831; cv=none; b=cDORcoriMtBAdYE/vpnUUbmLAlaxmYfwKqCgBAi92sdU8nydMwDqVM2yn1/XKkJ2jxrKFo+BlHoLuIzWiNYpCk6JFq+VSMYNjKRZPm3ygmhx9euCfySBW+j9KhMXwoJ1dWMsoLBJMnHPkgL28/uauhwP8Wld7JPi1PVyk4XVzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229831; c=relaxed/simple;
	bh=O4YPvHx3FhBQKBhiLJIArofq0e6hK59obw+n/IR5vOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=StUOe2vKoxXu0LaRKdvbTjnku/t37Jufow7slgb0NEtq30KDqFrln/uO7yY/xJIzGon+NkMCPqviloCuUSRy1b1p+rd0rLh5ugUAFA45b4E44KDPBR2UfSrrL8fdc8/9HtrIi1WVtQUWywPgrE215pF1Ztgl7XwdJ6TfTY2U7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AOUMRM/3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758229822; x=1758834622; i=quwenruo.btrfs@gmx.com;
	bh=Fpamz8RsRdUEWJpqdDrW21mNdyZzEnj/r6VEhToTRXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AOUMRM/3zPW4LnppccdS+0YSpfGPAzOCN4sTbZQjrBUZEyL8m/0zQWUEWlLIIWZc
	 G4+tdKfJ5ZL80cFMgvzt3QmMtA0mBFSr8ZJUWXtxjJW0p68smvHaoWwtzibwhVD3V
	 mbzzakMIxkaZ+Iwb+5296nJK82Q1ifX6yGeECQIjBJs9IC5BKNZPoSKBKUGF4b3g7
	 Ss2s+/9gylYUxQM7LItrpZda8CaaNtZhnE+W0KfWr7r0vJISbYy8aAVCXbFCfbsxG
	 t6tsg3CxsgTet3uGQAqqZ1TCG8+oHeMsrosy30bZxtNAdkEgDv38JnvozzqXdwLYa
	 BUPZO2ikzw8colJkXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1uiluL3uu4-00Pw6V; Thu, 18
 Sep 2025 23:10:22 +0200
Message-ID: <b0eabbd9-ea04-4ba1-85a5-bb8d4091ec3c@gmx.com>
Date: Fri, 19 Sep 2025 06:40:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: a couple cleanups in replay_one_extent()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1758198953.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <cover.1758198953.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:39Vt/JKlqfSTUM/OZw9ci8PLoUYjoFV19t2UuQ3hLC42oXb8uq5
 qS1cCVHMbZq6SiJ7iGrFUSvhI1Ve/bJhKcEJxlGIafk4uUTVH35z9w2GFS85Di+N/Z6TDYf
 cjVQxdoJrMGV3b4487qyS2fz1dMagaam2dWd3lofEqn8PKrkGTbz1++DdpKQ0iih0lobzER
 FMmQwsVprHttrc54zX7fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zDxFr9w7Waw=;+qXuf0e2DSCqnhlkZFkMBANyaiR
 xFQDc4cV13xD3Idn8ZWjIDKVNKj1l0fA+rvRgm7MmznwjnjGV2161Md4iWxbMzASAzL/DNPUW
 GPwsGoH4YnYktrvG8mJ/0sHx4CxuMWCD1poGLBeKnwfL3Bl3ni/G3k/h0xNxDkPtBCJRrwP44
 f/0e+uoMuBeAS7QC2qfj6XXXaBQjkWknJKWLghuWrPcf0Rc4DL70ik+VfjjzAB8Q+zYTUGRt9
 2KWgQvHRd50tbRDzK+o2kxu8xblYFQTPGY9Hjzi2TLe5QMxHLIu2g1meic8GaCcok9McJsa8S
 MOkAiwVJJTXQ3yg0LzQXQwh8yBppHKsyq3vsvdMZ8/0WhSx0QN/o98z9ol14huPwwsfI7xx6y
 ScpAIm/EAujnnammqCOITSZHENxRSjLnhunJRJQSYMuwCRlDWYkEGJxoi2PaGsof2ZRKYKO8r
 aOR4/UMH6eI34AWgkiv/6Sf24dD0lrBviSpTzKn/i2tIbJFKXGM0jJnabAfdNlSBBfwHUJyaE
 PJpq5xobcvxz31xg4rqobpra/EBjey34VywyWebjOEMIlnjfKqJ5yotDvEt0qcIMU4I63/qzJ
 XivRg0hQBA6fNUxou7Ywys841M6vQGaSVQCJyLGl3c9iiZDw9RrZXSqXowIZz6YNmCOVZoSai
 tRJCZy9mblhSaQO5XQ034E++w0cmRkdYx+VzjUZ29IVHRzPVkqNGusAngocATXJbi6rjIx9am
 pjCdq1crTzYEtydICfy5ldRvMWforiJmoqD/PfWpXxsNe5ar/b7dvPnxeM+MuJ2FUUp8kibRh
 SImEUt2F9QA90xj3ULnwkh/fzWc/zWoAMCTAvG05aSJyuRmvICeN4Wy3Kq7mlpnLE0Dr288Z9
 GHBN7h6psqKKLEjgnfS2bKGn3EawzplYxtn29czE8+1p3Rpn8Fyl4ApnNqIg5GosOsST0m34a
 ULZVfJo4Zc1QfJ6V7NQjy66XcKb1kuhnlXGavCP6IYWLs0palpfKWM4Bdms+LWizJAXSgGyYF
 6t7qRHKVd8GUag08MdzT76QYgAwUQkPr83lE6AO1eTKqGvgvRsRNRMWbkkB9dcvIgamC2AqDR
 gN7t4smVzjuXN1sjEij7krArm+gEy3ft4lnBRWz2Gl3nhH+8Za/IKdivHBtZwEc7voV8SP4Ug
 IGocfjsEY1EF5w816YoG1IbfIIHRHB2uAiFp09KR7sERgNEDdxxZ10/vkMah6u1IPY33kCjoh
 f5zF644Jqt9wWcUed2dKObBOYP3RWV9KtpPmJSqukb8hcLzw72wN0r1fAAq9HNrkbwcQdF6E4
 Mc0QWIDF/PD0HMpou2Wj5YBL6Rd6Dy6OEjlt39SiyfH+93iC7GwzNcT1QQpIRlaW6sTTiALn+
 hLijro+5xeffhEdIWsSQTBVKkbBrklgxa6U2jSdMfFeXimfiWBd7OIrMGHYCnZ/dlLH/B0nR6
 xDwNr49O+be/Rx5VPNlZPAPdER2PE4Ux65hbyn502KE0bW7eajV5gXtZjveAKFM6ixuFAcneK
 p1bmOp/InJ8hZly12FL19kmsF8lU9IB/kcR4eaPWIHRJ3BmDMa/riViaZlohn9hcNn+zKQcw4
 gPpd1lxiEp8ndb/g4M4vw0eQXM3vlAGemp6+0vD7UrBCLiF2DcJb58saDG05xzIHRCvjIVgbu
 4Zg1cDlw/kBRrlzvvx81xmEm/W1klYStzxdoj4MSRZlyI7xYoKv8w4aTBLVUzpQItGjWgOG4z
 svKk8F6Aibj5KML8Gmk/KE3mVFLvtElluJabFrRsZh0KC8QHsL6UO55QwIMDKa68h8xwhaKad
 6VBxctxuWbRVZdn3kOYUad4jQBZB+Xbgsjh+J+ctf1tARbZie8rfZ9h0tvZ4jU9XiYyOevVwo
 /wfUoK9mG6bnwCNT2LVknsVafODJyFjmjiJE7JfSzJ9J2gbI1/sm2E+iKVQZ/naMfO2wyI1gP
 +WkYCQOrJHCLsYUopgcx9tjw9OZ7Jf0J+FtxwBHvS488w68bhXdBcdYh2Uc/nSf2KiVkJN46G
 l30JDUgfmPq7Nzhet3ZLjDcStkRRoZiQHq0sEOD2BSf8HmiBu7y0HoHkb7eN2vVzFsuTwVfeV
 4cyQ5Ym20X9r5WzKS3vwVZJ8lmWuK0N/4eYexchdEa9gRORC0nJiRiWsCQPlA3BIzqtK43pmW
 X5t8vydiIpw2rIM5wbFjYXoLB7H1oJXdq1LERZfkpnTOOQjZwRVj8A71eojCy5DFKYcAd973U
 MySUebas5ArbWKinSrOSl4huufzBRB76vGvNs7/an7O+HHINaOr9+oGia5M7qnimxGR02v8pE
 S7l8AlEJ1IP7vqs/rRKg1AT7zDwXaMz17g3NZsKeXmKiS8FC7Ywj0Xb3sN6JPU7vv9I4++jP8
 0RAXl2878aEJIrUjDh3OAI+dZh6oEUFVQehXIOX3KWlHozQVJO6NKcjiiRjVFrInnm8esPMu6
 9D/VMDVFTcZfekv5okhiaUXTin+pJM2HUJWds+N7jghKHfs3EZo8En6xV1lkuwjYfXI4DmX9N
 By+RjSExkuxQ0KKefLY76+AXVpvEG0hOYi1YMYBf+jZg9s4X4Qfo5qy6+xAcSOufplSR2WYSF
 EsMdijExVyts1BMQ287p91JQcTq9/LZhQItZk5NMmD3dTx3YdmQuHwVcF6SEE6k9NND63aJpd
 aWzPzasBRs6o27DObl2Ud2XdEoMuzivX/DNyGAHAL0UwQCSRSmk7fT43d5ME0rbKOBQhn5CCp
 VVOFdHDEpScWeSjx/+kMjZba0DfLrVIUmXEgu0bZE6hSdHVvP5OIhx8r1TwlmHsgDCu99stFs
 bLkY/vke3KCxCoyQITuPe6W5kecWr04rQKrIQjW8bI+8BN4bBdDk1q3TMC+3SCqT1kn4m5WhR
 DEKIyC7xQb4A2+IZtSxzyg+4Q5+FVurcjngY/jbnq0yGBXFWt5mMCF1mEmONXkL9Bx0Ig4PDT
 oHWRuh7B8c2GR2d7lftyzJqnt6QwRR9MW6X+sQPZATIAG3bmmuWbtodsGaAb+GewPqhISz9UJ
 fVoOXPLGRA/CNp2xHCUzfB4Dn1J+kr2ES1GsQOvdIgSY1nL2Nx3X4u7eaLPyNlvYAFJg+H987
 u+4ydgYWV4wU12MHxoAkLAgNYIdJDE4JdZgfN+3xeu4RY6XUVPhXyATAknufp5Pepaiu6Dof0
 /4716I2XrhEb99z0kFuSBXymJzvDfIvDUIFU+AzeYT5Rh7WNA9JoTX6Xwxqcoohyqico3gyHU
 ML3uYTxiQ1onEG1SAf4zPXhQ1EdZV9ZSmyoCO6IyRENAgbl7uaRdZbZrT1nPWY/ZMYzeyCPkC
 Wa5p+h05ond84lQ/A4DYyoNvGig2zfR3nNlKVtDUyOykJLHqEORibNkRr7WGrYEJaD9nMYxUV
 0paxeKvnGQxvrTR3j8M6gtjMMg4FTTAvEJDM9q8tW8jycTuLOzehsrJxyk46QSNzWahSRf+dH
 LoM8V/vUug3d4zb0zYldCBqI2B1+3YA3ectVgA8rIOzvRL3lB1lsOanvz930BQJ52znAQh32A
 z38uKtmiweqWCAOzSPngGTF2jxIH/0kzg5SbHRE4Q/ZRPaXsH/uF/fastPjmICdF5kBdhzTIh
 hg72BwBPS7J5TIDaPLPHfkl0KV4GnN82quW8RKT0fDBLMfkTwZpg6TrvQjAbMdEem+vn+9OAb
 jjF8RgcGKB6OzJPONHqm8genyjIU8sO+ktpK6uTIKEyborskcHcKBN5rDMit0zIn0TmYFEVvA
 ybeoDbokZk9qMhXHpEchjsXaLAtz2RR+hwFeJeF/mcMBkWHVM+NaW134PltpeXIUqJqvCjUzM
 Qj8yLfsSOvvUCkr80ca2y9hALg1bm5/f7KNe5lM7h6nqFtZc/k7A3yalB1CY/bQJJ4HU6aDYR
 3Yesf4CxnB7Skqmd8kzQ90jd3nD2GIolTpTIGZwFVRoptd/0PiJEwtV3KaT5ueUMasetGPZsG
 CeYb7v3tZUIvMK5YruqpLS2bbqe80JlNOEslI1C2UZ1juQDlDFhpQLdnMyUPbT8SdZiSW5OVU
 Sp4N6MLIee0M+GvJz+/48wRz/8UeBwhxJX6cRQPRQjkvA+22ZAZVSFM9fYvh2NlOWct1yN32x
 EWDAkGsASg/F9HwLBYfxg54jMggDThWuU/ISjPHZcqRykSmBEUIsm+9dSvG0n2gBw+pwykDSu
 RXYSgNpJt32mtv5IylVt0t1Y/ORPAaPmA+J+/B7pmo1af+/ots+J978WXd3ak2trpPI2FwmDf
 PU1mIq2BpQJes4p1oYlKPp5aTe39lDSo3fcPi2pGF5ZKd5FNsnm32h6j+Fn0oYyiO24aO/4h4
 fHPV45kpJmExN3/YAXU06r3wcbRcE/iJ8Kg2jn/bcRwwvoQYe3yPZKBE1SdssaNrgE0DKZciF
 xg+r+wshz0Ax2qL+sCMUCbpTnrj2z4bpzG5mpbTobddhDm4RrGqaXfkSBc/3AAQ4fmCh1tdwH
 V5NniY8RXfYQBxlhCzLfmXw11IKMzY5ajyt4R2uvCebzvz3n31IolUXFb7KvftdwAR4I01idx
 66bpBxqEbvREt/nQBg/oJiXDumQ5sr6C8L5D1xhOXLzN1eYSEyyc0beh/z/PrjiVQf4E1rnVM
 i3PIiE+fPlNNhiA/F/E/jRqwPdiUMpNUb+ymDpsB8epdmJVc4ztvXU/v+D/PsWlwpGTCQ6Pqp
 mWD3eksqotFZXHQe9PICjjlAvGxvwqqglBWhPNa5HQ8MBdAzMw==



=E5=9C=A8 2025/9/18 22:12, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Trivial changes, details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Filipe Manana (2):
>    btrfs: fix comment about nbytes increase at replay_one_extent()
>    btrfs: simplify inline extent end calculation at replay_one_extent()
>=20
>   fs/btrfs/tree-log.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
>=20



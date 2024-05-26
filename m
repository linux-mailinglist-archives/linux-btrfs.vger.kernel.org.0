Return-Path: <linux-btrfs+bounces-5294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA08CF4A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498141F2130E
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C479199C7;
	Sun, 26 May 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="p6orHGgL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23960200BF;
	Sun, 26 May 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734787; cv=none; b=KPUWablkp8GlRlST5kP6gS02L06nLJxJ/19D3Wu8r/UynRcMvmZCcULlEs8j8Xv9p2eThZaduwKXp39LKbr3yUCsMKCUkKwIIcx+CUVGOY51D0gST+kt/EhLcJvPv2atoo6vS9v5YlzEFbwMDU1eZw46uhe3y8bqusgJHnAN5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734787; c=relaxed/simple;
	bh=0vsSP2Wb4Od4B1kmO3pzd4R2Y0OIKxRcYyO4Yyav6B4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=R/24YDG5k6GpWM9RSK1MZmlsgqd6OJ5+gjLXaQqOk2WHdLNEOSohBcinYBPf/1bnXX9DkxmzMRfqrvecjvghBbiTVqIHJD1t9KC8lvw55A5zOr1+BCEwCc1t+TxU4qIohc3LcI9uu+HUqnxq53wrYn+V8OQO9g/pgnh4SmwYNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=p6orHGgL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716734783; x=1717339583; i=toralf.foerster@gmx.de;
	bh=0vsSP2Wb4Od4B1kmO3pzd4R2Y0OIKxRcYyO4Yyav6B4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p6orHGgLp83RyK3e9qpvsFUe7YeN+rJjKFy5IZPq41UJaINdrMO5l1j6001XAR73
	 qEjoDyrOlamUBTNU1F03FnGhhTBkqH92VLCXKhzfRDD/W71dA3arPR5X/vKHygroD
	 K2TlkVhNo83uERgvRzdc6b5jAqLWg0bPWvvo6OW5p2Rf7K5b/hAxYFJPJVJM/DqmC
	 hwk/3upVfR/D3TKnrT+WqTRZWPflAyrSpzvajd8zAljKqxbcNUJPt62Dj+J94JAIB
	 PzMqcvCtw4ye5UPcPMBcAqxiSJoxWWn81gjiBpKqPjZqjo1u6O6a9gQXW/KdeWrVW
	 xjqS1q8Capi6oX/TLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.6.29.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1sJWaz0p1O-009PlK; Sun, 26
 May 2024 16:46:23 +0200
Message-ID: <3c053912-4e47-4c44-be80-dee4ade8bc6b@gmx.de>
Date: Sun, 26 May 2024 16:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RIP: + BUG: with 6.8.11 and BTRFS
Content-Language: en-US
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
In-Reply-To: <e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6i6w8nSOaTlq0wXwkekdEooTmK9X7MxciXQU1yhRTLsNrjfmUrW
 ytiCX4XZsXXeMn3PBngobJJqf9OUpcsQA/9PqZmFg4Wp5DUSCZ5QttEXSYR0GY9GfTRyUIJ
 QB+tMQh3hlfw0xX0/qijs3FOiL6XNf7v6DA9BWqS4OtPakGr6KAgKLsVkpyED+I6vonhVJC
 Nk0yAcDVPaUGqDlGv7MAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A1vqNOGN9PQ=;uO+Y1D1uu/JoQVirb/igGMzKW3C
 Ckt4O314IHt3vZIWnagXZehzi8ezm7sAZUA71Sefd6CkL349w5Nnh7asWYfP+pdMxLleVMwD0
 atk8mIox9vv5NFo1iDKnmVnJ0jfIJWiIq6PIDp5ClUKYsganpVcZVH2wjPI6HivKC4QPQc9aJ
 FL1gElCG8x7Uh2gaI7s5t0yP5TLDcFIcxBQ5RQ5m5V90UXwmJKM+f3t77xVMi0ytAQ/534zMG
 NIWvZJ5m4b8axm39n8KlOv4w6psWcAczS8X8H3N4GiiNRh/MkHIK7+iSpe1kGOIcWSL4NRdND
 gLnSnekgMHABHAFiUZ3O3ojYeHhDrC7NHpV8JEvxFfX9baAQh0YY1/UGQbXS5XLEHvpPCCCwb
 iaD33rLYVy9prcd0z8SvIRCFwPFkK76QVFeTGI2gixd0xgLp6C+OoTj3upjhkKoXZFjFU0xs4
 Sn0E8SQ0cLIzea7rDVlHfKP8oWxwKBnxteclZDII1DWDZbUzXqQNz1No7lXHf+AoI4f89gwNx
 INgx79VXSCnL2KSJKt1Bl1VBSbQa0qBJbkryPqkQplfiExJ87D+XnXLysWHC/WIulasaiaK62
 ryPZOzrRkDLOq/gR2hfg2olwxm5mtnX9+XrRfsZGJzdcNHAz472AfQ0NsDEBPF49kuRXOOOdO
 LUepn2ZP18u83XWgiVm7KHYzB8s5pWl4Z6hA3BilTrbBFN+lXHkI8XaP5p/ITh9l7EUQu+9NE
 tb+0Fy0gHtQfLOAiEy1cltKXHg9lyZPzjOIQJA98mQ3f+tl0y4bp2I5/pUG1Cg1ktug5RtViQ
 BZqsKqO5a/qn2yHgA16C41eW21oGO2xPfICvuZAP9pPLw=

On 5/26/24 11:08, Toralf F=C3=B6rster wrote:
>
> I=C2=A0upgraded=C2=A0yesterday=C2=A0from=C2=A0kernel=C2=A06.8.10=C2=A0to=
=C2=A06.8.11.
>
> The=C2=A0system=C2=A0does=C2=A0not=C2=A0recover=C2=A0from=C2=A0reboot=C2=
=A0in=C2=A0moment.

It recovered eventually, I switched to 6.9.2, which runs fine so far.
But these are new log messages:

May 26 13:44:06 mr-fox kernel: WARNING: stack recursion on stack type 4
May 26 13:44:06 mr-fox kernel: WARNING: can't access registers at
syscall_return_via_sysret+0x64/0xc2
May 26 13:44:06 mr-fox sSMTP[29464]: Creating SSL connection to host
May 26 13:44:06 mr-fox sSMTP[29464]: SSL connection using
TLS_AES_256_GCM_SHA384
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (2635 >
2500), lowering kernel.perf_event_max_sample_rate to 75750
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (3323 >
3293), lowering kernel.perf_event_max_sample_rate to 60000
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (4168 >
4153), lowering kernel.perf_event_max_sample_rate to 47750
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (5273 >
5210), lowering kernel.perf_event_max_sample_rate to 37750
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (6600 >
6591), lowering kernel.perf_event_max_sample_rate to 30250
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (8318 >
8250), lowering kernel.perf_event_max_sample_rate to 24000
May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (10415 >
10397), lowering kernel.perf_event_max_sample_rate to 19000
May 26 13:44:09 mr-fox kernel: perf: interrupt took too long (13048 >
13018), lowering kernel.perf_event_max_sample_rate to 15250

=2D-
Toralf



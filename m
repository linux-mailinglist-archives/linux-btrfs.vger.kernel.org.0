Return-Path: <linux-btrfs+bounces-17975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1DBEBC05
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF04EADCC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D126C39E;
	Fri, 17 Oct 2025 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hYx6kM1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341D1D5CC6
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734178; cv=none; b=CAl31xgisC+OFX+L7oRE5ZztXdYYwgoVcGrdqPgmzX8h9hVHpDLVmjH0PuYliY2gLui+X9K3xuRz9pnkQqsKTSxv65KUJPEJVE/GTYrtlb+ufuheRhxHlBE4LcX301CdjKQz/GRrvMWrXyAO2AWTlU2sKGufntROmTHa0MzP6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734178; c=relaxed/simple;
	bh=LX0cx3yS9A3lf5/ltW1wOr3VX7TrvCBYs2TjaVVCOuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0Woi+lXkbm/D/idBY7oda09ORlKG/60upbfetGbpvCDkD2KXGeLvO+cTpNLarW0VTNL6vDJfnoigsNnDFlwbq83z0pdQjaMgw9P+GfnYUca6qr49f84xMfJhqTWFXzKtbl/rDwfUjaMXbB5cr3GdU9uLL/aG0WxpTDvIyCQ/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hYx6kM1m; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760734172; x=1761338972; i=quwenruo.btrfs@gmx.com;
	bh=LX0cx3yS9A3lf5/ltW1wOr3VX7TrvCBYs2TjaVVCOuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hYx6kM1maEp6bDkbZbwafWYaWbmVwpMZZUL3eP4IKFvatnMGTtnZMfU4wYQSfClw
	 fS3DACCqclGpEWMJWo8eIMmDS3rtfXxmVcE+ZpYZYRRz+q6Se8Uwnby/zLUkx3aA6
	 bNvq4sVbxz8fmueRwhYCDJQp2UgL1oDBzYx30n43cVPeOm7gZ7QXQxZYNJsJdYgwH
	 s3jrNf5Kwh753s/F5CGQ1iDHXGIo93QbCUwLJhh1OS5QYaF91O5uwAMZDcMFJDBdt
	 gtVFUDC9/1AhyjFMt8sPRNlcWOGOPOs9TokmKKQidydRXdsHrZhcCDLUP5CxoIYo5
	 T+m7OTNiEGIgAkagiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1v5keQ3UZt-00Cn1o; Fri, 17
 Oct 2025 22:49:32 +0200
Message-ID: <8b0b03ca-781a-467b-b6b2-fa613e730cad@gmx.com>
Date: Sat, 18 Oct 2025 07:19:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
 <20251016164224.GH13776@twin.jikos.cz>
 <c66eae15-2651-405c-a024-05a31e836fc5@gmx.com>
 <7a20d7da-d536-459c-be04-b530d8d1ef98@gmx.com>
 <20251017170045.GN13776@twin.jikos.cz>
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
In-Reply-To: <20251017170045.GN13776@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B/vBIvy6TaEXLPc2XAraWzdwT4bpFn/ztsmDxPwBA9SmnpK36oP
 YP9sNErJGOZE1ay/xusRIRKMzVu9LaJEwLhMVwHYtbv3Qk0zC57xGhvFITvWyskYRU4sCsW
 tbmOgAOUEXFxBrpFHp0z78KLL76/tx0/P1Ukfo/vhn0VhfWpAQf6Xw7le+0Nn9NZIHliKC+
 lugWPZb6jdMxansxTwtMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zo/JmSHkq48=;KoaToZGqRvZzSY85XLbVhd42+Vf
 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
 UlT3G7q3FqEifKLjVdqDLX2SsloHGv0c6zo=



=E5=9C=A8 2025/10/18 03:30, David Sterba =E5=86=99=E9=81=93:
> On Fri, Oct 17, 2025 at 06:24:33PM +1030, Qu Wenruo wrote:
>> =E5=9C=A8 2025/10/17 07:05, Qu Wenruo =E5=86=99=E9=81=93:
[...]
>>>
>>> As I explained, pm requires all user space processes to return to user
>>> space.
>>>
>>> That's why your RFC patch doesn't pass Askar Safin's test at all, no
>>> matter if the pm is configured to freeze the fs or not.
>>
>> If you really want to a resumable scrub/dev-replace between pm
>> operations, it's possible but not in the current scrub/replace ioctl.
>=20
> Cancelling scrub is not that bad and it also keeps the last status
> (assuming we can store it during suspend phase). I'd be more worried
> about replace, I'm not sure if it's restartable from the last recorded
> point or not.

Dev-replace is unfortunately non-restartable.

After interruption, the new device will be removed from the fs, thus=20
there is no way that it can be resumed.

On the other hand, if user really want to finish the dev-replace, we may=
=20
want to add some optional support to use things like systemd-inhibit.

(I don't want to include the full systemd dependency, thus at most some=20
system() calls to systemd-inhibit directly)

But for systemd services files provided from btrfs maintenance package,=20
you may want to add different versions so that end users can determine=20
if they want to priority pm or scrub/replace.
>>
>> For now, my series addresses the more user impacting problem (long time
>> out and all other processes frozen, just acting like the system is
>> hanging), and I'll add extra notes to scrub/dev-replace about the
>> behavior change.
>=20
> On one side I agree that allowing the suspend continue at the cost of
> cancelled scrub is an improvement. And we can eventually improve that.
> The concerns about cancelling the operations are usability and
> documenting the behaviour won't be enough, so at lest a message to log
> would be good so there's a trace.

There is already one, every ended scrub (no matter finished properly or=20
interrupted) will show a message line indicating the reason.

> I don't know if we can catch the
> reason,

I can improve the return value so that when pm interrupted the=20
scrub/replace, we return -EAGAIN/-EINTR other than -ECANCELED.

However I'm not sure how to distinguish pm interruption and signals.

Should they all return -EINTR? Or should the pm ones return differently?


Either way, I'll also try to add some optional inhibit options to=20
btrfs-progs, so at least users can determine what policy they want.

Thanks,
Qu

> ideally when it would be caused by suspend/freezing then print
> something informative and suggest restarting it.



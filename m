Return-Path: <linux-btrfs+bounces-11755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA2A43968
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865053A6E3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FC242913;
	Tue, 25 Feb 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ezUUzWHc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F94C80
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475345; cv=none; b=pzUu5s3gn4KsgycRzRIjKxu1QUfhMvkHViIp15r253ZeAZKQyLspbpXwazubllhhDufactW7DAYbcmRB8UxByCA9AbPJGo7+85t0REGsZh4XCFCMi4ZPeic/xXdUJV9PXOZG6Wo2LTrgjWXq0nRfuLqnJfQJxinP7ZCSg0ZArCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475345; c=relaxed/simple;
	bh=5k4c3Iz6/yUA/TUVStkhtxDpFHaES9aYuj7NzqOIZK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS/th8p98QRm73wBrd71ITK7DfXpB3+uwN5rCRAU6RAz2mKDyyxETnR5770TrbtrhueDVZnTh0ZJEHFZYbZRTRI1lFAmjmNyMFV/cuCiIkzVbxn7ilBEh5xVktlU6f4L63pZ+W/qjwLKKJ2Sce8jtLHqDhwA1AlB8wurtTjJWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ezUUzWHc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740475337; x=1741080137; i=quwenruo.btrfs@gmx.com;
	bh=L7b2tN33CraAV8uSIkq2QuX7O+YtWnHZsYu7nVvjrv0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ezUUzWHc3KQiibs2e2XWi3mErDosdcvfHK3C2vkIAND37eHJdZiuTyRxBQRUlxlU
	 zkkViElMSVhgNB82zipHhTpbTUno3qMlNDYhprnZjHPpn1W24QfVYXAC19Ww1/NWC
	 dYtTn9Hujo91Yi+K3J2rJ7kQizCRdiGWJ8g4ov+9hbkN0Te1Y+PUnbX5Hak2+9s7X
	 8had34V1ck/8DTCw2+vYzHcWohWc5qckKdTum8yqOUGOh7o5NTShLkfKWOBKs4H4m
	 VYnVg+TTBnuQq18BMVghOgm8UpylyVa3A2DNm71naUSRWrdQ73seUYuj5P1+uCSwn
	 izgR/WEcceyk8yXdSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mi2Jn-1t8rUn3rqz-00cMOS; Tue, 25
 Feb 2025 10:22:17 +0100
Message-ID: <d7f97a38-43eb-48ea-9a21-b6a90e8c613f@gmx.com>
Date: Tue, 25 Feb 2025 19:52:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
To: Marc MERLIN <marc@merlins.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Chris Murphy <lists@colorremedies.com>,
 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, Roman Mamedov
 <rm@romanrm.net>, Su Yue <suy.fnst@cn.fujitsu.com>
References: <Z6TsUwR7tyKJrZ7w@merlins.org> <Z71yICVikAzKxisq@merlins.org>
 <018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com> <Z71_TednCt9KzR45@merlins.org>
 <d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
 <Z72LAZDq8IegQoua@merlins.org>
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
In-Reply-To: <Z72LAZDq8IegQoua@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3T1F1Z0CSwAL9uhaTXt/EEMAx4ffnBngKtPem2t0ZcDokyK9sIa
 k7K3S3nejJi53hiaBmw10bQtgYH8cIPRswn9WObKIxlpii4mvzNoXfUGzu4hOWW+v/pxFf1
 WJWMFE+dClB0P/4p0Fqy26I7lXxwu4qzzQnegC3l9VW/zMTSLNyy4opdVJVADaasXIK+mnD
 Des7p8iD3g9rmGCs6Db9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l6oEnqZSxfU=;yqqg/YjCkGKDqjBnPwMW/Hf04GS
 iJkT+E9/8D5+oFImeVz0VRZHdDkvTbXrBBTVhqzE0nNnUQ5VH7xJ68G+eE6edHXrdFtFuELdR
 YKYLNlBir2aOMRZYRMwdwUGR6fpKoYh0hxdTUoeuKFyrOQ9C7LGkyFEi26jmxIdvrMHAT68FL
 wjEF4PaVXOslGt3sMBqHXvg0yjBkYFp882AbaC+K0MPvCL7OHYCvmTK2F64CgGq3ERzTHcTJS
 NEzykVPJf9R+T9iku3dWMFqWHoxMzwYozh39MMGDmRGcEc6hPUDELk5NvegkJ5Rsh7TBE4Sgv
 BNbfKYLWe5R2lEupBi9CgOAP4oiE2Da9AgQpVwPC2glYFuc8cpkgHODm4wG7Zxaz7EKhffi1k
 7J4OkDunNbnUVNp3il8+2cdCwYBFSdIAwfTR4EdISPlLZR4LXpmBal9cGDvG6j7/XuuJo1+Rk
 9gmYvYS0rhpvaApdQS3obdy+eDuqPrdFjBgNkynSpfpwtF2cOZFrovzrNiz+mDsPxAqERacgb
 FoGppErRW11+zE7qlJndXJLZKlefxQ0Afd5Aa7S9bgGAjSMTTuSTzF9ne4nwKQQ3VoG9U73Cu
 e+0yLXnqk9TH1CPiNGpaX+gj5AzcOfAxOjyjxX7fKtDeo/lhKG1QHgSkb9QMAD8HcLyeIp6uS
 A/yZ5muZYbpuUj8Von5x1l/He5f6U56ghL4IElF8l5tzBuEVH7yLbdFseUPVN145twuvk+xCt
 f2saHjI2Sh6uq8LV+1wssjNsuXzX6mPuox5p08NtB0esJOqdyJtN6tH5Tmh51mqL+tz09EADU
 VkNvvZCCo7I/GE7nH58vr3saF33vdGEQKp8CWwbYusBjkoBeT3uScNFt3dXYwbv/rRl98PTYi
 6cX7FTrhu8j6EkOFdRfb6Gk7yy8D4UUMhkxuWQrmZutVSrRCN+ifSII8Uw8r8oRMSFAfBQYjv
 BdhjyJeCBvszBWpAIauUfqmFYrhVRy6kHaHYQnMcDtHTNN84z0rphuB5tP1wJh2LyWulvoTta
 JQ9cNrF46HpvbZr36Ih3x+l6002Q3wRVWU4OGF9T9tPMxkkfUoXcBjvqtXbFRJ+P2RtBE5UWx
 XKr0G2J5Z27CNP7ikHLk1qMtWPPpakKmT7c3AGGsrZbTd/+zLHu/G82yq7j8RN+v5zMv1cF0L
 i6OW1+ukhdOG3LsrypnOtOi5pmCJy8/RhTBZitFCJU9UNeHQZUJCnr92ky4iTtJpsiwK7W0jD
 GFF99mXFPmOCMmmP7mVUb2oOv7ROqZK95uggJn+TOIl3tYPB1410y9jpRHgExHXUdGyQQ1BMh
 aqFN7rc9ta2yP2aq4T3Hulll9m9Sk7evFu7nTUggkMla5v/cq0PhZTZeNn00J4XiptH+oJY1V
 +ZX2T/W9mVZsENFUY3qFp9UUWMXrPD9C1zwyeXyIbx+jkzyzfn7FaYJ2Pb



=E5=9C=A8 2025/2/25 19:48, Marc MERLIN =E5=86=99=E9=81=93:
> On Tue, Feb 25, 2025 at 07:16:31PM +1030, Qu Wenruo wrote:
>> Ref#13 is the root that mentioned has the existing one.
>>
>> I have no idea why it shows up like this.
>>
>> But since the fs passes btrfs check, mind to dump the following tree bl=
ock?
>>
>> # btrfs ins dump-tree -t extent <device> | grep "(350223581184 " -A 50
>>
>> I want to make sure if the ref 398 exists on disk, or it's generated at
>> runtime.
>
> sauron:~# btrfs ins dump-tree -t extent /dev/mapper/pool1 | grep "350223=
581184 " -A 50
> sauron:~#
>
> Mmmmh, so 350223581184 is gone now since it's been 20 days already since
> my original post.
> I can try to re-enable balance and see if things crash or not.
>
>> I believe your machine is a ThinkPad P17 gen2 with a mobile Xeon, with =
DDR4
>> ECC memory support, but I'm not sure if your memory sticks have ECC.
>
> model name      : Intel(R) Xeon(R) W-11855M CPU @ 3.20GHz
> sauron:~# dmesg | grep -i EDAC
> [    1.293722] EDAC MC: Ver: 3.0.0
> sauron:~# dmidecode -t memory | grep Width
>          Total Width: 64 bits
>          Data Width: 64 bits
>          Total Width: 64 bits
>          Data Width: 64 bits
>          Total Width: 64 bits
>          Data Width: 64 bits
>          Total Width: 64 bits
>          Data Width: 64 bits
>
> That seems do say I do not have ECC or width would be 72 from what I
> read :-/
>
>> Just as a precaution, please run a memtest (I know it will be painfully
>> slow, so please only run it after the above dump is taken).
>
> I do not have the system with me right now and I think memtest cannot be
> run from inside linux, correct?
> If so, I can do this when I get home and can reboot the system.
>
> Or is there a version I can run from inside linux?

Memtester can do that, but it always leaves some small memory left unteste=
d.

But that should still be better than nothing.

Thanks,
Qu
>
> Marc



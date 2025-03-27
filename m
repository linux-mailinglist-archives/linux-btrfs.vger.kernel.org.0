Return-Path: <linux-btrfs+bounces-12627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D467A73F7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 21:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB43BCE35
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987CB1C84AE;
	Thu, 27 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ltOR+tXe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB717A2F5
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108467; cv=none; b=Mh/JPIyYGi3SopGBGpPU4y5CTYSO57piACmECyeGWHXkJxCiV8QVUWLX4UtomtvYQ2/boee6qUK22nvwJv8o/R85LlCf7M2zdsb+Ed0S3RpPd21Uj/m30kX4xkxv4fV4AUm6K4MAKiXcE5+7x27PyZsO4IDYMCmuT40Fc1StWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108467; c=relaxed/simple;
	bh=aEgctEAP5Qw+p1u3wXAGZ1l2o0GwwfGQUfEh7zoBTCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyl3WUMtmutfZHxeqj1xmE54HkFZTWrZSGy4QAb5WImfiKwr1UE5w3M2mQY8jDXhk8TMQIaiD2d+HFkL58Sxz9lTZ8KCzszSetHv81xh+fV9uP7hnSk1lKd1Il0pKYYSG9fO+hqvGdmwxck+/KBGH+xT6WedIplrGjWD/btwi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ltOR+tXe; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743108463; x=1743713263; i=quwenruo.btrfs@gmx.com;
	bh=mJ0rJad29A1Mp5ut+ngBGh2kv6Bk9j+fAdZZLa/bXSw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ltOR+tXe3WujkxPsE07wvlxtuIlfAlHY95SVMf/WW3HZVcjawhpCOuw4q5MbK2jW
	 JruUs6oEeXTZVx8mGMDjktymvkEgGoveiH6ZQVhy/VE7MNuFkU4ks51ydHF6mn3ol
	 4+wI1+wZEB8c8kKqwoYn/XcY6Suul/vo2HG7cmzMp3AfOgdQ3XepxZqSgt1hP+VLc
	 ZiZjajJyFP8WoGNaFqd6t27NC9bcJjDQ9fJyU86WYzO3dQ/LyFhdvnQv3xofX7E+t
	 5jYKQpaKF+6cIgEBEMGYu8853RaJF+UmjddiGwuYkx/DwPAu70VBGJKF2xXNYBPA5
	 gOLqkPn8mdFf7rZ0Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sDq-1u2q5c3aVO-0014OY; Thu, 27
 Mar 2025 21:47:43 +0100
Message-ID: <0ca94ef9-7626-48e5-8417-0c1efa4d6832@gmx.com>
Date: Fri, 28 Mar 2025 07:17:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: refactor btrfs_buffered_write() for the
 incoming large data folios
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1742443383.git.wqu@suse.com>
 <20250327164713.GV32661@twin.jikos.cz>
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
In-Reply-To: <20250327164713.GV32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsZwlOT3VcrOjMdUAIqFo1KE2MDonBahNFS07/o5MV6CUzkjLQ8
 olrLClHJcKsrOEYwohtNEdHxq99oq+DM6jVFAVh7VUFiR+L3OPK4Ymhs+6Vzizc8yN0mbX3
 UdHPRcNBFsTWlJJmug/MVRy0BpYTfpIQ7XWCyBVRO2az4bclv20xhacdWiXEGATaE3qNOxQ
 UGBnSWyK3s074gasP+ImQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aY6zRSpJexg=;X2j1LYdkUHQCZLoT6SJftoazGaA
 4xYcxEJWOuaDKLOZSvkP8KmXky51icZOu13EU6NoHWcbTvtPuNd1lAaQjAOoijsKOTb7tcX8H
 TXiuid8eqv/Z5rl6eBTAtU5isL9WMBQQPbIpRBfqVtStXcJxP0WyKUay3m+qxIWzv/5KP200z
 sryuAMC7JT6ylfOTc5nfXHINehGTrnBzE5+oyUK0gXVuOn+e/CGZXQThlSnL5b1vHaTOZ/p46
 bSLiGcF/fXxG9QTcvsxJb/uNAv3Y6As1EC/bk00S+tPljCGFNw6tcz0/FeH9In17voYXBri9J
 5nRUNYpIJVGFgJj+JdYm2j6Vw1xcUXU1HsIig84w7UaQmf+6qcZQfHl5BZRIt3zi9PgEP/ick
 9qjW043UcsAtH0lBrxuHxA69F82GojAVdYvsHdlmnymFZ1tD1Btu5LSLV0UrB9I079ofcMDK5
 zWdXQyow0LPTi7+xEVpQskFAdx4cp3nT/yAITLt7IteUqaIMYkMYxd/OJoH9hrK9u1673By0Y
 U7R6E7xJmbIWX7JMgav2gQitEzFRK+cwSerw4mT11d+OSObnLkvX6gU63ALSifQ1g0wC9bzZ+
 tNldJwxLPpdIUuCevv8CuP+/ZfRWySh0hyv8uI0Dw26qpZfo0fao7mZD+EMRhowXWGklZ9UXK
 UfXeVVYqx9NdXVWWJ5jq6bhtQN0/30kf0LYAwidSPAVxDW4he/i/SjVlKdh5pOMXPKtxw6Me0
 +q1pI7wfdrDppITWJSav2b3Ez1aLKTaBo298xEHgDiE8OLL2Uww5Q7e2WbcPvs/jjbEzfG4TP
 B9b6/wnhkYpeVBrDmD0VTKVo8gN3JtK/K4ng6PoEXvw1WMJ1onngipbm74nCGtu+blQFUOE1D
 06BiX2LBqpFwiXMPCfRDEcYyv5lVrBvzyGTt7SJSZse1alhqaY95n2uxQJFnwlW7+bVNsZn5C
 8IZMWHodsPXUNw0M5taxP84lV0PKqvMJcFMXfNjMQHGk8aZQdPo7O+L2KAjsKypH3kTJ9s8YC
 Ggoud75xk4kuUGI+Kz1gennt3GjRhd/7yyXCq6kRLjXd6ofZ4BipK8M7UvUbRxUtjK+41cx57
 n7/9OvfQH/+IFRhHDrJaRhRQGLrrMtFYXRaCnaWYzUD3Q5RiV9wlhUM/YHb2x1dnrZ6BeHJo0
 1e0p1K3LUpjYype4FTh/vixO1d7hFXomYmsELq3Y2il92VtQ83VUCQgbaHc2klXu6RQt6fc0O
 PBGlFpoEYqpvP92g48B7v4hsUQ1pl22rVqV3DKaq/8wCgAAQjMlShrqhHZDr1xH8itxow6/D8
 7s1dHzOizw2/lGefZbCeYzzt/x8cdq3MnAZZbGQW8dBkBbsa4heQkV5dd1fHe3f8rXI2hEnQs
 tpv+ThTBYWOdUAkrzgL8nqB4gzr29O7aSCZq4YTP+RInoHZuw46VypDHqJT13Zr8ldLRDzaav
 BOg42Jx0bgkG7pkY1YahmFdS1U84=



=E5=9C=A8 2025/3/28 03:17, David Sterba =E5=86=99=E9=81=93:
> On Thu, Mar 20, 2025 at 04:04:07PM +1030, Qu Wenruo wrote:
>> The function btrfs_buffered_write() is implementing all the complex
>> heavy-lifting work inside a huge while () loop, which makes later large
>> data folios work much harder.
>>
>> The first patch is a patch that already submitted to the mailing list
>> recently, but all later reworks depends on that patch, thus it is
>> included in the series.
>>
>> The core of the whole series is to introduce a helper function,
>> copy_one_range() to do the buffer copy into one single folio.
>>
>> Patch 2 is a preparation that moves the error cleanup into the main loo=
p,
>> so we do not have dedicated out-of-loop cleanup.
>>
>> Patch 3 is another preparation that extract the space reservation code
>> into a helper, make the final refactor patch a little more smaller.
>>
>> And patch 4 is the main dish, with all the refactoring happening inside
>> it.
>>
>> Qu Wenruo (4):
>>    btrfs: remove force_page_uptodate variable from btrfs_buffered_write=
()
>>    btrfs: cleanup the reserved space inside the loop of
>>      btrfs_buffered_write()
>>    btrfs: extract the space reservation code from btrfs_buffered_write(=
)
>>    btrfs: extract the main loop of btrfs_buffered_write() into a helper
>
> I'm looking at the committed patches in for-next and there are still too
> many whitespace and formatting issues, atop those pointed out in the
> mail discussion. It's probably because the code moved and inherited the
> formatting but this is one of the oportunities to fix it in the final
> version.
>
> I fixed what I saw, but plase try to reformat the code according to the
> best pratices. No big deal if something slips, I'd rather you focus on
> the code than on formattig but in this patchset it looked like a
> systematic error.
>
> In case of factoring out code and moving it around I suggest to do it in
> two steps, first move the code, make sure it's correct etc, commit, and
> then open the changed code in editor in diff mode. If you're using
> fugitive.vim the command ":Gdiff HEAD^" clearly shows the changed code
> and doing the styling and formatting pass is quite easy.
>
This is a little weird, IIRC the workflow hooks should detect those
whitespace errors at commit time, e.g:

$ git commit  -a --amend
ERROR:TRAILING_WHITESPACE: trailing whitespace
#9: FILE: fs/btrfs/file.c:2207:
+^I$

total: 1 errors, 0 warnings, 7 lines checked
Checkpatch found errors, would you like to fix them up? (Yn)

But it was never triggered at any of the code move.

I know I missed a lot of style changes when moving the code, but I
didn't expect any whitespace errors.

Mind to provide some examples where the git hooks didn't catch them?

Thanks,
Qu


Return-Path: <linux-btrfs+bounces-5149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE68CAA64
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E437280FC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F45356757;
	Tue, 21 May 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Gu+taHP5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57254917
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281728; cv=none; b=T0NlrpchBCPfXXrthbD/HFBlJhuM9hImWwnwroP3P7jCYmm4J94VRnMJrwUentiiytpgzFyMLJs/2RMAhlxDslgKi3oTC+zdmUMnYGbnyGTW3gCs65fqcTPPqATMIcsPhYSxdxgH6z1D+EqiKzudMprR5esU9q+LwDYqgW6i+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281728; c=relaxed/simple;
	bh=9xhm+Sy8WwGTi8NfCHmoXxSOxCqzYzgpjEWHiu5RdAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hAaRXZR8vWY7Rm4YY2czVI0KjlMLR6aLKCtZpVsFuyH4eFCfXShNay02Oz2/OFFswXTIPIYTMOr+M4xz2oW6+xWM6q+qpHvKCl7EljWABd9unGKr8CNVEh1JRBRsuW09IMQeO/9Jdy6kXhr8ShrGAVrnGPfeQODxfifeEx1cMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Gu+taHP5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716281721; x=1716886521; i=quwenruo.btrfs@gmx.com;
	bh=9xhm+Sy8WwGTi8NfCHmoXxSOxCqzYzgpjEWHiu5RdAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gu+taHP5h8CDbb5RYsKXo1pqSMAeKqVM+TBhHY+T6nGYdxuf53leVxukLjSS2IAr
	 1EueOSCtFDXI0C3g909SBWW8aUXD6nRC1KBKIwOL8aKJoNziNMQz4D9YSQa1z+Ra8
	 w1g5LmmkXZmR7bQ52z3LrsKQB6AcJCV+YV1xY60qPtBsVYAhld2JpnTOwwJSE+Co/
	 4oyAN6Sr8qckdivNOGM0RFejqNrrioejrq9eUFx4LIYFjXdRq8Gb8f4utAxGtzeXk
	 PsvjV3Z239yG06eLAzrIy6TlJ8xdj+J0fHllr8xx7HaKXIQJUI40ioJxn9DS0PEPu
	 UPdfhccgD+hfBzNLQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UUy-1s9tVb0B7a-003xDV; Tue, 21
 May 2024 10:55:21 +0200
Message-ID: <3c492c05-bab3-46be-861b-f658d6c6a095@gmx.com>
Date: Tue, 21 May 2024 18:25:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: please undo removal of "norecovery" (userspace breakage)
To: Lennart Poettering <lennart@poettering.net>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
References: <ZkxZT0J-z0GYvfy8@gardel-login>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZkxZT0J-z0GYvfy8@gardel-login>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4gXQR3vHEBsqNlBAOhPrjGMyATrBDyHARFtxLXCjCWdplMN/KSA
 J7Lzq7gylowGT2uRrtlqgCe+luGuh5mfjYmBlNSSmss1uQs7AjvlLCSIFFyBg76OACavRZO
 KsNab1pKapDvy+i+NAYS0Qp6J4kC7GU7d9tUWSxNg4qiX3+VdljV6OpjVlpYOVghCoo3mfd
 St/KSIJ09dlLz7ZowpENA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zMsnY1ETfGE=;OXzS6vMu5pGeMoTgFdsX3pYislC
 5nlaPEASl8Ll7lkYg2AXzv+vCussQ8dw0g9v8+37xl0vXm2dKp+L0ig25UeRtfpRYmvZSePzj
 uLfZGe2v6gZbf3J40QRjWZAJeIdAMfkICm1OISGX3WEqopMnj+QIa/8XyCyBNZEsMBNVCZg+k
 XTxuv2ir5BzNhyJDRvZVteoMirZDBEuPJij4laBOl0HTWU9yRQSm14dLqTGgGMzUoyV0kLUMI
 Ils5wnWii7+zV7w9rbJp1qtGi6NKqsUUxwWcLXBcJzXjeyWKaSt3Plp+dBwvLJr3nGJbE3W8+
 UXN40bIA9MNC8+qu6A3p2UuOfTY3l/sHOoQRrvK3YE/Tuw0cSnFGJZ/5sNjt6UwqW9ciZBCbh
 IS6miqcxmohfA9Ahhh08jguoF5G3sn0fAFtRkJ7EEpqVjh5yIpU+G34ieOptlMScs9MrwlOgz
 BtB4m8pfpCpX7KAPmQAu2RxKcTUL4KIfe82f0kB6H1wxGOVtuoUCZ2tvi03BYlkNURiq+vau2
 9GFYgN8xpKgxbtY9l3r00OtcO4wbJ6CHisEDE6WwMqGfx2dbZbQopQbXGc0lp3/9MpuCQ4KEo
 r96JosltRqK5DKbgDp+6WW+kzOjz0Zc5zFWJyNYeSsOqa4prs6pyawCrxgpBlnWvDYIQePu+K
 hW2inJCdg9Wl6rt3VzmLKL8bmywUEli+4+oC4Q8dwCyH7R87yUCwPhMlvGPs9lXVjsTSBYb44
 NEt4a92WssLiyALoXMmqpx5QsR3/RYNO4ka1KSgyXDhUwQ8R0gHNt4p77ojGBoC4cWLNAWDq1
 GbHf1JP9LH5ODcKCWN6VLes7Np6NdCE9dZsqDIUfpNjlk=



=E5=9C=A8 2024/5/21 17:50, Lennart Poettering =E5=86=99=E9=81=93:
[...]
>
> It's fine to hide stuff in docs and so on you think is redundant, but
> if you take the kernel developers mantra of "we never break userspace"
> seriously, you should still keep the option around to be parsed,
> because this *did* break userspace, quite massively. And there's so
> little effort necessary to keep compat here, just treat "norecovery"
> as an alias "rescue=3Dnologreplay".

OK, I would add such alias back as a regression fix soon. (hopefully can
be merged in this release circle)

At the time of the deprecation, I didn't even notice other fses also
support the same "norecovery" option.

The original problem of "norecovery" is that it doesn't follow the
regular "no*" mount option which always has a corresponding enabling one.
E.g. btrfs has "datacow" and "nodatacow" mount options, so are
"datasum"/"nodatasum", "datacow"/"nodatacow", "ssd"/"nossd",
"acl"/"noacl", "barrier"/"nobarrier".

(The last 2 pairs are not even btrfs specific).

Furthermore the name "recovery" is not really clear what it is doing,
log replay is hardly a "recover" procedure.

But as you said, no matter how unreasonable the original mount option
is, if there are users relying on it and it is consistent among other
major filesystems, we should just follow it then.

Thanks,
Qu

>
> Thank you,
>
> Lennart
>


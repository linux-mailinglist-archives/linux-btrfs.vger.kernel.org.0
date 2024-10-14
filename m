Return-Path: <linux-btrfs+bounces-8917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07199D8A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE51FB21E8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FF1D1F50;
	Mon, 14 Oct 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Aw2FQ38h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5731D14FF
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939331; cv=none; b=HZP4R2L4At/hWxb5G7A7U7EoE5n0y7cD8sgW+BkitO3EDeyOUf/xQCjHZ1dpfJ5Cd8o5A30s2VVwNSEWxJOf/IqHpyj6TIMWeg+95lqTjIfCpp1Z6z99De0uT5sf+jDab0srmKgzKHHWRO2B+13a8VKmp+FzWHlFRQBsv66Kj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939331; c=relaxed/simple;
	bh=MRZ/lwdOkyFYwi/B5mLsf0Cyyxoy4bjwuK5H4J9aU3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roxzKTuQNYRpsgzQw3T03aPGH29GMNHtDFiZp9dmh68l6LjSCuC5Bq5UuL9ZanWJMwqZoKovuhuZ7KTi9Vye94oDNVr51tHMSy1qFNeJHX3KTA+iueUdhdAkF+9czcX+lN3G2jfRkkdLTpQvmjAJQkL13Jp/aDTko79vLtwPH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Aw2FQ38h; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728939326; x=1729544126; i=quwenruo.btrfs@gmx.com;
	bh=EMkWzYGWlFefuO2NQniTq+fP+lOu6bDdmWqpOGPoZGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Aw2FQ38h+iLRNih0QUBCG3KVABzorGVhN8U9h7GUXPa9AadSyfWmDDTSaW15Z1ks
	 tLOU1Ep3LsOYo3Kyc6v8f9sACrpLJIxmLUN+V2Krq/H6545LzsEBzeEzIUK0DcCrS
	 RG8dukpXDr28bjrHl/qZwthT6iii3M5OMGuTY4/5LWt9hczttKjEinQmANXc58lwf
	 HGvZQEhaVMsAHplVPKIfYT0WWMl74wOp0GrXw5B/QPjUyOeUyxZzIfeKf4G8PL7D8
	 1DSlXLqAToTPEpbHLGIIqATFMG4yGGJuLuWZHwEmKUwWLRuBnlUlUUFBQI+GLP3BB
	 +xEG3RhFUK+dOt1SVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fn0-1txp6T3g5Y-016pbw; Mon, 14
 Oct 2024 22:55:26 +0200
Message-ID: <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
Date: Tue, 15 Oct 2024 07:25:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
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
In-Reply-To: <20241014141622.GB1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGZnfsaEn4xj0Vwwip/V8y0V655JkuxJZa1wx3iYkxYQPTyIG1V
 tuPgnBdQgdiKYxJc3Uxu500xsnVePLXi0KGkudV6S8v6NM76sygcozH2YJixj9qqFmfmhad
 w6O/j2sKV1ABxC5J3Pn+z7bF6/Nd4KmSt9Hq48ih4tKyc/acPHsrpTxsuLczkNBBgn/s12H
 DNjUG2a8YFvm5XcjxXkyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KwamqVL6U4I=;9qF5acN3q68dAoYijM8iMq4rNSM
 L7EytFo7FhMOiplGsI51ZutrO/gR2D0+VdggPihTkbLtW8+kWa2CTXBF3HCcxQ3NkYkRewR8m
 nmdsCdfn2dMYjWQz++2iam4RbBJI1zUJai/4OGUyWYYujzW2N/hLBEzCPJs6hO/JB+4siVvl/
 JeueB8U99biYX8cBit7fFCREI5mylD3NuDxKiJ5+AYzVLiGBur4gvaL8R5Ju6Gptk12w3qXBT
 J5oQJ/9nVtG4OUlIHmEGQ2CztYbwG4AvrD4ndJbE7bPMqS9nPA1kAuWwNeR3oz1cDnLRyG9P/
 o+aftz4lfvK6PjQ6hnvO2xkGf8T+g0v6rRRiVhGmsGRDHNurkbOGL9w+X9HAu3Kf3k1OXwZn1
 lEILGxkLXRTxOmGQKI1R3M/oqnrDlbUZETkYCHOgdi/IbNd4gIbX393AjPuoCmpbM/0APWjzG
 TG2gGJZzjzg2w2d5FI+mcnm3C/RPN/gMY6YXoLFWWtv2/nbOhLBFCjxzGSALn8SBWns3w7rzk
 THZncW949R3Po/ysVz21MZ9lY7uLMEWj5QRx14tICZ9VNHaqQLSpwtRJS46mhPontqdfyDnZN
 9UNheXIbvPQIEAxmblrYSQaGkdRsuJyG51nkUTWwoCI8QUwpgSFMJtev2CdScdkHP4GWfU1Ke
 UeSDcVWQaqnsBFnSASGaJcKEuTscZ1MJQRm3527wbZTOFjXvVPubF2IkFA923atitYhwJrsjF
 S14SjRZG1q10WZPXmXNLrX+4AlzkYfgqZrtPb+fK1yhDoXHstCQG7+7Ckr9Qe2TvOWRYBgVpQ
 w05gP+DcNDVf0g9FnPy0qInaF3F/w04rfVHbRZB2Krc/k=



=E5=9C=A8 2024/10/15 00:46, David Sterba =E5=86=99=E9=81=93:
> On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
>> __filemap_get_folio() provides the flag FGP_STABLE to wait for
>> writeback.
>>
>> There are two call sites doing __filemap_get_folio() then
>> folio_wait_writeback():
>>
>> - btrfs_truncate_block()
>> - defrag_prepare_one_folio()
>>
>> We can directly utilize that flag instead of manually calling
>> folio_wait_writeback().
>
> We can do that but I'm missing a justification for that. The explicit
> writeback calls are done at a different points than what FGP_STABLE
> does. So what's the difference?
>

TL;DR, it's not safe to read folio before waiting for writeback in theory.

There is a possible race, mostly related to my previous attempt of
subpage partial uptodate support:

              Thread A          |           Thread B
=2D------------------------------+-----------------------------
extent_writepage_io()          |
|- submit_one_sector()         |
   |- folio_set_writeback()     |
      The folio is partial dirty|
      and uninvolved sectors are|
      not uptodate              |
                                | btrfs_truncate_block()
                                | |- btrfs_do_readpage()
                                |   |- submit_one_folio
                                |      This will read all sectors
                                |      from disk, but that writeback
                                |      sector is not yet finished

In this case, we can read out garbage from disk, since the write is not
yet finished.

This is not yet possible, because we always read out the whole page so
in that case thread B won't trigger a read.


But this already shows the way we wait for writeback is not safe.
And that's why no other filesystems manually wait for writeback after
reading the folio.

Thus I think doing FGP_STABLE is way more safer, and that's why all
other fses are doing this way instead.

Thanks,
Qu


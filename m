Return-Path: <linux-btrfs+bounces-7651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7D9633FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ACF1F22E72
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF501AD40F;
	Wed, 28 Aug 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RW2YVbX2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316561AB512;
	Wed, 28 Aug 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881001; cv=none; b=VPzFnZC83l4Y2MhQuWbvDPO8Z8Ms4Z1r46cq9rt69LW126wS8hr4T4cPZ5z0z1+s2GRNXoNuJ+SnkPWJC9qzLDq5IngpPzW1BPsiblsfrXV5vig6lmOYEl2u+ZWtSTPG3Vqv81LTKLP/WQ/0aky4BB4z6JNCy7Fesiu14oCYMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881001; c=relaxed/simple;
	bh=unCkoQWs3+D0Rb9hgPLFucvkm0aa+cAXsWLZY4fRCDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1YV5+1BqDZRY2ZfuIqdnV3HsSpbOXM92/Ekuu0hv+sW9cljlZZbKmqcziZcPbJF4JD2zrAaXPsc2XwgmAg5Zi63HYs2qZivgFDU+TsjxPnKs0kmBfu3BET9FYZk1opo3xReQO3bGckGMkMITj38XYmFptzNXcChaj1dmwQuKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RW2YVbX2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724880972; x=1725485772; i=quwenruo.btrfs@gmx.com;
	bh=7EWVk8UYp3QZZ7++Et/aCkLzlQMXcHopk6h7LDs8iYc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RW2YVbX2M3vtIVxznKZbm/uI9A6S8J1vaum3rsGUcmpPEZsJ7vNO1AtXBEDCyjUu
	 Tld4DFIkYRQeDX2LsImWr9O6v2+tbfKXAM2t+dox4K7ScwiDpscHh5DSy/kPDQMAx
	 rLyzRZJpmn3+06swmmVQ68Q+rzSbtJs5yOaLmLW0FkjoijkQjhR4CNuNJ4VOfhEzM
	 jGjBd5I08wbMPdrJ3CkSwxsLWTtTGq7TCG/Lbe5tHENLFhwMerd49hZZpDs8QPOY9
	 fcpA+PpItdbe2OBpQF0BVAWkrWGAkaX+FajQuUgUgEK0Z4Z/ZwKOrUkDVz2OVZbDi
	 lDjBeG/zyC1I7VcPyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1sINKA0IHy-00qi1U; Wed, 28
 Aug 2024 23:36:12 +0200
Message-ID: <1a972f83-d583-466d-9fc4-d96baf2e057c@gmx.com>
Date: Thu, 29 Aug 2024 07:06:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: don't use extent changeset when not
 needed
To: Fedor Pchelkin <pchelkin@ispras.ru>, David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20240828161411.534042-1-pchelkin@ispras.ru>
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
In-Reply-To: <20240828161411.534042-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PHUZKcWKh/NXYbkwkmEG2Kpja0CPbnuxdeeCwkDajTIvw03A10T
 iw95bHTFfUnCsMZMAaIP4HAZnYZWvZoL7wAfuCCG08faY2F0JhDd0u5PoI8N2BC0mb9pkok
 pFttp8bZMTocWPmwGvJwHlemVe7mUtCIH6OfAN3RmUR1wvM4BF0tNPCNcF0z5G4U1KyjIzu
 g7qFCrZ7EgV47TlXP2fYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z2X2ZbQJalo=;FBaXlpk0sGTNuf0dxdwtCl0Vzzu
 oDlZOhmZoY/ENgM4Qf36f5R0NfLja8wr2X0/EuKUUto3JN0xPLvT57Da+XAi4CYZW5G/SNdgM
 fuOsVuqGuIZ4VDtU2/QRXys/nbExcIGIgwIMRFUHcFI6psyHBdc1JSCesDHAOA7p1tfjob8o6
 XTb2UPQ4qnqCPu37Kn6otniN82/h3Tv0Jv/JeEmDmgCM0nknEsg8+R61VHmaTH4DH6zNVHs8v
 d8sdbn+MmmvzM59QEM3Ce+38k/y5cb1W37Gry+3z8rX4vqRbAmjl4/YP3Uic6GV1pyJGwx7gR
 wTHgoJwuattT4iWPe3lsUPoIlN3RKsnhMHbukkfEHCDmUJp7r28djc0g+PYFByDMh42Idum7l
 66gJ3VL/Inf4tIovZt+mOPeBDRMtYzPS37IkNCZUPbvUsPvKsvswnLqN7GRK2CZ/6hqe/YW9x
 4bXWb+KN+l0WMFEBL4N5abvvJX0n2rowcvn1EE7qLdvv+GZdQ4ytAEbnABtAR3drsP2OLldfB
 3TBlGdT55yCScbibTGdOkwkbb4aktOOBTM1uI0DyGHHvY0YASuTpKn98B+Um2ZHWiyfmqvnhU
 vt077PRWee6aruxaJDKl5mcX3TMDac0h79qfEB/riVw2FYPQ5coGuL8kGEYJKBxu+mpLvJoB/
 ALwGnMq1JF74FGAeElv/l4jpCsI4sw7V2wRSdwJclaztdGnsJfP36BhipQmWG4C8vknuJwGDC
 wyUOwPgs14KE1AtVd4RmiAqY3gUmHnKz+K/R0asec8IEiOefZjVheum4wQ9kAL21W0cWb68DW
 QfIQnUxSfCvfVVzdFeFz2YFM0ygcTYd623g3fm3LW5P1k=



=E5=9C=A8 2024/8/29 01:44, Fedor Pchelkin =E5=86=99=E9=81=93:
> The local extent changeset is passed to clear_record_extent_bits() where
> it may have some additional memory dynamically allocated for ulist. When
> qgroup is disabled, the memory is leaked because in this case the
> changeset is not released upon __btrfs_qgroup_release_data() return.
>
> Since the recorded contents of the changeset are not used thereafter, ju=
st
> don't pass it.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google=
.com
> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota dis=
able")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v2: rework the fix as Qu Wenruo suggested - just don't pass unneeded
>      changeset. Update the commit title and description accordingly.
>
>   fs/btrfs/qgroup.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5d57a285d59b..f6118c5f3c9f 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4344,10 +4344,9 @@ static int __btrfs_qgroup_release_data(struct btr=
fs_inode *inode,
>   	int ret;
>
>   	if (btrfs_qgroup_mode(inode->root->fs_info) =3D=3D BTRFS_QGROUP_MODE_=
DISABLED) {
> -		extent_changeset_init(&changeset);
>   		return clear_record_extent_bits(&inode->io_tree, start,
>   						start + len - 1,
> -						EXTENT_QGROUP_RESERVED, &changeset);
> +						EXTENT_QGROUP_RESERVED, NULL);
>   	}
>
>   	/* In release case, we shouldn't have @reserved */


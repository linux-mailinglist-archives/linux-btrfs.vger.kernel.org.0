Return-Path: <linux-btrfs+bounces-5916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE69142EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A64284B6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72ED38DE0;
	Mon, 24 Jun 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NUFP2TvS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82413FEE;
	Mon, 24 Jun 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211301; cv=none; b=GA4KmEcNwLv/qr4x+oAW97zmSogIZhSOaRhx8ZaKvIURImSulRAtyg1bmSeigz2fdnkrsdWVNLCQueniMIfScaPbqNzNmE6JOQ6DyVQWSkGyw77yeN4Y8wArPNTbWOaMztZxwFD2f7XjeGm7FIHaS+mCAC8gQBMwXrsq8JqydRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211301; c=relaxed/simple;
	bh=JP5B+MQQugsOtC+vxbP5c8Qc99M6wSYruuOXlnDvx8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi23vlMD/0RDcsr/q6WE8CQcKbX5hDEsQDI2tg0BtL3fRPoEG6i82S7JPbnBUeI6x44+qnxI1vNCTG6FNXbb6Fv6/LyB32T0joCKIRfddTYkZZoiW2xaq4n3DjbjMZsSdUDu0zruQEMgOk69sOK+yUrdYTb+snntPC2shUT3V4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NUFP2TvS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719211288; x=1719816088; i=quwenruo.btrfs@gmx.com;
	bh=dQp6F7hrw8SpbrlKTnZJQMJNtEhqy2JqWEWubbGkggo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NUFP2TvSLUd8n7wH8clIHq8HZOO/Nia5xRhT6JM6/hPJaBtg6ig0NpOBsAZ+WOCF
	 DqH3Mzh9nk/hJ5F+SCz7kBTFikl1xC0gGuJiVdG3jIRA0Lx3bD1JEEGlhjacsBgWG
	 /x79DAjq+ILLRmhAg9JqQFm0Kq9IK4pcqYK/HwnFXu+V7WCP9TPQC5wMMVUEEfLu1
	 iROk+rTpyvPYn6oyq3pCoP+63b9OCIKdCNccWYL7ACk297QELvbxZbWzxVJmJmO6P
	 Ua+kYH6WQ5+IYcDP+MWItlLqgrEPCPWBtv3QpSPx1CGichLwV4Mp9mqnYocXiBRRy
	 IV5UR3RGf4ulomoMeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqaxO-1shmvn3lOy-00o8ZP; Mon, 24
 Jun 2024 08:41:28 +0200
Message-ID: <40fbcb1c-e35f-4310-a2d9-9932570cb245@gmx.com>
Date: Mon, 24 Jun 2024 16:11:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: fix slab-out-of-bounds in
 btrfs_qgroup_inherit
To: Jeongjun Park <aha310510@gmail.com>
Cc: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com"
 <syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com>,
 "fdmanana@suse.com" <fdmanana@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
References: <20240624030720.137753-1-aha310510@gmail.com>
 <a0840520-929a-4973-8ce9-91db07d6a9ec@gmx.com>
 <c5646885-3368-4c49-9cbd-092d4b7b7551@gmx.com>
 <CAO9qdTEJaM=gEgQJLXuhKnh2jNA2KPyU9b4_kMWn6YNa3CU4SQ@mail.gmail.com>
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
In-Reply-To: <CAO9qdTEJaM=gEgQJLXuhKnh2jNA2KPyU9b4_kMWn6YNa3CU4SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c4VK82tujrsqVA9Ju4FJaT8h56hWDxiZWatwehLrc2whgjuWImH
 7w5WliJrzqSHEMwav6LkMqwL5w8QR82sTeknxpJ+OM71PWPfV+VgP84ce8L9Ar2g8uTy3s6
 JGfPq85hx/4VGCm5kg/i/+vB0ZMyTLQXBmex4a4M/UJCpqEFTbCU2VrwPJz2nH6tnaLBlhD
 DPjGm98xvhMciZTq6pIZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AYC4mI+8VwE=;UXs7BocHRdx8ULnuP1wauQhALC3
 1i82ViQtaaELXAuNV1zcauARdjfvISbCV29N8ZTSWIdakmS37Hx5i2LWyipfBYC/kYO1zyt2Z
 gyRKYzPkQNYCxE5ALBWVTAYwqGzj1H6lsW6Whb+zv08qKeUgKJzHCGTnkhMDYXgIGNjbZgQdq
 SkJby232NGjUzI0oW4hAplYhpiFrfn56PL3v/Z+q742FC6SFVx1EXrUJCMnNnP9xq35z3puGu
 xR1Caj4WCSSa5DWHtjxSNhDGXRdErqTQ4SaiZwa0UCiIZmUkoPqv93QsndhqignKmidCBhUUj
 9ZYHpiSER5FCYAZ0Ovgtq8+vXfS7kXgDakkHrmJ2ppAkPKWWyqx4hjSzGLARPMTw0ryCdsZt3
 6PJMLS5P/ibNIzS23NNVAGxcl+COodKO8ke/fx2JPvYRI2MNYeGbY26NOK9gw302xpsgcsBfe
 i7e3bK+3kcAGD9AZi3Hn3xjgAGeBAcqD0TKwBoE16oZ8JaFJnSXa8Z8Dfd0dFPJQY+w6rlWpM
 fKwWRzZciolxpzXxuv273R9Uz8zUFHTWYmAi+pxibvEaZ2Y7ZrRLeRE7WmH0RKmNLbo3o8o1N
 ObZBwaugT9F5pKlU6HhnAOCHoQSjcyPyXlI//F/SKQd1OPoJvmsSkwblc32i9UonplM7LgkBD
 ZHGMnNPVPsZ3vOdm3I472flMdYpiN0u62Eu4Yu7gUFG5aEP1fiiwI2EpFvmxZxIgV0QkBZJeW
 RT6hfQqFpXmSNHt2eo3m4YluP57+E/A0/QDnZ2LsJEFTNCAVFQfMiDFGt4x4AcPXkoWOWB37B
 kRQe/QzDonq0lEQ8Eyo6J1pY5J3/Z1QtbknB5t8WRi6HI=



=E5=9C=A8 2024/6/24 15:59, Jeongjun Park =E5=86=99=E9=81=93:
> While debugging, I also found that a problem
> occurred in btrfs_qgroup_check_inherit().
> While debugging, I also found that a problem
> occurred in btrfs_qgroup_check_inherit().
>
> I think out-of-bounds can be prevented
> more effectively if the inspection logic
> containing btrfs_qgroup_enabled() is
> moved a little lower.
>
> If possible, we will send you the v2 patch.
> I think out-of-bounds can be prevented
> more effectively if the inspection logic
> containing btrfs_qgroup_enabled() is
> moved a little lower.
>
> I will send you the v2 patch later after work.

Mind to check my v2 patch?

https://lore.kernel.org/linux-btrfs/47d3dd33f637b70f230fa31f98dbf9ff066b58=
bb.1719207446.git.wqu@suse.com/T/#u

I believe this would be enough to prevent the bug from happening, with
all the existing checks in-place.

Thanks,
Qu

>
> Regards.
> Jeongjun Park.
>
> 2024=EB=85=84 6=EC=9B=94 24=EC=9D=BC =EC=9B=94=EC=9A=94=EC=9D=BC, Qu Wen=
ruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
>     =E5=9C=A8 2024/6/24 14:40, Qu Wenruo =E5=86=99=E9=81=93:
>
>
>
>         =E5=9C=A8 2024/6/24 12:37, Jeongjun Park =E5=86=99=E9=81=93:
>
>             If a value exists in inherit->num_ref_copies or
>             inherit->num_excl_copies,
>             an out-of-bounds vulnerability occurs.
>
>
>         Thanks for the fix.
>
>         Although I'm still not 100% sure what's going wrong.
>
>         The original report
>         (https://lore.kernel.org/lkml/000000000000bc19ba061a67ca77@googl=
e.com/T/ <https://lore.kernel.org/lkml/000000000000bc19ba061a67ca77@google=
.com/T/>)
>         is showing a backtrace when creating snapshot.
>
>         In that case they should all go through
>         __btrfs_ioctl_snap_create(), and
>         since it has qgroup_inherit, it can only come from
>         btrfs_ioctl_snap_create_v2().
>
>         But in that function, we have just called
>         btrfs_qgroup_check_inherit()
>         function and it already has the check on
>         num_ref_copies/num_excl_copies.
>
>         So in that case it should not even happen.
>
>         I think the root cause is why the existing
>         btrfs_qgroup_check_inherit()
>         doesn't catch the problem in the first place.
>
>
>     OK, the root cause is the qgroup enable/disable race and delayed
>     snapshot creation. So that we can have a btrfs_qgroup_inherit struct=
ure
>     passed in with qgroup disabled.
>
>     But at transaction commitment, the qgroup is enabled, so some unchec=
ked
>     inherit structure is passed in.
>
>     In that case, the added check is not strong enough (lacks the struct=
ure
>     size and flags checks etc).
>
>     A better fix would be only let btrfs_qgroup_check_inherit() to skip =
the
>     source qgroup checks.
>
>     I'll send a fix using the findings above.
>
>     Thanks,
>     Qu
>
>
>         Thanks,
>         Qu
>
>             Therefore, you need to add code to check the presence or
>             absence of
>             that value.
>
>             Regards.
>             Jeongjun Park.
>
>             Reported-by:
>             syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
>             <mailto:syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.co=
m>
>             Fixes: 3f5e2d3b3877 ("Btrfs: fix missing check in the
>             btrfs_qgroup_inherit()")
>             Signed-off-by: Jeongjun Park <aha310510@gmail.com
>             <mailto:aha310510@gmail.com>>
>             ---
>              =C2=A0 fs/btrfs/qgroup.c | 4 ++++
>              =C2=A0 1 file changed, 4 insertions(+)
>
>             diff --git a/fs/btrfs/qgroup.c b /fs/btrfs/qgroup.c
>             index fc2a7ea26354..23beac746637 100644
>             --- a/fs/btrfs/qgroup.c
>             +++ b/fs/btrfs/qgroup.c
>             @@ -3270,6 +3270,10 @@ int btrfs_qgroup_inherit(struct
>             btrfs_trans_handle *trans, u64 srcid,
>              =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>              =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inherit) {
>             +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inherit->num=
_ref_copies > 0 ||
>             inherit->num_excl_copies >
>             0) {
>             +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D -EINVAL;
>             +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>             +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>              =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i_qg=
roups =3D (u64 *)(inherit + 1);
>              =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nums=
 =3D inherit->num_qgroups + 2 *
>             inherit->num_ref_copies +
>              =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 * inherit->num_excl_copies;
>             --
>
>


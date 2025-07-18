Return-Path: <linux-btrfs+bounces-15566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E5B0AC65
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB141C403AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CD22A4EA;
	Fri, 18 Jul 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fKWMspFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992F1DE4E1
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879621; cv=none; b=q0FGzEFyrA0AOSSuxUvPOrws6++sjeW+lO+rfcahJfnnKLDK4l9jWZDxIxrIqZ5Bt0gf7y/j4FPPhFG+Jn3KRzviCB+IgmLSb/onireHDk+91/0qEYt6hzrHv3IVVR8TBfee7H5ZZFO7SmRVSFwXBZkZL2fPiEKDEO9ZCxOzMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879621; c=relaxed/simple;
	bh=LjAdqmH6zWSIXhG2PiciBA1HS+FZeA8GGKweI23Xdfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez1Jxgxz4ILtRJTRRPwlqxB0oW/uIGN+2WKfGjyog4fzVU9FC8ObG0OZ0DbJaIl45edqDgeOwU5nacRXUSSiXPJAQTkqhmfP8sFNVGXOgHeV4SvCvQIognK1K8h6/2hFvaa1+i3GsrGOZN+kueP/QwE8jlkSDAOfm4W9nxVXjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fKWMspFa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752879609; x=1753484409; i=quwenruo.btrfs@gmx.com;
	bh=ESQHIUMv/zsVctOBPk+YbbVPc0+8oabU74ddp7fbScM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fKWMspFaCIuW7pnPLJdAgrzzPG30SO3PvRMB/oB594t38EyGwz5TEQhp4UsnV5Hl
	 iIr1SyUS+INNFdNJggkvr/u0DwI1pN0qryaQwOheCzMpbjXu+Tyu2pCDoDp6yMtch
	 VRd3bq2aRvKjeSoEnF6AlK0o4Dzi7o/J6Gu4s0J0DTke6qKorZsUSLFphyViJPD7h
	 j66wpqcjxVTUW6yznF+1eHuX5nTYPYHexpeQ+uNaftH3oQ5NdB2bx027sDtufi9cL
	 U3vJsvS0fsRGGMSuwxN/7zWzzKMaWhXGERUAup8ZNRWuCXPzT1fbhHyG3RXVFmLjX
	 G6m3ZwybSyYJIRoLNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1uApqY3Bks-00VnRw; Sat, 19
 Jul 2025 01:00:09 +0200
Message-ID: <83308a5d-5692-4b16-ab27-1a1459e74631@gmx.com>
Date: Sat, 19 Jul 2025 08:30:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
To: Jonah Sabean <jonah@jse.io>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
 <45b28eee-c05a-4030-a4ac-a3543646be11@gmx.com>
 <CAFMvigc+GEc-Vim10Z_Z7n==EJ3i8qr8r8LeZSGHBxqbnZm_QA@mail.gmail.com>
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
In-Reply-To: <CAFMvigc+GEc-Vim10Z_Z7n==EJ3i8qr8r8LeZSGHBxqbnZm_QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fHNZGw386jDoTS4uceGsfxcK94VWv0BmUNw38bRnai4EmLnckLD
 JEqMc2KQu7nnMmQAyAq6Gizw8m/WC6hd8W87B+A5RkUESb2GwPQpVbNcrsGiebmCXk1P07H
 DjcVJkytOgeSQB7WQUSDIVUkV0pHtuWnN18w9JawBh3hPOdjTEJe84/YdIDZdj0tgQdN7Mj
 F0PRmQ/cpDxMcIs20hoEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oyzde/0uya4=;ys4vbvOFnUISrLIUDD+s2Ue1j6D
 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



=E5=9C=A8 2025/7/19 08:20, Jonah Sabean =E5=86=99=E9=81=93:
> How does this affect zoned mode? Isn't fallocated not supported?

Zoned btrfs won't have fallocated extents, thus it won't generate a send=
=20
stream with falloc.

If you are trying to receive a send stream generate with falloc (aka,=20
the stream is generated on a non-zoned btrfs) on a zoned btrfs, the=20
receive will fail with error just as expected.

>=20
> On Fri, Jul 18, 2025 at 6:42=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/7/18 21:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Currently holes are sent as writes full of zeroes, which results in
>>> unnecessarily using disk space at the receiving end and increasing the
>>> stream size.
>>>
>>> In some cases we avoid sending writes of zeroes, like during a full
>>> send operation where we just skip writes for holes.
>>>
>>> But for some cases we fill previous holes with writes of zeroes too, l=
ike
>>> in this scenario:
>>>
>>> 1) We have a file with a hole in the range [2M, 3M), we snapshot the
>>>      subvolume and do a full send. The range [2M, 3M) stays as a hole =
at
>>>      the receiver since we skip sending write commands full of zeroes;
>>>
>>> 2) We punch a hole for the range [3M, 4M) in our file, so that now it
>>>      has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
>>>      Now if we do an incremental send, we will send write commands ful=
l
>>>      of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) =
at
>>>      the receiver.
>>>
>>> We could improve cases such as this last one by doing additional
>>> comparisons of file extent items (or their absence) between the parent
>>> and send snapshots, but that's a lot of code to add plus additional CP=
U
>>> and IO costs.
>>>
>>> Since the send stream v2 already has a fallocate command and btrfs-pro=
gs
>>> implements a callback to execute fallocate since the send stream v2
>>> support was added to it, update the kernel to use fallocate for punchi=
ng
>>> holes for V2+ streams.
>>>
>>> Test coverage is provided by btrfs/284 which is a version of btrfs/007
>>> that exercises send stream v2 instead of v1, using fsstress with rando=
m
>>> operations and fssum to verify file contents.
>>>
>>> Link: https://github.com/kdave/btrfs-progs/issues/1001
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
>>>    1 file changed, 33 insertions(+)
>>>
>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>> index 09822e766e41..7664025a5af4 100644
>>> --- a/fs/btrfs/send.c
>>> +++ b/fs/btrfs/send.c
>>> @@ -4,6 +4,7 @@
>>>     */
>>>
>>>    #include <linux/bsearch.h>
>>> +#include <linux/falloc.h>
>>>    #include <linux/fs.h>
>>>    #include <linux/file.h>
>>>    #include <linux/sort.h>
>>> @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *=
sctx,
>>>        return ret;
>>>    }
>>>
>>> +static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset=
, u64 len)
>>> +{
>>> +     struct fs_path *path;
>>> +     int ret;
>>> +
>>> +     path =3D get_cur_inode_path(sctx);
>>> +     if (IS_ERR(path))
>>> +             return PTR_ERR(path);
>>> +
>>> +     ret =3D begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
>>> +     TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
>>> +     TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
>>> +     TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
>>> +
>>> +     ret =3D send_cmd(sctx);
>>> +
>>> +tlv_put_failure:
>>> +     return ret;
>>> +}
>>> +
>>>    static int send_hole(struct send_ctx *sctx, u64 end)
>>>    {
>>>        struct fs_path *p =3D NULL;
>>> @@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u64=
 end)
>>>        u64 offset =3D sctx->cur_inode_last_extent;
>>>        int ret =3D 0;
>>>
>>> +     /*
>>> +      * Starting with send stream v2 we have fallocate and can use it=
 to
>>> +      * punch holes instead of sending writes full of zeroes.
>>> +      */
>>> +     if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
>>> +             return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLO=
C_FL_KEEP_SIZE,
>>> +                                   offset, end - offset);
>>> +
>>>        /*
>>>         * A hole that starts at EOF or beyond it. Since we do not yet =
support
>>>         * fallocate (for extent preallocation and hole punching), send=
ing a
>>
>>
>=20



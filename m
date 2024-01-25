Return-Path: <linux-btrfs+bounces-1771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EB83B890
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C6D284644
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD07489;
	Thu, 25 Jan 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jrwPt4MC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D217460
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155622; cv=none; b=snOYwpo2oY2RrKMNmxCmaBJLtmFbWpvTOdAaZ8ToJeuY+qe/mbtHPS0KxKhrJ1wdyTAhdKWAABfL98UWnxvnRD9P1CqJYVuNeUmxjIQbrn5r2pn0brN6Ks0vdpLwDCWw7JO23RDtGSq5gwTfOD/QgyTFXa69Hg4Z+iOiki8m4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155622; c=relaxed/simple;
	bh=lCqgIfeCerLBSK3lUXrIvuxy9J20Vv9HMiVFN2JLWzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MqCYxcRtW5V+hLdYZc1Z5KGE1eL5oeME170qosysNRj4pFm/cd+UZ0YCUp7919G+m5hMRoIrseL4TacuCl7t1joAywtymOv1d8qxy4UUFhZ52SaL7mdKFC7GTNzCm5HxrAdYh6nkt1Re/VGqbBA29vaOaApkbTvyrkUv1ORCVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jrwPt4MC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155617; x=1706760417; i=quwenruo.btrfs@gmx.com;
	bh=lCqgIfeCerLBSK3lUXrIvuxy9J20Vv9HMiVFN2JLWzE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=jrwPt4MCuqoSXDHBb7ZNlYlA5iKM1MtMYOoLADX7OxDI8uzVAF9YtzislIW76Xo7
	 4iSJuqwKv8Lojb6VKbTtDCmJOx0VRvNWUj0n+L0oXQ4ukFjx8ksLJEhpaBmZ9scaD
	 9iXdFQXM5RdFLEFDVfKSPY1GVw81PDb1C8tslXzNbq3cI76ZkvlmvsxQ9uZj4R6iC
	 2BaUy3ScjgxurM/hc/dZ+gSj8ceJTxqAkjrcS71ufW2hI1ZnU1pqRVWXFq4jL9ewF
	 VlhREhdmWCGwOtnDWuVMBcHmaTUX1cVYMcXcsriy16/1RXc+WR33cRFBAOdV9yEnT
	 4jMg4d1CxfLxA2CcYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1qp6Q449Ee-00dkE0; Thu, 25
 Jan 2024 05:06:57 +0100
Message-ID: <25c4a7ae-b598-4563-ad0c-cc71964adc10@gmx.com>
Date: Thu, 25 Jan 2024 14:36:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] btrfs: handle invalid root reference found in
 btrfs_init_root_free_objectid()
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <aeb9fec3b34c662de4a9771f44e7d0b839de13f6.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <aeb9fec3b34c662de4a9771f44e7d0b839de13f6.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udoSeMHXN7iBkra/yX41btzqLKrEljiPq12rtUa/+0hvIY8V5vm
 E45dbQ0Ol5VGA4id4+mbKUNGQNadGsDuGeu/bcxAwy4tPz0FTcWSzy9LkWkm30sJSYKbVOI
 GIQ5Ct4BI3qydvOpQ4VpVWYvmKevzF1DJPdgWW3YCSRBpONk+6VAFuJRDd08Sk36jHCovI9
 vLQ2IhBp6kv9X/DQR1rIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KgCxmTAbmNY=;98cjazJ56xYMGroWLnrYE8YPZSa
 4qoM12WWd6VsxN6AZb/+Ln4JVWGTd0OVnTdYaqTR3P7EyauhUeEoA1TCm0R4PbqtsO3bQqKKp
 PA6y5Hn+8AQUH1vcOyq4oqah/vVu3T/oyrWADSvaP87mVhUESuamDdMXVRhq3H6Xn3VbrDySm
 YqVKI0G73lnwcu/CcLUQPuDXqo7HnSu/XR5ncXXPyDMzyankitaIQIkS0wCN6zeWE1+BP0UJY
 BXNKl9Pr2xG/3+llLUxkgXFKbumlbutKf31gb/N4fkO1/8NJ0pdCmci/DXRWoKfZvDUaqzIgp
 tgXpbY7cmvJ0GCmF4pDWourpj5+7MGPaOnAvTeyGIUa6HQa2fbRd/uKQrVKDy9+FilYpjACJg
 e6Nfh3xUyYs6El6WK9wIvpI6iZ0KsTzjrcKUeeC+KZbNZ3fEIlE6YW9vE+Jg9mTHqqDehmfJ4
 IgE4k9Cf1B1U1RIfnSrZ+NA7Nd7u/mxJCNoeRBzzcMjBWpnuJ+Ha1nDfbm6hZFXX4ykjmchEk
 teyy7/ChbjYgt4toP0ZRPL+JVKzM7toYS8yUMgujHWRsYwM5Ye9WEErMQd3C0FDtHL0QxsVl3
 n9X6Sk0YT/UDfZCnHzDQn2n1KjQGE3t4K607pjSQ49PraGL/tklCuNXqxSsUfevWSRVwMaYMR
 11D6wcaYkXWgEiNu+DO1gQifJ62iMcqKEGkjHMfMoEkv4Wp9xLqzC+rI49ue7IE75QYqb+kTZ
 0w3+C4YNQS5GVJFW2SjBHdf5KRaK/a/ZaNxl0Yml9X+TcnPaSBcO+p+Qgp5jmTb7V3czyAtm+
 LYwGBnitji5N8J4a8WUy8Rd1eJvrZg4P5+jll3zvBkBhIcYpymhV/k5V9qgtywea1wchgNQq1
 InG4Y4o3qsKMSxvFSNeGE5180JzBswF1z5LyeNKwkzusUPwNpCH670mucHxCCEPby7OeMyoxx
 kVk979+n3IC1al9Y4d7pXpA3do8=



On 2024/1/25 07:48, David Sterba wrote:
> The btrfs_init_root_free_objectid() looks up a root by a key, allowing
> to do an inexact search when key->offset is -1.  It's never expected to
> find such item, as it would break the allowed range of a root id.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/disk-io.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 274a3e1faeab..3f7291a48a4d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4928,7 +4928,14 @@ int btrfs_init_root_free_objectid(struct btrfs_ro=
ot *root)
>   	ret =3D btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
>   	if (ret < 0)
>   		goto error;
> -	BUG_ON(ret =3D=3D 0); /* Corruption */
> +	if (ret =3D=3D 0) {
> +		/*
> +		 * Key with offset -1 found, there would have to exist a root
> +		 * with such id, but this is out of valid range.
> +		 */
> +		ret =3D -EUCLEAN;

Better with an error message, since we don't have a trans to abort and
one of the two callers are not aborting the transaction, making it
harder to debug.

Thanks,
Qu

> +		goto error;
> +	}
>   	if (path->slots[0] > 0) {
>   		slot =3D path->slots[0] - 1;
>   		l =3D path->nodes[0];


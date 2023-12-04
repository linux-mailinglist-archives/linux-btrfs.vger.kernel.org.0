Return-Path: <linux-btrfs+bounces-590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C0D8040AE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 22:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F5628132A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 21:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC5364AB;
	Mon,  4 Dec 2023 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Gcdgx30c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF0AA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 13:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701723855; x=1702328655; i=quwenruo.btrfs@gmx.com;
	bh=gz7eQfSMazQe7dob8h09fTUMCqL5b1ZJV69V/25am4w=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Gcdgx30cJd4dHutLWcfnd4X1PpzqFJbVCytJD2loD2q1svfIJW4/mbwRsCRvd/r9
	 SagOD15xbffB9qCdzK5YpctGvbd1IpR4nHUiBodFS95kb2u5OgU5R2gs2YjkNw9Bp
	 GEz6qR9gBc9+g2YUCLJogRyS1XTEK4rF6iBlWXoBO/CYAyvhy2AOC5e03aoA255NF
	 ffd0OsQy+Ukl2sI4lf4/8vWMIsek+RjWp5xJC6BGv8r/B1khMZw7K7RXor80ksIpi
	 +dQg7RrQBaTWIIv5mPhzSZUBxz0IUuChVgsB7lHqdtvTePU3/3KN6EZ9DZJR5w8NR
	 ubtmGzJX3Vuvzuv8Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1rZ6To3QUI-00jrjL; Mon, 04
 Dec 2023 22:04:15 +0100
Message-ID: <a72c5e7a-13ab-4f2f-8371-7ef4e2e2646e@gmx.com>
Date: Tue, 5 Dec 2023 07:34:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: free qgroup rsv on ioerr ordered_extent
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1701464169.git.boris@bur.io>
 <301bc827ef330a961a95791e6c4d3dbe3e2a6108.1701464169.git.boris@bur.io>
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
In-Reply-To: <301bc827ef330a961a95791e6c4d3dbe3e2a6108.1701464169.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TCzcukJ4jIbKSJ0eL8KPLoSt3/a4jrjaX7M2QUUR7TQdpx9JX99
 +Ro8H0+ZYEj+lS/KrkIKMrE2EYNaQ+uMANWOV8qHD/61b4ft4aOG1XQErwxYvAokUwrc8Ul
 VbgPwfs45chRGaT8S8jp6dO/G0407re+WLA5+k7moAggiPncp2rnN/PeGHrkcehN13nD7Hf
 WsrRqLa6GjwZugQsjFncQ==
UI-OutboundReport: notjunk:1;M01:P0:lnmB3bywTv8=;jm15sDCttciVqQVXdTzaKZG6stu
 tzBkNhB9d+QzKXlHDMdInhx0QbgfayaBE3vLXG3fPk3WT/7TW05mRAiyxbDkxmBA9qXqrPWbi
 UNoJuxR+0GwrUXvygoOHrUZ8bgAEersZD96t5oy8TMSjJRAkU/FdSqIfkFlSfxmI45ZeUZLPN
 OM9mg6QUGzFmzbnEfdN7HDVkgh2I1fcdKWWaTpsokqIU9l4YheUq1thdshsTqWvpZIc0AHjo1
 FOhpmzLcVDqyDxoOC+/cmV28Qp9uxLZOiXcjUOcIfDe5eqVy5jqjmY3KV74Pe0V2hIaS7DwmY
 FFJkMs0KXDK/6igV/o8+DV6PT6M8Io7992+AzHH4KolqssNJtWFw0jCDlNGssCm3tDfALbKNx
 BGzatCwU/vvj7Ju30Th7MJfbtvfLnVYk05s6k2XG1Kicjgbdy8N3kWEekDrAufbXJLAP+bowz
 YUQt5Snw3NAN7G4AMjTjqRG2Uf+cFGzQ4kZpQLn5iCIi05Ef2B5S5GVi0nUTJ8ZKaVeASZlyR
 aiza53vw3IAFrQJ+BX2vTeOHog8017dTidDFOQ3QCuw/YTu7Erdl0Vg8+w5MrA4NLiqlL+BG2
 uQWdzNB5GUXOJbjLyWe/FvOzcwFnLk/9RWwdyyE2rtQdny/wD/SKO4EcEsyQXC5up06XQPq+K
 bxCZVKNR78eZwCX8IVihy6POSbLKUlhBk4Gb7oZFWhP0EV2MQVYy8anjiinjUihOghpHyI6oP
 2TbPpDplL0tDiX5nGSKZywhuRL/0jFqk4mLp4VnJjaHUdu7licILDDAQVvAlflSMkLxoQO6fl
 CflHNrAcefEl7txxjLz+nwsL1iuKm7M2X6iV14lHZLTNm8E3WkVwsKBFiXoRD55mYOnnkjmWP
 RU4VWA4aJd99lV68WiQGbgWnJVO/LTf8AemQnsnE4w39ekOBnD33rAcCnrtNcKt7N1m/cmmAf
 STFjhlGEWVfeSqRU4yvvLWjuV1U=



On 2023/12/2 07:30, Boris Burkov wrote:
> An ordered extent completing is a critical moment in qgroup rsv
> handling, as the ownership of the reservation is handed off from the
> ordered extent to the delayed ref. In the happy path we release (unlock)
> but do not free (decrement counter) the reservation, and the delayed ref
> drives the free. However, on an error, we don't create a delayed ref,
> since there is no ref to add. Therefore, free on the error path.

And I believe this would cause btrfs to be noisy at the unmount time,
due to unreleased qgroup rsv.

Have you hit any one during your tests? If so, mind to add some dmesg
output for it?

Or if no hit so far, would it be possible to add a new test case for it?

>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ordered-data.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 574e8a55e24a..8d4ab5ecfa5d 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -599,7 +599,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode =
*btrfs_inode,
>   			release =3D entry->disk_num_bytes;
>   		else
>   			release =3D entry->num_bytes;
> -		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
> +		btrfs_delalloc_release_metadata(btrfs_inode, release,
> +						test_bit(BTRFS_ORDERED_IOERR, &entry->flags));
>   	}
>
>   	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,


Return-Path: <linux-btrfs+bounces-1466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1882EB4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 10:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FA21F21D2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6812B9A;
	Tue, 16 Jan 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MznAwDtF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BC12B8D;
	Tue, 16 Jan 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705396363; x=1706001163; i=quwenruo.btrfs@gmx.com;
	bh=jI6sDzQkPN+DfPBKgNfksiXi37NWcrYrS2OPe6mAuzY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MznAwDtF/ES/ZNLD7MABrPa3lUldNkEi6cLfjHDewciNLUmtOEccn5yaaIG7m5Yf
	 WAfZwzSWGunENe+LMTz72O16EUrO1a8FceGF5osFYBs9oVEEqnB83U4MVG2NavX+t
	 2N44ZnxSVAXucPpUJ0SWZ9KC/67QFURFcgRJ5io6zslQa+/yonT7Fwn1GrRhsZP6G
	 ZW3yqTSDOCdqW0Cu/eo4yPZf2F0PNJl43urdxY37fXe+wFNHupw/pIBn6HoepF+x3
	 Nh1P1rjyCVPazHdBbBqaiu7/rdwunxcsrZeea/2O2G7JJ+jb88V9oQjMMnhGBF544
	 9XTSeTL9gHIWVN7vhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1r1Z2p0aoy-0121za; Tue, 16
 Jan 2024 10:12:43 +0100
Message-ID: <4cc5ba4d-299a-46eb-b452-21eac629ace8@gmx.com>
Date: Tue, 16 Jan 2024 19:42:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't warn if discard range is not aligned to
 sector
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
 syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
References: <20240115193859.1521-1-dsterba@suse.com>
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
In-Reply-To: <20240115193859.1521-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iRnlzFSNJPCJl1ODabPRI+EROOJhSAY8iwjhY0ZHQ+zQVi0CGXf
 xlaV7L5HWQjgW/7H+hfL15mY8GIesGdchISje1bWAqUyX02/mhLG6/azdiwEcMpOWW3yiAf
 9EOcQ35QZzo7m9iDZR0RPBJWrd70MsLF+MOgCRbDBy4rigAjzhJsP8wK76+P2VT/Se6pcdg
 WD7qddXv1hA62MG+/8ysQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MrwAzFOjfR8=;SoAuHHJeI/m8fDGjXQ6pccsl6Kq
 BIDiODGqsptgNCq0LvXG/X9MvzJZFB/qPE+XfAeTvObTPFdEz5gmhFjVfTlbQkeHeHlyEcpQq
 boqbd9+qtMPGnSPPKdssm3PbKIB/0hKWSb1dIkG8orUVy0vcZ3fKotiCO/TULgMAuz/SCPzF7
 tzUf/lIz5MYQNVDka8WfsqUDnoe+f7rDL24KH2TdzjW4nEgHMZsUECvIspNX3/IzIIE+UThFp
 sP9mPQoYQ6BFMS4Ab5SURs612GIYNww7dCTEUg0rxiHT1TcUDGxQMd89HPrvSn+LbewoAVH+W
 XTLotRmEjnPEO393i5TM3rwX1f97Lc+pIz+RypG19BY+je29NwjcGGFr17fPW9Z4Uj6gfesPV
 +dAoSSgDlP8t5t+Clg/kjE6RPK8IsTTduLLkXRaDMZncT2UKNqFkBWQy3h8s5HApADFs8+9r4
 C4fkitYdjMYVlasd9LxiPh5EFJ/BOwfuk+BP8ZxJnskJwxM2gKX5QwLIQ6mx8A4m3AEIe5pmT
 KF9auM9ijFMCZJ5lY7kbEDOjSwb3Ba6EFz5dRPHCP+jbXPkhqx0zxd25oI1fDgRBAKySpkd4B
 3y5n5X5U0D5WxLvlCeLY7f1ndcIS5mPJgcHVCqbbTc0RAqvtuk1XWrjre4MdkAM8n24AIk7/Y
 QS5L6mfzujxdmQCcEV4hBYNe69iimqr151XFEAaReyL/4AEwVEs+Gpovu/P9yRA1/3l1dwgSu
 XV+SUflWBkF3K5+8JtaTdNqSaLmESklSRrfZeNOQjCeywC2RavKC0KjWsIufC3Zr/E88jAGW4
 VADHhJi810aO3ljhsi2PDu75ctF+fzVRcha1xtCRADdaNbktz88OLgtvOURCncwAXSRJ13Uxe
 EeVFxnbR0gl9tR3cmkhY8o9nKSHirlKixwsqP/xqhezX2a5j4NXL/ls2R9cIbHIuMXunhUNNH
 7s8iOVuzyX7I70PBn6vIEWiI/lY=



On 2024/1/16 06:08, David Sterba wrote:
> There's a warning in btrfs_issue_discard() when the range is not aligned
> to 512 bytes, originally added in 4d89d377bbb0 ("btrfs:
> btrfs_issue_discard ensure offset/length are aligned to sector
> boundaries"). We can't do sub-sector writes anyway so the adjustment is
> the only thing that we can do and the warning is unnecessary.
>
> CC: stable@vger.kernel.org # 4.19+
> Reported-by: syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent-tree.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 6d680031211a..8e8cc1111277 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1260,7 +1260,8 @@ static int btrfs_issue_discard(struct block_device=
 *bdev, u64 start, u64 len,
>   	u64 bytes_left, end;
>   	u64 aligned_start =3D ALIGN(start, 1 << SECTOR_SHIFT);
>
> -	if (WARN_ON(start !=3D aligned_start)) {
> +	/* Adjust the range to be aligned to 512B sectors if necessary. */
> +	if (start !=3D aligned_start) {
>   		len -=3D aligned_start - start;
>   		len =3D round_down(len, 1 << SECTOR_SHIFT);
>   		start =3D aligned_start;
Can we do one step further in mkfs and device add, by rounding down the
device size to btrfs sector boundary?

Add maybe output a warning message at mount time when adding one device?

Thanks,
Qu


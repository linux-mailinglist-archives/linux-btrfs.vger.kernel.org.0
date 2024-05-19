Return-Path: <linux-btrfs+bounces-5095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977EF8C9760
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F1A281183
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2024 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575271B4C;
	Sun, 19 May 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FXwbpnBO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C596F079
	for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716161411; cv=none; b=LTErUp06B9AB4mH0U8clfXheLM8wSKWSf6L+0RZJyc4ZrfW1EoVPHmM8R+kOtNyGu96mjfEwa1Q4b7l++r9g3nLO3e2KraicnbjKw3IPV6TZKfPxZj1PwFcGcSDWJeuD/ueo6GUmNawUcEPlUGkY88Y4Fcp5A5gdmh3WimIBf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716161411; c=relaxed/simple;
	bh=ncqh/gYp1klLfv9XWDqlPkf7hhxU580E9MJyfo1UVHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IxpHIPINtLmQmhJ3gkGL06Xhr2wxsOg9L7T/RRcpDpPuhUlOFeTyg/Zkqn1D2Gk1S7AWpzp1xxwRNA9L5DNIta2KmXnkHd18qy3eYcH8ymY/rW5JhZO9EmmPEOJhT3Z/9gPWg6hyyogFzjJ7vg/tC4S0tN3krS7iaIU+o3d1wVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FXwbpnBO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716161403; x=1716766203; i=quwenruo.btrfs@gmx.com;
	bh=XlNcdvnchH3UwGHhla51/pvyNGjq6UPOA4WBsJOq8qk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FXwbpnBOEeyUAIYiYVZmwktIpxrn7br102qllq/gBNnCp/akT9Hh5Ww3ZGIrS0xV
	 QNC2I5ZspqLHdelrqyhQljWb1takVEYvMYYgSMixPRqPofUHy9duPIyv8XA1dmlrE
	 Q4nddXFHSK0Dd9UrTtC2b2X+10OsqYyQqUJc2vc4esj7WBVQeKBxa5njDz2d3sYxc
	 qA8nplpnmziDDIiSL0SQGr/vYP/fq973zMDJ2aZyqurCDcg2d11iKd0pBKWEKC2ZW
	 iU5TQFaJEtUHFabqKbNNTPIwSXbZlWu3RynIrlMbWKombaTPZwyQxmzVW9zsZcpYY
	 +CLmnT4E1e2/DZ6PJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1sEMHe25w4-005Vj3; Mon, 20
 May 2024 01:30:03 +0200
Message-ID: <2211c822-f5a6-4302-9f83-c20c49ecada0@gmx.com>
Date: Mon, 20 May 2024 08:59:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: move btrfs_block_group_root to block-group.c
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cab027dd541768375585dc32f14b160abba476c9.1716077975.git.anand.jain@oracle.com>
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
In-Reply-To: <cab027dd541768375585dc32f14b160abba476c9.1716077975.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fvC1VSHWdcBjKEwKUD8vRf76t97TyAoYA+CT6ZnLyIP8/au/p8V
 e/vfSKkPb60FCd4sX69QF739JLb5mNIvhlg5okXVDWOFUKLoTFSd+PlJEcFJOhLEzyZuoin
 Ba0AF3/VSAc1fL+weK3hbOdWwm1KWfPklsgjpa/7OprhcSEwJhQ68wvix+4DMRqArUqiyuN
 CMQKdftyramy1CtU5HiQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MDVzDTmJYSQ=;aGFKA/Y09D2RrE7A0KNgoPINpd/
 u7fuYoafXJy800hX7tgaupn7PYl81khSbh4bo+OA3/Tqkt9YXZr8Vep1Fl111UjGeVw3IacOi
 pFD28PwPS0ghFf82hN7FVH2PShnHEZHO72BWDP9CY1FcxOrROtDTKYznBYYPdeXcCudMcirht
 OKDxmEq+ewDi5w41sXmMbroFHqCONW9OrVMmNk8zqoCxz2uf2+GS7ad6uiSmZi6QCsOFYEF9E
 zrgfXTzb1tnveZW/A0OlHy/IntBudKF4zM3rAK0SnLDCAFwH/ahD26srd3wSD5MTMypBoCUDT
 QTvR3UfwoSlx/b76b4qjrLeKsj5zP71X0tN6NhZ/VVnaqA7ewTHstHoZ3JlL6P1Q4AWsMsFfn
 z2bXYY2hnB41ErzoJhBVv3Dn4MXubgnTxuDlhz+9/CyWWkG6rCbwOPvuaaqt7DBC3qTvDxcHZ
 JKcyBMFxw0iOflqolwh+e1PO4EbpmR5Pr+5NiQahtGjX66HLfWd8ZqFwoC5N1dTP0jH63uko4
 QHoc8bt3sm7vSBP8adWUDackEZ3pFt5G+qnPHEaZlc8VrNnm4y1n2M9volEzn6i1XK1BfnjM1
 EY/jRTLa2gsAk2AvGuGBD/zlKt6fifvXJohrJQTD+qdGuoicZ7PMXiRXHiJLkECGZW1uNwrgL
 k1C2OnQJTJtLxzx7Q/LryNFv67yaBPsoAfmlgRRXDq+7GhMmnDa84QTjEPXKb4UR+9HBAk9n9
 PHKomimCPieozd0tMFLsXsjf9FbBjJZJcWcMisQmwlaGNakAEOT1KCLweVGBNW4CDHqpVqouM
 q7246RFP1BWrUo680JAEh0sQ1CNiJEWjv25IqebEkoe7Y=



=E5=9C=A8 2024/5/19 09:50, Anand Jain =E5=86=99=E9=81=93:
> The function btrfs_block_group_root() is declared in disk-io.c; however,
> all its callers are in block-group.c. Move it to the latter file and
> declare it static.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c | 7 +++++++
>   fs/btrfs/disk-io.c     | 7 -------
>   fs/btrfs/disk-io.h     | 1 -
>   3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1e09aeea69c2..9910bae89966 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1022,6 +1022,13 @@ static void clear_incompat_bg_bits(struct btrfs_f=
s_info *fs_info, u64 flags)
>   	}
>   }
>
> +static struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *=
fs_info)
> +{
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
> +		return fs_info->block_group_root;
> +	return btrfs_extent_root(fs_info, 0);
> +}
> +
>   static int remove_block_group_item(struct btrfs_trans_handle *trans,
>   				   struct btrfs_path *path,
>   				   struct btrfs_block_group *block_group)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e6bf895b3547..94b95836f61f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -846,13 +846,6 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_f=
s_info *fs_info, u64 bytenr)
>   	return btrfs_global_root(fs_info, &key);
>   }
>
> -struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info=
)
> -{
> -	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
> -		return fs_info->block_group_root;
> -	return btrfs_extent_root(fs_info, 0);
> -}
> -
>   struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>   				     u64 objectid)
>   {
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 76eb53fe7a11..1f93feae1872 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -83,7 +83,6 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_i=
nfo *fs_info,
>   				     struct btrfs_key *key);
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
>   struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u6=
4 bytenr);
> -struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info=
);
>
>   void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
>   void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);


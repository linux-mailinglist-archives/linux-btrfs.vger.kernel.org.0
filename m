Return-Path: <linux-btrfs+bounces-8524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D63C98F89C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB86282103
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A71BC063;
	Thu,  3 Oct 2024 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZwkSQgMt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9E1DFFC;
	Thu,  3 Oct 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989847; cv=none; b=MaRFXH3FBO0VDJZPbNlZCOel052gmwam+pBgwfvU4O++4ikYO6SAQuCOcTWhqzYgC2HZNdQwecsO+yt4hfSi62a2kxb09CZgsKdfAhRYR9FKJWZQaHsezbvLq1S+BfAlQKcRwzrY/mQdAHXmqjnQ9AL0hl2zv81AiJnnZtR4CAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989847; c=relaxed/simple;
	bh=YhAu9I2yqn5jCgp64f3eT1pz5uRyjOrN1bKUPiuvyQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITdqZUCte6b3n3anWrgynVbH7QFSPVeQG5b/9aHf9aoYzUo1tHzqFCK//5YoCAo91xfkGlhy6NrRYltuEbtDkqaA5/NPxeLWYylNtVhDaJNSfj1TDNssIZROvdTmzNt9VwPSFLKsnjX+NDxkitNz4Z2yFbVgO9C7c3a4RnqmWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZwkSQgMt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727989826; x=1728594626; i=quwenruo.btrfs@gmx.com;
	bh=p2aN87dafSnvz+ZpNg1AuBY/5si21x2jAH/gLeAq0es=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZwkSQgMtQ7GUO+unMnTEQUrHEpHItyg3jHjdJtaqJXPALD+D4eAiV8vqBmFhZjpr
	 JSN7QejIBtQYrlIvRhIWNa93eywawH9UtzWcGUO3jEXL6csXVe9Icjer0oBDHQyE4
	 Wh1gCrnCL9uNy/B54IAOGxvck5ivFdfWUrh+oU1gnAkny4AcYFUjCeDwbCl81/CGx
	 nfNuYAl1PEGjUyqN8kOGKTMI63vATuntPt4kJ5lhG3kYlk3RfXaUsHMdOvoB8BsSb
	 s0PLCZFfn9hJHnJDpZMinSEphPI3TLDcdEYAhLAKFxl0SkobuW9SMEBQ/pNaxrgwn
	 rsfOswq1Bg19nE/9ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1rtoE92axY-017C4z; Thu, 03
 Oct 2024 23:10:26 +0200
Message-ID: <51b35809-bf9a-4b09-8df0-4eafc077d00f@gmx.com>
Date: Fri, 4 Oct 2024 06:40:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Remove unused btrfs_free_squota_rsv
To: linux@treblig.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 boris@bur.io
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003203319.241687-1-linux@treblig.org>
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
In-Reply-To: <20241003203319.241687-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4VM+YyglaWBXZ0yeUJc6x0wX2Yat1UBGinrnQ4Kj5o1+RrKka3
 Zz1jpU3f5XSMLFmvhkh0OhqV9uZgo/bvgxsvd+ogEpFLclhiVvNstFNmH6fCI60dbpQ6yJm
 MhDt2ZaTbKv7BL+fsNL0TS7CUcdqUtu3UX7CVZnhKWK95cdXTSzfhMWlSNDXBSoy6Ee2SZS
 OgAxwWjYnPV2/MvemIH5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wm2aO4vLRS8=;ZRfaqWR63qwmMUGwgkyu9/dQbCe
 A1PRd9aR+7IKz26MOHGL/mynnEJoqaRKfA/6Bc1Mqi88fdad04MM342H989SiWYo/nbhENqid
 N5gL7Hx/dtg30jWGHHX7kgd1gS+42UkDNX85Sj1+og46G24Md2UfFIb5eGIm7yin5RTAmqgIp
 h9w6/w2O3GaRG/KzGLWfKPAcAP/lN0KGQLWBKmiDS+KfKuI8rDu0SaBVzLCBK88aQAjq+6M9r
 586JF6kXs0WWV5LYOWR2pZUIH49NHpw2EdAQnn60+mkPesRuvDRNXnrpRwNyiPybZffDtvwML
 SYJgqSgf7GXrNEjLUvz/ifG1ZjWam20b1omEv8zunBaCA8wpRxwBOu5nThyLwQRvmTi8EkHoj
 0lpAXmBP2wTU9uUUJZCCerRhx77NZRXgvCClV1TuJpoezArhgSKYLOH5RlTdZ8o9r6muXxLE3
 ardS92elZc0usyDkRIEKJ8vJ7xx+NN3erFrZ9C6QGgTpObvQYr08161q2OPmYLtWZeillKwim
 HZLIGJlwbZHbk99bdVg9liwbGYFH6eOu4HajmPkkwr/4RoffDFXGOvACDbRQ/hWlhCAOOPAmu
 wnDsdrHspayVFUpGGTn6oskaZy3JheaVNue6W9LhIqeiB9Q6Df3fDC6c0D41Iqdm3xJ7vNIg8
 oydlOH+RkrD3ioTV2DSTOFQdBtoU17JUZOTE5JH6oesQQmMcf1wuCLaUt++s67knQJAjPE6Lc
 XaEptOwu5qatWadz0+QWz2zswnNxTqGcucS2JkNAbiUp8ZQ4bQQhkKknqg+RadyDLlIsnhl54
 t4XqMvqkU1D2sUG7BLrtbaHLY+6DBjJlo5P+S2Ero7tG8=



=E5=9C=A8 2024/10/4 06:03, linux@treblig.org =E5=86=99=E9=81=93:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> btrfs_free_squota_rsv() was added in commit
> e85a0adacf17 ("btrfs: ensure releasing squota reserve on head refs")
>
> but has remained unused.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 11 -----------
>   fs/btrfs/qgroup.h |  1 -
>   2 files changed, 12 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index c297909f1506..52f0cf7621d6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4883,17 +4883,6 @@ void btrfs_qgroup_destroy_extent_records(struct b=
trfs_transaction *trans)
>   	xa_destroy(&trans->delayed_refs.dirty_extents);
>   }
>
> -void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64=
 rsv_bytes)
> -{
> -	if (btrfs_qgroup_mode(fs_info) !=3D BTRFS_QGROUP_MODE_SIMPLE)
> -		return;
> -
> -	if (!is_fstree(root))
> -		return;
> -
> -	btrfs_qgroup_free_refroot(fs_info, root, rsv_bytes, BTRFS_QGROUP_RSV_D=
ATA);
> -}
> -
>   int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>   			      const struct btrfs_squota_delta *delta)
>   {
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 98adf4ec7b01..d72e09de2d64 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -440,7 +440,6 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrf=
s_trans_handle *trans,
>   		struct btrfs_root *root, struct extent_buffer *eb);
>   void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *tra=
ns);
>   bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
> -void btrfs_free_squota_rsv(struct btrfs_fs_info *fs_info, u64 root, u64=
 rsv_bytes);
>   int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>   			      const struct btrfs_squota_delta *delta);
>



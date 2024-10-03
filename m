Return-Path: <linux-btrfs+bounces-8526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105D98F8A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953DA1C20B74
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906D1B85F0;
	Thu,  3 Oct 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rZR2KbGP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670191DFFC;
	Thu,  3 Oct 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989919; cv=none; b=LDm2CYnhek/iLkXIoja1QsDq/BUNYvanExQm67MLcN/JEJGW+mAuiIXWzka+caMAQdxn/017t9txN0n0emKqewuAWrayoWuBOD/WDmCy5AkXhP1/+CKyYjUSd51lYq4HvNHm+IUnoSc3mSMFEVBiR/1KaQ88WU2/FYUTQWXpqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989919; c=relaxed/simple;
	bh=zHtwbfPKl9esjzv8yZt2knOYFqGTnUuf6NCKuEJj5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNAcpK2FA0ZEJ3W6yRTbE7yfXt8/4di0LhDWp5ZNcKvACSIwI4nnH+DzFM+5pCPtPz9M6ldUMlqNB2y6EZHRfLtzAwryTfUCR/uMK/3LadlpL1NV3VRsUMHrpHHpHQXvz5USBDrw3pgoCto3472eGsb+PIbd1dxwgQYfgrBiv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rZR2KbGP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727989901; x=1728594701; i=quwenruo.btrfs@gmx.com;
	bh=c/lCeAT6hSDYTc+cIPnNyxRQIdQxXMgdm39Hp9rPd68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rZR2KbGP8LuADC5pGU1BFCzTYPV7/5KYeat8p4JmrxE4RKrYdxUz48kejBvnItCE
	 DcwGvPsBphfyMOpoqGtG1lknDB9csSjJV4huZxNUNdYdq5u7rL4/8/9TK7akWFjdt
	 LtmVNaNPSbQtI5XvPTA+G5TPhqXosnXftIOKa4TWHZpwZWJerLB+MnflzOf19jPdT
	 OGW2GJhYfBFasETyATaLXR1bO3RVsk2XWb87LnzBXc8eja+4xgDjBOACdW7BBPu7U
	 iR+I1pX5rYR+yzpVuqoVOJyEgdm8taySqOeFTFwKVohQdMVbxT5Gp/gIxTKNSiSYH
	 gVCqg4PmkWViFnPVVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKu0-1sTxuG3niK-00Y3SI; Thu, 03
 Oct 2024 23:11:41 +0200
Message-ID: <99053f27-621e-449c-9d88-f8f82300cd97@gmx.com>
Date: Fri, 4 Oct 2024 06:41:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Remove unused btrfs_try_tree_write_lock
To: linux@treblig.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 hch@lst.de
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003142727.203981-1-linux@treblig.org>
 <20241003142727.203981-2-linux@treblig.org>
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
In-Reply-To: <20241003142727.203981-2-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MqMdwWvqnbZm9lXwDrcyD2ThATOP4QxDs+xR6yUt0MT+SGmW854
 czVGGFbc5CLn9gL5OToIHvWa4U8D/4keHCD+i3tzYojxEWqXt0br/nfdGL26BPM7paL7+iR
 0gF9eJzBXtA6zRdr0B8yzjLyPLFhwnj1/ufUvirUgs7YmRmmwLqouoEpxxKiym0ChN0c7ls
 kXFywuX7nU5zRgiMZxw4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6QHpx0DvlBY=;9Fn4w0ujUpf2jXBOiXmEWEmfFee
 Xy68yieZ8QryAvnlPazx1OzQrHRQ+6Lhnpi6G+Z0Q0R6rGdtxA3g/ys3ctc39jjgIuJsPSf5C
 Qk54tZX3xYDXKJHFpMue70fM81aHB/3DmNjboIcqfGUfSB+7CI3eJjukWaEGSL4CtCHtnlK0X
 nemYWdsf/Vp4qVdSM0LL66aaKVca5hP/YphaKyAxlZ6noni8GfbPDRjpZxXU2ZBScb5hYSVXX
 oJLTasG7e3bhVbygmgp1RGBL/VAaCTQVygjctQbIpq832z1hQ2jkrVTy+pNov2KL6mDgTE9B4
 pyNsZm4IiK15eJu0pp8rpH1PFf+gdTLEi6jRsPLEQLyHmX23wkizlmVEbp5J4gl35hBcZeWIu
 87LVckUO7Noaqpp3OLv4dsS9HMCn/qMHNVllFKqfS8eK9YgSaNHYQZrFPb7vtVRMsk6mPi9q0
 iKcurlnVrdf9xHxgAnz/6UdppbWzF9tIo2dFaVV5xLkdcsjBQKavP6b4Ydp+QhwsnrywaXrCN
 fYLy5lBaZGz3/88lfQQu4MLwfZozmajpwQMkRFCMn9R+OGfM8VjLvS2CM/q5/U/jTBz5l1iP/
 WELzH302IVjT3wjyKdVPJjS4dDzXA8IjnAlU73TzUCqTnxhHhsB6rfkAZdCWHXM38kbONGAlW
 eLRNOciaCB7W0guDRm8ROJl5Zwqv9HG0hPBpHpdqmRzT1zrbX8cttHRyMAVAeZiGTELfhHe4P
 9cehMdrfLdxVaDNcGkbl71v0ouw7u9t8xl0epc6ckeYCwkLFRm/XxYaYb7E4Pa9euCWbXoPQ7
 PetAKcxh44ag6N0kLe910LPQ==



=E5=9C=A8 2024/10/3 23:57, linux@treblig.org =E5=86=99=E9=81=93:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> btrfs_try_tree_write_lock() is unused since commit
> 50b21d7a066f ("btrfs: submit a writeback bio per extent_buffer")
>
> Remove it (and it's associated trace).
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/locking.c           | 15 ---------------
>   fs/btrfs/locking.h           |  1 -
>   include/trace/events/btrfs.h |  1 -
>   3 files changed, 17 deletions(-)
>
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 6a0b7abb5bd9..9a7a7b723305 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -161,21 +161,6 @@ int btrfs_try_tree_read_lock(struct extent_buffer *=
eb)
>   	return 0;
>   }
>
> -/*
> - * Try-lock for write.
> - *
> - * Return 1 if the rwlock has been taken, 0 otherwise
> - */
> -int btrfs_try_tree_write_lock(struct extent_buffer *eb)
> -{
> -	if (down_write_trylock(&eb->lock)) {
> -		btrfs_set_eb_lock_owner(eb, current->pid);
> -		trace_btrfs_try_tree_write_lock(eb);
> -		return 1;
> -	}
> -	return 0;
> -}
> -
>   /*
>    * Release read lock.
>    */
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index 3c15c75e0582..46c8be2afab1 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -180,7 +180,6 @@ static inline void btrfs_tree_read_lock(struct exten=
t_buffer *eb)
>
>   void btrfs_tree_read_unlock(struct extent_buffer *eb);
>   int btrfs_try_tree_read_lock(struct extent_buffer *eb);
> -int btrfs_try_tree_write_lock(struct extent_buffer *eb);
>   struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
>   struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *roo=
t);
>   struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root =
*root);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index bf60ad50011e..9b8d41a00234 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2341,7 +2341,6 @@ DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock_blo=
cking);
>   DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_read);
>   DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_write);
>   DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_read_lock);
> -DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_write_lock);
>   DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_lock_atomic);
>
>   DECLARE_EVENT_CLASS(btrfs__space_info_update,



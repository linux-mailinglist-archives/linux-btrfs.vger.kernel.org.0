Return-Path: <linux-btrfs+bounces-9194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67E9B3C5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 21:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09527B21ABB
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4E1E0488;
	Mon, 28 Oct 2024 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rLRjn6v4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49C18FDC2
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148947; cv=none; b=b0NAKZpoHYt8snWs5IPihIeIV0z3t/ahNzZV5k/1JvLPLzIccOBG+QhTVaX8UexkdQDYuQg5PlE8B9PDHwGmZV65AOUzbz2rrIgu09OBmlgTai5SVW5X9q/zzFPBT3zN9wgXrPoAOqH46G7jwGWiiXVyGHT2IWX87SiYjkjrdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148947; c=relaxed/simple;
	bh=S0+9xV/5lMsiIHUqfsjZXK5eJACMzE4yd41WT0b92uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P2WQ9L+hvv3CkB+CPIWwnvzQQXqKF829BiRvVNjhH7GLJZEeUQmrxI5gBzKeBNVsY57kW+A6uxORqJ2q8neUxYQbtk/k5aVfh9MnIE4brkv87H2b0zGamKWPA/tB2kRwv/zqzUdjdqAeQPruJP6Rn6yq5iOg7c4o82k1wCP95lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rLRjn6v4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730148938; x=1730753738; i=quwenruo.btrfs@gmx.com;
	bh=6hth7pSS4j7Fk+/8OnHIybCyZRg0tzmy66m1kL6gZEo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rLRjn6v46wc51eWogNcwNNbH0372w0Z9ZZYHSoyunbmPcGIEyAPRMLMDlqez6i3Z
	 bS3L/aqVg215Tw4Ro2FllK2imtbqOzvd68FE5jRcD6uRKXHMWVWYWNbcQpoNe1KDu
	 1rOMH022A0T4ySJg5oVAw3doFkinCU0PkKa8FK+XR2H3I9u3GEK0YmsDvtSsYpWHJ
	 cqPGCA7kI/rNYbA7lG3CLte6fxI/Af/hJ3kXDxAGKZr+gUZ1/W68fR51Ffn/Qqklp
	 hFc7HJ0IqeltYhBfc3gYTXJTNhttSAdWTuOqsDiTrMt2tZ2B6G1I+smrIVeNfbm07
	 HGzXnErbDbWnhnqDXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1t9bOF1EX3-0006WE; Mon, 28
 Oct 2024 21:55:38 +0100
Message-ID: <256a805f-c6cc-46d4-a024-92ddb1c7fe36@gmx.com>
Date: Tue, 29 Oct 2024 07:25:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1729784712.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SYOLQChpx2o7NBNZo6AzKJ2QPfC+e2vD2atu2b20p375BgcOcB/
 4C1BMAfm2qA6+bfATyXBG+fB3xhJmcxqNf3yqizDyLoYU/kb3lSTU+TSmh4bYfUMUSLN6nl
 kJp3Tjto9zN5ZhQXB0uUglTqvX25SY4otidrDTT0pHTkyNBZhRHcAuWRLTnspIcWsL0OSLe
 /0yduBpRuX5T++Dj0oWSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jzxe4eRXZEQ=;bDIo3nopipJy8ew6PUXXbVSQhd7
 YblNgFhK9peOK7mVzOvP7qJ1nzTHKRTUE9Du1q+GDmGP5Hd1NjRjl8Z92Mu9wdYiRMNVkVdpJ
 bkBTe9SRrVdP/sMnRH3HOBOC3WAXHN/gDRTEgFzzXOkZZ0W0DZvIPY7lTPDsWhpAKenbPTmLG
 8ym+CdR8VZZjdQ6JWhTv+ZEB2hTK7ssVjhH7H+5EO7jO0Mrm6yX3ZZf02Z6futQ80rBU3RfpT
 ifQhYsSiF3AWGWG9FnsbvUAu8hI/4VaCiRPL9GgDDUYPqMLAIXACbkcx44bDRVOfbJaeGHvx8
 8jdCWi2kUXBYoHboR2WsFFG8o18etLCfSefMdLDgDapUZojwZNAl6HF/5IUzW8vW6Ys+omjdM
 hzHA/+ckeHVQKJ+OhV91x8/WmCprp5zfCkKy3osDygqYihANAKLEwvTyJiKlTBWnZY1yytIJh
 EOyfwLpP9y0bDkssZss6iyHob/sXVDrOhFZvW7AlIXTifU+6DW8bOzVOER/aQNSTCH6H+yOgJ
 Ug6xqAjTlgmq1SRq4Euln5ipRbiw4RwdFCzHlE7i7KM9xYogYTnVmkrOIyhEnwr4Lip2Irp94
 pbgJ7/vZ/NflnKdEqsQM0N5UC8ANlxtQRXGwxv/hGCFzq02vv46TwKafX71M5IGrN/W3gGfX4
 jcvzSssJuN/Vc66J+HNvLabr+8dIVEV7bCeJi2wpEf8VzAFR5vv2+cFVX7MzL56DKX0Vyb/w9
 2IJWANYykThqcQA7adx6ATRBsI4ZD1L5CTLHbxVPjxIeB5qFP12+RirqxndUtCtUAatwyPNUC
 whugLv+qD3buyEFOwbe7yp0g==



=E5=9C=A8 2024/10/25 02:54, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> This converts the rb-tree that tracks delayed ref heads into an xarray,
> reducing memory used by delayed ref heads and making it more efficient
> to add/remove/find delayed ref heads. The rest are mostly cleanups and
> refactorings, removing some dead code, deduplicating code, move code
> around, etc. More details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Filipe Manana (18):
>    btrfs: remove BUG_ON() at btrfs_destroy_delayed_refs()
>    btrfs: move btrfs_destroy_delayed_refs() to delayed-ref.c
>    btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
>    btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
>    btrfs: remove duplicated code to drop delayed ref during transaction =
abort
>    btrfs: use helper to find first ref head at btrfs_destroy_delayed_ref=
s()
>    btrfs: remove num_entries atomic counter from delayed ref root
>    btrfs: change return type of btrfs_delayed_ref_lock() to boolean
>    btrfs: simplify obtaining a delayed ref head
>    btrfs: move delayed ref head unselection to delayed-ref.c
>    btrfs: pass fs_info to functions that search for delayed ref heads
>    btrfs: pass fs_info to btrfs_cleanup_ref_head_accounting
>    btrfs: assert delayed refs lock is held at find_ref_head()
>    btrfs: assert delayed refs lock is held at find_first_ref_head()
>    btrfs: assert delayed refs lock is held at add_delayed_ref_head()
>    btrfs: add comments regarding locking to struct btrfs_delayed_ref_roo=
t
>    btrfs: track delayed ref heads in an xarray
>    btrfs: remove no longer used delayed ref head search functionality
>
>   fs/btrfs/backref.c     |   3 +-
>   fs/btrfs/delayed-ref.c | 319 +++++++++++++++++++++++++----------------
>   fs/btrfs/delayed-ref.h |  61 +++++---
>   fs/btrfs/disk-io.c     |  79 +---------
>   fs/btrfs/disk-io.h     |   3 +-
>   fs/btrfs/extent-tree.c |  69 ++-------
>   fs/btrfs/transaction.c |   8 +-
>   7 files changed, 256 insertions(+), 286 deletions(-)
>



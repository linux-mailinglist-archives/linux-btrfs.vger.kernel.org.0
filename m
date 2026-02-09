Return-Path: <linux-btrfs+bounces-21530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKaSCnCriWmXAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21530-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:40:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A910DA88
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9456D3005333
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4A5363C5F;
	Mon,  9 Feb 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfjwqJil"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3753446CD
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629986; cv=none; b=EZqjXWT31D4IQJU8j8p61obrfKjcTH7lpzoJVmZUuo1a3B3IU/z5hQvwK3+vpFs0+nBmvPLIbRoAOG/RKwVLr8HL0g38I09wb9L/ZfUzG8zlmWssYxVSpMZIMZBbwaXVUQODGUHkBTW70j8T/L6xxExfGJN3e4CEvmgPbhMkDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629986; c=relaxed/simple;
	bh=8ASy2kxXd1rMcs4guiltnL36JGgHsbkwXteT2WFDyOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNwqNWXOzq5CrFsU+fG4zaDQ+vKTCNjbIaY0E7ePi2Cd2v2fhjKvdDfqfBla6NV5VKdD9NEJxELK/5mnuIXtvkHrkaOHI1p3SupOcVk/q9HGMvrl8eYQ831+NbMqL1c0ERzlWE+j3bJsRLsH+FI5BbfYuoQLotVWh4axns0KYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfjwqJil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA2C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629985;
	bh=8ASy2kxXd1rMcs4guiltnL36JGgHsbkwXteT2WFDyOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XfjwqJilqzKeio1Rsq7zaDp4wdtmwb3C5hIQhPCXZcILPGUGs8jhOW4jnBf47Sr0d
	 yRWGNhQFG2yBbsJ7sPuJq2NU4QBKLI12SDiqb7o/P3KsJrMiSeFxV85s9ra7M20ISG
	 11mspfOwg2FQOM5435BCgt8D/X7+6WSPmnQiI19uAAF12nVK7i7zZdHZBcBKjSfgS0
	 +88bge+TZc9nTkQ/vbLs9Q1nuBR7W0ms8vz2WWm6qnQzK/JiaZd+KqAqt/0NJIVPY+
	 OkI6mSb1wyiNizLSiCXUjJJKxvemrvxZNS8E99Z3nRUw27dCyrxd+jyMqV0vzz4LUB
	 BfPNpHpyV5UdQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885e8c6700so705984466b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:39:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxDh4j3b3cU6j7t4fKFqGqtjJzYKfynvGUyYb0rQsCAbu0A8622
	u1kiAag8W2IXTMK+R+cjqKgkhfmZp+zUA2wqKuC+ELAyNfUifeijU8ov2xFqmXcNwFqxEdKz8FE
	vzlyelPqSUsl1N4uw3Z8DpVDVo5UOuzE=
X-Received: by 2002:a17:907:9706:b0:b76:63b8:7394 with SMTP id
 a640c23a62f3a-b8edf376df1mr605455466b.51.1770629984206; Mon, 09 Feb 2026
 01:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205114546.210418-1-dsterba@suse.com>
In-Reply-To: <20260205114546.210418-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:39:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4pLHd6oKKShm_3OvTHN1jJ8g8HHxQwKYkDZ1ShQqeMbQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh4EdLFJJHHttPbVjnGD3zrgrhln6WU46kDzN8lGo1xAUwpvQIiaVSdTL8
Message-ID: <CAL3q7H4pLHd6oKKShm_3OvTHN1jJ8g8HHxQwKYkDZ1ShQqeMbQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: sink RCU protection to _btrfs_printk()
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21530-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 957A910DA88
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:45=E2=80=AFAM David Sterba <dsterba@suse.com> wro=
te:
>
> Since commit 0e26727a731adf ("btrfs: switch all message helpers to be
> RCU safe") the RCU protection is applied to all printk helpers,
> explicitly in the wrapping macros. This inlines the code around each
> message call but this is in no way a hot path so the RCU protection can
> be sunk further to _btrfs_printk().
>
> This change saves about 10K of btrfs.ko size on x86_64 release config:
>
>    text    data     bss     dec     hex filename
> 1722927  148328   15560 1886815  1cca5f pre/btrfs.ko
> 1712221  148760   15560 1876541  1ca23d post/btrfs.ko
>
> DELTA: -10706
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/messages.c | 4 ++++
>  fs/btrfs/messages.h | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 6190777924bff5..49774980bab6c9 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c
> @@ -219,6 +219,8 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_inf=
o, unsigned int level, cons
>         const char *type =3D logtypes[level];
>         struct ratelimit_state *ratelimit =3D &printk_limits[level];
>
> +       rcu_read_lock();
> +
>  #ifdef CONFIG_PRINTK_INDEX
>         printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
>  #endif
> @@ -241,6 +243,8 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_inf=
o, unsigned int level, cons
>         }
>
>         va_end(args);
> +
> +       rcu_read_unlock();
>  }
>  #endif
>
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 943e53980945ea..73a44f464664c5 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -85,9 +85,7 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info,=
 unsigned int level, cons
>
>  #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)      \
>  do {                                                           \
> -       rcu_read_lock();                                        \
>         _btrfs_printk(fs_info, level, fmt, ##args);             \
> -       rcu_read_unlock();                                      \
>  } while (0)

There's no longer any need for the do while, so it could now be simply:

 #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)
_btrfs_printk(fs_info, level, fmt, ##args)

Otherwise, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


>
>  #define btrfs_printk_rl_in_rcu(fs_info, level, fmt, args...)   \
> @@ -96,10 +94,8 @@ do {                                                  =
       \
>                 DEFAULT_RATELIMIT_INTERVAL,                     \
>                 DEFAULT_RATELIMIT_BURST);                       \
>                                                                 \
> -       rcu_read_lock();                                        \
>         if (__ratelimit(&_rs))                                  \
>                 _btrfs_printk(fs_info, level, fmt, ##args);     \
> -       rcu_read_unlock();                                      \
>  } while (0)
>
>  #endif
> --
> 2.51.1
>
>


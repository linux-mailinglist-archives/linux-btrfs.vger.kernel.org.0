Return-Path: <linux-btrfs+bounces-20772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J9iI7w/cGnXXAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20772-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 03:53:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC4500F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22D9F687D9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C64279F7;
	Tue, 20 Jan 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOJtztTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120E42315C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915455; cv=pass; b=tZV4iJBCQI21tRYBQzbMF0ODHWltoOPDCcITlY9AIEonC3NXXVoXjWMyFh9WhAn6XPKbeH/MCjTMm2H5a4ialc/Y86CEUSjdXmGIysBILE4EKLfzztvHTnYF68/kdUnbbWFgC4AMNpZ+XwHY36QOnWvjiuKuAsW7BNQtHqM9KXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915455; c=relaxed/simple;
	bh=itMdVy0gNPDSdBGhSb79moNyRf8m4SyP4M0XjHTHzAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rafM717hqeuLFCdZ2KZ+4n0EE4B80uG0CYG+IBucIIRm408EA2GMez+RmFC1uDelTKtxtpfBM26X9Ifzg6UfF4Bc6L7ZOH4LRBqSZ5e1jHQAevlBl8yDscV6N3tw5p+zXmPG0RS4bb0fKtmqVOAFV0DbiLy6ObCYsGoc9oQ8xBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOJtztTR; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b834e3d64so7754454e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 05:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768915451; cv=none;
        d=google.com; s=arc-20240605;
        b=GX4mk/Roi5TUOr5C/5h15uKa9IZgcxnUCNbmygPYYrbZBD6J8B4VdPLOOWHYIU2p7D
         /dTvUWKBKK6aRXMcsH4j6Le68md8gpJTirIb0aP2ZB9jrh5lRgJjS2yKL6egzGddlpyI
         +cg19unp2g9JaFLSqE+ghp03GctdLQZefeDgXl7blfoAeb+TPP87Twh5dU7I392HZy7k
         HJwEQRwiTCztzuXofZm42jYwwnnTwnJX2kOYfno7ULKnXG3nbCaXhfEP0MEfgRVtnxtV
         RNRH7SfKHOey0SKQecD0kAQhnWLe1t7SxSZkUpWywn1weODJueJQrnQlAMgQnOO+X5WU
         lgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qon3QWP0YlpGboD0Jx05dQkqRedhmIXPl5+5SEEa1A=;
        fh=XgyVQL63bakpFfKqPxJJiY5NdZTbMYsxaBXyIXgyd7w=;
        b=YpUOexU7csOyuyPGEvxZbeFv3ieDQpUmV2MvWnCScABMve+HvPhn+ROsXSkusSAYqd
         IQ74J0v+pNoImatNpUHm1RmaBzQ9x+bugEWmr6rmqbR+ZVGTKGTL7u37N24D5qpoEsnv
         NfRA8eGyqBz6Fe910uR0Gnpz99K0Wu7qasHFmDlebMt8Hd3XW14pMv46HgIQqJjwTYS5
         5AwFMvJAdYsA7BsUBIcSDbbrDKv1p6sq4I+RSrduXDT88wP8Rv5r/lT5qlZJzVIEoEFX
         O2b/HkEL5mFHYLAocKC4u7pXTAiV8XWt2QGzAvS0NCK51GXgv+uFFymK9g+TgPJ499ng
         bKjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768915451; x=1769520251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qon3QWP0YlpGboD0Jx05dQkqRedhmIXPl5+5SEEa1A=;
        b=gOJtztTRw+loDE05dlLyWR4OUIvQtOJ6ghrK3T6qZdd60ymUPDgI0ZNkeQ46Rq5CaI
         VVyh/V4C8jX7kefbwUuc22a1vopmzS5tEapNmGx7sHRZXRn55IgEoJKzExjlQUiidmPV
         156sHYw5gzQpCRPqDWHW6oNLrv+nzBgQm+NvJ1hW9EEApaSj8HgmLlsLLhcks71bzdIH
         bOBqM7zH7iOEHHAjVFAnzXd2ndYU4V/NtT0OiB6Lv+sznpUUSk59f9Sye3811H4OuXQz
         hPPGLnAqCNHJ7fn4UZ6Qzw8NgDpkLy384Xqnom/V8NymcaDEk9r9vWT5BhpWXMMIwmLv
         XNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768915451; x=1769520251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/qon3QWP0YlpGboD0Jx05dQkqRedhmIXPl5+5SEEa1A=;
        b=XesMMmbixFcvQGlIbGwFunaHKisOgabISYd7Qu5pL6k+NpCBcGEMeRTpOAbS9bov6b
         F4gO5BmrMTP5VqKoA2SWyv5jDyNoAQbhRvL7yc3UYuCwsZFcsTdR9Hm0OouCeu8juSnd
         At94ZGGvAUjqjyQ7SP+rwSkdq7GYKLAxKpDuhh3HPUdMdb1lfHrdb5xNtgRrMDpjr3GR
         WDS9yPc9CDQHc1AhK2sjkMMmQy4egxqWqkvtxnGDDA3A/M/I4bTN/gqNgtHI2ID0YwFL
         GaIyPY+4x5FsAUIui2eIkX03NEYtjTE2eQn2/7mZdjQ9/vcALLGN6gtpA/8rdysKeHwj
         FvhQ==
X-Gm-Message-State: AOJu0YwXl1S6ZI8d28t4VJk5i+FzWaLHt0eBTEbuYvsKMjnBz2i1Wjpy
	29GkxsJYwI3CQmKoiq/H3E/rdBetMlIYbNM9kMCM967sd5ayzzqGqco9ryaloAl6YclfxPI8woq
	q4nyWOalbpVInxBmtYOrQjBTW8uCsM6x8lwysHqI4Gd4Ykh4/9UCx
X-Gm-Gg: AZuq6aLWinVPDnWXHHaOBqAMo5o/ruJUnFnmOrJwV8i9LNjbthbZrASneLe7aWxM500
	+t20YtkBvWb7GbOUwDo9VRFc9pyP6dYkhgMBcvJw43OxuTATQeSjWyQ3AMm/E9lnPGVg7cSzzc6
	iGfP8r+fTZpuyn/h4fvL1bFnP1h92bqCDY7j2NeAngiN/AJ6rTKPTlgftzGQLXASlfPrQKgZLGo
	u78YKZNZJ+6Wfc12mwwXcGheDTkm5B0X0PRRxoZZ/U6XhNpyu79G6YKMsKTOVkMe98HuIeGQXO4
	yh6O6bwnKvbk+ZOW8A9/2Bc764b0
X-Received: by 2002:a05:6512:238f:b0:59c:bf32:26ef with SMTP id
 2adb3069b0e04-59cbf32275cmr2643701e87.6.1768915451221; Tue, 20 Jan 2026
 05:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120081946.139598-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260120081946.139598-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@suse.com>
Date: Tue, 20 Jan 2026 13:23:59 +0000
X-Gm-Features: AZwV_Qjq2bRp8Xo5zpBN12i076oyEZimhRxoxxNJ26BNoRDiCVXCUvXSvgyN7m4
Message-ID: <CAKisOQGHsbFvELePt8HgkXaqOAnFz01LXkY49Y48yJMnR4QZfQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't pass io_ctl to __btrfs_write_out_cache
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20772-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,wdc.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 55AC4500F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:19=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> There's no need to pass both the block_group and block_group::io_ctl to
> __btrfs_write_out_cache().
>
> Remove passing io_ctl to __btrfs_write_out_cache() and dereference it
> inside __btrfs_write_out_cache().
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/free-space-cache.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 20aa9ebe8a6c..adb972c6c728 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -1371,9 +1371,9 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *=
trans,
>  static int __btrfs_write_out_cache(struct inode *inode,
>                                    struct btrfs_free_space_ctl *ctl,
>                                    struct btrfs_block_group *block_group,
> -                                  struct btrfs_io_ctl *io_ctl,
>                                    struct btrfs_trans_handle *trans)
>  {
> +       struct btrfs_io_ctl *io_ctl =3D &block_group->io_ctl;
>         struct extent_state *cached_state =3D NULL;
>         LIST_HEAD(bitmap_list);
>         int entries =3D 0;
> @@ -1533,8 +1533,7 @@ int btrfs_write_out_cache(struct btrfs_trans_handle=
 *trans,
>         if (IS_ERR(inode))
>                 return 0;
>
> -       ret =3D __btrfs_write_out_cache(inode, ctl, block_group,
> -                                     &block_group->io_ctl, trans);
> +       ret =3D __btrfs_write_out_cache(inode, ctl, block_group, trans);
>         if (ret) {
>                 btrfs_debug(fs_info,
>           "failed to write free space cache for block group %llu error %d=
",
> --
> 2.52.0
>


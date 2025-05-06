Return-Path: <linux-btrfs+bounces-13735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F4AAACBC2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1F41C4533B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD02283CBF;
	Tue,  6 May 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g5VJ8E58"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AB22D790
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550737; cv=none; b=qzEnghEfvHGj9UbZQGy//zhlRw/fCkR4hzhKKZ6bvh1K9pLaZVYxohA3iP9D1k4b8/YThkRA91xL9gptWRHHT9dwrFKFosoS/RqBNhfkOAuAHA/N3KxWT+n++z0uLYRgJX1Lc+Vut2a0NAyXDRhHgLFKlxbIKE6UIDGlsyLXKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550737; c=relaxed/simple;
	bh=jVB2jxgVsCReO63gxZ3uktyX66QrpVkmkYrXvyvyg1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTumYyGSv9JQ0bj8iICVkvmN9GZD46GnL/bKjMtKQZVSG04TOu8u/jAgckE0uILHHMh7BWStU92CpVDKRgUIuTmfU771/I4eFiCII+s5KBLz6WjDxLPsmkRodSPm2eIBOpiPmVzpNqPsXug2IiM285rCQwF3cjpcqAgbHLnOYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g5VJ8E58; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso11156018a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746550733; x=1747155533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7hUHs2kNldnsoytx2aGjhYtJCBH6cEuTdx9zinRLw14=;
        b=g5VJ8E58UBGN5a2dCHYOlS1yZiFxi44bZXI35S+qQkv3yxTts5zN6aWxne1iAXAt+c
         CCL91fTW41+zrLrfWeHTJ3CMf9UFTzAwZ0951WKajHaxb03T7RVlWNsZAcGeFADSJLl2
         3RD3mFwEQ3JdL/sLehTNgwEFaXH6A3UjHsUDwwc7kH1kwAtQZFUf0SntkuX+cwunrfS5
         l+pRIWnlY2RN0PF0rxkI3GW6yOGjzD8G9SGlKprJcPZuuIryFn+MMn8DHZMh2Le7zQDs
         IxSy5QJAcQ4a7wqo8wy1hC4OBVq6RpM/KXKkstpLDUorR0y3uMVLdAw/S3pxQu9hTO9r
         u87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550733; x=1747155533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hUHs2kNldnsoytx2aGjhYtJCBH6cEuTdx9zinRLw14=;
        b=d/sd/5sWUH+MwZ51nvnqloUY+ndzYq6P5EhwkdKZTJtynt7vepSSOV1ejy8MEi8pbb
         X1Js0GodEzNIPjpWartSUtEnDZ7YB9cKyqwoJ68O0xfZGsKHOaYieDr9xfiojU7XfEV9
         6OhMnG/47LuboIzh4Iq5GECgwxFNAOY4LE2uNrq2abfhokgB4R3tOE2GtqOSHVwOfHL9
         0gkKYXnS0EA8lXd6re8D18Ll09GiLrEhlv7YAm4sC6zlM+x9DD7TBa9X9Wkk/xgX0Vkv
         cufMUTgAilC1NcoMH9sdpFIzhqK9j4x3Rll6phPXbnESYWsH57ApWo4xiuThkR12D6kf
         kGKg==
X-Gm-Message-State: AOJu0Yz5hxkSaMzfxarKhYiUWhkVSpvti9i1diS1brRaRi90PmxF8msN
	dV1jH09Cxu6Tpmn5sW6Gaq6fxs4gjj5G82N8Tx8Zg5GhJMXuyihpTPuaQrGfQsJEP6c9BRXi6zZ
	KZOxTcxov3Zc+vKi4IrirrNZ/lwpPd0SoO25lXw==
X-Gm-Gg: ASbGncss9GbK0MaSqtVbanR+OmIYEoKDrNHtaTmZLDAgyjsSN5i0NVHpfkKeS2ab0GA
	Hv2VJyDZS/JAg4x2N9ziCv8rWcGRQ35nketFeta7nCgV1eX3gTmq5Nl9GCS/AtH6HPUtwT17F3Y
	QC72yNdtTCQsd9Nq7MKjTk
X-Google-Smtp-Source: AGHT+IHUJZc2h5tOSUz9GzvaQ0LlFP74ssnWTf+xb6f//EX2yzAdqSqrZgrvrifpnjrZV00ckjaN/c98ETJlLLpvuVg=
X-Received: by 2002:a17:907:7e82:b0:ace:c225:c723 with SMTP id
 a640c23a62f3a-ad1e8b92275mr23925866b.12.1746550733544; Tue, 06 May 2025
 09:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746460035.git.fdmanana@suse.com> <28f059e4718c988385c0d330c5c4663e253b60b0.1746460035.git.fdmanana@suse.com>
In-Reply-To: <28f059e4718c988385c0d330c5c4663e253b60b0.1746460035.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 6 May 2025 18:58:41 +0200
X-Gm-Features: ATxdqUHdgO_dZK6TS5AOrXSvhR-qzqyxnmzXrBS0HYRGU2AY4dA2bz6vR8QxJqg
Message-ID: <CAPjX3FdfQdfTQ=73BAynOPgCmthPea53B2e0fSX=8bJFrBQMiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: use verbose assert at peek_discard_list()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 17:50, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We now have a verbose variant of ASSERT() so that we can print the value
> of the block group's discard_index. So use it for better problem analysis
> in case the assertion is triggered.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/discard.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index de23c4b3515e..89fe85778115 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -256,7 +256,9 @@ static struct btrfs_block_group *peek_discard_list(
>                                  * the discard lists.
>                                  */
>                                 ASSERT(block_group->discard_index !=
> -                                      BTRFS_DISCARD_INDEX_UNUSED);
> +                                      BTRFS_DISCARD_INDEX_UNUSED,
> +                                      "discard_index=%d",
> +                                      block_group->discard_index);
>                         } else {
>                                 list_del_init(&block_group->discard_list);
>                                 btrfs_put_block_group(block_group);
> --
> 2.47.2
>
>


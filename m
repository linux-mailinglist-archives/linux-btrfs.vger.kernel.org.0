Return-Path: <linux-btrfs+bounces-21606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ALqGwspi2n1QQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21606-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:48:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DE11AFC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27563034DE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76500318B93;
	Tue, 10 Feb 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe77g47f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C0145A05
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727682; cv=none; b=XLSbw73UglMgmFT1a0kFjOprqOoqFCDaO/9xzv1vpwZ08nB/XuM+3MsF45qSqfQC/DQpdThnMRUh1RVMMT1LTUYpbLwhsQfrPnz1QW7xLNyWWiPPUesWCWerzsMmn9SMzuipZgFLPzvVcYMxgcEqZ0Pj1iH/3uEu+l8k7qYtz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727682; c=relaxed/simple;
	bh=8JopNUqiCvjf4RJ0UivVKWkaSe4+4Rn9gi/oczn5UzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD+587SkI4jBOolJsLrFJcOO4ONYiOqXnykHg5igW92BqxlQM/GwgIEd8Di57LKLoq925inlEjFdx41/Ksq86ZsId333FX3EGA7Bj8ucBGvproEaZXa3evUTDhpc5A3BgQxSe6UIJMJVIh/zU2dxBm5kcU/SK2/XPq37R0S/GvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe77g47f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2FBC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770727682;
	bh=8JopNUqiCvjf4RJ0UivVKWkaSe4+4Rn9gi/oczn5UzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qe77g47fK0haypDjochC3DTJWSBvjMMQ6Lc69Rjpiph6Xw+izoRd9eiEjjHSVAMUs
	 iqte9ImcUT1Bu4A10oqk7Lq9Vy8pO+s4hJQ1nxws1TsmOvwHP64Z5B4PLFq+pm/p1t
	 VoKnOIif8PyNVK2o/jNzBkjcKyB+7gNcMsTAUkKI+Sbx9Sm2SONwACJqx8RbazfnRF
	 TFFn6lctB8KkfKl4m5CXbjmo5iKuFcezA0kYsLvQYqs1OWw4QUA9QWS9+rkRxTUT+0
	 /Z54OtC//KOl/XhALSpFdTyTmtq4rbk2lJd3QLAXA7U5qC3x3C8XaNIBejIzs1nNeQ
	 F8ak9Z3onerqw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so146205166b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 04:48:02 -0800 (PST)
X-Gm-Message-State: AOJu0Yz/1ADVE+bwOPUzkq9oaNqNL7l+jg7PLZQ7GRpy5eeuGm3vSklR
	dXyDJDjJhaHdEwsEzRgIGyIfdkzyzcZqlvj8Ktg4jK3zoPtGHthSPqEWuae1g3XM9IKbyQCeW6T
	2ceyzEDhmZ5r4Jn2OFA2S8PUW4rIEeXw=
X-Received: by 2002:a17:907:1c8e:b0:b8e:a024:1c81 with SMTP id
 a640c23a62f3a-b8edf176c31mr803745166b.7.1770727681027; Tue, 10 Feb 2026
 04:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770693583.git.wqu@suse.com>
In-Reply-To: <cover.1770693583.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 12:47:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H64p=4TAsocvUPz=r_EjttF0cS3xt3SDR4sJUTYXOZ46Q@mail.gmail.com>
X-Gm-Features: AZwV_QjpJC1JwCRDSlg1PKNa3JiITrzNi-tQhe0BAqec8PprGlUgpkxKH0nux2k
Message-ID: <CAL3q7H64p=4TAsocvUPz=r_EjttF0cS3xt3SDR4sJUTYXOZ46Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: ordered extent csum list related cleanup
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21606-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C87DE11AFC2
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 3:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Trivial changes, please refer to the commit message of each patch.
>
> Qu Wenruo (3):
>   btrfs: rename btrfs_ordered_extent::list to csum_list
>   btrfs: make add_pending_csums() to take an ordered extent as parameter
>   btrfs: rename btrfs_csum_file_blocks() to btrfs_insert_data_csums()

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

>
>  fs/btrfs/file-item.c    |  6 +++---
>  fs/btrfs/file-item.h    |  6 +++---
>  fs/btrfs/inode.c        | 18 ++++++++++--------
>  fs/btrfs/ordered-data.c | 10 +++++-----
>  fs/btrfs/ordered-data.h |  2 +-
>  fs/btrfs/tree-log.c     |  8 ++++----
>  fs/btrfs/zoned.c        |  7 +++----
>  7 files changed, 29 insertions(+), 28 deletions(-)
>
> --
> 2.52.0
>
>


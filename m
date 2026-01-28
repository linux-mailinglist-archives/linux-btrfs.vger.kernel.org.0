Return-Path: <linux-btrfs+bounces-21185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKQpAGY+emlB4wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21185-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 17:50:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E6A6337
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 717F5301DC2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078530C60D;
	Wed, 28 Jan 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWSzclhy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF432F25EF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619019; cv=none; b=jDcxQu3npaOflhs4toCDy9HRue2HV0Jc8F59Nb9uyNKCa3MFLirU4zxPuX8GHnkKP/EWsaxvLkcZtldqQZRqFjj59y300zDVNqp0pRpVWxLOk3bm6jBXzin+4kQDCkUijres1fE2ZdCB/kHCaDBHGyME7tLrxTDhx1nHSUX74rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619019; c=relaxed/simple;
	bh=mCXYdIe8zzrINeffKvBB7reMsR5sNZEgGtGCqLtX5aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCBDmRFFN4WuSxtvbqBEdcQXfsX86QM6jNq9LpYdCmGUy32RCeZWzii4vJ59AgmDoKm6jkZgWZuA9Nt4cpn7eTPnpkkFtdkm8bH8o7wdK5AVhEXAFgfciC4waU4pFJG6sla51HkCAUCUfd3U8b2NcgBhuRAtEkvQ2rAiLeRtRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWSzclhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBE7C16AAE
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619018;
	bh=mCXYdIe8zzrINeffKvBB7reMsR5sNZEgGtGCqLtX5aM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eWSzclhytmQanz/LBiiInBtQRE9862ElSOXls4n5EC2boZBo1e4dytzdxvLEMBFGY
	 W7h4o3gCihCPu5q9A25f9I+4jgDWRUNPeIuXpZPduKL9xmPZsxTZGHZza18ro3Ubub
	 nWiRwOVFTwAdjiO7udixWFYVoxPBxHJWlOU5HbcWhwtq0ENqU1gZTGCZebdLqhotej
	 RqKMsA31iG5hkNLesntLGL6sdT/o5k1UQhlx3V3UEhd9RvmJFLrtdawXsDQhN7muZW
	 3MC6zYVpT6aSyqW+TTsPA4LJXhRYZCB7kv4PuyLVPBipXBL4lK1GCC9ceI7ENWClzg
	 EHTgO4kyYhuuQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b884a84e622so7429866b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:50:18 -0800 (PST)
X-Gm-Message-State: AOJu0YwK90ASj9J6ME5c50viQgydFpI/A8xiHsPb7X70HBsuz9PDHTJ3
	sBXTpDBClEtKQVk0mNdROazBu2uOgJjavyXz3YqMiUe+VSlEltSzNhAOI9XhxulFJwrXclbytvU
	YK6dJ+ro5EwpQ+BoKHn9T6b5HFbUzwtE=
X-Received: by 2002:a17:907:7207:b0:b73:a2ce:540f with SMTP id
 a640c23a62f3a-b8dab2da697mr389039266b.17.1769619017257; Wed, 28 Jan 2026
 08:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128070641.826722-1-jinbaohong@synology.com>
In-Reply-To: <20260128070641.826722-1-jinbaohong@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 28 Jan 2026 16:49:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4LWBzFygciC9QBjszRqrHbpeQ54HCdZD2DhpoigW2_Ww@mail.gmail.com>
X-Gm-Features: AZwV_Qg7-Oi2NfMeqq4uywi8oPsK9ObMi_SSXNoRCOimAQffMZnOPgYx2_xQsd0
Message-ID: <CAL3q7H4LWBzFygciC9QBjszRqrHbpeQ54HCdZD2DhpoigW2_Ww@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] btrfs: fix transaction commit blocking during trim
 of unallocated space
To: jinbaohong <jinbaohong@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21185-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,synology.com:email]
X-Rspamd-Queue-Id: 6D7E6A6337
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 7:06=E2=80=AFAM jinbaohong <jinbaohong@synology.com=
> wrote:
>
> When trimming unallocated space, btrfs_trim_fs() holds device_list_mutex
> for the entire duration while iterating through all devices. On large
> filesystems with significant unallocated space, this operation can take
> minutes to hours.
>
> This causes a problem because btrfs_run_dev_stats(), called during
> transaction commit, also requires device_list_mutex. While trim is
> running, all transaction commits are blocked waiting for the mutex.
>
> This series fixes the mutex blocking issue by refactoring
> btrfs_trim_free_extents() to process devices in bounded chunks and
> release device_list_mutex between chunks.
>
> Additionally, this series includes related fixes and improvements to
> error handling in btrfs_trim_fs():
> - Fix a bug where device failure stops the entire trim instead of
>   continuing to remaining devices
> - Preserve the first error rather than the last, as it's typically more
>   useful for debugging
> - Handle user interrupts (-ERESTARTSYS/-EINTR) properly by returning
>   immediately without counting them as device failures
>
> Patches:
>   1. Fix the break vs continue bug in device trimming loop
>   2. Preserve first error instead of last error
>   3. Handle user interrupts properly
>   4. Refactor to release device_list_mutex periodically during trim
>
> Changes since v3:
> - Split patch 1 into three separate patches (patches 1-3) for easier
>   review:
>   - Patch 1: The minimal bug fix (break -> continue)
>   - Patch 2: Preserve first error behavior
>   - Patch 3: Proper user interrupt handling
> - Fix patch 4 to preserve first error (consistent with patch 2) instead
>   of overwriting with last error
>
> Changes since v2:
> - Set dev_ret properly on user interrupt so callers get proper
> notification
> - Convert -EINTR from mutex operations to -ERESTARTSYS for consistent
> handling
> - Restructure btrfs_trim_free_extents() for better code clarity
>
> Changes since v1:
> - Add #define BTRFS_MAX_TRIM_LENGTH; remove maxlen parameter
> - Move loop-scoped variables into proper scope
> - Fix comment formatting per style guidelines
> - Replace goto with direct return statements
>
> jinbaohong (4):
>   btrfs: continue trimming remaining devices on failure
>   btrfs: preserve first error in btrfs_trim_fs
>   btrfs: handle user interrupt properly in btrfs_trim_fs
>   btrfs: fix transaction commit blocking during trim of unallocated
>     space

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I pushed these to the for-next branch on github.
I updated patch 2 to replace "last" with "first" in the comment above
btrfs_trim_fs(), as Qu pointed out, and fixed a couple odd
indentations in patch 4.

Thanks.

>
>  fs/btrfs/extent-tree.c | 174 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 152 insertions(+), 22 deletions(-)
>
> --
> 2.34.1
>
>
> Disclaimer: The contents of this e-mail message and any attachments are c=
onfidential and are intended solely for addressee. The information may also=
 be legally privileged. This transmission is sent in trust, for the sole pu=
rpose of delivery to the intended recipient. If you have received this tran=
smission in error, any use, reproduction or dissemination of this transmiss=
ion is strictly prohibited. If you are not the intended recipient, please i=
mmediately notify the sender by reply e-mail or phone and delete this messa=
ge and its attachments, if any.


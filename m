Return-Path: <linux-btrfs+bounces-22256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPy+EL/DqWl3EQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22256-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:56:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6752169F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0D4F30A95F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E563E5ED6;
	Thu,  5 Mar 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MIZ2NrM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pF7yezXN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74984371054;
	Thu,  5 Mar 2026 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732980; cv=none; b=OY7GaF/46k4JdeBNQ4TICV4RqnC0WsT3M9VCCCw2O8aE1PVTw9CLhvzmZwnhx4pHhxN/6YvRhkhOfe/MlMQ4xqbMpSRegft+mn1wJacHvsJMNo24tsWTX/+aVD8skz3bx9CHksMG8tGdGYF0UBlOfo56ozKqRs7jjnv0CY0dx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732980; c=relaxed/simple;
	bh=WOzkUkbOKwAX79T6Q92WLwijfURHljlVEEGNqhUkZIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO+njH5TJdx01ndNj8rD7jADrafZdUBgrDDl2cVE8Eo50PPiPfvOF116V3ri0eBG93Z1Ijb12Al+m3eHFDISpBpTGMoXeuc7eLknZELBoxDw21Q6jBuA/GW657bG5OpHLTVaIsGav/hEmoKhxQhVmFh+1K0242TwboxX/BFG5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MIZ2NrM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pF7yezXN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2750140016A;
	Thu,  5 Mar 2026 12:49:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 12:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772732978; x=1772819378; bh=mMdvIs+tjC
	HyDZQgH2hmQUxNB0P/3EQTnxluRsQHJg8=; b=MIZ2NrM4tzoJXyL0LGu/9RHhyK
	BZSHUCgO6xAoeKrmE5lTNL5E7WqWYEJsTt7jv7nPjT2tGFizBADYvWqjZMbi4/Vb
	qeOsgWjQ4xIu01m4TDZVfnKarUdagrP7vlpmTwkRWN0Sf4dD4NeFfZVfeW5nLRrA
	msxD3T6TpHq6hRbrZ963OW6n6/kY8plZF+ZGs8vlu5YU7uXQn9aH23C7XZdQ4XTm
	/peoZ/7+BTSIeFR8STLk7Gpt3KI1QVYzh/7mm1WqMHz2VcfwGLICPGqkcITajcMo
	4KxnhY5sWC71bhLe+dWD6aZ8G5lPyfZUlU1AjcvUkE7lBbIsSblu59usH/bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772732978; x=1772819378; bh=mMdvIs+tjCHyDZQgH2hmQUxNB0P/3EQTnxl
	uRsQHJg8=; b=pF7yezXN7G5D1pNYePJ/QTfOnS6o4cWQjp8RPKShThRV67Q0FHV
	UYypAGf4fHHU++P0kvwxXv/01Cth5ltWcgE0rxpmws+NN/XpWrqQgaDHqvDppnEa
	mVcXWILUA5jt26wh43uULvjwvIwVu3vbC8KxEHV3miNxecmRCNYQCCCuM6cGI4ua
	ny0Ly3l8aeQuKAZUq94QlmJO+GWuhNM1gwnQC4xSrtmaAU5zPXz562qKqoSAC1lI
	PMMsW4Gz7qCQO1JDYxxfpOqWjb6SDsmW66Qs3oElqmBXpLKgdUXv2SYbhGaUprFs
	SuZMGPDgsENSxXN3jrTFvsOdpvqeIAi25kA==
X-ME-Sender: <xms:MsKpaQdHvH10zQ4n5a7fFn-okR0kfWTgR9nWOFXLeVy2NfC0qf9w0A>
    <xme:MsKpaQCWjhZrZ9xkaaH1ahkHABEBLhSCQjR6H8NmvJB4DylV-Qg2_a-7CVcSSbCuj
    GYojWrAGCQ0_8uRQuCVvo1OTLOhcwWVIYb3qyCuwwQLqd2iZZPQMMY>
X-ME-Received: <xmr:MsKpab8Tu6rXy04ekyVE1-oPTW9f300zRTaDG3FN27ZWH72C--5u7KRHReI7BRIhDUzLcwpDSt13RfTv92qpQb3HukI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfshhtvghsth
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfughmrghnrghnrgessh
    hushgvrdgtohhm
X-ME-Proxy: <xmx:MsKpaTJQD-qQJP4gW9mhHFaZqHxovSEGjqJ1JyLF1EnfqcxmsCBTDg>
    <xmx:MsKpacgklTzqp_RnU8UbHIgW196W3o4yzyXa1pJhW64yx0IWay4-7A>
    <xmx:MsKpab4_GT525pjJmuKAu-X7llmzIF00Q9xPljr0BDvaqaxV6V1dzg>
    <xmx:MsKpacZqP0ojEkGm333an3Axph6DUhGD7dvk3V-ZPPd9VmGsjIfHJw>
    <xmx:MsKpaZjY2sSoQ52ae3GX1UUgaXTHCPJ2ZwmrSYrJi5LSoZZV9AMN1AVC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 12:49:38 -0500 (EST)
Date: Thu, 5 Mar 2026 09:50:18 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test creating a large number of snapshots of a
 received subvolume
Message-ID: <20260305175018.GA1172981@zen.localdomain>
References: <18154871aaddf2f1887c14e63513955c79b2a712.1772106013.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18154871aaddf2f1887c14e63513955c79b2a712.1772106013.git.fdmanana@suse.com>
X-Rspamd-Queue-Id: DE6752169F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22256-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:34:24PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that we can create a large number of snapshots of a received
> subvolume without triggering a transaction abort due to leaf item
> overflow. Also check that we are able to delete the snapshots and use
> the last one for an incremental send/receive despite an item overflow
> when updating the uuid tree to insert a BTRFS_UUID_KEY_RECEIVED_SUBVOL
> item.
> 
> This exercises a bug fixed by the following kernel patch:
> 
>   "btrfs: fix transaction abort when snapshotting received subvolumes"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/345     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/345.out |  2 ++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/btrfs/345
>  create mode 100644 tests/btrfs/345.out
> 
> diff --git a/tests/btrfs/345 b/tests/btrfs/345
> new file mode 100755
> index 00000000..75cc3067
> --- /dev/null
> +++ b/tests/btrfs/345
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 345
> +#
> +# Test that we can create a large number of snapshots of a received subvolume
> +# without triggering a transaction abort due to leaf item overflow. Also check
> +# that we are able to delete the snapshots and use the last one for an
> +# incremental send/receive despite an item overflow when updating the uuid tree
> +# to insert a BTRFS_UUID_KEY_RECEIVED_SUBVOL item.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol send snapshot
> +
> +_require_scratch
> +_require_btrfs_support_sectorsize 4096
> +_require_btrfs_command "property"
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix transaction abort when snapshotting received subvolumes"
> +
> +# Use a 4K node/leaf size to make the test faster.
> +_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Create a subvolume.
> +_btrfs subvolume create $SCRATCH_MNT/sv
> +touch $SCRATCH_MNT/sv/foo
> +
> +# Turn the subvolume to RO mode so that we can send it.
> +_btrfs property set $SCRATCH_MNT/sv ro true
> +
> +# Send the subvolume and receive it. Our received version of the subvolume
> +# (in $SCRATCH_MNT/snaps/sv) will have a non-NULL received UUID field in its
> +# root item.
> +mkdir $SCRATCH_MNT/snaps
> +_btrfs send -f $SCRATCH_MNT/send.stream $SCRATCH_MNT/sv
> +_btrfs receive -f $SCRATCH_MNT/send.stream $SCRATCH_MNT/snaps
> +
> +# Now snapshot the received the subvolume a lot of times and check we are able
> +# to snapshot and that we don't trigger a transaction abort (will trigger a
> +# warning and dump a stack trace in dmesg/syslog).
> +total=$(( 1000 * LOAD_FACTOR ))
> +for ((i = 1; i <= $total; i++)); do
> +    _btrfs subvolume snapshot -r $SCRATCH_MNT/snaps/sv $SCRATCH_MNT/snaps/sv_$i
> +done
> +
> +# Create a snapshot based on the last snapshot, add a file to it, and turn it
> +# to RO so that we can used it for a send operation.
> +last_snap="${SCRATCH_MNT}/snaps/sv_${total}"
> +_btrfs subvolume snapshot $last_snap $SCRATCH_MNT/snaps/sv_last_as_parent
> +echo -n "hello world" > $SCRATCH_MNT/snaps/sv_last_as_parent/bar
> +_btrfs property set $SCRATCH_MNT/snaps/sv_last_as_parent ro true
> +
> +# Now we attempt to send and receive that snapshot, verify that it works even
> +# if the creation of the snapshot $last_snap was not able to add a
> +# BTRFS_UUID_KEY_RECEIVED_SUBVOL item to the uuid tree due to leaf overflow.
> +_btrfs send -f $SCRATCH_MNT/inc_send.stream -p $last_snap \
> +       $SCRATCH_MNT/snaps/sv_last_as_parent
> +_btrfs receive -f $SCRATCH_MNT/inc_send.stream $SCRATCH_MNT/
> +
> +# Verify the received snapshot has the new file with the right content.
> +diff $SCRATCH_MNT/snaps/sv_last_as_parent/bar $SCRATCH_MNT/sv_last_as_parent/bar
> +
> +# Now check that we are able to delete all the snapshots too.
> +for ((i = 1; i <= $total; i++)); do
> +    _btrfs subvolume delete $SCRATCH_MNT/snaps/sv_$i
> +done
> +
> +# success, all done
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/345.out b/tests/btrfs/345.out
> new file mode 100644
> index 00000000..11ef4e7e
> --- /dev/null
> +++ b/tests/btrfs/345.out
> @@ -0,0 +1,2 @@
> +QA output created by 345
> +Silence is golden
> -- 
> 2.47.2
> 


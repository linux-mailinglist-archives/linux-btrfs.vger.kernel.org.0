Return-Path: <linux-btrfs+bounces-22225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMkXM7dMqGmvsgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22225-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:16:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE1202653
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2C213150CAB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1E370D4A;
	Wed,  4 Mar 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTdgbq+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A711349AF5
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636655; cv=none; b=OBehhp1MXoI9oHNw5jbPTOmVZo4ao/sF19gVBwbrI3Hvw++LLKpDO6kNqbQB0/XYAd1Oo9moyZApLuJ9zObuctf64bP7pJGE1EznjRBkqLX31cGUW+BgRf9CNCQDOqo76KiblI7om8ByHLjC2PV+XdGz7HmfjU9ZDXoChi9Tfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636655; c=relaxed/simple;
	bh=5Ye0REItnKBcxlfOVIDs+PLE4HBkZCQkGC/PocV9s5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERWRpljHoIYSKa8wcV8U7FrSSt+ZwAPyXl/ZH/E6rGYtnSQB4cfsQJGiVNbxyNEut8YvbtHTREB5doBuAaRaaftx2+PuvhP+Nnfy5zQToFm9Wko7uL75QReZXk0hLAWWegtgwDtqZzmve/vRx39vqjaKQIwf0b59gdERkEHHbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTdgbq+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC5C4AF09
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636655;
	bh=5Ye0REItnKBcxlfOVIDs+PLE4HBkZCQkGC/PocV9s5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hTdgbq+hXzi5ueu4SsWtofpmaY9pLRU6em8FMtVwgzc57f/4Mzl4NiNegenRp+YcY
	 SZCKRCD+hOVYnbixCzoiWDoMlCixy4H0CnqKUV9fo4kRKZLhiSNu9C1U5WLl2IaLaX
	 8s6eOPTZUt61/i8gbNTZIFdxcKUx7AUM/BeqJqTRdFQL834j3xUIDr7FxueXvlD1bo
	 ekrp2HLXc0j5V1vtsVZ8R5M17Ok19b0hKEQxmCQnI4zqg6VBQonrsgPmwCX8xA2Gco
	 F0n2eRkrENjb9Irb0a66yOcroybmiIlodfy1OgqXnGbicSb9yE0jVSrIkJcSrA6TM2
	 E2+GA6JNEzfCw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so2233216a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 07:04:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjwUcCT3Au9LPlMyWJMS+6QEXDTmdplHQDE5Fh7tPHbq27sUAHACwgbbuF6d4Pkpxx3P4r90iZZ7aDuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcPf6cVfZ/IptU6zpLka8x19Q4o10L2cQ4o6cdrKR1VAbndYG
	Bx+tmfToxMkO55YsVO0nzBiQZ/YijaSOX2mI0jLKW1cnsmiZeVjfnY1t2kCSUN3BKCc6VW7IyxW
	9uCgz6hEJmkKpWI6r7dRtD/XpbIfoW1Q=
X-Received: by 2002:a17:906:d555:b0:b86:edb9:c01b with SMTP id
 a640c23a62f3a-b93f11eb22emr133964966b.8.1772636653834; Wed, 04 Mar 2026
 07:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com> <aaguMUK6TgYfwtZk@infradead.org>
In-Reply-To: <aaguMUK6TgYfwtZk@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Mar 2026 15:03:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H44GTr+S91rYVfHcasWh9=QBe3dU9wLTRL4LJcinRE=VA@mail.gmail.com>
X-Gm-Features: AaiRm51pf_gXyYDLOI2VE-Og2RSp-fCBAuxc8B85haNQVkRPrBuMSlH-h84aFcM
Message-ID: <CAL3q7H44GTr+S91rYVfHcasWh9=QBe3dU9wLTRL4LJcinRE=VA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: test a directory fsync scenaro after replacing
 a subdir with a file
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6DEE1202653
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22225-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 1:05=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> The subject is wrong, this is actually a generic test.

Yes, I'm sure Zorro can replace "btrfs:" with "generic:" when he picks this=
.

Thanks.

>


Return-Path: <linux-btrfs+bounces-21699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGjJKBc3lGlpAgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21699-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 10:38:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772614A7A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3818230342BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0A30F7EA;
	Tue, 17 Feb 2026 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="MwDhNPH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7030F552;
	Tue, 17 Feb 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321067; cv=none; b=TVhRRNLgSpupRh+WkjnLJUoZxqkGf/4BybFauLVjQdZuzpZIYlcYioQWx4pvAh8vTM+WX2XkJXSwhQRUwGJvuk0DZX3GB3996a//NFhB9IQS2ATML9oM3wtWFbJA98ynH3wL7tNuQW+PnE6jQRM6gRbOu04tL2U/62X6wX24CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321067; c=relaxed/simple;
	bh=ZNE2cjVm9h/GNVlN/tgzzuMRCEo7DyDq5EfAwVtnSxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnONeugbRNoNv9DQPU7zOZ3Wk5VnOU3zlNl5e/QzP/8v/SXrteGUyVHaeVoewEGNpuNtKCdovfECnSpx/njlLktNw+XVnOxWETcKrk40mV+QAsckNgaRdYsf7sDvT9HESr/5N7QQiQtbxfLycU55xBXCvGBW4+BaHTMOkbMYOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=MwDhNPH9; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [79.139.249.127])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7754540ACDE4;
	Tue, 17 Feb 2026 09:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7754540ACDE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1771321056;
	bh=60hLXG05tv33tUYdJE9WudTXXtDcQhx/dk5Ikbs44tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwDhNPH91eBjAqjmR86Z9HC9rTp/qv4yub9FH+RwlhEKpcf9uq0j0a2fSl0YWw8C4
	 XMRxOlJiq/kK7QdpLer1SczZi3zHXCftsxZt7NZY6bnbfIrXMyHkGw/XryVdC3TqIs
	 W4Cwx40kfIt5DINWUKHZDoeuTTbj2UtOanHTNQEU=
Date: Tue, 17 Feb 2026 12:37:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Burenchev Evgenii <EBurenchev@orionsoft.ru>
Cc: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] btrfs: remove dead assignment to dirid in
 btrfs_search_path_in_tree()
Message-ID: <20260217123442-4dc46ffd577ed43dac0f636d-pchelkin@ispras>
References: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f1d7281b3004c6baa24a531b409c466@orionsoft.ru>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,linux-btrfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21699-lists,linux-btrfs=lfdr.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras.ru:dkim]
X-Rspamd-Queue-Id: 0772614A7A4
X-Rspamd-Action: no action

Hi there,

On Mon, 16. Feb 16:16, Burenchev Evgenii wrote:
> From ff2df73ba6483b0dc67b3ed89d2a43c49f1c2eb8 Mon Sep 17 00:00:00 2001
> From: Evgenii Burenchev <eburenchev@orionsoft.ru>
> Date: Mon, 16 Feb 2026 18:39:30 +0300
> Subject: [PATCH] btrfs: remove dead assignment to dirid in
>  btrfs_search_path_in_tree()

These headers shouldn't appear inside the body of the patch.


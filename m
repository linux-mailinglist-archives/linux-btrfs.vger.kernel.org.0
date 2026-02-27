Return-Path: <linux-btrfs+bounces-22074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG4BNM7AoWnPwAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22074-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 17:05:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01D1BA81F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1333B306BEF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2C4418F9;
	Fri, 27 Feb 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7xfHkJq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BE4418D5
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207474; cv=pass; b=A6gFdgs/qN/vHAi6zrP7ziJYVSIojcI5j5X+OqQJW9kEqY7BvcDzKDxzBW8U00u15bErpJcLq18weUIo+9R0rbBxCgMsEQ158QflcF7aAlbSq6pXKfJYPIIy6xrxONjnoJ+zvxYfQ5i7oYxVk03uCQioKMa1ML+okB7jjOAGvh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207474; c=relaxed/simple;
	bh=C2dXB1sxCI7Pk9wL8pHCeBM7riM5637FJHGRurs2elQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceR9C6mH7XLqjf2Y9U1JiOdRZQ2bS1QWLaEWsKeAdWvoRqQ7PDZR9bNCWhrANm67EHA8DvqoBsv90B+ODbjQEg2uP72UlqdHOEPut+uA1xeyRlwnB42QZq7SCymOP/VH7DQTNYgcJfc8pIKBUPuPR9fFoj6lzPIRuax5/8vfrnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7xfHkJq; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so25395025e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 07:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207469; cv=none;
        d=google.com; s=arc-20240605;
        b=AgMSaQoF7U20qydqWA1YgehfAwYutwCBtrpBB4OV2HHzMp/6PCXqrwzf017H4A3NYT
         ElxuddidzUxCySZZQRkxZW3XonhePI9qXuAhuT1/3Jpd8iZZPcEi+0mRmVVi++TYUFAc
         aQ10ysYgbzZ9nx0Jy9ezHEndjCO82koW5TcqqkhrmAOEy2OXO/UnN+buBoTyRLp+Chk+
         4Ec8aKlM/7t7YEa4nFwgoEZx7PHPsh4s6rpNd/CyXrB8SRcA2Hate350wEtMXc7IclP6
         wYpxzkuhK+pcKKuMs5ZcVZei0PFAchudnBpCgwch2zafwmb9w8msYo+rc4bCEfk157FX
         faNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        fh=TyMaR7i+QZx0uC8/cfCNlduVtDkoNnlxX2meDQoFHBA=;
        b=Vbfkc/omB/U7TMyviXZAkspya12hdo2X6MOf+QZms2/lItxo1oTCFRO8hXpQMPBoNI
         InFn3moE7UHfJMi/2QA7QXJTSv8SPUOK8crTIBvRJzXBH4+NczV/SPOIte2RUd+khos8
         Hu0zghGmJlq3gijCJvuEfuI1TKgRt6WGqCDA0I/fZzAFRMmDuorNeso3qnYLdN+6WZ/M
         1a21fzRSr4Yda2Qyzb4Cs01MWlkSWxMP2hEgkwfQvQ2jbnr0CheTBsbVizMkWtZ3SXVj
         63i+09RVYvHdsIbwnc41jlI24paH0lMxACDMLIqg0GvFtbTcmC9O2qITK3kar2pmj0HO
         E/JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772207469; x=1772812269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        b=O7xfHkJqIj7ysBjltL+OEuC7IvVKrnNE/caIfi4So4zLwms0AvlloqnR4SaSsbCDZR
         iN5wiC+rxAHlSLUT9rMACdeNPTXynI0oS3IBvZkP0iwHAB2V41FMXNtUHT5ApUcvP8OK
         9NW4oK8f3opDJUA2V9DW2OC1iQQrpgxWCky12CG5Xa1DnqU9Vcu0bW401OIN92YJpFdW
         T3FEmUHB6nB+AywKA20yuam/TrIySGBysDmP9NW0WyRY5APuYfNd96qDCGqBa8wEU55O
         h4SRqYxkRS/Wr1gxZPonSBmuR2Go40C0sztGPllflGuYHBfM/m4rB+pic5ux5krWgIYv
         cwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207469; x=1772812269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        b=LD00vUuZ1yPzbihHdzVQjEyvBreZLoFtlu4MR9049Zlzj9779B+8K0ZuOMiN6Ixqwu
         j2nzIg0nFE3tO6PVN8UFZf327hFDoKIT5FPbGbKM1Okay5YMc2u4Ajb8YiNb6+L7xdYE
         SZf/XO2oPx9Ee4j9RLBQ4JqJUQTWfS87jtJnV9vajynj5j+HXr6dyKuErj6gS0yRZRpp
         PkSMZhjC593xbmC2RkTxb4ow5jXWx1B4uNIeBQ5whkVpw9bdJ9/d6mMsTepjlZ+pJo+D
         YMYbBOyQmNuX12ADISi43B9Hgx4JGeUZf3ABvZgY291z9NzbeX8JYESDp8zBkHAo1sOa
         /DLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnEDbtvszVW4OCZyi2QKxDGG2QirSKjOme9oum2+Qw2nHPCHGA/4O0owjlqj+QWivWS7aIhCBTy8fODw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDG+f50OOZC7V6cUlcaVTy1OzQme9p4OLdpuv1lEgujRt/4S90
	2GFXAP++wXaY6cRykMW6bNLqyn88pxYvBi9hlvz6K1RSDWYhHeOftd1XYHG8Br1eECJNNCjmN+X
	PB5rn1OXoCFdrLoHGeKh5j9+5Ia4ssaPwTmMJHKtIww==
X-Gm-Gg: ATEYQzw8e7yTPT0cYiA+ZrP9S4rUpwVJReNL9gJtNhzhpGeia95MSDuDi61+dW2v2q7
	N9zU6VvwsuCT0yPYYK2hhMNE2vG5cNW5mHX+K45qiT4hD0fugdfpz4b8fgrh7eoonV1HLvIqvV0
	EKgygmQoiT9mPvndAmbH1lUW19HgE044y57FGH5v+hL8Hx1BLNU8xnhndWPbuSuA92C3sncaTA/
	wE36KUoLCgMvpgAc7Bs2pD+LJvWD6gwZqVqPzBeeHjEbJ/davqU9UNbQu8wlJ6qiRt+gZhxXlzY
	FMAIILNYDE71Sok6S27geJCx/sxTMaEBvs4sl6+GDw0O9vzHkBTgKtZkgCH8Ou5cU6vaJ7dPCoY
	fsVte
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr44092495e9.32.1772207469176; Fri, 27 Feb 2026
 07:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
In-Reply-To: <20260221205606.GA23260@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 27 Feb 2026 16:50:57 +0100
X-Gm-Features: AaiRm50Djn6O6G3P77GWwQPmb2f1tOFDkZh63lAskdXhiotebz4l7KeZVsyYZpU
Message-ID: <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22074-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA01D1BA81F
X-Rspamd-Action: no action

On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > Hello,
> >
> > These are the remaining parts from former series [1] from Omar, Sweet Tea
> > and Josef.  Some bits of it were split into the separate set [2] before.
> >
> > Notably, at this stage encryption is not supported with RAID5/6 setup
> > and send is also isabled for now.
>
> Where does this series apply to?  There's no base-commit or git tree,
> and it doesn't apply to mainline or btrfs/for-next.

Hi Eric,

My apologies, I did not explicitly mention the base. I'll do it next time.
This was based on for-next @20260127 (commit 80dbfe6512d9c).
Since then, some changes occurred that will require additional
touches. No wonder it does not apply anymore.

Daniel

> - Eric


Return-Path: <linux-btrfs+bounces-22107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C3hA1Ogomko4gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22107-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 08:59:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78A1C1547
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 08:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C163073180
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBF39901C;
	Sat, 28 Feb 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vbt4Wigh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586639A7EF
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265441; cv=pass; b=iLiJM6cO04++yk3ns27r/hoVPWf/6sesSPy+JPlP6rfluH5Io+7j7lovl0InccjsWcOjR0+6f1UyCXupeqHco2VGJF8MjXriELyTybWlp8Eq5aMM86w4i7GB6NRGUgR2CMmj1Vtx4xgiCPT8paq0N4rpENEZKqM6g3Fnq/TWtlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265441; c=relaxed/simple;
	bh=6PdqOpfgB3YMOOlux3bduC+ojGyQw/085BF80Hxj8Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRSz91r20v0WRHq0d1kE7XR1MZ3O1IAJrP+ZvGYHcmcfngJ5kE7jdE8LRxvauBuLsgxIBRTXWNmgFitQqYzmOc6h3sser9k7sgVt/fSradGhZUZnhvBZXw1959MRemU57lk6lObF9mcLup8VOWcglgwMHbpUfFQCpEIt4a1/xiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vbt4Wigh; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436309f1ad7so2276584f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 23:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772265438; cv=none;
        d=google.com; s=arc-20240605;
        b=fmigG8i4raY0j4jxjOC43yo8pN/54A6EJKq0fmZ/g4Q2LhvjlC7q70ftGMaITwoHU2
         +ztrxTrnbQq7irHAPvrk9WW1mB1V9FOd7EEgvm9HI+OrkDBywBeTnuF2XACff1mC2+ry
         FnCTQCvQDD53GB0T49xbzNpbyH6pruqdeATSw2lB3Z7XV/lr9B1TqKCJilLIj9bw6xSD
         /Qu83wRlU7OR2E5rqdZswqZ20xk9CEg9fUSU5RL7tc48cwFF/sZABUrEWS3uFS+KpIjy
         T+djdNR/LzK9q9RWncDNYgW/B2FrmoVYqIbRVJeee9ISBrAimpvyX2QqRWkE2hqmvCFc
         6mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        fh=X4Qoub5ciwvfkHTFN4pK6r4bsfYsESLQSg8b+FubLv8=;
        b=DPNPHJIfFUYfmAHRCQbd8QY7AaJ1R2kVUwuCjnkCFbgSMD7Ib2oEb9D96rcF3LMnI4
         XxLvDDVj1HXYxuZtVlMybp2Hu4uV+dNF4Md2C2B19Ciuo2/MPhXsW7Zrva2Nqw1U3dlb
         4S6s6t+hF4FeglgfyrzWX/XGNTjMpCXlg7oBPV6UI4ShKu4QgSV6hOYN40hn1vrPecYt
         dlQ0hnCS5y76Pxu4k889PAybcapLoiSFPD3jB1tkIZ98WDizwCM2Sbh77mJ3EHk5yHCe
         idzv3Nu1aLre2QqfjoqnEvDd9hs54Pij++d9fmuwjMlhrqIo5c8ENfbbdwLsb4Cebpv1
         RF2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772265438; x=1772870238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        b=Vbt4WighTUGP+oXtWsfyZsltXqfo6+swatGLEdwqw8HOMXUzJQ7k2UoUQjxP//tcfj
         s9N+MX9Ipxw83tnOHvudb4TyAyI8FCDUPR2tK+Ewh0j+jm+4zYd6e/XJROtE2cv/yD9b
         K/opeqNAkvON7Vq8CZn1ZWZXdVSzAINrdtTL1StdkB+x9FID+sQAv7ETgvTqqWLM+JwU
         Z5L4Zc9WFQD7ya26sb1shoa/LuLzx9QleW6EQXT34Dcdbli4nZbhzeLdOWwjlblpCmCU
         jxqp+lVO2+NSumQWufcdTISg8r8yyFNBRbagOw0pXNQ+TDMb5gd+Ee/lOdniQpJZyfR3
         4Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772265438; x=1772870238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        b=UUch5W4wKku4ckoLo1Lw1VyHnrxNX7/LhjurrHyTRbJUrFD6iPA43qbLx8mIT7jYSy
         HDRWykVNKosTsMEX4PxTOia79qjjiZsbJv2PbSA0H38H1Vyn4itqihRMd2/l/2rkAOgR
         tJbtDLpAzdcou0+VG9D3g31TmbNHKtNA5QHaKE7jxGJzr7/ybjZSSxkcLoAzC8PJW8KU
         yCCwiHl/JIQrVQf45BYAJt+Xbp39dBfXlk06NS275h0P35sqNKvxcwtzOygBGH8qksLQ
         FuHewF5wQc6E72SqIwbp7B5t+wrQh2WzYV7Kls2r9Y5wOawC4etYUC1I42Yz3qSWj62m
         sD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVV3kI29bQUefkT1/xCURl5FwBuzMQ0B+t/of7/8vM5IwrDsQU/ApBFB5ZX8xR5xrAcHkWf3OCbKne+IA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfiwm9F15fDRyMmvKlHXNnIopnrV/4sPvlIe20qOMXPyply8jU
	7kzm1oo2eKTqJGbXkatWUpPXRI8/5xVVO0utJyLlhRLi7+mVmA4imybiAzQdUFaK23/ScOv54rj
	OEEKELAdBhytIoUXTF/xQuWYAAqdcorn1rEdo7gkC3Q==
X-Gm-Gg: ATEYQzy6e60Qf9JuRaGuxDHQcoh81/25BiM65iMbAbkxQJPKEaNVQWb9eo62x3iEkMX
	LgwpQCqRG8vLt4MJp9Ob4t2uGOAAbbcOZwEVewoYPIJaWYWV/jMFkPnzFSOeTrM2cxAT1ctI+F6
	JQ9cJqpOw72FlBzUQBZCEEkNkkCwTw4fE8+PG7HK1ZoGCNEfzcc8bpLeBQRWdxj8xLwfJ05S419
	Y4iNKr7HMz3HdQdWchS+7wsuIM/XxJtZyh4Pecg5LkhG5+rozLFiGXTipo5WVl9OT0SM8FuXHTQ
	F7vSaUE1liIQqm1y2m8xfHiFngotLSZL277w7/NBNQTFgzLcNgkZSJCXmuJ0d2eGC1yuJnI1z18
	5KXI7
X-Received: by 2002:a5d:5d0d:0:b0:437:771b:26b with SMTP id
 ffacd0b85a97d-4399ddfc43cmr9839007f8f.26.1772265438557; Fri, 27 Feb 2026
 23:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com> <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
In-Reply-To: <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 28 Feb 2026 08:57:06 +0100
X-Gm-Features: AaiRm50fp_4Fyhos6nvwQgL-IlBc5T53PNbqLb3xsg-h7pbpyOz2GPW0NAm_PCQ
Message-ID: <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Neal Gompa <ngompa13@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22107-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E78A1C1547
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote:
> On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com> wr=
ote:
> > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > Hello,
> > > >
> > > > These are the remaining parts from former series [1] from Omar, Swe=
et Tea
> > > > and Josef.  Some bits of it were split into the separate set [2] be=
fore.
> > > >
> > > > Notably, at this stage encryption is not supported with RAID5/6 set=
up
> > > > and send is also isabled for now.
> > >
> > > Where does this series apply to?  There's no base-commit or git tree,
> > > and it doesn't apply to mainline or btrfs/for-next.
> >
> > Hi Eric,
> >
> > My apologies, I did not explicitly mention the base. I'll do it next ti=
me.
> > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > Since then, some changes occurred that will require additional
> > touches. No wonder it does not apply anymore.
> >
>
> When you make your next revision, can you also provide a tag or branch
> that I can use to grab the patches for testing? It would be easier for
> me than trying to yoink them down from the emails with how many of
> them there are...

Sure

--nX

> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!


Return-Path: <linux-btrfs+bounces-22087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF7GJFkaoml7zQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22087-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 23:27:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAA1BEAF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 23:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99C4C30E66FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 22:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656747AF78;
	Fri, 27 Feb 2026 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMaNTNyq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A3B8BAC
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231220; cv=pass; b=FmdQwUQvF8WvRXBgPMMxr10vfRHZgWidmFe12IFw2eHoAfoINwzkXhCyD8BmTye6xaY6979BjTOu3nKeHg1Dh3YlMCIpdGu3YJ6sKl+gWqVmL6cWF1CeoQIs+5wMl+RkjFrP6YmXjRrFy+dcRl4/Hfu3jcld2K4nvwQRL3DGaQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231220; c=relaxed/simple;
	bh=HEc6W3B3KyQ3qcm07Kteieoys840RWPWeAPSz2C3iaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLdejs//Gwkui5624dx94BY5xlzzu0U8tb00FlZugd3ueW5/oDNqZi9CyHEa/kdtU9zUZqhoxPXArlduhdyHPWQvwAPSWnMFOmAbng36Q/TUH1D+e7LBizjhdG9ujAJJTj6ZAV9sJ24iwHCmvuVXqEiZNyKQN0kpnCvxDNGFqrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMaNTNyq; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d19d3c7208so1628886a34.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 14:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231218; cv=none;
        d=google.com; s=arc-20240605;
        b=MLlffDsfjpBfo94675duaRnaEAG8wAUtPNkbLJ0WcA64+1Or3URNG5joxgzFw+/ywX
         g2DFvRIfPFq7TI53P/aOt/dYHUqsKA1bhi4gpJzhNxo4cwW9mFdRB+PqQUPcfgB3JEPM
         ICsHmiBbJGbgJR2C7qvUggXUeLRRA8oRU/zbgN2iQguVuVqlvKTLvPVUW0hwmvhTJjh7
         4rx6zLnC0xZ6ooyyC9ft09nfG3WlPsA/LjcrtXh4vVtAagh1YGVFrPqVY6HkwjZ+K6au
         y8o9UFy/rdqe9w1o9Mphsfs2wFsJUtxp8UjkClfknCvtneYO24LvBMeCQWMJZNgm+KXC
         u8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        fh=yYLGY0vmLY2eHLPcNZCb3zhEqKi+34ptJGuvpDBgpFk=;
        b=TAzne15ZvOdFkQ2BHvDoi26STHxUSytNhLfrzHeAySNsPkQMrTH11B6WSBYt6iuci/
         /ZRc6WDvsORfaXfs334N8gUPayrUIcb50iWNG8aQsqQgyas1h2EwBx+UU2ma9tAt7xPg
         Jl0a8su46InUj4zuNUYXXzyf39g+nUXd1iR5i/iiNY2tL4xFwnfTiXL0khQrKcusZ/TD
         3PuTdalhCn9VHw/8iDY49f7bVf7hmM3jHkgPIn2c42zpprdUa2bhqq6BS4H8vgVPYWPW
         2Ebr30ik7nQQlqrP5rsGQT9T5HSe3rJJqaxtGm31sBbVdzyebDPIlY57zbctYgk9cmTZ
         sMJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772231218; x=1772836018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        b=FMaNTNyq5P2L2ZOkCx08XVH31ftCQCl//RJJ8Z5O7k1OA/ou0pGQpNJbIqWkpnZ8Oe
         vZVoskqyK4ickPDXrLzAxRqbxkgeJodI/gOFvmb0EH3Xf9lFTn9sVoJdZ5hpNa4QPRry
         tszjE4/VFQAYW8cT4I5YY3V/FhBFENjQ+jeccGBEkGPapY1EeL/6wTeK3KpszC7oMm4y
         la8vrr3WZrTNxBasHGYx16i7IK4UiUYtlHC70kghTEkn/fCeFOF7Gn9y6NRfIVDrhgtS
         1MRgAkx/zyHpkOlBbc3mW2GdNF1OQdLV8wWsCE2YkVWxuX5W1mfITHB99EDZZrN2imdk
         CZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231218; x=1772836018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        b=JvyfQXsGoNn7Q7ZmadFR8S8oM7PQBYb29tGNb57n5l7ijHJCTkXl4jm4zUNUR38Mrw
         rIYzbUD4RrMtwLUCA+RxS0rGyGYfNnoj3JOHKGe0SR7elOhqB+Ii5aZTjF3opYKssgNJ
         wWKpUhJ9MTrL4y8/TDySIFUD0c1LImEMRXX3R85rdxe/XNsv/EVcL69oMnYygTp/2HQd
         YPTAI7tJFd2sAleOzb/bMmLxsZqtE3zlP2kwtiTm8cG85Rm9kkD9mk2D9TbZhnxZDvRp
         nv1Xdjq191yi7RS7TfIckJC7X0I7KI6ddIS33yf/fK8IBX9PO2c1tdEAE4FXNuaKk1pb
         PqEA==
X-Forwarded-Encrypted: i=1; AJvYcCVhUI/5n/xI1qJ589/RjQYvNofdgAcG1zVpJy07bLkDpVpXwBrmEJ1xLCi2l7k00pQWu/xh4tdTws4zag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57xuOkzkxW1xubP9flsNd+5jjIGaYObHfFpAMA5zp+FtAOVbf
	tnVNyuh0U1DkI/t1Cc9yFZzRMt+Anhz+8kQlisPEFtslkja8J+MoM2+aWzTBW48eVulFgGJdwZs
	d6FN4cF6xpoPYNFuHRgDeNX32WLKexWA=
X-Gm-Gg: ATEYQzyrCpPn8VtaEctnyIcPSf9ZGgNFU11qlVz0mcBhBoaEpYMcSvQuXb3OqGd0M8K
	7oExamTI5ebFrWcmOZTMzZyRsrTk53YqAWVXy+aa0PUUM/43I9IdApiAtwN7OHr7jSACyhwvDvS
	6gTjf2VKK0J5sKI4sQ0VEzCMbdvq2Uf0by8a2Psqw+8Q1e5CTvXA+FJq3Fad6QccTWgfSU2rSYQ
	fFqvaSwMq0HsPPtrJPRu8LDeQNrL/ahGWAI3MzNdxOk4bx0yJCIbx0LJ37mVMWayv6Vwz6VQpjp
	OTCClezBiL3lYo5hIq35F3d2ARtLYBFRT0rcVrGhbGJ6IhmTSZux54DwGw+/XiYKsD3Zy77kaRP
	ukaIXCxLbwfRjyXj4PKS5Jac3NRXv93V+NgcD3A==
X-Received: by 2002:a05:6830:200b:b0:7d5:96a9:388b with SMTP id
 46e09a7af769-7d596a93bc7mr1340172a34.17.1772231218567; Fri, 27 Feb 2026
 14:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
In-Reply-To: <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 27 Feb 2026 17:26:22 -0500
X-Gm-Features: AaiRm52Usi2aZHq1dkEfq0px3QfzRlx9VQVNLzVN9g7lM_OjE4pL_WS1HE1bAk8
Message-ID: <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Daniel Vacek <neelx@suse.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22087-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ngompa13@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01BAA1BEAF9
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > Hello,
> > >
> > > These are the remaining parts from former series [1] from Omar, Sweet=
 Tea
> > > and Josef.  Some bits of it were split into the separate set [2] befo=
re.
> > >
> > > Notably, at this stage encryption is not supported with RAID5/6 setup
> > > and send is also isabled for now.
> >
> > Where does this series apply to?  There's no base-commit or git tree,
> > and it doesn't apply to mainline or btrfs/for-next.
>
> Hi Eric,
>
> My apologies, I did not explicitly mention the base. I'll do it next time=
.
> This was based on for-next @20260127 (commit 80dbfe6512d9c).
> Since then, some changes occurred that will require additional
> touches. No wonder it does not apply anymore.
>

When you make your next revision, can you also provide a tag or branch
that I can use to grab the patches for testing? It would be easier for
me than trying to yoink them down from the emails with how many of
them there are...


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


Return-Path: <linux-btrfs+bounces-6087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E991DE38
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920E3B20CBA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36374142624;
	Mon,  1 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="fHeo8MFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927D3BBED
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834009; cv=none; b=pkyw5WVtQ/G+VEnBjFvczm3ayuu+8qAX3gllOIGX2jHgOEEYqhqPnGBBP928z1XbSs+1F5NFfLzDj8505GC70kQPt3waOUbOX6Fn90IECDCUIrz5WmX353v2Y3t1Qb2uVgFziMP6W2dSkIye4AohcTxmRoF8SiuKSenIqQYfUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834009; c=relaxed/simple;
	bh=IkGwujxvA0ZtsOkckD1mZVvybkk/UBmuH0/fTIk+Bdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc8axINSkpUg1ETfat1NdtefIINSEZ7AGFeuBFgmfZQspogKkQ4c5krjW/m/w0pd4Qixzp+dZsHBPl/ciwLoNaCEkyYY6nBp2cE4JHeJlIVZg84u8fHsyiZHLAiAJSlx4RCjhipDZNoHxJA5sPhXwmEjM5YxAFznE1PFbISjoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=fHeo8MFR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso173603a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1719834006; x=1720438806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ixj4l/f2SKSEdlbjmsvpt+HlnYg1bZGWl8Y/+Ch7JXU=;
        b=fHeo8MFRWqULvIPOOZJUZfzrbObDmKLlKPYOILxk8yPACLTCTFq0GMBCL/40sGEJC8
         v7/vIa9x0o0Q3uLff+bxuoqVcDKeOU9M6XS13oDVplWyKKnX40OJxZPijf5S+8snK845
         6RGvsZ9q5/A2pcfV1TmYlw1Gr6ytsg4i86PDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834006; x=1720438806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixj4l/f2SKSEdlbjmsvpt+HlnYg1bZGWl8Y/+Ch7JXU=;
        b=Us6jeorgb22tdqLXwpb4aWTZER19MEgXo8xonXa+pV1Yjx72ZhKYRZhkKPGbAJ/cXE
         IdiVdBpoF++2eGG8V5xLRo++nP1WyEgx1Z/gn51okef4SGJNsK77UPrdwNoGSeyMuG0s
         uEqUSGrR4sxODzPPpS+Wk53wduQBdqUeB5id6wfNaHVnx7/W5ayfUc7/3iWjGR6KCLxH
         9jDZbO+3TcH4NhfZXBBYs5JkHWJtkdFZ74kaVL9B6OHPtV04ZHM1bX/KMiY8pYGiskIG
         lFrkwK9B+JI1x8pJL2lxc6BvZbazH9m3yZhH4XsMf5h2w2FfdH+uXP7IxAda8DzsycyT
         xRKw==
X-Gm-Message-State: AOJu0YyvJDWVjbSAN6IamPjUaj6GXhhW4tajiPoBVV91BDEuOwwjkLnq
	A1l7cBR2lRI6Hv70uW/M0oc6DGOdaKqiVD2YspQN3OfjBwIpujUrUvu0YrOwDaHwpTcNeLxaMhR
	VkyaZ128OVJlMDaOewwk3k53719IbNYqCZ+jkICcTpW2Eg2kZdg==
X-Google-Smtp-Source: AGHT+IEw/5nK5hU6bGgC3vq1PgT+myZCuWLRjNUxSwrQUBPqI+ymxQaOJpzgfcnAaWV0iQQaBam37JMXoFhJXOhsnDc=
X-Received: by 2002:a17:906:d930:b0:a6f:5723:fb11 with SMTP id
 a640c23a62f3a-a7514495948mr321253366b.58.1719834005933; Mon, 01 Jul 2024
 04:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ5KVjrg0OO1eEXyC85Eg=97oP_CWvOdQ=1ZFKLKLOojyw@mail.gmail.com>
 <20240617134637.GG25756@twin.jikos.cz> <CAK8fFZ5E61qNKC5TtbWm0vTtRMS0yRt=TE0gP8HnamYig+vJ5A@mail.gmail.com>
In-Reply-To: <CAK8fFZ5E61qNKC5TtbWm0vTtRMS0yRt=TE0gP8HnamYig+vJ5A@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 1 Jul 2024 13:39:40 +0200
Message-ID: <CAK8fFZ4aRZj7PSOR9XsiVDUi01HMx5k8w4Gs-vntfB41YvAc0Q@mail.gmail.com>
Subject: Re: Linux 6.9.y btrfs: "NULL pointer dereference in
 attach_eb_folio_to_filemap" and "BUG: soft lockup" issues
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Jan Cipa <jan.cipa@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> >
> > Hi,
> >
> > On Mon, Jun 17, 2024 at 01:33:59PM +0200, Jaroslav Pulchart wrote:
> > > Hello,
> > >
> > > We recently upgraded part of our production environment to kernel
> > > 6.9.y. Since then, we've been encountering random kernel "NULL pointer
> > > dereference" and "soft lockup" errors when using BTRFS. These issues
> > > occur sporadically, sometimes after several days, and I haven't been
> > > able to reproduce them consistently. Due to this unpredictability,
> > > bisecting is not a feasible option.
> > >
> > > Attached are console logs from some instances of these issues:
> > > * "NULL pointer dereference" in "btrfs.issue.1.log"
> > > * "soft lockup" in "btrfs.issue.1.log"
> > > Any assistance with investigating and resolving these problems would
> > > be greatly appreciated.
> >
> > thanks for the report, the symptoms match the problem that was fixed
> > recently by commit f3a5367c679d ("btrfs: protect folio::private when
> > attaching extent buffer folios").
> >
> > > [1072053.328255] CPU: 15 PID: 2354438 Comm: kworker/u195:18 Tainted: G            E      6.9.3-1.gdc.el9.x86_64 #1
> >
> > 6.9.3 does not have the fix yet (unless you're using a manually patched
> > kernel), it's in 6.9.5.
>
> Thanks, we will try the 6.9.5 asap and report results after a few days.


Hello,

we do not see the issue any more with >= 6.9.5

Best regards


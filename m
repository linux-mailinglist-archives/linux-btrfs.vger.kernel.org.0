Return-Path: <linux-btrfs+bounces-20890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ByzNnnNcWl1MQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20890-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 08:10:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CFD6269E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 08:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23C19524527
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37935770F;
	Thu, 22 Jan 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="a+zn/nWO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D353BC4FB
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065757; cv=pass; b=T68p2KwBzXGS+oW9CNKHO/mZGNSjNrXhTHd1sCM1eU98Y+pzTNgX9rm6MMfg2mma7QV3B3le/9LExbqUzboVmgQdiLUC0A+v/XMJrFsA/k/TPvR+M740tIbVy9rc3jUkvGOtepTu/PONBPLsOdieq8ZNDUm2dY0GkbbVHI2z3l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065757; c=relaxed/simple;
	bh=ITENsgm3PGVTe6yqyFLBtbKX9XRG3MOqIOOf74VDDrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzXf4/Wm5VvnUNEvB+IS4bx7CahU6oXMmu8DUb9Qt5uWO8uIL8zcT3LUJLG1VF6U7GLNNGJGS/Qoc/tqvAVD9+xWPTA+WnEvLsYRR+xFP1VK9uW9AA4niG8ZQYIn/2hKEsE2F4efAK31qgyV5LekFf1ycBDFB0eR5HynZ5siC88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=a+zn/nWO; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12336f33098so664834c88.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 23:09:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769065755; cv=none;
        d=google.com; s=arc-20240605;
        b=ivhDoykp4SMTOB0CfjBq4n9Xh7e7Z1ynOq4zWkCOSbLqRknPkxhwyODBDrLvHlEB5y
         lIYIEARf3giiho65JKwbLS915VRoiXpZwPXv/hYRB3StWoOBH2nJWnefdGv/g/RCmmF3
         FU6gapZzM8pi7eXFCiU1C7oPXsC43XYJLe9womqNYo+UjMQ6wxEjjLXmPZyRmrNk2aic
         Q7xsI9CAxkOlKsZpihnmLFElPtp04b2f5N50GtsyX8BmiJuVr/4NGupOogkDwxU2Y+Kl
         nG7rtDCoD2wpUaJkbOATvz+ywT7/5BMhwdfn/IgMVFth3nH6ObhnOPR0urc0kZmXIpzX
         wHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITENsgm3PGVTe6yqyFLBtbKX9XRG3MOqIOOf74VDDrY=;
        fh=rD7AFfHGIGAXzMbb+0dGu9sQfGgQoJ+phA/UaO+6iIA=;
        b=C46ktwb29h8d9i2v+095O1DImvxKlEIS6IaerBDAEXqUpB8Xf7JN2PSKhVhITszG/0
         +ZLF+R3gnCa8TQqkgW2XUKXsG1TTu4uY9mb5HDfohjfliu/Ll9WFm1zwLp/GbzcwkixQ
         yjvI9QCGWdIcUzXrhOfUbu4cu/FY8apX4dRms/9vRrLL8CjozhYmlX56fLVfvSwiakfg
         N3sP0knuignDuD8H4isbCKXdaVEtNZyq5oujRTMK1N+GuV8H2xbdctM3IvXLQ4ymv7c+
         CFvtz8s17JzqhwtXVoc91eG1yi+Gb4N9GeJc+8SjuJzQWaOUZC8bBZG6clEbT7uY++d8
         JfMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1769065755; x=1769670555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITENsgm3PGVTe6yqyFLBtbKX9XRG3MOqIOOf74VDDrY=;
        b=a+zn/nWO5Fx6pQIEofpjyAJTFRDUiyjRp+erjnMtUktRIB3ODTCpNC9zB9nf2GjS88
         M6N6Kzv3aWVe40Mt29KDVgj3s8j2uKVOkugtdLxdXMx6WGZulqAX9QJanHShpK7pnsjz
         SDvV4JTMvPy1LXv3ary5dmgyXyjznTpgf0R0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769065755; x=1769670555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITENsgm3PGVTe6yqyFLBtbKX9XRG3MOqIOOf74VDDrY=;
        b=Dc+rD7zcMbEdrzzlZhkAamqb/TfdxGZj67lp9ggvtEfynPY9E/rIk02X7LD1BQbgy5
         gr5O+AzJbSPJfwtHye2qzdJ0e2lyU1tehQEPY1K8GWw3zRzjP7i7ZpoA62reVWKl4z0U
         y8t6eoKlHRDpCrsxfJo5r6hv9EPMCTkGURmo1UVlvFMZLo/cxA6OXqE+0vg9IT77nBiW
         Bk7uwsU+tlH5OHf30JzvGuXgPcCVSdUDfLqtIBjjyadANjP8h3yzY+5kjyHWmFAB6UWF
         vo6x5nysM2/F71Lgz0E8bjLy6V8oA6wAA8tK179M/Dv/PVMl7pLZ8C9nT2IjWje1ON0z
         JhGA==
X-Forwarded-Encrypted: i=1; AJvYcCXtuw5PfejRl3W7mAyEI3PAAHLVyIqRbux2ozfJy4KBzQZn/6ymkoWOVbDkWKS5yaialpAjAyspi/9/7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyHy6E9pjtsMDpeizRh1tAp44H18sepMvBycv1fGCzBPPcmRZ
	bi2dyT7H131MoTrLy6QdhAaRNB3a+43C2bQrMTyumbD0U5A4f+N2DCR5sRgmeT7IVE1G7fCjCcT
	oW9ql77E9v7nEsnuMRhdA2xs9zSmt/4Np/PamtJyg
X-Gm-Gg: AZuq6aJoE2F73nr6fxo9pLmW8fJPeHMVqeCTNIJmjmxmESHoSFt7BytOEixE4oqXKKn
	Y3RaMDe8NCvHjCm66bUkHaHDCjNBbpsus6647S4hHelm+s8m0V5RPZgKDdNDbUioP2UMW4O+1Yp
	aaC8xLCzLv+iBP8dfxGUG5VMFXnAyYonGjOSYcNkHvEHxlHz94ZaX8JgqhVs7FPsOKl9zV1n96m
	vieJL46tdRJ4n7jOqkPa+LIHB7eBpElrkZ59xphL9vWXI6/SS0FJ+gBs1AMOoasHQrte4bk
X-Received: by 2002:a05:7022:2386:b0:119:e56b:91ed with SMTP id
 a92af1059eb24-1244b35fcffmr12268276c88.30.1769065754553; Wed, 21 Jan 2026
 23:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ6EBcV2p8NRBbKxWQj16yzKVpn1gsobvcpgjz7QDnyxfA@mail.gmail.com>
 <34dc9243-95a2-bb3a-2182-0e6ddf16c3b5@applied-asynchrony.com> <CAK8fFZ6uE7iZNb3zjFGZLXZoscB5PgRGXCwXr=6YzYr5v442Wg@mail.gmail.com>
In-Reply-To: <CAK8fFZ6uE7iZNb3zjFGZLXZoscB5PgRGXCwXr=6YzYr5v442Wg@mail.gmail.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 22 Jan 2026 08:08:47 +0100
X-Gm-Features: AZwV_Qh7_6VZGZn5It6P-hTyFaIQbh7rhQuS-qTL0hAlxiCNXFUuPP0WFUwbdis
Message-ID: <CAK8fFZ4wXYoFnoS1+DjMku6wyWd3tVUn5O+bN3qsqYEpagLBig@mail.gmail.com>
Subject: Re: btrfs: refcount_t underflow/use-after-free in delayed inode
 update on 6.18.y (works on 6.17.y)
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20890-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gooddata.com,quarantine];
	DKIM_TRACE(0.00)[gooddata.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid,gooddata.com:email,gooddata.com:dkim]
X-Rspamd-Queue-Id: C1CFD6269E
X-Rspamd-Action: no action

=C4=8Dt 15. 1. 2026 v 17:03 odes=C3=ADlatel Jaroslav Pulchart
<jaroslav.pulchart@gooddata.com> napsal:
>
> =C4=8Dt 15. 1. 2026 v 16:05 odes=C3=ADlatel Holger Hoffst=C3=A4tte
> <holger@applied-asynchrony.com> napsal:
> >
> > On 2026-01-15 15:46, Jaroslav Pulchart wrote:
> > > We started to see a kernel regression after rolling out Linux 6.18.y
> > > (vanilla-based) on our fleet. Systems upgraded from 6.17.y and were
> > > stable there. With 6.18.y we see refcount warnings in Btrfs related t=
o
> > > delayed inode updates, followed by a general protection fault and a
> > > kernel panic.
> >
> > Might be fixed soon by:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git=
/tree/queue-6.18/btrfs-fix-use-after-free-warning-in-btrfs_get_or_cre.patch
> >
> > (unless I'm misreading things).
>
> Thanks for a tip I will apply all the btrfs patches from the 6.18
> series and give it a try.
>
> >
> > cheers
> > Holger

Just for note: Yes, that was the fix.


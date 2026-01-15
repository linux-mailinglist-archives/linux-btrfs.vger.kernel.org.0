Return-Path: <linux-btrfs+bounces-20544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FEAD25981
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0026B30262A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC830F54B;
	Thu, 15 Jan 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="PYawOAWM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D92C0F68
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493012; cv=none; b=ECJp3OMBoUagsnCIXpwzVGjg5RrSa+JagqNvNnaO061Rg/EuCjBRpfoXMF1D+g6QPyuZAnbHLY9qHMbpUnQxQSL+ibjTG01+kr+oEkEn2PRXK40bdtNFfdtExyAHgM2wLkQPTlv9agcRB78LhypgBCRmo7APo3k9Vpcvf2BeRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493012; c=relaxed/simple;
	bh=mBxML9gOhhwyXXGjIjDgrKEVP5kaCpj/ZTMAbIzibdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDdMqxZdH1uCGDCVUmXwZzJv35LIO1T2IWmF8EDYO5ZeOCXLCTGTe+bbQFgNDopmQ93YmWd3UKxUZo1t0p6gG5NYEJqJ3MEX2n98CBtT/QIlTfy3PM8CQH1+WjchLmkgNPjcurOFBCWHUxyZu1tKlJlDNS2SFW+OuNuvlKqFXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=PYawOAWM; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1232d9f25e9so1903748c88.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1768493010; x=1769097810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBxML9gOhhwyXXGjIjDgrKEVP5kaCpj/ZTMAbIzibdo=;
        b=PYawOAWMNE0dPNb07NTklf+jvAt7X266wczCvFfsJBGLhubyMgZnx2nm8CKn6pZvsR
         HN6gPAPOpgBNzccaZZGeokdhbMTEJBv55U94JjEMzzPhy6GdCPnfea+XoRlpKNVJtLql
         YBBTiR5Bwbt08u9Ak3g66gZ4ZBIbUG9Ax7j4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493010; x=1769097810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBxML9gOhhwyXXGjIjDgrKEVP5kaCpj/ZTMAbIzibdo=;
        b=bF9MXpN28EBD4wdh20hqoZ2CwytnLXGE6sNZF6xB/Z9COGUZiOepyLA0n6YchUv/FZ
         n4FZNmQKrMIgXGTYDAmrASkkqyahMh10drqGwE09yoMz4/bPsEPjLD+KqcZ+cPVC2iU5
         Z3ivtOhK6OaaWP+7RUcMFI19LT76aeHsK8JXpzmkDjpmC4VXr/y9V2TL62k09J13udNU
         ftHkVuULKOs6eE/9T0PrpIgqzVCEpbdEr71GKnHZPzIdnez3Hzb0crMdx9dy4sn/RpCS
         KYfG98tsFkZhDZ9uA+Ke4yeSaZZkpompcampa8l1Rq617Fzw+38PI4Qv8cVTJcXiLjs5
         jejQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1RYCJOQC8C/fq2KTZe3d0+SbdeX6972RMfUZehLM0hQWhvxMumAytz0ZCXD0CBZiGgGcmqZBIycgnKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FHXUeG3IgvL3zclzTwFwP0owlzT182shVzyg7ndWWlRY4UiN
	KrAVM2LrrgiRIdTX1sTuI8JvKtEg7xmWqWpqp6U+VjA/CFH94wpVG/DKzFvbVquo7TKpwlLmcyc
	wcxGdE7Zyr1z2EBn7lZI7+tJjPCKqPKYzzlR1sp3g
X-Gm-Gg: AY/fxX5kjZ5f/ckdSGFRmixG+7Df5vBppRt2/Na+cZo0IjJBwWhNnUEv7a1HSPcrcyO
	VGyzRaSRTz67Vjm84txtsJkyXrWQT4+ioaflKSgRDhl6ugOgf1iiCEEVVu4F4t9PAej1kcQO/jw
	9Ku4qeweWfOCTDmUdoBbalQeh9G+FB00G6xhMHt96eRaVH0NRBsQpD8Vu5GdaKfEFpx/78gjkhp
	B9NxEYlFrEaS3HmLJmAPnHTtw2acyra6sZPoZgjmlZIKBedj0z5p6ceg9nco65fcFcANCRO
X-Received: by 2002:a05:7022:2386:b0:11b:9386:8263 with SMTP id
 a92af1059eb24-1244a7b4f5dmr70259c88.48.1768493009398; Thu, 15 Jan 2026
 08:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ6EBcV2p8NRBbKxWQj16yzKVpn1gsobvcpgjz7QDnyxfA@mail.gmail.com>
 <34dc9243-95a2-bb3a-2182-0e6ddf16c3b5@applied-asynchrony.com>
In-Reply-To: <34dc9243-95a2-bb3a-2182-0e6ddf16c3b5@applied-asynchrony.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 15 Jan 2026 17:03:02 +0100
X-Gm-Features: AZwV_QiDE2LAV0hRi1xI2rCCDxtMk8fOJVHWycdh7gew1yLvwK8A-uAvjnTzP3k
Message-ID: <CAK8fFZ6uE7iZNb3zjFGZLXZoscB5PgRGXCwXr=6YzYr5v442Wg@mail.gmail.com>
Subject: Re: btrfs: refcount_t underflow/use-after-free in delayed inode
 update on 6.18.y (works on 6.17.y)
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 16:05 odes=C3=ADlatel Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> napsal:
>
> On 2026-01-15 15:46, Jaroslav Pulchart wrote:
> > We started to see a kernel regression after rolling out Linux 6.18.y
> > (vanilla-based) on our fleet. Systems upgraded from 6.17.y and were
> > stable there. With 6.18.y we see refcount warnings in Btrfs related to
> > delayed inode updates, followed by a general protection fault and a
> > kernel panic.
>
> Might be fixed soon by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.18/btrfs-fix-use-after-free-warning-in-btrfs_get_or_cre.patch
>
> (unless I'm misreading things).

Thanks for a tip I will apply all the btrfs patches from the 6.18
series and give it a try.

>
> cheers
> Holger


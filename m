Return-Path: <linux-btrfs+bounces-14782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1BAE027C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DDE17B233
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D62206AC;
	Thu, 19 Jun 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cbp5gBSv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD92045B1
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328212; cv=none; b=f9Mz6AaptASBvlHeTU1dCn17Jpwlu8wRLM3vRnKgg8c6IFUQG93MSmAjh8UEnsiOth/MQWoj2fLyNgvQDJbGl92jRBHsPLRiP+X/+kZIEcEwtbsdgXmoJdJyIHd4z6Mp5xaS8gSEhOPSuBfx+NPGPXxfdG51fyOMc2wF6zSrE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328212; c=relaxed/simple;
	bh=CDmKxS3RKk6fiUkCfxS9KYKSM85M/4FDXV9Vv766FdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1r1uoN2HinvjsxeFqbwtz6cMutDorvRaFEFHdEpeAXfMFofA1HQg/gY6T3fDpCfD8xFa3/sdxXDggP6xJYGQNS3+d4/YnX2aWhAHDvff47vdnmiV8579jM3ZclgJIhDnI+fNWNl+8+e3ZVbDYEE/UApGA4v/qIN2b9krG7+DM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cbp5gBSv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso1072324a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750328208; x=1750933008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvfOdyqrWH0d0v3rCRsdAaezQSZRqspAe0AaVuEmmBY=;
        b=cbp5gBSv37GxcTRqnEJzqXwzSR80eSCUH7+J1yirtb4neAW/Fmo3ILjEpy2lbfnYkf
         oFRnkkICgl7WS6NlaTbI+mq9FXrheWY0ogqp2hyZLoB5kfzCOOQSRhSXl1uVPdEFiDit
         H86LD3W7DV5eNdWzVjKH2z0+URyel6ZMxKdvV7VRDJrIy7mlMHQdv/jaypL0aK4n2+kt
         3BBZrV0xBpMPQU394EIsgKDDw55kEvXjkoUvZbLCq55PXuxJMSQDOQWrM7KNq6M5MQ0I
         AkM5PaPuLW7C8zaaFFYo66n0Jp4VRJN0sQRFLhY0ufRS2UV6TTQNZormT2Z+tU5CdYfH
         Pl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328208; x=1750933008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvfOdyqrWH0d0v3rCRsdAaezQSZRqspAe0AaVuEmmBY=;
        b=exjImVrhtJ8XWcKJNog4BnXYFpwlOoOzgevu7YPSuawBMtskSh9/jKyIU+qKXgliM9
         Soub+OZ3fO0wfZzyBmC+mtfTiI+noOcgRHBYI2Re0h7U9AhqbABPtKp0gotgxvgahYAf
         8Jh6Uw3/X0Dlu3jh9a4CupkSLFiJ5obL4UnT0Rh6D1JHS58u/Kbeg93lyH5HCMx5dw2O
         rKmjAKWjaSNQ/9Z6B7oMEIrMFqdObrxLxT2EDzxNu/BVstrmWueBC5BTBsoRykwUKJF4
         sD1suhmIXMPCxtlJ0ZWzWJNMwX0y1HcImA5kYtmRCyiMGxllzf6HaeEDsvhfyoLIHlHV
         VjNg==
X-Gm-Message-State: AOJu0Yx+xQts6ps4BO4he2OJ+n9C/hXOlGbSu7aV6t3TenUpxrTnMKXE
	Ept1sEqApo28afqdmrkFUfnejY8sNu/3mEcHUfpTWbx3KkrEeBa3FcrwkDWUS3k4QDlvcu0nr3N
	RhJ1NTmKO0JaIR8g9d74+rsvhiEWBOVi/Fjw4rUO0qA==
X-Gm-Gg: ASbGncusLZ26D7UJPChX8MgfF2PMlMjUK2TwVXfykeoaUGjrNgSCgNgFdusFBoP+NR/
	jCu0KfiLvSO2IU3fIllQ4r19TU94sskZuXO/KNQF3mKAduSBcBubjJX/lg32Eshp6X47Kv6F6IY
	Oo66xljoUQH4hrixeqeumXuRKo7m1tmpfKJuO6Dj2bLQ==
X-Google-Smtp-Source: AGHT+IGfGFFakoTcKQyOuGyUEiI+shGZdW35FW8Rt+K3C4pGr0NaRVnUNiNETL2BIG0R0T6VP0jTq24JV2IIsFfA4R8=
X-Received: by 2002:a17:907:9801:b0:adb:1804:db93 with SMTP id
 a640c23a62f3a-adfad4f61femr2071543766b.49.1750328208574; Thu, 19 Jun 2025
 03:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750244832.git.dsterba@suse.com>
In-Reply-To: <cover.1750244832.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 19 Jun 2025 12:16:37 +0200
X-Gm-Features: Ac12FXwFWZK8IUhpu47frbDnqoXd_RMZJvsYNCkrcCndDHu0jVldqQlOhEw7DJ8
Message-ID: <CAPjX3FcJ+fPT=OB7Kw3t6VdMr6h9jJXZ_ySTrc9uPx-E_K2ayg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Device name and RCU string
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 13:09, David Sterba <dsterba@suse.com> wrote:
>
> After recent simplifactions of the RCU usage in messages, this pathset
> implements the RCU protection directly without the RCU string so this
> API can be removed completely as we don't have nor plan anything else to
> use it for.
>
> David Sterba (3):
>   btrfs: protect reading device name by RCU in update_dev_time()
>   btrfs: open code RCU for device name
>   btrfs: remove struct rcu_string

With the nit in the second patch, the series looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

>  fs/btrfs/rcu-string.h | 40 ----------------------------------------
>  fs/btrfs/volumes.c    | 35 ++++++++++++++++++++---------------
>  fs/btrfs/volumes.h    |  6 +++---
>  fs/btrfs/zoned.c      | 23 +++++++++++------------
>  4 files changed, 34 insertions(+), 70 deletions(-)
>  delete mode 100644 fs/btrfs/rcu-string.h
>
> --
> 2.47.1
>
>


Return-Path: <linux-btrfs+bounces-7987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D710977895
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 08:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9182870C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12B185B7F;
	Fri, 13 Sep 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KffF1/tf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4494224CF
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207291; cv=none; b=ei307kUitqXD+HYu3AO8THfR+ZVxog/zid8SZqb49jEkH9xISyFbol1p0Tc9RqzbU19Lfdij6DWHo2ZxnMceEDLibbQx2Po4n4hrfKxE0EqZwryQHKhHmJucXoBTwBao67aBe5srdg1KASbEvhAigD/Lju/bSULlUOYJeKiUJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207291; c=relaxed/simple;
	bh=yqaCnAkZGowFvOqp4/r/DkTI2z5wUOrlTurACOGIdMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=brGqtIZwfLybBQ4pY3dpHo/kNfFReFEcbu+yaWIleSBJKzFQBeB3Lrv72JKsofG0TJimfOz8bizqDfRCQYgFAHD+cWCrslf606E1Xys1p/nkP+JcQimtJ/GH1s+BZbkdVOaDnaLoWnDFxN/EMeMehE4yFjfdAdnFnNFczPOxh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KffF1/tf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d6e2b2fbc4so15185317b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726207288; x=1726812088; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqaCnAkZGowFvOqp4/r/DkTI2z5wUOrlTurACOGIdMk=;
        b=KffF1/tfGjMtKfv3IStilgWCIQf4R85ZvnESJnNhDrPVwpI2X4TCbaB2V7AiOw9WhH
         wmM+h95IV1yZvrK5dTbLtWZqtZEhX1jMvADzCalUjFDnLl2brulF4ONWVd9MOh4qoigG
         YUVvLUXK0fECOsbPYPGHXToWAus0iCSQ+4nlMb9cEvSncF9pmaQukNKqNCyYyD2Meb6v
         7HF/cK4Pz1EZAFDHU7cA0ysQLUs5wJs/TYcvbIZl+ChDP4rIcE2RebzpvrJupf+L9eMd
         /vr7h0MrB8XXtLPypmeW2XcH9p44jkMVmuZz06gWUi9oho9v+Shor2VxOUcY+OVtr+oC
         M8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726207288; x=1726812088;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqaCnAkZGowFvOqp4/r/DkTI2z5wUOrlTurACOGIdMk=;
        b=RkryMep3J4cSRGvLVn9dUTsCDFzLMuG4CVqOqZiY5JJ9hiDU0/N3hubw3gaBuPGfy6
         7HyYNfSfNWG70jMDJrV/FaLxRc72yAXoBmZd2n8SSCxf38xqb0XiNXEHLq0EqLX8oL7G
         IpUYcd5npdTT0e3T/HMVLkyvb6JvTJncWF3Eu77jq5Us55tW1rFIDL/ZfzRCh+jK8t4S
         Wfw7YkNgarUncy5LgItQ8maN5CxQ1+ROMAiV87d/ysjZBsSNMQLMN2FgCFFYOIUY0FkT
         FA8xTPvgD2X0faBH4C8VIrHR9ShRSDds1Yr5SxnnBhFGma4TtGH/PFiJmDIP9Zacqn9r
         GmnA==
X-Gm-Message-State: AOJu0YzENM3E0oW1IXZlx4JltrpvHEJzZCedRZzxS/p6tDq70A21xej8
	mzXBqstEKEBRmnAbfu+uDU5OL3vpozEpHamT6PxlrDXvc5taeF4OtAA7rFzaeIARgWyMjgl94TM
	ohAq8HIfpMBmoVH0hLVp9lMfgolmW
X-Google-Smtp-Source: AGHT+IGLrB8s/bBvBT0Qa9/yFYOav1uaoFqeMqWjYl7wiPbBYHAzSu43mVmNSNHSGZHR21r55pe3j6sSJEWg85n6STI=
X-Received: by 2002:a05:690c:4a02:b0:632:12b:8315 with SMTP id
 00721157ae682-6dbb6b246d7mr49775067b3.22.1726207288526; Thu, 12 Sep 2024
 23:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABk=v_CWGXrH+wzKFLzOSMuAZXyiJNbzKQqox_qm4e1PhfhBQg@mail.gmail.com>
In-Reply-To: <CABk=v_CWGXrH+wzKFLzOSMuAZXyiJNbzKQqox_qm4e1PhfhBQg@mail.gmail.com>
From: fcon <aperture.server.owner@gmail.com>
Date: Fri, 13 Sep 2024 06:01:17 +0000
Message-ID: <CABk=v_Bpc9nAkLoaNAW7ZEO=e9i3JsYqQgVqht0xZwBPx1n27w@mail.gmail.com>
Subject: Re: Huge mistake.
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I just realized I was on Linux Mint 21.1 (kernel 5.15) on the LiveUSB
I was modifying the filesystem with. That's probably a big issue here,
I imagine. Last interacted with the filesystem on 6.10 before all
this.

On Fri, 13 Sept 2024 at 05:48, fcon <aperture.server.owner@gmail.com> wrote:
>
> I've been trying to shrink my BTRFS partition with GParted and that
> led to me running btrfs check --repair a few times because it
> complained about errors, it worked the first few times but it's gone
> awful. The check passed but I kept getting I/O errors upon shrinking,
> one thing led to another and now I'm running --init-extent-tree on a
> 2.76TiB partition, and immensely regretting my life choices. From what
> I can tell, this is going to take a full month.
>
> I should've just gone here from the start, but all this was giving me
> a headache, and at that point it had already taken me days to try and
> get things sorted.
>
> Is there any hope for my files or am I, to put it simply, fucked?
>
> I'll provide anything that's needed. I'm still running
> --init-extent-tree as I send this email so if I should end that,
> please let me know.


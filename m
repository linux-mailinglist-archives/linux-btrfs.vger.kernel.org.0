Return-Path: <linux-btrfs+bounces-17803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3072BDC677
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E3340578B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16F2EC564;
	Wed, 15 Oct 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUZnyyKV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CA2DC774
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501195; cv=none; b=LouU5fVLrOt4DuurkO5mKyoHhPjh5gHJsbip10CzswFf36TZnVuSvaf/F6zV2rUesFLbH+w16SyHgaYljiSTFqwBfUSF8PoeO2NoMHuVHf4zJ3E21dMRqOpgWqW565kK80vktNVrR8rOZPGNQUzxS0Q7ZqvpBOG6i4AfDtMPRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501195; c=relaxed/simple;
	bh=xLADcWejROoePnk5VVOq2jpvBZmzv06KAtTUs64mWZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdYu23xWzyUjbmYj7bqGfaQVkNVCk5WIgYhHavFjM9aageKDcdSCG2M5UW0IgjjGREMwZFVyhcJBWpSrwbFoV5ePa/FAq7u6k/xMpBiY9kzf0Gady1jZSI+EHbLgaMoJ/V42hNxOO2zlyZ0LoU615KsuDWqJhcNdKsduEDAH9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUZnyyKV; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bc1aeb427so6242378d50.3
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760501193; x=1761105993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLADcWejROoePnk5VVOq2jpvBZmzv06KAtTUs64mWZQ=;
        b=CUZnyyKViHkU+4jI7gGX8UlOj/KX9MEa3gMxAVWHeeyp5rE6BPuqzTBRAtG9FU0W0i
         VDEhOG9XuBCpbM6UoVO3fUdlqHgIPtmCgeE9+VRK2aVqDRKZtBR4AEmL1GCgxgsYLz0k
         qDLZgg3jraHu4OCRZBTXoP+IXIGcr3JdXvTn9ugOhYtpgFjS4jo7ytjhKiW5aGOPDpWG
         8QCtNm3nQtGqbsxkpZyGrL5w/UVm7oEcDmspgEhM+baPfyiShSXV4FmEJYcFm23uNDjf
         W/Vi+RVR8hVZRehqF+YNEChFuKApgFiJ9yPTwsjnJmO7LcSt96XGD22EQipkWytiHLdS
         RE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501193; x=1761105993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLADcWejROoePnk5VVOq2jpvBZmzv06KAtTUs64mWZQ=;
        b=gWsvaFf6UVYFxIdBK4tp80WW5I/hZju1+7FXEDNV34eWllyrboOIp525Y2FCnP/fu8
         bcI8gpfvwsb6Pqdje2lTMnPkL4EU5xpTzvrMRuCfMW8BObq31uFd6IkJSwAe60yH0i7e
         dzEk6/NpWoQ4f9qaePvqdbo0giKM4Nm8DyMDwDS9fvvKqmsWYwu5jWTbiaT1LTSqMCwQ
         VhG95cA8a2LohYb3aapk0dr/CWSUjV8jXdqMe3XC/D0+a3gUroZTqDI67J/VnSsTLcuq
         vhjn7KyuV/7/Al8F22Nt1VU3Fkr3u4jcqDt8jfyAa4SwQq0hwwo85mvPcsUoX/9X1yLk
         A40A==
X-Forwarded-Encrypted: i=1; AJvYcCUNUkwk9UZ9BMmvwLGA11azWfyc+udfrL5yXU2Pu07pCq5H1aIjCEf0GAzrS39+wDz5c1dX69EIxSqd0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ZY0TDpcPFsSf/wh6xxfth4Ugw7CJ1IrZDgcj+gJDPQJtL8er
	bDM9EHLDLvnMpDzCZSbaWUZjkw2CvC2cjZQTkQ7t2iwDaDxBn/1hO0buYIY9MBVN8GBS+XXVSrn
	ebRzcxB0F/w42BhftPUTGIaCF9ePyPcU=
X-Gm-Gg: ASbGncuWNY3ADk+I3CFXG6lDbdejWYWQqv8hx65Z/InpAy6Ipl6bW9MIYAVdTnujDRA
	GUgbduS9OMbgP7PF6L4ZbrWJS6+ilfymgEYmck7oJ8ia2WKUigMZA5ZZbSq+wS9FTsWW5EWHkUu
	nhnzLk2NeLU6RoyAuZ151WKqreuY5HmHWFPG9zuKAPGgone21stzLragwPEoXwgQ7hk9SfcY+cd
	N8kttEF0VKXQEjJvMnth7JiNGRElQ==
X-Google-Smtp-Source: AGHT+IEgZCAghqFp6BUTMemX+ZezOIMAIYgGg/0tJbjFOG62hpALrKXOqPFXhkFuvRHIwF6O2NAqlWmT8Wjk9haf2Sk=
X-Received: by 2002:a53:acc4:0:10b0:63c:f5a7:403 with SMTP id
 956f58d0204a3-63cf5a70c9amr9883858d50.55.1760501193099; Tue, 14 Oct 2025
 21:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <20251012082355.5226-1-safinaskar@gmail.com> <bb658f9d-510a-4265-944e-88b2ba83d134@gmx.com>
In-Reply-To: <bb658f9d-510a-4265-944e-88b2ba83d134@gmx.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 15 Oct 2025 07:05:57 +0300
X-Gm-Features: AS18NWA9QBnguL7mUrBuRhl9Z4A1WUX1Ng0IjAaJ95RR75juo7hMnbH2mIEuZfE
Message-ID: <CAPnZJGBES_zs-vpd5vd3hw015gDWAYktgtDbmi22EHp+QW-AGw@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org, 
	Chris Murphy <lists@colorremedies.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:56=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> I'll send you new experimental patch(es) first for test.
Thank you!
Also, I tested your patch on my distro's version of btrfs-progs. If
you want, I can retest on new one.


--=20
Askar Safin


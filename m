Return-Path: <linux-btrfs+bounces-16190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA5CB2F4DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 12:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1313C728825
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B202EF65C;
	Thu, 21 Aug 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9Ny7DMS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B32ECEA6
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770814; cv=none; b=hn74L2PMW0P3ECuJVLfbqJTEFzErgUElEuf6Jnb9CMnQ/wMJD2N2B9SnMR2xqSb1286og485s1Nj1wwYd78HhA46/qbiGS3HXrY9VlYAV914HiIk5kLFOKOO3d8Ztj3UkHdL9YLEiz8lfzdWAgiln0kC3YMxKQ1yBPHFkVvLhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770814; c=relaxed/simple;
	bh=l79ysE7/YxKx5Spay5Rm4pbvXTjzzOGk9Z5RBBD1MFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMEnpmdeYWbkaKsn8dy4z3N1S5IvHfqhtcATVTTwD2p5BJfKkDvikLkX8b/jW5LnOZ01gyw2v6GWyhI1GoJNDaJl/N+ethvIoFjFZ5Te6mOuoMYs9xZZ3QSJ6vAPUjCXnCV+laO/vOvWmV+imG2WtzbSRpRWL/ooLftR1Pl85CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9Ny7DMS; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b47174b335bso113457a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755770812; x=1756375612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLTDnq2eiuixRcfWgH+r0YbP50YMK0XvV/+DIS87XHM=;
        b=O9Ny7DMSlHVpy61e8e9ipyhbXVz/h+8D+IvT1skvMP6rGNwp9d2lc0kHeHCUFLaK4L
         dcGA4okH+C2wMj5RnsDRZBhUKEqNl1a5oWjrQD38gxwk9IDsgnLfF57CkDb/E7XAJ+H5
         1sUKdJ7on7U/cq/5XzH5AQ06lDaHreM+iFHMbpY1PUnt9piKdieGVchKVmfMpIdjySUd
         z1ulyyCRi3uwLvN/Qe1pi1899LcVHcX93eY1ty79euADYWfMjuvuTtKRwDPSUVWPf8a5
         4D3t9cs+bOAWLxB3rixNCh0VZjoqvTKq/YXgfgvmJ1ok2kEERWOAqEl0Hzkrhf1BKZYy
         y43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770812; x=1756375612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLTDnq2eiuixRcfWgH+r0YbP50YMK0XvV/+DIS87XHM=;
        b=NxMtm6/+1BOKPyrnmeECb/Cqu3udHTMC/7oBaV8u/s9Qba6WK+UvgPGDK16R2Yq6sB
         KFaXo6Q91qgWh+2NvFhGExKob+kKH7p5ANBHEkqw+SKjRSgnV46vm4QrWlt+QYYrVFrX
         Oeo78AIrD9sYo+bxfepLWZlz3qTBZb10s0sedUakREoNlHUbU2u7uxeM/FcVGNd/YDvm
         6RthWiK57nxqTvZdfzA7kKSQls5oNxdiIE0trphLMb46ASCzUc0W3B8Gn+psq+GAl9w6
         WGWcSDNA3mdcvlwFtho3y8J1LTl5anAB4uRq145dmJtDgWrRTzILtOlimso1fal5oYbF
         iHGA==
X-Gm-Message-State: AOJu0Yy9cwEb5/On9G9nPDiRej0YLSjApGo7E1GuXd65cjsJJeeN43Y+
	a4r6qXtkp9DHZcCvNM9ULRYojdzPPceH+7sU29AgOjYkZePtAXKNkaOM
X-Gm-Gg: ASbGncuAFVbZibokRewtmngHbSxWR4puxUiYKsYkyu5ZP6d7rVe+h3okEIhVRhTqenI
	bLhE3yiNct3HgrqklL8rTjpFAiN7htRHd1oBxn0LtR8TBMP17heI5Pl5KGVHvP0QE+cIiGVrGSG
	dazT41aDe8Q4Oe9Ug0bj9ElV+4JSJ+eIcZzTKsHaMODwuhYoDREQocjajGHUSZYyv6M/YZhSXoG
	v6CU2fQpoKTh5DPsLkhgIDZXEkvqGfCpFFfO8pZddQ9sL3CeNa6UPiGM28hn2AouGZiNnVq9Zqx
	FGm4BpOfqM+ykiPajGC8fo7hpAPRlAynkSwFuakAmuB4+hIQTfS5BLJhj4oQgumze1Slrj+SQWs
	nnLhC1w9X0kbcc7KU8Re9P+U5La/a6bnTYMRu3jLxWDJp9OB1Urj/z/0=
X-Google-Smtp-Source: AGHT+IGIEUUD1ZjYg6IoXktIVqMwnlPwL0JQn8ta6yh9sNgjWCNuBcA2BHXf4S8VY7rWnPUx6CspHQ==
X-Received: by 2002:a17:90b:314c:b0:31e:a421:4de1 with SMTP id 98e67ed59e1d1-324ed15457amr1412264a91.5.1755770811730;
        Thu, 21 Aug 2025 03:06:51 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fba7fcsm4350751a12.10.2025.08.21.03.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:06:51 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Newbie questions about DIR_ITEM and DIR_INDEX design
Date: Thu, 21 Aug 2025 18:06:47 +0800
Message-ID: <4682834.LvFx2qVVIh@saltykitkat>
In-Reply-To: <32f15414-0ed0-447d-88e0-6368f29a989a@harmstone.com>
References:
 <12726025.O9o76ZdvQC@saltykitkat> <12736164.O9o76ZdvQC@saltykitkat>
 <32f15414-0ed0-447d-88e0-6368f29a989a@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> No worries.
> 
> It looks like another factor was the fact that the original version of
> getdents() returned a 32-bit d_off on 32-bit systems - which is okay for
> a monotonic counter within a directory, but no good if you want to avoid
> the birthday paradox.
> 
> So if you were designing Btrfs from scratch today, you might choose just
> to have DIR_ITEM, change its hash length to 64 bits, and disallow hash
> collisions completely.
This is exactly what I'm thinking. I came up to this because I have a quite 
large dir whose size is about 66M on my machine. It works well, but with both 
DIR_ITEM and DIR_INDEX, the size is doubled.
> 
> Mark

Thanks,
Sun Yangkai






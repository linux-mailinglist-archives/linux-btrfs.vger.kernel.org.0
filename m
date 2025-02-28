Return-Path: <linux-btrfs+bounces-11933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4577A49228
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 08:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D69D16C4B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268921C84C3;
	Fri, 28 Feb 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W89eSf8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1E276D12
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727713; cv=none; b=QBiXYQ5XI22/ub/r0uZ/qDMg7l5Dc3ui2MxnFXcHVT3OaCPmWiwZ2GrQpZ+dncdxpF3asaWoOpd+GMKAs+S4UmeN7N4ix/9LPQAlLvmOlbF2yvnioDwb3oCKS8sKRO0imngP7jHgASAi22z09/2p5ZLFuqB1m2kXc3g4v4BsCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727713; c=relaxed/simple;
	bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snIxrrpapDzmrznSwIji1nahmAVmM1DhAHO0olC3gl7FaIkr1d/RqXwOap3YrauqI66ZyPQa0vmIPT7jtYy9TRqVYhDTlkH6fenQV+HIO1XdeDUfIMhVr//jPTjFVDDny6GRncZxCrMG5nHbVIQ5RspLhvtD+C0ovNOB1ebOXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W89eSf8I; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb86beea8cso319490466b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 23:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740727710; x=1741332510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
        b=W89eSf8I5OV52Kj8YfabcvbgIUUZsBfKOegCt/ue0Hdk4YRAewVRoLGUn/wZbXfX9i
         7JCxzIRjPPJyHiYMIo85ZLdD6hJQRK6WijCNSnf3dU4GKVUeSAOVy73dL4/4Bh4su8pN
         QGATkjB5TC3cGj60t1pu5D6a3KMlP+3ctCxStE51jPRjlN/nq0ADjlw0Oci9GsM3QdP3
         wG8eFD5dORtCe6swbDX2R+MIruUbN+xtuLoFWuUjSJGDeM8ENRvWJ+32mO7yHdYxGNaV
         60ZbEfQ4Om8RQMlVw8GnI3Ok9xsMTzlNq5V9GQkPcYbFbRq7Lw4yZZFUqz2Qy5v1MiIr
         CUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727710; x=1741332510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
        b=I4xc/3mwY2TSpnv2BL6K0oQLz9/cIcfsMZfcbQkZRrgYIJx3D309A+6ud7pcXo1iir
         gu4Nc/WyDpICsljxtHyHjUAI2piDv23hrhhwLIb0n2Q5DDK3Hh0+b7hjLB4KFcd4yrP7
         Uf3No48SpXba30ehFyOM90IKe8vaNfy/uD58/sjVaYVs/fFr/tkQFdnl0tLYVrxIBUcB
         RCr2FQpudOdw6xmH1b0BradhTgvqMiTeT0x24TQLwYQorAmQPd1nc9iFm69G3ZG1Lsgz
         wNrfkJNpHYyJJr6ReLCB9tRDRdGE8JixDordtv8mH2k6N2liAWn7QZ9rzfTNQMEIBRXT
         KQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu+B25Uu/8AgxGQTYexDcC49P+7UANKDq5IhWbZdRbnnnBKMcuvnwFTEI7LyqTHufTzT7xixMGZZ1vQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPiYBql5zcyUtaFT8EGYH3ozXboLUktH4Mc5UILs5k9aDkEBwe
	tArc3qFdYLAi7wposp8hTi0FOgA525xt7x+W2j/7iQAnbyNIVoyQs2BjXkj7BtVYes/8USMTu6E
	0XQ/OJO97BgrfSHs1QgpoUhZ8MbDvSNhCDJs7DdxMdluULVtM
X-Gm-Gg: ASbGncuJdbLzQrmMRenJkbljOm1jxVcnoPcf1jRbZg5WDDMI2CVbnIwpyhTzzffU3Cx
	ERWz+14+fhDtGgTdeNpSHsIIcp/yP8yjdO7lSMvuUTY+byWN1VqNfxX/8aZ1Yh/v2/GLGJvGT1U
	pOhOBwaw==
X-Google-Smtp-Source: AGHT+IH4R2kwv0u7uBbeTCbIGT9I7myGSTMV0EyCvRJQSjFWiBGZ9j7Eoim4HfepcT8u4R2D8OoUZRctTV9EXm3dlfA=
X-Received: by 2002:a17:907:7287:b0:abb:b092:dae0 with SMTP id
 a640c23a62f3a-abf25d94490mr232283366b.11.1740727710003; Thu, 27 Feb 2025
 23:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250224111014.2276072-1-neelx@suse.com>
 <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com> <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
In-Reply-To: <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 28 Feb 2025 08:28:19 +0100
X-Gm-Features: AQ5f1JrQfI-ebfKEktHHPxhekjNj-rUhiE3xW1tYIfMsVeEO0SQ5XlrAmW_euo8
Message-ID: <CAPjX3FfVUZ93n0fE+yNdJAQyxmf-SREz81cJifr15PYp26ABDA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 07:10, Anand Jain <anand.jain@oracle.com> wrote:
> Fixed the changelog and pushed it (for-next).

Thank you.


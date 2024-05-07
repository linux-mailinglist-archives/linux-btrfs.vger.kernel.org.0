Return-Path: <linux-btrfs+bounces-4800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9D8BDCAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8717285BB1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302113C67C;
	Tue,  7 May 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifye7cWF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397813BC39
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068130; cv=none; b=X1RvUKgIougOraTF33/kuRTLP1eLpFN+2Ut9d6un3HoDYCHQKx6MbxeIDXVX5igP659FFO5CJ+n6iJhbUkYA84ajUvBVw/3QLOuYCgbbuO9c3acUQYnoXzc03TMh39o+zdpYbD+Mby8MZTeY9k6ScXCVvB33mYG287WbZx7INZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068130; c=relaxed/simple;
	bh=7JOEemcGXX2zwMUt8FNgKwIivENn+cXEdEVN8HL/q+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuyhBRQk5g8sxsLdF8oNuAzwDW+eH4uGScd0KuBU01dWkoEiucW6ch4b2OllqQFXDmEV8X9OYFMHgXrmkGZ5HcRMnaoXpFOCosY9W/+Nq2pUUJSRQU5mcDPsx/cRQmrzseV+dXbae8hASFD6PjPfp7HhzNgOntPD0gJ+SfhF54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifye7cWF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso37507861fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715068126; x=1715672926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JOEemcGXX2zwMUt8FNgKwIivENn+cXEdEVN8HL/q+A=;
        b=Ifye7cWFFjIsr4dFxNFSRZ//1egwhDSBE9MwyiR9i8jERa32zn92xoxdoUqOteCjlZ
         lZmMTPuoOniFsO4I84efaFL+nPtHTZ9TMejpUaz8TePhb5hfZ/MbovIZP/ENsqOiyT8K
         2cITe9hxr61iXI8bYBBFeta94XUOvXa+7LWsi5MqkRTncTT2mibR//qoBh0opjx8/ZBz
         KZlF7Sio7JeUvm/FgrblRO2usdYnDCEHdRNOxx9rmUdgzav40i78i257AEiMa2qcyW0T
         uo65l5wfAxnt5pdnTrHqolKnnExqG/5AUBLkiH5q8TXIn5qsNEjLKkwkMT5QcjIYtQ6B
         3Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715068126; x=1715672926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JOEemcGXX2zwMUt8FNgKwIivENn+cXEdEVN8HL/q+A=;
        b=ajfBmLCr4MUHLwKH7DTFdWt3QCh/YeKP5c8DusqddJUPeHn0coqTxWnIryJ89P17G1
         Pg3/v85l9psd9/tEfnEdpCTaqo3d2tYCMblunCv4r6fznbgnFA8CiZ8AqrXBhTBoKQDM
         C6eVsa0sb3b+6VwtU950l0IDWkYP/FnjXnVzx8iv9V7uir27MTwKSL+lN9wG9/lqU+4q
         A0mrKqCMf8zm7HyKVdUiXX/o60brRjiU+LbRrLCIyb9PBuqXTZuZ+lioZSSToTiIWcAL
         Jzcx697HjK71FIbnBLbTxy6+s3T8lM/RzDTxyaRRWzzpmFASH3vpRFKfoMuwqehOeLjM
         tEyQ==
X-Gm-Message-State: AOJu0YwW/fW6QXi7SOT/IMM9nXyqKdOEuqoy/1KWkWYNL/ZDy/Ul7S9m
	B7anz0N1x0DudzLgz3XroYAeOKk/QTiFu/VlXnc33N3DpbT4E0aXU+RJ2TTnK+3n1ON7aDIY6xZ
	6/zjsDoj7WTdX5uaPLwNErBlyT7ab6Oh8
X-Google-Smtp-Source: AGHT+IEfN4Zuxb70wE399Gaf4v0/UX7IJhjkypgHGuz0RgOIHPd5tINVCK0l8O4PHUOhsWaK0/iRhfu1VTOEG90Wwgw=
X-Received: by 2002:a2e:2e0a:0:b0:2da:a3ff:5254 with SMTP id
 u10-20020a2e2e0a000000b002daa3ff5254mr9585536lju.1.1715068126358; Tue, 07 May
 2024 00:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715051693.git.wqu@suse.com> <bc92cbbcf4c530b18b27a4989767188ba8ea4f96.1715051693.git.wqu@suse.com>
In-Reply-To: <bc92cbbcf4c530b18b27a4989767188ba8ea4f96.1715051693.git.wqu@suse.com>
From: Yordan <y16267966@gmail.com>
Date: Tue, 7 May 2024 10:48:13 +0300
Message-ID: <CAE0VrX+tqJ3t3Hmu5wE9fCk2RvgNvEE7UpFs2UVVo02-Zd7+rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs-progs: convert: rework file extent iteration to
 handle unwritten extents
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Converted both, the small and the big 24G, images properly - no failed
file checksums anymore.

Thanks, Yordan.


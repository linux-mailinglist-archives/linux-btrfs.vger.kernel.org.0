Return-Path: <linux-btrfs+bounces-15584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECECB0BE71
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 10:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F747A4B7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D285078;
	Mon, 21 Jul 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsYnvStT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F772F4F1
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085278; cv=none; b=onX5k32YRgxSeyFjW45cik2Ck9vTcWsqDW5eFHYpqj189vsNMEwjEyS+ila74/64irXZ5F/b6nHG04SWHPcS9+iUc43t3uCR/DzV0EeI4rQVPGZQ19w1g4UJ8IriR77wZ3o2LKrFfRIhiKPkXx+WmiBlssTiVCv3w8OMeAPJYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085278; c=relaxed/simple;
	bh=+PZldj5NuqlJ6HrxzCV2L98xwPb8SuLMw1jQ09JF0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjoDMZSFk3/nQaLG3W9KV3T9/eo0o/co594aH8noTRRnl1JXW/Chm+SFHRyMZyQ5c+6Vpm7jiIiG5xWpJVCabKKGdnFjlk4HSC+Tr8m7BKBNTyhysaa2Jv4xagwWVhOh7/QqR/4ZfSBLfJCg6JQ2Wqs4tUGKqEMdbMoR0ilBlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsYnvStT; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f161d449dso6006912241.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753085276; x=1753690076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+PZldj5NuqlJ6HrxzCV2L98xwPb8SuLMw1jQ09JF0iM=;
        b=NsYnvStTHeNcM9APt9wzHjbQFFL8osCAj5iiS1yjY237fGhSBIJKw/cVf9/lskuXtN
         MW1eUZeq5ga4XAnM6o5ZPC3dPx8P9Ofm6Bue5sqaEgNJ7k4btVmKu0uqusNshiKcUHvH
         y99QuarQmJh2LX+OrINzbkulA5MATPvuGraYCM5rAAobzLXTmo9mU/bGgkgutjvnUxK9
         DNdM2kddRUODnHzDyoBywLTQOofrg6Mt9RSIQM7voh8EoFd4XW/0bLxr6eepoUMzujC9
         TQMnvdI0mnYjLEsJZBv9T+fEBKIUEbQUW/dNYHzYTDz5uN/Mp3nPmXd/ow4KRWJ+5u2W
         6QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085276; x=1753690076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PZldj5NuqlJ6HrxzCV2L98xwPb8SuLMw1jQ09JF0iM=;
        b=EwlmS7S9lae8dPTO7Q1vU++Kw5VH/jSL4yRgV/d9pMWWxqyDxnvf8/hH97VfzEwwtt
         MEUJiKMY2B0zBCjxoWSE/i9pBJ6B1kCPJlZdeNodY0GzeFNSBl7+AmS6Cv8FRfttBPkX
         9tyOUQOJukXsoEWrXJdNuOgHtL3ss7z6ksuoNTjObTwwKoNRDZ80AqGt/aqO9CNvtQC/
         iAlCqBexZBQqfbsMwmobbB+Q7UhpgfqzLv6sjMjSWL7BctTKgVwn8gvLF55oO215kw1M
         FUqokjqnga6Jy3eoiVKcSourQWXgsNyRGaCj8zQgQ8ZBACJu/boMJ2PGqOpMXXv7MNaz
         R/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWuAANNhQGbLUKBXB94cgYsRw/n0TIEZYTTYsNte/D6AHA8+ANXYuDiyWPrPflU9nfwGyzLDhaI982w8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyr9sxV2FZijTyy5YWt+f01cmWEfwN9ttGZV+xbC+tHeHrjZ95
	9vKKROibfs8Dt+R2j+3/6MbwPGFBPnN5nhdTxXnOQJQ/glnQVcFHLJFUIsETZXnaD8CdLnGoGOo
	33p0wIRBXrcyJB2OYMK/dNOF7ujtlU8s=
X-Gm-Gg: ASbGncv/BScVCGRTpdrF+Woo3YcWtcBJXd9iO/zoTvcjg7QLeaMD41HuDVl23tKoteN
	n2+lDv+VQ+chvXjmqBwrBFMDHVQA4O8xBNixmcolZDN5s8AGqxQIGQRQTrPzgJbGtcP9pH/06IM
	kaZKlYce5/OEF6tM0nHOIVra5UWRYmdz4KTiXNeTAvmhd6HO/y922sVU5B9fnmuxehxNFoLpj8b
	T7LFu/cfiLuthcxww==
X-Google-Smtp-Source: AGHT+IFcOYPDv7CEDMreParp5mbNL+FMZ4W3pJwNCAnXVcSeV8Ki+dhn9f5rwuOnMmiq60KH6scv33ovUBcMUylFFSM=
X-Received: by 2002:a05:6122:3286:b0:535:e35d:49f4 with SMTP id
 71dfb90a1353d-5373fcbc0d3mr9051571e0c.11.1753085276055; Mon, 21 Jul 2025
 01:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-3-sawara04.o@gmail.com>
 <e508301e-4474-4490-93ad-bbea3e6ed04d@gmx.com> <CAKNDObAZHiqromZUimS_V3mfDT5CJaBN91rhOYr7b4nLTh-__w@mail.gmail.com>
 <d873210f-baa9-4f75-902b-e61158e78333@suse.com>
In-Reply-To: <d873210f-baa9-4f75-902b-e61158e78333@suse.com>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Mon, 21 Jul 2025 17:07:44 +0900
X-Gm-Features: Ac12FXyVAELQ0IXZcsQr6btCaz5-ASFk7u0L38kcv5TBY6Wzm2oxnfOJSDA1J24
Message-ID: <CAKNDObB4iTJptxZ=z1gmnZjAsJtALpRrJy09_W53h5BcdEMjmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: Fix incorrect log message related barrier
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the discussion appears to have stalled at 'btrfs: Raise
nobarrier log level to warn', I plan to drop this patch and submit it
again separately.

Thanks,
Kyoji


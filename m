Return-Path: <linux-btrfs+bounces-14224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71814AC327B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 07:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B5D18974FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 05:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D72157E6B;
	Sun, 25 May 2025 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8B2o7oi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E115533F
	for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748150893; cv=none; b=n0RNhoXoLAEZEIeebkIvAjHKkeWWk1HdrV+6sS25LG3yXnQewYQojLsDx/TJiNXoWZWCI1oilZZzkueUJu5rzSMqc+RNZEH6MouDzxXzh8yImkB0OR8CxSOoP6ZETacmU/PIee7c4BWKfbuUggClYYBJzy8Zms/31Ug7s/AShyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748150893; c=relaxed/simple;
	bh=8wFhblMkYeYeEiv4BZ+Ee9AFeNkgqWW8in/zMyyDams=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv7wg0jUiH6ltjFl4t9CT34YOugACUxvRb15CCSdIXELLjcaMgWbHMQzPB+lGhLTtpGqfc8C4EmrexMx+nHt5TfhXGWWLVme7560VkYDHKbBefHiPmW2Ro6k4gsrJwGB3STTZ2YGBx01jdpCVJLTgeuwEeNe3u6h5EUqplJqLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8B2o7oi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748150890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxIb00znYnaQQylpZcqZ2SAmognhEUrZgCmsKXobZ0Q=;
	b=b8B2o7oi5pKUozRZ+p39QxHYEbDuepA/qKq8YiuuqTkxewGGyLprp3Km1OLsHE2A5UhVeq
	WpzwTUkVktx5+DqfRCwmdKwReJCLwIFi1orkeQxoqJvnKt0gcT3jPADFyyK8+FV9XBYk5y
	e8vs22bbrv3kt53NVLmnoNm80CO9htc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-3NX0IAcnMr2IxPKTmB2VSQ-1; Sun, 25 May 2025 01:28:08 -0400
X-MC-Unique: 3NX0IAcnMr2IxPKTmB2VSQ-1
X-Mimecast-MFC-AGG-ID: 3NX0IAcnMr2IxPKTmB2VSQ_1748150888
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2326a6d667eso9507425ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 22:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748150887; x=1748755687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxIb00znYnaQQylpZcqZ2SAmognhEUrZgCmsKXobZ0Q=;
        b=MvT/CH8/c+RBK5+w4PzXI2LcFGyt4j6PfXeX9Dkjl9CFoevCBKkRFknnNOHgOolHM5
         XRBGvEoGRvar7SyUKxhPz2JPrCYheP1Wi7rlJYDFgzYSiCH/NlROdX8m9htS3lkZ7Hkj
         9TJGxc3O5GeE2cMpxPtFQ5ZiF0am9DACTTQzpsPrEBdY6EDJXFHYXXFGB3Ygbah2HShJ
         M7SvWXyR3PKmKmA5xfnkhBi1/W4Vc0RGIW8eNMYe9qJ4dlbpytW8JoKC3nRFJT+9linP
         v6xunO1qdCdeOO4XEO2qdzxxXJJrV12bnjtSANFm4KNP0KZMKDb3//9ohDPsY2DG0Bky
         V8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWroQuwYl5LNn+OM+KnIzQ81eO+nDO027apopt9k+E8RkxvUNJv7safdh2wwVMzzhtUMEKMy2Oh1n/1QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfAcPRHaV8WBVKmKhzoNXKKvQrlTr8sB0Qf359Lzu9w7zreUw
	nXICDiHouGNjkbyH/y1fkUq63cNg6hDsIfPNaMeWsSevHjFNvBMk3THDzFmD511PpuryUZgOqVl
	QVEaDz4/6HAwxbwCBv803R8tEgmRG9GplEVL6FO9xAktnRIdK2yEsJuvGLNfYoMXVN9ej53LL
X-Gm-Gg: ASbGnctyFqnkxLhObFBbhYCdTPnLaPDVclNkKTMrz4NA10ATCFzp+TbIpqb9EEdenfb
	Z3PHZnH5xAMxA7PILANM3NLcviiatyRZMsJ/L3u2KNjTS02oChpiLwKm4xsSqq/7AzkY3z7fLmh
	1PaG3c5YLOM+3DXiaxzchc/WVSNCTF3l2FkphJK1ibeoWbO6zPY0xfLZkDNvv/J9/cSabb8rOsU
	vMsWyvFLglEfLM5+jZx8GwUuGpdaXQ+pRIg0CzcV0PIiELWDsTK8/AByl0Vo4W/wr19IGXMzaTS
	nSaF0Elvrb6GICCfbMTRfvsmZYue24NLDviTBlGAuWphuj9ZfuzS
X-Received: by 2002:a17:903:3256:b0:234:1d9c:33a6 with SMTP id d9443c01a7336-2341d9c3dcamr51304135ad.21.1748150887533;
        Sat, 24 May 2025 22:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8BTG+ZtUDAqgmApyLIH+r0ncMp6sjGvfO50NFDQUn31n1MKXrNWG2m0xGWaqUuQT9hpKIqQ==
X-Received: by 2002:a17:903:3256:b0:234:1d9c:33a6 with SMTP id d9443c01a7336-2341d9c3dcamr51303975ad.21.1748150887234;
        Sat, 24 May 2025 22:28:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23447ef0436sm3458515ad.32.2025.05.24.22.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 22:28:06 -0700 (PDT)
Date: Sun, 25 May 2025 13:28:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
Message-ID: <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>

On Sat, May 24, 2025 at 03:52:54PM +0800, Anand Jain wrote:
> 
> >    3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
> 
> There’s an additional fix on top of this patch that doesn’t have
> an R-b yet, so I haven’t included it.
> 
> https://www.spinics.net/lists/fstests/msg29195.html

I saw you talked about it with Qu, not sure if you've reached a
consensus or will send a v2 :)

> 
> Thanks, Anand
> 



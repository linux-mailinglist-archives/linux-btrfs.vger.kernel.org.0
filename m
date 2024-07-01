Return-Path: <linux-btrfs+bounces-6105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FF91E23B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FCEB25E8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA916728B;
	Mon,  1 Jul 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wH42BY8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5A1662FE
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843536; cv=none; b=pJuac5+6D4c1d2YNWIspIlu1gyB093ru6thUG9ZqkCsOH5NyAQ/K4bo2NRCxTHWfmLw2DUd3gtMXummDbgJGzlunCAROgFXKuRPQu95OW6KVsMqyo9X+PqHpYT+M6uC1fNlapR+l8C5VKbIIuYVvaYHgBHD5Sul6YpW3OhQnoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843536; c=relaxed/simple;
	bh=l4Ns34r3/VPtIm67avTb8VNqjhRwW64SjLF77vXrtC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR24Au3gLnUL6X3ScdC3CZw7/z6Bv0sFjqFC/J+5bP2bVYDDqH6vM81kZgJLurp4aJrqPUGRftDbQMAyZ5+etT+5N+nnO1y0GnSxHFisG0KBKVRGdcty7+IpG+uxrExnmRgJocO2LC7p/2gDHX2SDRmDojGtczY8wLhfjKsNv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wH42BY8N; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-446386df749so19200681cf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719843534; x=1720448334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3+U0SqFf/5QeErrbhXhqa4hoAqrRM3vR89Xs3iQvTg=;
        b=wH42BY8NiKTtvYN3LrMx7i0ahodWr+EGIow/zeOi4ejo/T0cJjSwTcm+MQQ/q5vsfD
         QSokGlR6WKbD8IaJiOar2kMrWIQKfGZH+gx59W4V/QrF322ZCzVXaaq9k8vVqCXS50IH
         RyNfwUoV+gqFhHutTixJnNAIAplh791xk+ExAL89iHrK1GmnHSuGOu7TgJ5hWzlc8mKh
         OSimhQX+w1KXBgObSVGbtwD/tlbDBUS7N8uxEqfdSouk8vo48gF3BRMFipJAINzh+yBi
         Ggovxo3sqdi/e6Ndbgdr/DXb1Wj1lChDIEWQQE+SfJ0wInxPy7nVRlEPzfTA9m5cmEq7
         cSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843534; x=1720448334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3+U0SqFf/5QeErrbhXhqa4hoAqrRM3vR89Xs3iQvTg=;
        b=f0Do7Jd5O7oEJzAii/vNQRPlh01dQE9VBg9eST8a656N8MWB+NqDoEzDQVkD51Eb1j
         mnsIaB4QwrLJrVwNVQrZiYaQa7OVBprvCX4pCT6VL1jYbcaT+z8wfge9P/m6SppaYQ0c
         ie7jIJvO+qucr8y6UyMBTkN72Wf6bdzFSK4/CFbN52a1AcTf3O3vkfVblDCJ6NC4vza5
         eCvn0rloJXBXxYAG2qjI10YIwvQasiIS/nzDPrhT6zAC087M+eKks880da3kmj4dJpFb
         4A4Dhy9uYYf7spEUoxnIJ/59IwfRtZtZp5NZE8cuTPEf9GVLZYHhL1lN/U6gSNWCVABO
         +0Qg==
X-Gm-Message-State: AOJu0YyLTD2eX+ry0CmuiyFL3bGSsSePxa65jjeQESzw6sBKm+18JpK5
	sep66/qHT8hOfFaaVaCvB2eJdrHq7adtix9cKq9Dm3WsjIbfBm3G6rr2WzvV/Rm0RPZSD9Tm6j0
	x
X-Google-Smtp-Source: AGHT+IH5LHo21DgPDGUl0tvjYm3/Yv6RJRIoWGc61r6+qU/htiCHPNZht+b3pSvErqWwi8aDD07hxg==
X-Received: by 2002:a05:622a:134b:b0:445:22e:2cb6 with SMTP id d75a77b69052e-44662e07deamr82314601cf.37.1719843533688;
        Mon, 01 Jul 2024 07:18:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446641f7ea9sm18140081cf.26.2024.07.01.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:18:53 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:18:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't loop again over pinned extent maps when
 shrinking extent maps
Message-ID: <20240701141852.GK504479@perftesting>
References: <cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com>

On Mon, Jul 01, 2024 at 10:23:31AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During extent map shrinking, while iterating over the extent maps of an
> inode, if we happen to find a lot of pinned extent maps and we need to
> reschedule, we'll start iterating the extent map tree from its first
> extent map. This can result in visiting the same extent maps again, and if
> they are not yet unpinned, we are just wasting time and can end up
> iterating over them again if we happen to reschedule again before finding
> an extent map that is not pinned - this could happen yet more times if the
> unpinning doesn't happen soon (at ordered extent completion).
> 
> So improve on this by starting on the next extent map everytime we need
> to reschedule. Any previously pinned extent maps we be checked again the
> next time the extent map shrinker is run (if needed).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


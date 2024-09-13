Return-Path: <linux-btrfs+bounces-7985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0C977886
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F05289888
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AE187334;
	Fri, 13 Sep 2024 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8y0CBW1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1315187326
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206499; cv=none; b=FFRsuy2hQVE0kvHAjtWJY1tO2Hca0bzQUixJXUCBpaK6WwvivJOIxhSH35CLtn/4Kp/q3KW0KGnifdKAwOBqYpkCZmHndgFqKMjyjiRs5TPB84i/rPm0sSOzhgytl/H4zuDjpHC+lAstkIzQNjji0mF1uvKDUnQpXlI8xkGqDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206499; c=relaxed/simple;
	bh=GJ+kX2jxT05CkMnjQNO0otOi9FxFV+lIQN+tobjEuZM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XTPvTADXPPbHjgMTRslGtVuId0xTkIQOKmVpZK9iH0RXIFeCmYCdul8Lw8aHy/ykMuHB8kKrSru3UqaU9fMAo685Nrw5IXtyWWD8BElxnlsmGlenY6d7mFIRuHsv29HDzVsDUufeyZv3w/ILAfks/E10ObRFwcTcSgS1f3qyppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8y0CBW1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d3f4218081so16128937b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726206496; x=1726811296; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJ+kX2jxT05CkMnjQNO0otOi9FxFV+lIQN+tobjEuZM=;
        b=j8y0CBW1rWM8P67f0MJOcsEOdHlf4TMbD6AysVR0ZaJIg4pzW5rBhVCOONSd7QP5Jh
         srTghgHU+COI374OVmYtktXfoWdhWdVBxoSpFBe9KfdBMjh0S5Fy8C7550Qr55g6fBOD
         HDi4dQ6PuZKLIceXxIy7ytOwe3I9/fZ5pYcwlel7cxDcXL79DBLnbNmPewwJlxnSfuTo
         WZs9glbiSk3vb+l2/wp8/AD2IvYevMTLZVElF0SP2RC5qe+SYCqjwFTZb3BinjiiLO3r
         sIHLMobURAU4p5iDnA/t2yAr/dqNu3y7hpXI3U5t0v65kEtoweHIz7rrq0eBaqcsT45K
         A7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726206496; x=1726811296;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ+kX2jxT05CkMnjQNO0otOi9FxFV+lIQN+tobjEuZM=;
        b=FhJIcuRJnoPzZvTFpEqzNggpBA5WGJVWcdwweerRbiDywk/SAwG2ICSsRa3uHHtgdw
         QdRCEG09Ux1emAS8Wx/if7+ETVlxOVfFk++BIQ5otftXXqk7umyPfyM2q18ALwWtvfUX
         +BRfEPIJGuXbfUP63GG28AI+HDfHEehz5he5dhPUpEDaUPxiiEl6gGc3vnOV7CRbUlEe
         AgOso17RfHnASvoJuHCVsTLBtSK14WJQXa59kMVGFBe7ymW2MnkL6So+dRNXK0AwnQ2P
         n2YseRUmSRYRLlnfVsLLnHmb9+nA4nEtbJiPa4qAXSQOUsz/ENi9gbPZFg+fWkGe8CZ4
         VFSQ==
X-Gm-Message-State: AOJu0YxBoKZ6grO2HuZVC3qkRyzQWudTjRgsZKE/HDcuEu53uJFwF1cF
	zX7xVn1B0tzKWKax0k0WOrLfvqXHrfn8hyL8FKhD53uBhlbKQJT+GUTX7Jvje/bTe1UhSVurLoM
	hYrlqLqr2ZILdGUTz6VAJADFJWWoF
X-Google-Smtp-Source: AGHT+IE7GT8vDeczEUis6/05EfhQGEKrDpbLt60H22onPC5ooce9PdPyq4aKDuvF9PnIO+xX6nyZR4Difw7nVftpKCo=
X-Received: by 2002:a05:690c:fcd:b0:664:badf:5a8c with SMTP id
 00721157ae682-6dbb6add2cfmr60484987b3.3.1726206496534; Thu, 12 Sep 2024
 22:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: fcon <aperture.server.owner@gmail.com>
Date: Fri, 13 Sep 2024 05:48:05 +0000
Message-ID: <CABk=v_CWGXrH+wzKFLzOSMuAZXyiJNbzKQqox_qm4e1PhfhBQg@mail.gmail.com>
Subject: Huge mistake.
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've been trying to shrink my BTRFS partition with GParted and that
led to me running btrfs check --repair a few times because it
complained about errors, it worked the first few times but it's gone
awful. The check passed but I kept getting I/O errors upon shrinking,
one thing led to another and now I'm running --init-extent-tree on a
2.76TiB partition, and immensely regretting my life choices. From what
I can tell, this is going to take a full month.

I should've just gone here from the start, but all this was giving me
a headache, and at that point it had already taken me days to try and
get things sorted.

Is there any hope for my files or am I, to put it simply, fucked?

I'll provide anything that's needed. I'm still running
--init-extent-tree as I send this email so if I should end that,
please let me know.


Return-Path: <linux-btrfs+bounces-12278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83AA60029
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061607ADEEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6421F0E5C;
	Thu, 13 Mar 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGtrWUW/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F11F0E48;
	Thu, 13 Mar 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892108; cv=none; b=AawFkUL/FiNwA4agP9ZUuIxb+EebfBRfu/Yf/p4L+3pOou9S6g0J9VHEh4n4o1qm3ZQL4PJbYyi4ech1syYDJQIsDPoWPFHh7HDldTtCCuloy+Q6WLk7HJY0uAodtSPM7hyXSmOHkF9ABKDoVknVnXjiRuM6AUxqRDNLN24lWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892108; c=relaxed/simple;
	bh=qXvwKTD2I1uFx9G1b72YzsT0pPXLzjbATobXsUry+ys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LvCYmVgxrc+1HtIka1Vz+ITAdcoqjR3VnzxGg3ycJlfG91Tw99xRN6vw91tAv+zJFmVr0Pu8sEOj2VWpK/v45iYJKrUylQPpIYeSrmjg0Cy3V0aK/GQgItQ+tA/rs2E1A73YzBKjZHq1p4d2xhftg4hHFZMEhrDtMRDwNyASSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGtrWUW/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fda22908d9so10255237b3.1;
        Thu, 13 Mar 2025 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892105; x=1742496905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXvwKTD2I1uFx9G1b72YzsT0pPXLzjbATobXsUry+ys=;
        b=bGtrWUW/9BEthlHyIJ//X6aaEGtJJRXrQDd4ezszvTCNuKwAJFf1xsWm5U6U6K3jNG
         2PJqfQTkuTU2tih7CrmBsz8jw1+dO7WJW0jyG2RNGuH1pfYSIktwslowWKD4SUEK3+Fw
         Srww6yLcE1WPCZ4QwcgnMcuqZDoZrQaQFVEwfLR7kgkzfYNLsPZXswVcrHG7W5+yrc0L
         bfDRRm3LT4o4p2aWfj0MHxGmjq2m1eqLSg0Qibdu+z07ibU130Ih7ZlLaA/FMQej+2tw
         WDsGQP/RL7ObweyLxbEAEB1E4qUhC6Gbia+1yzUXeWzspoB0SnUe7yliLj2nnJCgC9i+
         PTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892105; x=1742496905;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXvwKTD2I1uFx9G1b72YzsT0pPXLzjbATobXsUry+ys=;
        b=BczscUt5crgjKYWvqPXOFQLkVav6rD1eyjVQZqc0DeLRUDDPzau7g8+SyHqxW/kK85
         H32XBhm4950TiL6ICaMeWnV2hN0Cwg8ljIu/UVBiB29lwtoLh33yUE4j0chJ4CEAinao
         gPpL/3KiCrGtIFHws74fGcUVYccMTd2ClZiXSxjUEc6i/WRjQsMcy+tzbJ4aMJNA8Jwl
         qRSxdw/zUOx8QEvbG1a7hztEy6sCsFf2GTawhrwGGx1APSw83jwr7C1V7Rwe9C6KVbQ+
         Z2Xl227xdYaGQaXtp70M80KG9qC85aNUGdfIpc2lEdQdV2X+MbmGwzthNEKl6Z/8QS0t
         XcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2ORJqPP0XxspcRYQ8TBOLJXZSkY4RNpivEr7QbVRg+0nC2Y917oGWIoUZqi4L3mi+0cMKdkBpCyttQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIj7557+NfahpQEcwqfXDb8+RuJAvJXBPgw2wv1G2XM3IrBXWl
	2AhRoN7jTC0c2+BAAuUu8ptS0zb/oN1sN8pwfIT2tl00+71C2dUN36j8IjBz6YW8gpmXusCjsXn
	j8yXIx6qpP5NcomvHkBwjJJ9CYY3f8/g7NLo=
X-Gm-Gg: ASbGncuT1RyjgKooFupHjlNYAxdR4ReDUD8z2CDc8qdEJ4v3/042xJr4QFZhVYuDr1w
	mWlqLdQnBrtcvJs/cT+0ZY49pE8rU3mmP2BOLgokoO312/Zf+UlmCqXEtqWoGoKdbdA7IphqsHm
	qeHFaBZEsvNLBw3VD/O2y6cXHP
X-Google-Smtp-Source: AGHT+IEKqQWH7dcD6ejG247HSFtsx9xlYEtjwMC6/LTN+1/xsgE1a+3OO4iHGWpOaSpoQwnGnGStkTAfRgQ0xPSa48I=
X-Received: by 2002:a05:690c:7446:b0:6fe:aa66:5d75 with SMTP id
 00721157ae682-6ff41f56827mr10681797b3.10.1741892105454; Thu, 13 Mar 2025
 11:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: pk <pkoroau@gmail.com>
Date: Thu, 13 Mar 2025 19:54:52 +0100
X-Gm-Features: AQ5f1Jo1crF904GwTCy7t9ym3SZy2HPEL2AnM4Gp2OSq8JXebw5v5lqXMcN_LJw
Message-ID: <CAMNwjE+6g4j=GDfef1hkrDvu1snaB9e0MhMWJFhZxuLtinrOuQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 458/462] btrfs: bring back the incorrectly removed
 extent buffer lock recursion support
To: stable@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"

Hi all. I confirm that the patch fixes the issue for me. Thank you very much.


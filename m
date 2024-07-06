Return-Path: <linux-btrfs+bounces-6259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBED9292A1
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B53282C06
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171954907;
	Sat,  6 Jul 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgAaNn/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413D4EB3F
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jul 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262889; cv=none; b=ElNT/Zi2FbY0hS21qfAq0yAmLL0TsvLfDjvO3zp2WW+Qt+QHM4biaejbmXNJHcdn5KG4tFZlu0JDAECH11MKg0FoL4+g4Ic1hC8EEn6jxvk9bZAKlHsJYduxAVVq+IspqRYh0Y4HM2prRjkD7DexEw/xGlQO/6DByxVIvVAit34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262889; c=relaxed/simple;
	bh=DxXvz2l/VR5ZPIy2tNju9iir3Q4LUF/whTn2fh/BA5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYnoj9lFan/rW4g1QpXTg/YhNCbfTE8RsV6b3diJixpdsOmLhjdDcaVhaey0B8uiAKhG8hBJsC+e2XEuE37ZXqMmUNtl1Vo5DYK1IzyA6pT6kJCh6innY16Q6icjBxZC9clKPBYx4LgcZc5oZCOD+G/VhnjoIVoWLB2F2gkY76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgAaNn/0; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-643efaf0786so19977467b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jul 2024 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720262887; x=1720867687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DxXvz2l/VR5ZPIy2tNju9iir3Q4LUF/whTn2fh/BA5E=;
        b=JgAaNn/0nKJoUijeOEM5GMhCQW6UTiY1Aps6KnTI4sfQZVkdCCJnL68271ClM9PBzt
         1xxOeam4V9RPWuA4xG3r9Y7O5E33awI5gKSC/iI7oxB4AH7g8b6JYIVhGTHhU9Aw7psq
         DHsSkGdUSNq8wbjFBnQyIeH8sQmMLDczWLzkHmBEsudvGRalK2XSczeiMb+pz1iz7QTL
         E3TtyXEa3/sFxrkbR05MOe+rMbbtI0deEj5jT/P8VXw4T0Dr8kkhxuqfyAgRxWojS/B3
         EWSKNgbh+UIU+rAPCSJlz++vGE3rDNUToA8XthCa+iJkQ3+YVuWwOrJo/2/RhPuZX6Y6
         PnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720262887; x=1720867687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxXvz2l/VR5ZPIy2tNju9iir3Q4LUF/whTn2fh/BA5E=;
        b=XHqvGCXz3TPE1Ur1zZSwb0++EKKClrBhAIiThpC/vQx/3J2+dg7VNb8lAS4Vl9Qycz
         zcFqipukact3uStZtew7NHvg5bi3dpir2Mc4QDAiWmjv1jd2iFO/67x6mJlYwQdYsPaV
         LVDIYCZ9uyWkvGTcdil5MoJY1xC1YugYsOGg0udQpumelpgGzS2Du+GExKcOBdVHVp2R
         xu6D8hx2vaNHTrVWBigwb7uF0GK13/GLs7wxA0dN7PEaLP2OZQ0/uS/ALimgwEyoM9BW
         jgdKtrhGMWviMCbg8ifv74Q0Q+/RRoxnpUq4bQAJixI0zgOSES3G2x6/1xPvkc63KI8F
         njiw==
X-Gm-Message-State: AOJu0YynuJEuJ7SfRUR1IQe+4geHTmdulHtG9rsO2J2u/duXNMBsP0EB
	55IN8fiGrbdmSDRKST6f4Z1zu2qHwEgRVJp22iK4eEu/6c/L/iIKWCub4iVjFOPjNb3FYtf0vFd
	CoomG2g/HURGIxr61PSA6EsRYTIs=
X-Google-Smtp-Source: AGHT+IGVPSYwZzGqpVw9M+3H9Sd4Ep5qwPwDfMaa4HqzQ9w1kt7pbDYDFTzJ9Dx1LQyZ59KetRvljg7EQlnxZvsnqec=
X-Received: by 2002:a05:690c:700c:b0:647:e079:da73 with SMTP id
 00721157ae682-652d53348e5mr75394967b3.10.1720262887051; Sat, 06 Jul 2024
 03:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
In-Reply-To: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Sat, 6 Jul 2024 12:47:50 +0200
Message-ID: <CAK-xaQauuhnY0bM0ss6JdFS091bFPaK77HGnbp9qG-KCMtZFyA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: skip name hash check for image dump
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 5 lug 2024 alle ore 02:02 Qu Wenruo <wqu@suse.com> ha scritto:
> [FIX]
> Since btrfs-image is mostly for debug purposes, we can afford it to be
> an exception for tree-checker.

Sorry Qu, but I'm so stupid. I didn't make it out.

I mean. Trying different combination, running:
btrfs-image -s -c4 -t4 /dev/device dump.btrfs

both with patched and not patched kernel, I was unable to mount it:
a) not patched kernel complains about crc and so on;
b) patched kernel doesn't recognize the dump as a BTRFS filesystem. No
error, no complain, it doesn't mount.

Also, doing a simple:
string dump.btrfs

I read filename in clear.

If you want I can prepare images of what I used and data and so on.

Thanks again,
Gelma


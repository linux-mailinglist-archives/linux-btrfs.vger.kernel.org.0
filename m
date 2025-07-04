Return-Path: <linux-btrfs+bounces-15261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184ECAF9769
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB613B30D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622F315508;
	Fri,  4 Jul 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYyAsY/C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E910942
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644720; cv=none; b=QB6928DJb4U423VrqZr6fz/O54Vwv38m2Zccogd4bqxkGF40n0e28zGxNSDssk+Q5HbZ80ghbgzbXjflZnqB2+K8I22IM14j1PDej5Rr5tYJLy6fbKjh4/yC/JwrkNv4xYB7FeadOg7mbkxxw15hUun87BSoHbQvrg6d6tJhqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644720; c=relaxed/simple;
	bh=xS22J4K97ac2EsfY6dnLNpqW6UtwRf5G6RtOXAbXFQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZJTEL8dvQRMLZCwvrZfkhk10Cyd9yLp4OROgfwfhjXc1q4XG4h7gQ2UlIKP8TXL76nhOLXEZaq63CzDUVMM/1+PuA9xyjmNrhAzdmojsatm8akrClwNk9BuTKqfr7JQX7iimvblLG9CadiphXaR8kdYWByJCZ/8WOloKZeNEh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYyAsY/C; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b595891d2so8963301fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jul 2025 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751644714; x=1752249514; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1yMVk0TeT8TF96EFQYbYh/QZAA13UdBvvcrCWCvZCE=;
        b=TYyAsY/Cg6PmkdFM/5bffjtxpJscx7o2jLZfIN4OWrGmcdnBwIPCqGf/+Aeg7AQADR
         YFrHihUYVN3xKpPw3XUm12rDSisOcUyB6wDvZ30qREjC5DOmSOY0XGs12Jlk6ZiIrKKW
         KxtigTs8YPb/hIXbsOaF26Jc/OECV6JP7NG4YsPCGNme3EzW2PRXCIJJqZ8EWYAayY4G
         j8KjpLmvwwtWryZAVP8DiMCUw6xpd3kMjEqFUX8PgguJe+83K6qTLb2pZimZFr0fcZZE
         ErCxjuLtw9SixP+qWVJFX+d9zVlQpbh1v4ndhc//B2HcJLMMLU38N8mpVa5WFctacFwt
         B3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751644714; x=1752249514;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1yMVk0TeT8TF96EFQYbYh/QZAA13UdBvvcrCWCvZCE=;
        b=ibovokniCOHaIbmcS+I3WIWCrynXE9V9yHGBNd7dMa5CGnWAmWpC91viwnQ++aTfTZ
         1dHRJJk2QJym9mCoQf9eMT4sOtfzAcSD8XXppE1tWqpkshSf2hWTeIqymVMoOSPjcgfD
         X8r7EsCThyExKPcA5tdxHLMvCdncxfVh82Lhfdb+58o+FIQPDOd6Kq1sQiY/n28o7r2E
         5Z469QD5Sr9rFUPTsb13JC4gtBJ5nw87eTup/3bm31AGbEq7VLvkiaeHbVlT2pa7vKlZ
         M1hJ0D11neA0RxBGf+hq8CQblqgQiXlc6SgZj+Vql7Mh6PL813B7jOEkS95r7GTkaUIa
         1EYA==
X-Gm-Message-State: AOJu0YzJrAr46Og4Pk9q+5M6/NqpeihgamW4EsLNzN8Y2yEWicXKBi/A
	rbPePlMdiOzTWAkrld2iI/kuJLR05hDwt7DRIUhmJJ6hPNVrt4vzafkGQpD72rpwqx17iduRa5j
	IrNjo+ESEbXr/qYC4wfDyHYz0GH4pE5kcRFjl
X-Gm-Gg: ASbGncurZjlGvhpJmqlwmzOKyBHewr2hc5iMEeQEEWW+vUBNvpraa4l3lpp5sCsdivC
	KVsdvZpxXsRHkDwOt9h6v2879/1N/s6GyvvJipnjtd6kYxhmkatm91JE3TRAem11AoUhnIGKDMF
	+6tZCvMX4UASngpp01IGUX6uXElTeiwOazV2QzKTP4nzmr
X-Google-Smtp-Source: AGHT+IHc62MaDpYONOpeqn4oip+vzVJ9ovjx9wLy28cfxrkeUzZNI4ez6RYjRWAEkbH0HnCxUBfAHy0ZO5SQpN6DzQo=
X-Received: by 2002:a05:651c:419c:b0:32c:a502:8334 with SMTP id
 38308e7fff4ca-32e610eae5dmr9965411fa.36.1751644713658; Fri, 04 Jul 2025
 08:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
 <CAPYq2E0QSmpQR2wV7TRnSTfihPHOEtx=3JHtCq7Yd2rOMwiXMw@mail.gmail.com>
In-Reply-To: <CAPYq2E0QSmpQR2wV7TRnSTfihPHOEtx=3JHtCq7Yd2rOMwiXMw@mail.gmail.com>
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Fri, 4 Jul 2025 18:58:22 +0300
X-Gm-Features: Ac12FXzCCngl6JjS5lBWSNHTTqOPFFXx76DTxO1dMjXe-X-Dv6khzjyCraaUdBo
Message-ID: <CAPYq2E3zdzx4vvSrGT3goRvikt4grUfgZuE5kB1hcoK=RRpseg@mail.gmail.com>
Subject: Re: [help needed] parent verity error on HDD
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

extra extra information:

> sudo btrfs-find-root /dev/disk/by-label/LV-01
parent transid verify failed on 120422400 wanted 8301 found 5836
parent transid verify failed on 120422400 wanted 8301 found 5836
ERROR: failed to read block groups: Input/output error
Superblock thinks the generation is 8301
Superblock thinks the level is 1
Found tree root at 119324672 gen 8301 level 1
Well block 35749888(gen: 8300 level: 1) seems good, but
generation/level doesn't match, want gen: 8301 level: 1

> sudo btrfs restore -D -s -S -x -m -i  --path-regex "^.*$" \
/dev/disk/by-label/LV-01 .
This is a dry-run, no files are going to be restored
ERROR: failed to change owner of './Backups/Other/school/G12
School/eng/hugo-portfolio/themes/risotto/exampleSite/content/_index.md':
No such file or directory
ERROR: failed to change owner of
'./Snapshots/Backups/Other-1748279502.547062230_2025-05-26_20:11:42/school/G12
School/eng/hugo-portfolio/themes/risotto/exampleSite/content/_index.md':
No such file or directory
[1]    11852 segmentation fault  sudo btrfs restore -D -s -S -x -m -i
--path-regex "^.*$"  .


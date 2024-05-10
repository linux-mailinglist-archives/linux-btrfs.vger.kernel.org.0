Return-Path: <linux-btrfs+bounces-4888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4158C2346
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13731C2088A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2E16F85A;
	Fri, 10 May 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JpYLSKGO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608516E880
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340241; cv=none; b=quBSWtBmM1u9zigAEo8mZS89ZebLywb2AYwRFv6QEy5vyO/OjiA2+ZO7UoWAjUSm+pWqXrODFwjjVA66kpz71wyGFlHm4DrMrRQqBCRaY8kG59PNoZuTdNZ5+96Pk91ZFB9u/kThR7CQh5rhKvZ4+mc2RIbIzCd0SGoin40c4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340241; c=relaxed/simple;
	bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0DNZxR9g3K0qNq3ha8RY20E5mKCb0+q1nbU6llNDVskpFHEkPyftUmQCsotB5J5iwQ3q0SJjYnAHUjyEyE04WDqOjR7k34s1USxS3t5ZHxukwh6BjNLNRADkxl+zAosq42cyVquhreBwDQ9wNC3s2FXCoq3UTwCdzEE6CoLX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JpYLSKGO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59c448b44aso490633966b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715340237; x=1715945037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=JpYLSKGOBfaIc5A8kOsi5/Dp2+/FW5QcD3PSDQjxzFhPoThcC9BFnBTZ6bjdLPn1y2
         H3Ciyfq/DoepN2m57HmuLeQcub49JESXoeDmgeJbyvwVncXszisdoYaiKihDJhidJ0fS
         guBqjTh2IcbqsTVlhlUJUWjpelIrxQkrhmoR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340237; x=1715945037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=ZSjvruLj0EVlJ89RGAUB80YP6wsMgFAEGB82FMlJkMdW2mBza8/DzuYBrDnCFE/yFm
         5wXwoJcOZgxPgTlVWi6kZuHTnifZmqV6dBYZ+NHQYRbPjk4BSzhA3SEifZ1HiJ97G3l9
         Nrw5qkUvGnAvNlPRIwsm9AE1f2eIg0bc75RB1g0c+PG/epop2N2950qtrt7VbB3Zv+cF
         gude+0VJ0yP1kIdg5jzwUhXFzFpNJUj1j7pZkF54P4mz6OFVRrEoab66A4SHmsnU7/RX
         q8sPbf8GsJPJSarC/FqKbYuOHNXmjZG82IzcqiIKzaKsKG4HqN9lfW3vwEgmt1Wcr8bc
         zmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVgadYopU/YQVAxVwD+6QG1sMickWMAmaGatIuUFYKL5LixV1scZaiFaWN3zH8wSMPr+xafzg7XPSn8IZJnsNQ+JULoOomeb/jGKX8=
X-Gm-Message-State: AOJu0YwGPrt1bz7KwzpDpuG2L83h4K6FQCgIjEpk//wcdaVtmgy3keJR
	NiZVqlcg9RNMKpgYRmYZX4aehy4hcRyuHs7dYS3MQhSaYTPP4a2r3Khkz2kNIBKaxBLU2xoqnOs
	UwFWiIF6jmaozipehH80ASq2OIqOdfvfCgQgO/A==
X-Google-Smtp-Source: AGHT+IFz5qP18mAylhBbmtThupMzDKv7Hxf/YKoxmcI8024bWwzwHlVosWJHVpjswkQo1H6JZ+uOIVvInsfVrUzL8aQ=
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr199596766b.62.1715340236873; Fri, 10 May 2024
 04:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502212631.110175-1-thorsten.blum@toblux.com> <20240502212631.110175-3-thorsten.blum@toblux.com>
In-Reply-To: <20240502212631.110175-3-thorsten.blum@toblux.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:23:45 +0200
Message-ID: <CAJfpegsVWa-fu=DePSC0J1WkfQxhaqs0RTxopMBHduwMANieyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] overlayfs: Remove duplicate included header
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 23:27, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Remove duplicate included header file linux/posix_acl.h
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied, thanks.

Miklos


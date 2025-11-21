Return-Path: <linux-btrfs+bounces-19244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A84C7920B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3CBA350FFF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D370341069;
	Fri, 21 Nov 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QFUx4fh4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089A34403B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730190; cv=none; b=DRXBuBPflzAyHJNm4BbQz9BXvqa2w4x5Og0WeKWAfgS0tGh7XjkMpzN5EIBzcQ1MWots0KWG1GCxSSi2FCc65iqOhD/z20SSaEvlfKmXdN1aayIqj4Ms6qeQnLKp4qFO/ojVZy6df4/0BYMcZFno71pI3Sha8HmL1sw45H5SGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730190; c=relaxed/simple;
	bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOFeznWRWlcAbjXL23UoKIg6HdzNNf3Wab3OqV7NCJ0C7ijiwa0n8y3KVVjgYnmHQO6v5HYCj4JLe6A3o8+YWi3NCu1ZO2wjiD+byJ0ZCY5s00Rv8ugfUMx2TVy8W9J5/Q+0pysQaxhDLsiZFxBGP08JXZSXx4fYmL3bw3XWQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QFUx4fh4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so17832905e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763730186; x=1764334986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
        b=QFUx4fh4YCD5UE1/uehzPoKxMW0qLKeaDtTAwwXWN7f5V9z+KakJ2nGk+Rj+3Nfmip
         V6OqdGFZN070ieMOEg6rzUpNhLQ/axXXp0F5H6tns5+UWOruK8XjnwrG8ZRwiwQGDTMd
         yW29K1l3bJ9WdI44Z1MwR/tXr4jyVKh7oJTBm34OcQvsSzvC48fU5hvjKPm0dLwihXbp
         AqwWaO4x9ImsyFBAGzu45Jb5UkjrtbI4GcoMhiIa2iC0S0suUo+bWvP6t0W5PtrJhJWL
         8uR4f6zMRbWn4J1AiPFqtrle07yecLBaTUTnjY4JTFsBXwMzQ+qJF+R/repYvRpYIDzU
         c4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730186; x=1764334986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
        b=DaXKATRRdWNkAZJALrlB1SoCtJN1dXGRojKd2N0bQGzsKHMDBuP8ykxty94fb8Fgm6
         vu7sBOAtra9Qi/OlOWzOZFlxCsDTK1yG3iZ5dMIngfj4/vpORVxAzvwr405dXoQngwdV
         BfMCA5DvkHsdSkagqBFOXy2xTAij35+q4VWfnNHVed/Mdo26Apz4u4PnF6IFgGWNq7Uw
         m7y4mA7raoHnULhLxqXONuqAW+fRB/KtCj+QyqsuPQoUGAdsPyNeT/pCWCTn1cKEKEEk
         F8UsUetTnaamg8sjW/Pwqc+SpZyX4BiuyaM6zU8PPFHcwNMdSXlMSayWHh3IactMsuAF
         NI7A==
X-Forwarded-Encrypted: i=1; AJvYcCUKX9ToJeB0gKuxjPy0VKzssdInSkF8jc+cpudpXP5F17ZDyCrmgBR3ljL4PYd4SEvQWY5pL6DCESM/Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2f/1uXlzporum+gZRA4asVln5FDTuk7LyhlwvZDbdIM2V6gK8
	oFJgnbjWa7or6l9BUxCb/uuMZ5048nv3TkFQOpbpSy51c4hqzYM1GhCeBei2rdBHSxEjhSdvdqc
	ZqX9QkVcaAYhoq25qnswjz4N+2qf9Etud5x6KKRMZEQ==
X-Gm-Gg: ASbGncsfaHqph3uECiGVBwkDAvgMXuXo/N4QDmisvCo3MCEKfJqDzr66m7Bha7uattS
	NaNlDYeIUU44WrT0DvoORB1Wtf1kLK9oS+1hIQqAMOai/SsjNljR+o12EEifW+t2YNBb7DWCPhq
	VJ/ElJawYC9uWhARkoxHKWH/sAeK+pbQnwfSSU1NcoHw39YRlq4kkhr7vs6/2pm4iqQXhsGExNT
	tukRNs5uQFs45MZkk7ZXKJW/LzbtnkDlOBnDNF/0ImnlbyUO+CFOhChQe264RPES8LBiNTrsq8r
	UErDHDfI1sWH9yJFffT4xMuoopwccFThaIVnRd1voZFwaovZ9ZiAV4+RXAypeYBRgVYL9nF946V
	nPOI=
X-Google-Smtp-Source: AGHT+IFKvlzMGUOsQjurJJO1/ddu129s8U6J9Qzr1L7YObQFc0ULUukUbdKdK6XW7KVAHd+E0Lj6QT3HD9PKGyA2iIw=
X-Received: by 2002:a05:600c:4e8e:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-477c0180d42mr21139625e9.10.1763730185944; Fri, 21 Nov 2025
 05:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
In-Reply-To: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Nov 2025 14:02:54 +0100
X-Gm-Features: AWmQ_bmlrTSQRB-IyIJw_d7QEyrSrCi1L10PR-iyaSdF9L9qt__gjWsRdUJNCmQ
Message-ID: <CAPjX3Ffrs28a6wC3PvtXpPy5Hw9pOmGYqchpg7WRtTwdDo1mgg@mail.gmail.com>
Subject: Re: Questions about encryption and (possibly weak) checksum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 22:58, Qu Wenruo <wqu@suse.com> wrote:
> Hi,
>
> Recently Daniel is reviving the fscrypt support for btrfs, and one thing
> caught my attention, related the sequence of encryption and checksum.
>
> What is the preferred order between encryption and (possibly weak) checksum?
>
> The original patchset implies checksum-then-encrypt, which follows what
> ext4 is doing when both verity and fscrypt are involved.

If by "the original patchset" you mean the few latest btrfs encryption
support iterations sent by Josef a couple years back then you may have
misunderstood the implementation. The design is precisely taking
checksum of the encrypted data which is exactly the right thing to do.
And I'm not touching that part at all. You can check it out when I'll
post the next iteration (or check the v5 on ML archive).

But I'm happy you care :-)

--nX

> But on the other hand, btrfs' default checksum (CRC32C) is definitely
> not a cryptography level HMAC, it's mostly for btrfs to detect incorrect
> content from the storage and switch to another mirror.
>
> Furthermore, for compression, btrfs follows the idea of
> compress-then-checksum, thus to me the idea of encrypt-then-checksum
> looks more straightforward, and easier to implement.
>
> Finally, the btrfs checksum itself is not encrypted (at least for now),
> meaning the checksum is exposed for any one to modify as long as they
> understand how to re-calculate the checksum of the metadata.
>
>
> So my question here is:
>
> - Is there any preferred sequence between encryption and checksum?
>
> - Will a weak checksum (CRC32C) introduce any extra attack vector?
>
> Thanks,
> Qu


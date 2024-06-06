Return-Path: <linux-btrfs+bounces-5513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440618FF7B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 00:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBA8287183
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E570B13E035;
	Thu,  6 Jun 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdXEZtMP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62E770E0
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713184; cv=none; b=AlT51Cpo3wdvnZVeY5Zzf7KgC7Ftfwdg+a7GODfWBkx0mty5HnTWmCieXMzxUo7cac8Vhf0i0AgH30qgqmNZ/vHrfQQ8eZknSj5pYToPBl0GTUpF1ysKj9l64LfLmZi/YTRdppsQKl2I54g0E7FUwWVdjH7y5nw3GswP2FcZ7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713184; c=relaxed/simple;
	bh=PZ8pqYrf41IxEI59MGOVNnLhCnuLGXjQZCx3DcFggQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXOjGKGdSWjWgGlOZek940Mxg33IVfLPgZQsl2gdXlAnAN6Rxy08q24/HZBmhgLUe77mYnjeB+6muVW9x6NhBgt+TfQ7e41j0ffsjvTGkFJzhxtAw+e/6nDhdKTQKZxkDriALA8q1TMgVuVPv5giAOa1y7Bmcx640YBsQNP6iP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdXEZtMP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa794eb9fso18120161fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717713180; x=1718317980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WOVbyxPUODh/uCyzRwI1jU2j4bN1ysCvxrJp+GdHOOc=;
        b=gdXEZtMPrpIwluv47/boYSM1Fjp0oAG/xNz/VzpBH5uApGuTmzdrS+08X8F6UgrtDB
         UbRxeJCcbd1oLDWHdnA/ph6IKjy76lt+aBnkztaOk7SLi17R7ewOCCqVYzCDr/DIKxxH
         AOII4QhYia5pMk92dNEexlzOyCwqcYZ7Fnii2e3xYqMTITnkcvZsieBCRG5RX3L/iPWY
         jWNCboIQyZcjHP2GJwYk13jng5bhOchxspEbBi8i6PL5Kic+ZWQ92xHMsoMwKmKNLZva
         nX5wHaWA3U7mdkSnmzaeaMeOGWOUzOcD12AdXMvY1oH4ekY5WJ0n2o4+64tbvNBozrly
         LJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713180; x=1718317980;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOVbyxPUODh/uCyzRwI1jU2j4bN1ysCvxrJp+GdHOOc=;
        b=EUuwd5qt3sONwAosklsF1J3G6DZ4D+nN1Mt04pugYPHf62tmwdIhayKlFoKUiyyEax
         rHB+b5jZuLEvZA1F3BIJYt8cz/YyGvNPLS94q2k4fjvehsVrevIa1sBZVe0pYx3k7jrN
         vp/CdaXk9j5Q7ASRTnH7dmxiq+O2Briznmgq48RTpudDwriHCJzpnkGhuYKmMR6qDo9H
         VA77vCwGAnNadZeIczpfStg41aQiTCqJyBZCX1EdA3Sl9VhXKQ5+JKNCyN+/JHsXsgDp
         FnslENTUxcV1xSo9b+PHI8sPQ0jnPESZ/l4lGSjsDWCBV9+Q0AlbMjO2g23ygfxnbzat
         bA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWKdEQrqarHwBkhQKwVVusCfuiAd1VbjmD4MTvCQ1M1JyJ/I12+T4Zty+uG1XofmCPmY6fhXLH4+oe5QmTF4Pzh9OrvpsKoJwO/ikM=
X-Gm-Message-State: AOJu0Yy/jcL356xXHL0SEdPtSkAEGsy2tyIVKZ/ksBpC7vfkWtB3Weh8
	Kj3iYtW51yf09X1/mYMP8OHSIQ/dZEuKAILBE5TLrMuUc26GudVsJCbP8qUjN2c=
X-Google-Smtp-Source: AGHT+IFG7emifbodI767E8bxeZHgaF+GaidFZYKGiljacXK40O2Tviki1y1aknFxWIvWdRHGWpEOJQ==
X-Received: by 2002:a2e:a40f:0:b0:2ea:80a1:b8f7 with SMTP id 38308e7fff4ca-2eadce9d3efmr5874821fa.46.1717713179893;
        Thu, 06 Jun 2024 15:32:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c22060bsm2247966a91.17.2024.06.06.15.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:32:59 -0700 (PDT)
Message-ID: <fa840aab-365e-4eb8-b80a-08e2a58306f3@suse.com>
Date: Fri, 7 Jun 2024 08:02:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: tests: add convert test case for block
 number overflow
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com
References: <20240606103228.3697282-1-srivathsa.d.dara@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240606103228.3697282-1-srivathsa.d.dara@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/6 20:02, Srivathsa Dara 写道:
> This test cases will test whether btrfs-convert can handle ext4
> filesystems that are largerthan 16TiB.
> 
> At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or
> corrupts fs if 64 bit block numbers are not supported.

You may want to merge this one into the existing overflow tests, check 
convert-tests/018-fs-size-overflow, which is doing the 64g overflow test 
already.

Otherwise it looks good.

Thanks,
Qu
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>   .../025-64-bit-block-numbers/test.sh          | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100755 tests/convert-tests/025-64-bit-block-numbers/test.sh
> 
> diff --git a/tests/convert-tests/025-64-bit-block-numbers/test.sh b/tests/convert-tests/025-64-bit-block-numbers/test.sh
> new file mode 100755
> index 00000000..0eb6bb49
> --- /dev/null
> +++ b/tests/convert-tests/025-64-bit-block-numbers/test.sh
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +# Check if btrfs-convert can handle 64 bit block numbers in an ext4 fs.
> +# At 16TiB block numbers overflow 32 bits and screw up total size and used
> +# space calculation
> +
> +
> +source "$TEST_TOP/common" || exit
> +source "$TEST_TOP/common.convert" || exit
> +
> +check_prereq btrfs-convert
> +check_global_prereq mke2fs
> +
> +setup_root_helper
> +prepare_test_dev 16t
> +
> +convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
> +run_check_umount_test_dev
> +
> +convert_test_do_convert
> +run_check_mount_test_dev
> +run_check_umount_test_dev


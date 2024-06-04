Return-Path: <linux-btrfs+bounces-5431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB68FA952
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 06:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425591F2279E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 04:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132D13D88D;
	Tue,  4 Jun 2024 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fNgPhLa5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68537142
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475871; cv=none; b=mrdJFrqxJmkJzYjejaB8XnMs2ix+MqGoou/WsmG0S4Qt3ybPo9Cacunvn+lI8n4rIerrnbGdRdFzrbglrLObczG8t6Hs0JbHyJx3/ACiBOxOg2Ukf42X8ss1mMV//86hz/YHDP37laBEpgxiHmLayZ2v8gvgxqQXg4YrSKM8wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475871; c=relaxed/simple;
	bh=9wlToptHaYxRAQvIcOzufhOpAqyNneZmar2rRTaEtcw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RPv3YY3qjl4UW2QpqzPjHuUykSuozANY0LZmCt3hfjsNo3Sb1bYiHob7PLgRV0+sPnHK2rzsWt4dBifTZbI2zTN0BApaMXjkWfRhbp0vMLU3XiJbJ0WUHaoL7VxwpkM0ZiH0Og1q5pPPtMf7mH6bx1osvAjQ/ehZd2H8T/4LiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fNgPhLa5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b900so5732261fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717475867; x=1718080667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWDZYfc4Ilv9cdms272iLhLGiCL3U/MdOsHKQegxlU8=;
        b=fNgPhLa5Khv5lN29R2tlMFevp/M3JZHJCbawxN51CG1manBcRnNMubqp0nHiutCmrE
         ch2CI41+F5eyS9Vs01QGdf0dZHxo6ueYXTRMjWbCX3C4ozl/zwuTrua/jj4/R3GSZKkW
         D9lEQt7tpoiUHB/sK4Z2ZiWxoP41IES1mYYBoETNAeB/GZ9bvT2svEtlWqkAsxnafJVy
         qeBhJFxaQ5T9WZaRE5YXcMb/XlfHKsrIlFYXMoGoEkwE2h3RpmyzFRzyKkrfsPvW7bsM
         jB+P4p+L4uWEbg3rQKHcv0laCIgrb0UPG7Gky4+EHrgLOSWDG39jTAvnFZQl8gOcqx7y
         kwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717475867; x=1718080667;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWDZYfc4Ilv9cdms272iLhLGiCL3U/MdOsHKQegxlU8=;
        b=pTjQHHWpJNpHQuCGJfbYenlLk9zO8i+CyEzK0u2oVrnMYIqfoz13ZUQeQzqkfED/7H
         nHa9/N5wBoI2PyaAMGKTW5KrJ6iCO0gbyJZax5gIyasB8iNyz2zeyrkfKKWDspfmA9CY
         Wel0gDrqnvHAicNgkrlJsFLJ5+oKMVoYc/09gRlajVIAk36jBHy7scdP+bIDtLi07sDp
         w+CSHADL0K7890BffzgW5YK0xPMLyxCkyULnpwKQE1N+tBoa/xS3xonUSK2Q1yrz0W7e
         XV0kxQxfKda0HCjLxnOUUvEAj5j3l7vPnoJpMfxLbzndPKsF20ETgQUdlO0nX6+7PEzJ
         2jdA==
X-Gm-Message-State: AOJu0Yx7Y+HWrL+VHxmMR/9r5WrDRr8gajwiNX4FyCIV3ov02JbGSEo0
	+fHVLUwlfwLUuYgrbc6Lt0ZGaehvqRI8/h/Cc+ZhYG7f7HQfKCQm+maN+t2BfTTxy6b0tK9tygg
	e
X-Google-Smtp-Source: AGHT+IFHWiqyoqHw6krlTbRzBsNhzPwxu0diL0QRrvsDSCZorf39jKTjlkZa8y9MFNoWf+SQb5jYsA==
X-Received: by 2002:a05:651c:1056:b0:2ea:81e6:2987 with SMTP id 38308e7fff4ca-2ea9510dcf3mr71153691fa.26.1717475867141;
        Mon, 03 Jun 2024 21:37:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70265e66063sm3078754b3a.90.2024.06.03.21.37.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 21:37:46 -0700 (PDT)
Message-ID: <cc455e1b-7ed1-49ad-b512-cc556f57b0a4@suse.com>
Date: Tue, 4 Jun 2024 14:07:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: corrupt-block: fix memory leak in
 debug_corrupt_sector()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <ebd4d57790941a9c1edef52e09ce0bb4838ab27d.1717474840.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <ebd4d57790941a9c1edef52e09ce0bb4838ab27d.1717474840.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/4 13:51, Qu Wenruo 写道:
> ASAN build (make D=asan) would cause memory leak for
> btrfs-corrupt-block inside debug_corrupt_sector().
> 
> This can be reproduced by fsck/013 test case.
> 
> The cause is pretty simple, we just malloc a sector and forgot to free
> it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Missing the issue tag:

Issue: #806

That's already fixed in my github repo and would create a pull request 
for it.

Thanks,
Qu
> ---
>   btrfs-corrupt-block.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 124597333771..e88319891910 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -70,7 +70,7 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
>   			if (ret < 0) {
>   				errno = -ret;
>   				error("cannot read bytenr %llu: %m", logical);
> -				return ret;
> +				goto out;
>   			}
>   			printf("corrupting %llu copy %d\n", logical, mirror_num);
>   			memset(buf, 0, sectorsize);
> @@ -78,7 +78,7 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
>   			if (ret < 0) {
>   				errno = -ret;
>   				error("cannot write bytenr %llu: %m", logical);
> -				return ret;
> +				goto out;
>   			}
>   		}
>   
> @@ -90,7 +90,8 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
>   		if (mirror_num > num_copies)
>   			break;
>   	}
> -
> +out:
> +	free(buf);
>   	return 0;
>   }
>   


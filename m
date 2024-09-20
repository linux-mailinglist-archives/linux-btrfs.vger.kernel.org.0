Return-Path: <linux-btrfs+bounces-8140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54F997D09D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 06:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD41F21C33
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 04:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F22A1C9;
	Fri, 20 Sep 2024 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DWCtswfb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0679C2
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726806899; cv=none; b=RM7gR9DtAae16IMv7EQywKCCL/FtRLgObU9mP/OKRdiNyzpxOGFCOCoo8gvLlMntxxMERQ2w+O9vYqn4wRkbNqtHX7Az59SahHwejSUXhFqlWOqbRBJztHJTrWfz9aGS1dAYzPLkw2FJXgY1QBgGz/aKWzWHq1dlAiboMjHYnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726806899; c=relaxed/simple;
	bh=c+L2YY0eYnE4ZRAk35/gAEbFAwnxPnOoEsjVV+BpSEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uAPvF4gZzUBHv0lcCW/xzFVlfn+yd7cwFUu+MVYTeckc7cWIdCkkoOi2CjRZQEpZcSO/ox7I0XtJtY/gEruuAhcbnn8I59hrKo5pVNj/Qu3JJNLL7NzS8P8XQPnHU+uB31ull0b7abD7GMtZFTV057cAKcI/bvO1hYK4eMK32NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DWCtswfb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f74e468baeso18598381fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 21:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726806895; x=1727411695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xamLrWSYBxyubXY5RrX+3e1E/8W0BcpAPMbCGCXlXj4=;
        b=DWCtswfb26wXz9SCT4+PmYHYk399FsabbjMlb37o08DiiCAt22wuni3Ujp2pbhT08k
         h1nJU75S/SmEa5VKW0YxFtXFNl7txj27+kAQ2OXwdY9k5qfAWnCEoLHjrKmiFC0reoqY
         RLdQjBbKhI2UEBYN7uXopa/aRNNikC4tilEfY7wVNff6qdaiB8/5CUBVp742DZdpIDFy
         mishf4oGgZLKoy/+TfxEXIrWofvWib90AY4yVrmn5pqhv0dICSV3/T+B3I9p0oz9gEUg
         dkuANcixzyYtLltIgQGDl9kHnJMmOlh5DcPWv0h8FWI+YfiCU+NSYvWpT2k1p4PJ0SvB
         hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726806895; x=1727411695;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xamLrWSYBxyubXY5RrX+3e1E/8W0BcpAPMbCGCXlXj4=;
        b=twDO++HMpbnBmjQmiVATCamNSzQWksszhJBMHjPQP0mBplCYi7zCtNQkDgJNggdL+5
         3xQDXPUm7X+WfaENRm1xrDuxm2KgCGviXGN3B5gsbetDlV2C7V4Zw9D62HA7parO3ALx
         U4tlLsyFcUk/GfI6/Dvug4E8aqsVTfq3C3Ld9DD6oapoFgh5YgHZd8BVtvYk0WX4MUYB
         e8wMDWxTCKlDCxob0quCZ/zPoEC/EpND8u13snzw8t6nfqWdfsBKx4TA+d7Rh8Nhnnx9
         l+U8A3AC62PxHaSqJKDPMY4qBGkNPXT/OkArkp/XUEfIJCpPuou+EwdPFw6MsvrVZP0z
         mdwg==
X-Gm-Message-State: AOJu0Yw7kJSL2A6VlaPDJ3AhdNDNQ0//poyZxW5ZK/H88EKAWzDEZqpG
	pCMy109QatsLTGEbQkSn02Yt8XNX9/4KxtggQSHPmj+zE3EmpABYYEhLwuDMQcKOw8bNdZ1YxlZ
	h
X-Google-Smtp-Source: AGHT+IE/m1pfiD+4yTJHGjVliFTi6TjIuJhM748TiPNAc5r4wfqKoPxKYw3/vzOryda1bD+F+uDhLQ==
X-Received: by 2002:a2e:a586:0:b0:2ef:243b:6dce with SMTP id 38308e7fff4ca-2f7cb2ed40bmr8579111fa.10.1726806894350;
        Thu, 19 Sep 2024 21:34:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7e083sm9297565b3a.140.2024.09.19.21.34.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 21:34:53 -0700 (PDT)
Message-ID: <cac5a710-63ab-469c-bfcc-327da82fa036@suse.com>
Date: Fri, 20 Sep 2024 14:04:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: libbtrfsutil: fix the CI build failure which
 requires manual intervention
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <d148df614aef86dd6244dad3e0726750a3176b34.1726793990.git.wqu@suse.com>
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
In-Reply-To: <d148df614aef86dd6244dad3e0726750a3176b34.1726793990.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/20 10:29, Qu Wenruo 写道:
> Currently the libbtrfsutil python binding requires `pypi-README.md` as a
> temporary file to act as the longer description.
> 
> But it requires the build to be run twice to generate the temporary
> file, preventing CI to properly build the package.
> 
> Fix it by removing the exception raising, after copy_readme().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please discard this one.

The offending patch shouldn't even be pushed to devel, introducing too 
much hassles but doesn't even bother to resolve the self-introduced problem.

Will send a proper patch for the long description, not building new 
fixes for such cursed solution.

Thanks,
Qu
> ---
>   libbtrfsutil/python/setup.py | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
> index d4de81dbc1f2..fe9fdf8a52b5 100755
> --- a/libbtrfsutil/python/setup.py
> +++ b/libbtrfsutil/python/setup.py
> @@ -69,10 +69,8 @@ void add_module_constants(PyObject *m)
>   
>   
>   def read_readme():
> -    # FIXME: hackish, needs to be run twice to work
>       if not os.path.exists('pypi-README.md'):
>           copy_readme()
> -        raise Exception("Copied ../README.md to pypi-README.md, run again")
>       with open('pypi-README.md', 'r') as f:
>           desc = f.read()
>       return desc


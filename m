Return-Path: <linux-btrfs+bounces-7103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66294E3BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 00:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094501F221E1
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24A1607A5;
	Sun, 11 Aug 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RVqYoQ7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2D1804F
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416382; cv=none; b=RL3VOHKSPkmtNHZjBScUZYbkUsSJhQvVWd85q+vceNa/gwI5vQBt2GBs2mqxatTkCO1g6DSsOGlJz+ayF276CIz527inAOVtf+EywxzQU5WdMN+XNpcgk2dnsSqc3+cpn3ScCyJbtKMw84F4lmO5dnrMbSmOwZUGdPGLko3gxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416382; c=relaxed/simple;
	bh=By38rXMSMbg8/vdtJmunY9ugKiZh8jPoGi4dkzfCE9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bPDD1/chIKhGr6EVtRoaIvAQ+7L5QAEfBQX3FNi8OURPUOT5pauG6rkSMWHgtwEaJRE2arfZYiYy3jj8U+qBLmkHyY8OAGtkh/CFkGv/sNe7/ohnkq9UTyb3Ctwwa7Q/vXbl1A9J7IOC6PipU952WjTpA1VPRG/UbQ9ccJDDPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RVqYoQ7L; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso40261851fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723416378; x=1724021178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RJh7cN0zL5se3VUVU7Rf804sG/UzGr4DDlzHCIeFUHg=;
        b=RVqYoQ7LZeOFPA4fS2YTS5+iATPomMlfaAexAJOB67BJ7Tbz2q3ZKgzMDHE5ZO7bzw
         67VtUfTdjDqjlPMLJKv/Gqp7oR7E1k0Drw677OOA/0UMKcJBjnftVeYcI7NzyEdjb262
         x6tf9iNO7gLkzcwNhr0AQJ/HxQfR5enShZidER19VQIZ05msB9TgpJZrPsM/ZlFSHzAe
         FN/nyh+IjwYDwijiQHEqTO26mGAa9xds+F4kqFXiS+P0VClJfaRYnSPut8JRBD+/qiVn
         DDKBq0ZZCInv/Sy+LwsY2+AsK3qfQl7kl5FsBWLSF8aOYI2UZ/MfFHqUaOuu11Gqr9tE
         cqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416378; x=1724021178;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJh7cN0zL5se3VUVU7Rf804sG/UzGr4DDlzHCIeFUHg=;
        b=RcIOzPf6/D1bigG03aYFKUiIE3MTWVkrQihHF9nWpOBo/xzTLYqWo6a6pena5j8huE
         rmroYPFFPaaFKtp2GnSBiuoybHjMwUK3pz1+92gE3VGmUPYZA49FDOo9iJU4W2d8Ro6H
         JB0kAc50MOJI7sbJmX8CS+cFSsqcUJQ7hVNhPKbwlJ9PuClt72l/iDcWrFBP+3W4xcua
         sX/yxNnJ+QGv/T1n491Wgup50pLOPJ8sYK/Dq6BIBe3+r5b0c2BAVtbAF3QBg3GmltRN
         glBZ/lMnS2zdV/tVJVDcjttvtqOgGi/nIdDKFMHwDryGX7xThD16xm6miT8mP47aleRD
         Pf1A==
X-Forwarded-Encrypted: i=1; AJvYcCUSbLNG+BvPt5zt+FpjW3XjCnEh19ESe5AJwDiIkhOy/PTW3/Lm8jqKCCCSRMnvoLuJPaQK+6g6t8CltoEd+I9c5tVY3+/m4EWxroA=
X-Gm-Message-State: AOJu0YxqLnNyl6MdhnxLTo+FX8GMlAuBHRzpmCY/NbgD4GTAXAwzDApY
	ofAlnKIQ2iFfh3lXWUKkusEx9vyzTUyBp07LDiGuZtgqFjXKagwRUd6G4oW7ySSsy1vcuEigFjE
	Q
X-Google-Smtp-Source: AGHT+IF9gGcalS4RGaZ8b0STOQOaeCuZCR090uvcbyNC6GkfpvwrlH30VZcTVULTsIVuLlhiIzdmqw==
X-Received: by 2002:a2e:602:0:b0:2f0:1a19:f3f3 with SMTP id 38308e7fff4ca-2f1a6cec373mr52711241fa.33.1723416377826;
        Sun, 11 Aug 2024 15:46:17 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3f06ae9c7sm503527a12.15.2024.08.11.15.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 15:46:17 -0700 (PDT)
Message-ID: <972ddd12-2196-4709-a7ef-549992ba4a43@suse.com>
Date: Mon, 12 Aug 2024 08:16:13 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: property: introduce
 drop_subtree_threshold property
To: Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20240811122415.6575-1-realwakka@gmail.com>
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
In-Reply-To: <20240811122415.6575-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/11 21:54, Sidong Yang 写道:
> This patch introduces new property drop_subtree_threshold. This property
> could be set/get easily by root dir without find sysfs path.
> 
> Fixes: https://github.com/kdave/btrfs-progs/issues/795
> 
> Issue: #795
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2: error msg for -ENOENT, fix desc for prop
> ---
>   cmds/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index a36b5ab2..88344001 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -35,6 +35,7 @@
>   #include "common/utils.h"
>   #include "common/help.h"
>   #include "common/filesystem-utils.h"
> +#include "common/sysfs-utils.h"
>   #include "cmds/commands.h"
>   #include "cmds/props.h"
>   
> @@ -236,6 +237,50 @@ out:
>   
>   	return ret;
>   }
> +static int prop_drop_subtree_threshold(enum prop_object_type type,
> +				       const char *object,
> +				       const char *name,
> +				       const char *value,
> +				       bool force) {
> +	int ret;
> +	int fd;
> +	int sysfs_fd;
> +	char buf[255];
> +
> +        fd = btrfs_open_path(object, value, false);
> +	if (fd < 0)
> +		return -errno;
> +
> +	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
> +	if (sysfs_fd < 0) {
> +		if (sysfs_fd == -ENOENT) {
> +			error("failed to access qgroups/drop_subtree_threshold for %s,"
> +			      " quota should be enabled for this property: %m",
> +			      object);

I do not think this needs to be error(), warning() should be enough.

> +		}
> +		close(fd);
> +		return -errno;

Furthermore for ENOENT case I do not even think we should return error.

The point here is, if qgroup is not running (or running in simple quota) 
mode, there is no need to set threshold at all, thus no need to return 
any error.

> +	}
> +
> +	if (value) {
> +		ret = write(sysfs_fd, value, strlen(value));
> +	} else {
> +		ret = read(sysfs_fd, buf, 255);
> +		if (ret > 0) {
> +			buf[ret] = 0;
> +			pr_verbose(LOG_DEFAULT, "drop_subtree_threshold=%s", buf);
> +		}
> +	}
> +	if (ret < 0) {
> +		ret = -errno;
> +	} else {
> +		ret = 0;
> +	}
> +
> +	close(sysfs_fd);
> +	close(fd);
> +	return ret;
> +}
>   
>   const struct prop_handler prop_handlers[] = {
>   	{
> @@ -259,6 +304,14 @@ const struct prop_handler prop_handlers[] = {
>   		.types = prop_object_inode,
>   		.handler = prop_compression
>   	},
> +	{
> +		.name = "drop_subtree_threshold",
> +		.desc = "subtree level threshold to mark qgroup inconsistent during"
> +		"snapshot deletion, can reduce qgroup workload of snapshot deletion",

Please do not break the string, even it's very long.

Thanks,
Qu

> +		.read_only = 0,
> +		.types = prop_object_root,
> +		.handler = prop_drop_subtree_threshold
> +	},
>   	{NULL, NULL, 0, 0, NULL}
>   };
>   


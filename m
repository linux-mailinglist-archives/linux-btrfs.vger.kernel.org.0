Return-Path: <linux-btrfs+bounces-3639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404888D0A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A58B21495
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2913DB9F;
	Tue, 26 Mar 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YixseXxO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA9173
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491637; cv=none; b=J8Ysy9vH2PgVoh5Xkp5juIugGh3SHXroP6afXhi86dch0x6kR+RD7IArpNF2/tamBavLii0M5dP7jZZCK6NKLCivAnXeFK7kk4XR/0Y2yS6o5L35dhA99yYdJpXjWDuiYkqThOINmNpmqVrMsa8kwPLpcj8gOmruuom/uFErmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491637; c=relaxed/simple;
	bh=Gykh9jnDerglikXh+QQiPB41J1Sz2Uorz7TlbjA/YQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s9Drh/3rhu8NQRIW2TgJEeNsIFPc2j2ZEWlIL1EbdldGc5K1iDiPxo9f/789tmfv/Otx773dasz3hHqQm0wdxfWJeNvuCWtNUzLGnod/QE29TV/BikqIYbr448Gjbcj7QeB7n802AYfzi6xunCR1ZBFp0WrRyGvlMbOCJm9v1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YixseXxO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso48460911fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711491633; x=1712096433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcXW2DfA1ckFtd+rxP0OamSz6g+h/Ak7rNVGZn1k4vQ=;
        b=YixseXxOoqwqGITnQq/TL/xTBIKU6RtvW/F+LU+wCSgTRclzkuZfZzx5SBiNIdZYU6
         k/ozmZq3B5kqhd/qUe0iKFGuZXODAeVszQOL0dB0OQ7wFbIcgoSACjqmiCWWjl8niAAL
         mRLqQMxahgN7rVI+J7CCpTYM9hK/3wW8fsB4qtKJPHfCLpp95rjG1B8JLI0F9kjaU0vl
         0j4ycXLjU1XUhhoEaRtWzZcZdVpl7V+AyXxht0QQ5s29tifj4ddnvmg/hP4Wo1lA5Do3
         pZQzLLl4zKnc4/659zKpnZHXQFDJ/roAE9Rt/QnNM/mCcTfjdeXCQGKZXrPDfsBBBXfV
         /g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491633; x=1712096433;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcXW2DfA1ckFtd+rxP0OamSz6g+h/Ak7rNVGZn1k4vQ=;
        b=l+JVAY/7Q1YJR89uWv/4WKopqxGXHsVrlIhVGCxruUD0GDqtORZbc1WHz8W52WxfjV
         jAvzDD5MeLHcCC8IdjC+sp8yUVabvUKc+gn3TcDlwGuyKvtVydwL+2POA86kGE4rn8zn
         8Fb0kNT4ho+WBCjSr0xtFMQoLzwsoW9aP7aAXjAA3jp3wmrX2PQukvBNK4qPkRW3DpCE
         +9qEVkNnmILki4kS7QJlnop7SLMP9V0xD0vF6/omvxIdpiCagulyRV+YXrKs2/f8Nq6l
         ZG66geN3d7ItCUzOxHaEqefTqcl2H3UZ6zc4T5Snjw3kHz4JK6bR92AJwBuhhkrsGcpi
         BQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzg/17BdNUXdRyBO5yp+Eyc0CcuoXuf/leKG+kbFxpvSF0qV2ihfzVX3QwDZOUqt2iyvOs0kp/Ic1d1vMvi4cbti/zfz9HSZuhhuc=
X-Gm-Message-State: AOJu0YxIIvRcm5rhtwmoPQ8dHynu3D8l8Lwvo9GJW4aRWSh/fjXDq9y9
	htJvnve66OYLPVuNsTCO0fKCw8kQx2fMZjUCWGlICm4Zp2gILTGPPX9TBh81JCVCxogwWDDTM9m
	R
X-Google-Smtp-Source: AGHT+IEjkEFM9gBvW9Xhpz4OF1PyN2d12kj05OGFm9XxP+pShvmrAUEQ3OkhLOgoDP1XC/ofqWlWVw==
X-Received: by 2002:a05:651c:1407:b0:2d3:f3bc:bb65 with SMTP id u7-20020a05651c140700b002d3f3bcbb65mr1545786lje.11.1711491633055;
        Tue, 26 Mar 2024 15:20:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id k63-20020a17090a4cc500b002a000f06db4sm127238pjh.5.2024.03.26.15.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:20:32 -0700 (PDT)
Message-ID: <ab6cd513-ecaa-4b97-a057-203b3494cc51@suse.com>
Date: Wed, 27 Mar 2024 08:50:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: always clear meta pertrans during commit
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <e38da2f7e722fbbb6e7653e69f1d28aa2e9e3bf4.1711488980.git.boris@bur.io>
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
In-Reply-To: <e38da2f7e722fbbb6e7653e69f1d28aa2e9e3bf4.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> It is possible to clear a root's IN_TRANS tag from the radix tree, but
> not clear its pertrans, if there is some error in between. Eliminate
> that possibility by moving the free up to where we clear the tag.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/transaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 1c449d1cea1b..df2e58aa824a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1494,6 +1494,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>   			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>   					(unsigned long)root->root_key.objectid,
>   					BTRFS_ROOT_TRANS_TAG);
> +			btrfs_qgroup_free_meta_all_pertrans(root);
>   			spin_unlock(&fs_info->fs_roots_radix_lock);
>   
>   			btrfs_free_log(trans, root);
> @@ -1518,7 +1519,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>   			if (ret2)
>   				return ret2;
>   			spin_lock(&fs_info->fs_roots_radix_lock);
> -			btrfs_qgroup_free_meta_all_pertrans(root);
>   		}
>   	}
>   	spin_unlock(&fs_info->fs_roots_radix_lock);


Return-Path: <linux-btrfs+bounces-3634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82F88D061
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6491F610E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709A13D8A0;
	Tue, 26 Mar 2024 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ERv9KlQV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E723CB
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490458; cv=none; b=kgvGGXljNKw6rq2r40r6WRELD7KBCu2ZKvhcNBw9ZBIL0UGnU1ACpN57JqMguXyNqr51DudrP4/mdgsr5to3BOXWDomAhPNHhV+L801hfzl2WF7sgHrQ5mk0ddngmre+oU8/z3jJDu92e+bn3+Qr6/QrB/g1fmbAfAMoTaS3w8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490458; c=relaxed/simple;
	bh=nOVVgzvUPi75WBxVmx29aMUMPtKKW2605ajRZPuszZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PBDf7aLTl8PUTfcaPClUfAN6e6Pji7Hka89/7pd7vHdO0ghxxNi2hGfXpJs4B3amYHlrmTNelAZ58HnjFSMO3qN4+YJ+wCUdnNWd/4f3iA+2KUpJqMLGbHyPqpW0uM0eydyOEOipQqT3aS8f24cX5hbSIdhoL6h9ZUz4rBo6u0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ERv9KlQV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so86675961fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711490453; x=1712095253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8R4Hn9RqZrb6SVsfUwSL6xACmQw029dsyFoc6ofnwk=;
        b=ERv9KlQVILmziSFzVEvS3LYFBGIsKP2kAtXgfHRGwWR2ob8sGD9CYmfrIwgtBkWSgt
         XmgAizIIpM3I01wURG5amUOmeTCwZcdkjSgOY0PTTPNqn8g4uPX1nE5mk9Rme5HRAj7E
         qyBKcdp4EL+iytac8Vu6fG+9shygszKF22OKVSBxD4x6FxZwEgWveRc0WJE9f3MXzsnL
         Ld+gf44KdEoNEOeS/P/p4BNdGJ2I+TV2gX0V9Sh8grP4tLkjBE0Y36Srv2+es80voXy2
         RCdcIE2LTFmne6YI4F8U+9a2arkOq73qBDTlUZkGlCS8VBAYJ+aKJ5ozu2wu0yLLpih4
         J7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490453; x=1712095253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8R4Hn9RqZrb6SVsfUwSL6xACmQw029dsyFoc6ofnwk=;
        b=w0QNHTSmrWZ/ECBisdCWevTPxmyTaNuEx3YDDcrlu+QT8cW1I+1OWQ9JHB0TetGxp/
         6o/qehRtaK2EGgVv0kzbNlaDKoyt3a7/dJufzbA6+FHPTbIcz7/R8+GbEUgtv4/PCVQ8
         w/sSQe2c3uIzgTcCXMRerPvbMvotlvZv0uNG6ivFWoYPQkgtCY/nPZov36O3CUFTGAKH
         ayjzM7rwib+0jsmpoVDru6Zk3axJ7za5f9VknNC9UFzZ1ZBn89ZTA74ZXCe3sip+hW3a
         6M0fwZauzoVMDklyhgzbB4t6PZNNWErqYHFr8q0Szfb9M9kLlftLs0LUOrCML1qx1RqW
         vc/w==
X-Forwarded-Encrypted: i=1; AJvYcCWd0uj2Pi5ulY29HzYgsVG2nVFgfZQ1uq6XJNx6aBLABm6O2lJVRnViBKMrAeKkHDqGZNTiNcOFb9DfpsN+NIyMAgocOPraROgyvFM=
X-Gm-Message-State: AOJu0Yx5gpIYurDvlQ+iNHxhIedzcTko39za5HMMEorJ8R+5rDtWS6u0
	hm7gWXcwEAgjQce6g0g5COss+Fk+fvWivw44KrQ05mu6FCU9mAnsQZ2OPJvfzYvPuvGdGNc1VYs
	f
X-Google-Smtp-Source: AGHT+IHIWPcVPCDu75KlD6DNfGHWjTI+nGbZq24m2hq9wMKB50qfAKBQvx7g4HCXqCDLb2VrJujORg==
X-Received: by 2002:a05:651c:1310:b0:2d2:ae55:f428 with SMTP id u16-20020a05651c131000b002d2ae55f428mr1895675lja.34.1711490453547;
        Tue, 26 Mar 2024 15:00:53 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e0b5fd3c95sm5486868plb.259.2024.03.26.15.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:00:52 -0700 (PDT)
Message-ID: <245057c8-e7fb-4ad0-9e88-d21ae31cf375@suse.com>
Date: Wed, 27 Mar 2024 08:30:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: correctly model root qgroup rsv in convert
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <71f49d2923b8bff3a06006abfcb298b10e7a0683.1711488980.git.boris@bur.io>
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
In-Reply-To: <71f49d2923b8bff3a06006abfcb298b10e7a0683.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
> pertrans reservations for subvols when quotas are enabled. The convert
> function does not properly increment pertrans after decrementing
> prealloc, so the count is not accurate.
> 
> Note: we check that the fs is not read-only to mirror the logic in
> qgroup_convert_meta, which checks that before adding to the pertrans rsv.
> 
> Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to record qgroup meta reserved space")
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/qgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index a8197e25192c..2cba6451d164 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4492,6 +4492,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
>   				      BTRFS_QGROUP_RSV_META_PREALLOC);
>   	trace_qgroup_meta_convert(root, num_bytes);
>   	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
> +	if (!sb_rdonly(fs_info->sb))
> +		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);

Don't we already call qgroup_rsv_add() inside qgroup_convert_meta()?
This sounds like a double add here.

And if you have any example to show the problem in a more detailed way, 
it would be great help.

Thanks,
Qu
>   }
>   
>   /*


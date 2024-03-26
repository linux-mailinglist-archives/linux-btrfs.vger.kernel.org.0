Return-Path: <linux-btrfs+bounces-3638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DD88D09A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301181C2A825
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95413DDAA;
	Tue, 26 Mar 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RKyh9beR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152A13D8B8
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491409; cv=none; b=hneMLUwQtbv/foRdHrqCP6fpeFlvUBtFgcE37MSAFSkY9z8DsokRhPYYHEZ4dtpAvZDpOr5rz6Ih0+z/49NZ2Zs4bsbSZGQUSbsxJI8yAjuKZ5is8AKed9pN3wOuByfc7P11pPffr2nOPmo3Q/QiawLP81nlsmHZiKbFhkBGTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491409; c=relaxed/simple;
	bh=/2B0Lbl3G1w3ZjvI0Mz6g6ICfCFqDds6MVMiCIzbF38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hFXMfP13C6dxM0Rvx2UbnUc5HPeY3g/PGq+227emeJXvzbmLPrxRf2s2nnO2XTmQ4lJSw0rPP3Fz3XJe9LANUtw6ISTjVhO+0CYulY3LTNEVOkHqrNWp10pntcplQ3d2wL/JyRJpsWqC4Buj9QKFVR2filLXynJtxlTqjDdCUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RKyh9beR; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso80511251fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711491405; x=1712096205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXkkYBlzKQCtQdfRJe+nC6cBY9CQu1ZGnxztlMZix30=;
        b=RKyh9beR/6QbJ7fiyhDU+B6yKFFDdN85xvUmFAIAkmvbWn2SKm70k0nUHPQ1W1BWCO
         Xi0ti/dZz0cpXci4GUaJinzUOJ+ZK8YOHXcbWUnr9H0j530vGrwjGztubRZthQwguM/T
         aeUsIfUSiYnlOl/5m0wqJQx+B76FcZlOAYh/YAsMuvuUDTpN90eEoKwKV8Qab6GjfG/Z
         6MyafbzX1mkcASzcUsL5Q9PhsnEEKOWwJtzsb76hh9p0CJbizDYIaE3M5aV3p7EkNaSO
         vilpvd+ZO08PRsi+axmwXqNE+50s3IoDp1QvoNFqPdtcEbcPtrLYLhKxGu+c4HyGlEca
         CFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491405; x=1712096205;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXkkYBlzKQCtQdfRJe+nC6cBY9CQu1ZGnxztlMZix30=;
        b=k4guYx3ubRSLFKeU59f8vP1bJ9AmKyx+o+XAqdY4MNV3JL6w87U4bQ+qBQy81njhpI
         POZcjV/AC4F3/8Q1DzhlDZgqYuuHQNDwJaP4m6Ndaa8E641Y9h4xu/h42jdSZO5a+vQh
         SFl4J1Z1ULkTUD8G8HLb2x2dSghISHomEzFb7gf2IqTqhP7hjA5pK59X6YamK6/47Y9J
         NUAhoTipBaGeGcOuNbe+ffuLxSEZnWa4eedHnCSmwLYBariorgXiG5X5xFKNSqEgCXso
         SxKrrizjwGMUJw3fSFTry3pOY/bv9dbWFfRdoeJCHe9G6/hCz9UNdixrVrkEmZPMNwa1
         px+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtUxwEtKKFKi4rsyFQdZGcehnzLY4Gh34HaQgSPDoVv+3SVj8qJLlf5kLrjziz6GLjPL61ct401K1dtIYTKugoVPf9yCDraUhvEiE=
X-Gm-Message-State: AOJu0YzVoQdwENc2nVCxwmYELJWmCkAjagacA8AAPNM0QyGKUJXd1u1m
	QULmzT/kvGEHUpCKyEJ67FzMRFcia9Mb1baf7loMmuCVUuB6tZEd5O9nZp0146KgHMBLsxfLpzr
	S
X-Google-Smtp-Source: AGHT+IG9O+pT5Diw2wZMybPrndDYyBQAZBEiIMP48mP6EDHV3s3DUxBYE2HYX2NSU+Toelz6B7FAlw==
X-Received: by 2002:a2e:840b:0:b0:2d2:a3bb:e319 with SMTP id z11-20020a2e840b000000b002d2a3bbe319mr605893ljg.1.1711491404932;
        Tue, 26 Mar 2024 15:16:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id ld8-20020a170902fac800b001e009717560sm7404546plb.232.2024.03.26.15.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:16:44 -0700 (PDT)
Message-ID: <78f3a17b-4b74-4b8e-b7c9-fa8a5eaecefe@suse.com>
Date: Wed, 27 Mar 2024 08:46:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] btrfs: free pertrans at end of cleanup_transaction
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <1697680236677896913e26948a76a2dd01dad235.1711488980.git.boris@bur.io>
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
In-Reply-To: <1697680236677896913e26948a76a2dd01dad235.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> Some of the operations after the free might convert more pertrans
> metadata. Do the freeing as late as possible to eliminate a source of
> leaked pertrans metadata.
> 
> Helps with the pass rate of generic/269 and generic/475.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Well, you can also move other fs level cleanup out of the 
btrfs_cleanup_one_transaction() call.
(e.g. destory_delayed_inodes()).

For qgroup part, it looks fine to me as a precautious behavior.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3df5477d48a8..4d7893cc0d4e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4850,8 +4850,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
>   				     EXTENT_DIRTY);
>   	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
>   
> -	btrfs_free_all_qgroup_pertrans(fs_info);
> -
>   	cur_trans->state =TRANS_STATE_COMPLETED;
>   	wake_up(&cur_trans->commit_wait);
>   }
> @@ -4904,6 +4902,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
>   	btrfs_assert_delayed_root_empty(fs_info);
>   	btrfs_destroy_all_delalloc_inodes(fs_info);
>   	btrfs_drop_all_logs(fs_info);
> +	btrfs_free_all_qgroup_pertrans(fs_info);
>   	mutex_unlock(&fs_info->transaction_kthread_mutex);
>   
>   	return 0;


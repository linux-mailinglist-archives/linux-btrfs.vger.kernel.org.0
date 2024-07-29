Return-Path: <linux-btrfs+bounces-6853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8394005D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 23:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9432C1C20B14
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377818D4CF;
	Mon, 29 Jul 2024 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qjmu+cTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88A186E29
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288371; cv=none; b=HYkbwXNXI8mvnZHmUCpH2nIaM0zqxsYcQrjMB9cpNf56sYOP1SNpONfRH0Z0vyBmSxBTbpOEg+AQiikqomLEpboiafQLN1Ux5DuGKXsN7nKO0CBP0PRXfemC8603ql1BrNkW/xkgwDsZbsYVMVtasp4nZ7ym2BWJMhhFntjropo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288371; c=relaxed/simple;
	bh=mF363wXx3RjSshA2XAXx4PfcaqX9LzTDIhfiQqWexV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QFy/6Pt/ptiZr+vZxMOc46ahx3vPDF6XdVnxncFoCHaJHsylKOOB6eKdPHAtqPsZyDJRC5obQZw9o/Sz17Qf2NBHQNWp5WkNp98RBPtD7KMcV0O2uKcYXpcFZlnSZggWxfVqNxILkLZ8sFmRmQI1r7bXAmKDR4Tm/HdocD2Bacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qjmu+cTO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3684bea9728so1946046f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722288367; x=1722893167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fJJQonw/hIlihVLe64bl9BnphV7hFXJ7T9PgIoQwE6Q=;
        b=Qjmu+cTOM7+MQ7nUs46sJjkvXHK09fvy5iVasNIEItkiPSbS3hPhDY0KpMYiH2wga4
         cmYqBWBffjCQpLxjls7P1hTrFJKRhFyqScoWd123vCmu7tz4FEBv8YgkB5Cg71MsBKVj
         3lVBZlvfKeGOTlvAYVQr3qa5Hmd2THPcDGnLyUmBFXt4frpbFQ4ueqfakttmsF0rAntD
         JDWuGs+Uvnw775laSyKPkf/CWFNNuPDG5uqW+pvKmqIdXQk3DjmhfTDuQtUPuYPTFJzB
         9gPF0hednsm6Q3p5ChVINsHTi55Cn10/JeAGoPlgexI1ijXFt/gRz4+h3A2CRyykqUpT
         Z0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722288367; x=1722893167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJJQonw/hIlihVLe64bl9BnphV7hFXJ7T9PgIoQwE6Q=;
        b=UME4DBAy0kIbz6swNWfvFLYWpPFHmunV1FOsJptd/hj+mJh50iw9PV6V40fbO4udqy
         7jS4eVEZi30+BzrZdm2yBSZm+H6xIRn0whDEcFwne6mScUYUUmQB8R/tkbFbZODBzbn9
         mQcZshXOVN3uqazx4DY7zrGFOl0DkzeOahxi1Wl+jVA++WB7kSeMixpkk3DEsFmjpw0Y
         H7Wt/EQPPssD0ms1fVdOYoQLYVkmBBuvoHGrj1vorfRzDkk6V8ywxvNVPdP9mlKvdQbp
         w0WW7Uf+8ld9Bje9W+2dGIEcrxLSnaAeGoEXYmeZf3Th4kYAGauhfkNE/AkdkAnF9iER
         uo7A==
X-Forwarded-Encrypted: i=1; AJvYcCUr2Wji8yFD+p7B93X5KTdB088o48F1mpph0CkEsmC93LegrxOFmRPuokUtfy/irnWjbwdiEdxaionrFHtXTVXvU3to+heT0jRdqMc=
X-Gm-Message-State: AOJu0YxuFyySEdBif+MVGOmp+cOlk+LgG9yZs9iwXh1hjyzidy7dPO2o
	S01ckPQ8IYDKyN3aaSZQfdoVGfP50pgnmzTGuU0m+eEDU5/9rxxBik7Gugfp7Qg=
X-Google-Smtp-Source: AGHT+IHHeDfew8E8bvdPjKskOoytqMXL+C+mWyxdgHFdImiqjOdMGpYihJasQwo0iEsR9Gw0m4oIvw==
X-Received: by 2002:a05:6000:4d1:b0:367:8847:5bf4 with SMTP id ffacd0b85a97d-36b5cee9bbbmr6584094f8f.10.1722288366853;
        Mon, 29 Jul 2024 14:26:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm88227905ad.157.2024.07.29.14.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 14:26:06 -0700 (PDT)
Message-ID: <612e73da-cd1a-4101-bb23-b59712600478@suse.com>
Date: Tue, 30 Jul 2024 06:56:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: emit a warning about space cache v1 being
 deprecated
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <942fd7466a40978db591c57457616f22fb0640c6.1722271865.git.josef@toxicpanda.com>
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
In-Reply-To: <942fd7466a40978db591c57457616f22fb0640c6.1722271865.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/30 02:21, Josef Bacik 写道:
> We've been wanting to get rid of this for a while, add a message to
> indicate that this feature is going away and when so we can finally have
> a date when we're going to remove it.  The output looks like this
> 
> BTRFS warning (device nvme0n1): space cache v1 is being deprecated and will be removed in a future release
> BTRFS warning (device nvme0n1): please use -o space_cache=v2
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/super.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0eda8c21d861..1f2e9900e410 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -682,8 +682,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
>   		ret = false;
>   
>   	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> -		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
> +		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
>   			btrfs_info(info, "disk space caching is enabled");
> +			btrfs_warn(info,
> +		"space cache v1 is being deprecated and will be removed in a future release");
> +			btrfs_warn(info, "please use -o space_cache=v2");
> +		}
>   		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
>   			btrfs_info(info, "using free-space-tree");
>   	}


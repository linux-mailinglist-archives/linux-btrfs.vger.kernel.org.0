Return-Path: <linux-btrfs+bounces-3445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E088804B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEC11F21793
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D092D796;
	Tue, 19 Mar 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QiXjm3WI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C42D051
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872692; cv=none; b=kSjKUFCCyEO6VFCQ+CugavhrDgm1VguYWoL/MEOUbArIr1OwdbxylTYnMMOXvNDAWPJ/TWubB24NQWQUviSOIIfJmvwNALHYagkyFhBxZAhkmgT7iH8ezHjLzhGd1iWO9VHd8+i/ip556pLfVp1UMPZrEn2+VjTTr545JS7U4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872692; c=relaxed/simple;
	bh=f3u5xyplYZ+Mq08tgagYkvUrZWMDRerMoXIFh0kHou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYeqh9S8a/67I43HMXnDFdt11RA90Ub8TQbXG9k/gGVotEz5RqG3xnat2zC89AYlFEU5gVB/fZjV+Rbfd5eOn8HET6iQvQ374ormR5cspTr3V/81U27JZDRKrx3lmRUYYDxsq6jh7wv2qGgHUHFfwNSHlmXybHNy//usHu3lpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QiXjm3WI; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c35c4d8878so2653253b6e.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710872689; x=1711477489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeLn9ii0I2GzXqnkXcyp0VdPlzLaFvRjGQOqdUSNwZI=;
        b=QiXjm3WIioPhjdoy+RHbXbfdyfXGfcfIB8smYI9Nx9OPM/gEe7HNC5zDpiKg66csJz
         B+hGSi1AJZ6+KUiYB9Wo4hbHYWAvmU3lw5LsWQjaN0Q1RGrTD3XwZU7PgoEo0V2heUXm
         eGTT5soZ0mU3nEh3f40QeVQzGzDi4rXVa9MW9yLBM7endDFqAO5YFNQlOld0cthc5Kl3
         2Pl2mny/4OqkO/0/8/mnqqMq8OlhhEOT8d8zFykX+0TpRbdne5TrLHeTw8Ql8keRRxEj
         LWagAb/nKgr0R2lofwWjoiu2BN+NYUwM7CNVDksu+pUbEIgpB8IvLhoLThJvZZfpTlOW
         IcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872689; x=1711477489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeLn9ii0I2GzXqnkXcyp0VdPlzLaFvRjGQOqdUSNwZI=;
        b=HoUtzdAjkX0hPtytHg5Ec6QjhuX0fNIoOTyr//GFnBaFfmjcWPFaQUlYve8NT0CgBr
         9b4KOgl0dFYPp+fT9k+Zdn4Lncn9nZUC5klOxsDzwrNWmKyit9UPoC5pOyjb5vQp19W7
         TYjUgz/9DBZk9R2TfxTKmQDBRM+iMS7054tL4w5Ykg9TpeVKW0hRs4vcmoXltBD/B2mX
         I18ZVzYWcU4A5khbvikecbLx0pYv0QljD0HLHCc2e3D+kKDkMLAgMsp/uUH8f8/5ePZg
         fihmT6tLreaEv90rPv0oWGEv9GeINwmfRRTcFXKqtS61fChePRkyAlHlh2STCR8YSrUN
         MRGA==
X-Gm-Message-State: AOJu0YyZJYrFptupM0trBuepej59+JQmdl7ipgO3CslETkNygO26Fr6n
	HK40kuz7F8BIW1T6QCIb/DFsNHUp9QiLy/IRb7JR3BXgS/dwYEQZ0OgCy1m+ccA=
X-Google-Smtp-Source: AGHT+IH09Pe0QcQp9yNz5/GIOZ46dGyrDeq/KIP5gXfCZpYhreNmnlQsXbAp3ZP0aePk/Gwg2gzDCA==
X-Received: by 2002:a05:6808:130e:b0:3c3:8660:b723 with SMTP id y14-20020a056808130e00b003c38660b723mr8789316oiv.58.1710872689525;
        Tue, 19 Mar 2024 11:24:49 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gd16-20020a05622a5c1000b00430c6318686sm3542399qtb.31.2024.03.19.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:24:49 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:24:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/29] btrfs: fixup_tree_root_location rename ret to ret2
 and err to ret
Message-ID: <20240319182448.GM2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b9fb4121b33c2b06ee0bcee74472c117481d2555.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fb4121b33c2b06ee0bcee74472c117481d2555.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:37PM +0530, Anand Jain wrote:
> Fix the code style for the return variable. First, rename ret to ret2,
> compile it, and then rename err to ret. This helps confirm that there are
> no instances of the old ret not renamed to ret2.
> 
> Also, there is an opportunity to drop the initialization of ret to 0,
> with the first use of ret2 replaced with ret. However, due to the confusing
> git-diff, I refrain from doing that as of now.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/inode.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 952c92e6dfcf..d890cb5ab548 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5443,29 +5443,29 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
>  	struct btrfs_root_ref *ref;
>  	struct extent_buffer *leaf;
>  	struct btrfs_key key;
> -	int ret;
> -	int err = 0;
> +	int ret2;
> +	int ret = 0;
>  	struct fscrypt_name fname;
>  
> -	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
> -	if (ret)
> -		return ret;
> +	ret2 = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
> +	if (ret2)
> +		return ret2;
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	err = -ENOENT;
> +	ret = -ENOENT;
>  	key.objectid = dir->root->root_key.objectid;
>  	key.type = BTRFS_ROOT_REF_KEY;
>  	key.offset = location->objectid;
>  
> -	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
> -	if (ret) {
> -		if (ret < 0)
> -			err = ret;
> +	ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
> +	if (ret2) {
> +		if (ret2 < 0)
> +			ret = ret2;
>  		goto out;
>  	}
>  

This is another place where we can simply remove the ret2, just do

ret = btrfs_search_slot();
if (ret) {
	if (ret > 0)
		ret = 0;
	goto out;
}

> @@ -5475,16 +5475,16 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
>  	    btrfs_root_ref_name_len(leaf, ref) != fname.disk_name.len)
>  		goto out;
>  
> -	ret = memcmp_extent_buffer(leaf, fname.disk_name.name,
> +	ret2 = memcmp_extent_buffer(leaf, fname.disk_name.name,
>  				   (unsigned long)(ref + 1), fname.disk_name.len);
> -	if (ret)
> +	if (ret2)
>  		goto out;

And here simply do

if (ret) {
	ret = 0;
	goto out;
}

Thanks,

Josef


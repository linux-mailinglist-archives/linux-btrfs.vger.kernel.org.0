Return-Path: <linux-btrfs+bounces-2456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57362858000
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF8B22241
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43812F380;
	Fri, 16 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGT9aZS4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1312F371
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095734; cv=none; b=MpUxQVsfbPkErB8z6JkP+9NxNdjfRijUBGs/B2MANIYNJoDXoMVAmqCKYFuzqDcz94tGkdkibYG8como1dai2wVgF8p//3Wrn0+brYf0QfRzwtBJAbADanWdEOZ2Ev09dk2sG9CMI9Jj6iocnrInjtaHXlDlrDtPs0aTgje5EOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095734; c=relaxed/simple;
	bh=VY15cb4sPWY/OGxNmTWPbGHd6YcBZkubimp6kxl3e9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icLvD88q/xt6TEvhpqRmBKInU3rOkdaqf2VAttW695DWda+mCFtmgso4BItRzHDIYroRqp4c8drGTeKir0SQ3gqnSzBl6pw+biMLf9Dl3U1xOVta3Nm4RnjZgxWNH8GpdLYaLVTPitCt5RJ4axa9JO6yclwk4gE2t5zXcqr8GZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGT9aZS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708095731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCSjgbj1ymwLX1C6dMEt9pKF79OFfPS7StJJLrlC8i0=;
	b=AGT9aZS4bV4XSN3YXHD+3AJOSdmMkZ4gWaDzGYSW9IIXGTNcKWttX8ViPZ7IE+AvZxRZYA
	RNBG2N/NAwV4jvfP57f2Ti+rxlh+JHwicCNz6PjVvUFi9Xdl4ZSB7L8Mg+fo0SizP364uw
	ysknvzZDpq7yWkrMhG8IqF2FZyQpSV8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-W50AwuKCMfCKSIkPGtLX0Q-1; Fri, 16 Feb 2024 10:02:09 -0500
X-MC-Unique: W50AwuKCMfCKSIkPGtLX0Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e0de722d43so1666996b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 07:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095728; x=1708700528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCSjgbj1ymwLX1C6dMEt9pKF79OFfPS7StJJLrlC8i0=;
        b=rAk+gkYt1r/Q3qkTk9Kd8b5xrlxFkwe/3XkJqfFr4tRXCd5HrtBFzdh8Fs1UOWMuss
         VGoxJH67iqMxwiER2JnRQaxqzPVzz87j9hgaewnQ5n0wtrdWQBvimjoyYzsuCXwy5h1O
         oCt5ZIS18VyQBp7XwtHkMpqsIqLv4by/tXf3eS8vbbn+HFVhiSQfKlU1JR6EaL9CgEDw
         AVFJIJAt80wxppjzR97xflwPoV6a/4OijhDY0wREgdQt5GGnVAS02r9n2+1BAAX8BhKG
         qvw2gA+PzMrE1zows63BK4nJwQKhfomM21oVFgkriisJj0rd8Pgq9ZXm1srbsqUqCu9s
         hyjw==
X-Forwarded-Encrypted: i=1; AJvYcCWah7AIQUYSh3fB7y6aqu80PhIH++pqUKagFgav9LA5QHDfy/ejiDC+7sHZeQjBKnvZEcN89WVVl+HxDaNCO5Ui1ucxigiRcSVO1AY=
X-Gm-Message-State: AOJu0YzXs47BE8hEsCROIFbY3KsgR52dF/2LfkTwB8ZxAsdfegd+Zh4+
	13EUROvAxmYYcSbN1hECVH6uVWj9eZGHBhYxUOJYK7HsLMDC87XVK53sMtGyDAnenvlhSCifjdo
	qbOyWh1DjD0S9QjcdmMYVXeF48pL6RzLeaV8QPwW0VWUrDwSGD0UkmTuShkY6
X-Received: by 2002:a05:6a00:2291:b0:6e0:e52f:dbdd with SMTP id f17-20020a056a00229100b006e0e52fdbddmr6478797pfe.26.1708095727990;
        Fri, 16 Feb 2024 07:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLHqe+sLnHRZaNmnvRIKB/n+wsjsx1DGh4ifROLPJCNnMazL6yVB+FIfvvQ9OYaciVNQgcGg==
X-Received: by 2002:a05:6a00:2291:b0:6e0:e52f:dbdd with SMTP id f17-20020a056a00229100b006e0e52fdbddmr6478758pfe.26.1708095727542;
        Fri, 16 Feb 2024 07:02:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k18-20020a628e12000000b006e09140e686sm41816pfe.60.2024.02.16.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:02:07 -0800 (PST)
Date: Fri, 16 Feb 2024 23:02:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/12] btrfs: create a helper function, check_fsid(), to
 verify the tempfsid
Message-ID: <20240216150202.vjkedtqtka3i5lec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
 <cd8342fb284a1983d7645698464debecf417e52a.1707969354.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8342fb284a1983d7645698464debecf417e52a.1707969354.git.anand.jain@oracle.com>

On Thu, Feb 15, 2024 at 02:34:07PM +0800, Anand Jain wrote:
> check_fsid() provides a method to verify if the given device is mounted
> with the tempfsid in the kernel. Function sb() is an internal only
> function.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index e1b29c613767..5cba9b16b4de 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -792,3 +792,37 @@ _has_btrfs_sysfs_feature_attr()
>  
>  	test -e /sys/fs/btrfs/features/$feature_attr
>  }
> +
> +# Dump key members of the on-disk super-block from the given disk; helps debug
> +sb()
> +{
> +	local dev1=$1
> +	local parameters="device|devid|^metadata_uuid|^fsid|^incom|^generation|\
> +		^flags| \|$| \)$|compat_flags|compat_ro_flags|dev_item.uuid"
> +
> +	$BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | egrep "$parameters"

Please don't use "egrep", it's deprecated, might hit a warning output.
Replace it with "grep -E" :)

> +}
> +
> +check_fsid()
> +{
> +	local dev1=$1
> +	local fsid
> +
> +	# on disk fsid
> +	fsid=$(sb $dev1 | grep ^fsid | awk -d" " '{print $2}')
> +	echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
> +
> +	echo -e -n "Metadata uuid:\t\t"
> +	cat /sys/fs/btrfs/$fsid/metadata_uuid | sed -e "s/$fsid/FSID/g"
> +
> +	# This returns the temp_fsid if set
> +	tempfsid=$(_btrfs_get_fsid $dev1)
> +	if [[ $tempfsid == $fsid ]]; then
> +		echo -e "Temp fsid:\t\tFSID"
> +	else
> +		echo -e "Temp fsid:\t\tTEMPFSID"
> +	fi
> +
> +	echo -e -n "Tempfsid status:\t"
> +	cat /sys/fs/btrfs/$tempfsid/temp_fsid
> +}
> -- 
> 2.39.3
> 
> 



Return-Path: <linux-btrfs+bounces-3472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C088137B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591D82828F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C8481A2;
	Wed, 20 Mar 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T01r7xOT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65A44C8D
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945623; cv=none; b=Xaf+uMqmMfRnMbCKfF2i8zyNhh/YlfqoeUwC8doZKyL9tr4NJ3CuUSPykdHRiZlPsyVpgiLBYcWdRHx80y/o5hp6hwOUKWKYqYQ18/6cG/eTjYBNHBotiDE2oyhHjEGNSIZQ9uNtwp/1tR+A5lj8vaIAyzhdonaFY0T5pqica70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945623; c=relaxed/simple;
	bh=TZWB7rVxfH6bCxHqRdJniVqZnVXMtnan6/FPGZtWuXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxkbV6o/mXNDiHuHuDsEfVB+ewIsthAMZqYyKb49o/4OCjDPDwh97vHbSdOqwldMRpZQXJoUbICjFnjWZ/pYwn/yTwSaHBJwSyeec5rtn6r09aJQw2Q9FXk1oUS7B36Id/H3URl9xqM8akoLgS6oC5pF1uuzufe6qyL0nZd2DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T01r7xOT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690cffa8a0bso39349916d6.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710945620; x=1711550420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnZ7/7LbBY99LdIkHT3CSgBcGGGSCDlCiMNc3f9EIv0=;
        b=T01r7xOToTMwEZDiELvsHcohd8UNvEKMVWJcn5VtCWOGan3UZ8jrfCT7cCg6l3VX5n
         ZPB7MxcpZbNWNTdO+K3xUL6Xgn6EK7EEkc5j7bmT9WVO84XFR8N7Lzziiarj/JDGiR4m
         2HnCI81OVn49gD0gpVc+tZrGTEk6u/GDNDTMbUyNRqK1gubTiJda+SWpmHkqSSd/9Tug
         EcCvJwjZZbcLEfsBluf1zyxg7fBw+NQ4nHIQwcHxF3amKy2MTKvFZGOPo8/23ThrbQWu
         ooHNZ5K4iDn6z+bqm38y6PAOq4uX48v+duyksrRSm35z218QQaFSl8L1JjavDfFgHjET
         I1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945620; x=1711550420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnZ7/7LbBY99LdIkHT3CSgBcGGGSCDlCiMNc3f9EIv0=;
        b=Ttj1YrFJlhsRWbm3vKXCUsjA4BKiDpWG/gP5yKIJ6UBP9BeB9PzBAYWXR2PWKReGIS
         vRIWua2pbx3DyRpKHgGLoymxWqlCCqjhsRoih6UOmd+SSuilKpw0JMZtTNwxQgQkNg3e
         FiurLu1jIVVR2GmAUq8FeoKLTZlIhp5ReZg2Qr0d10nENnCegsb64AVQZlOV2T0Pk9AR
         JEQPlzaw0N0dGJ8b71qPsmaoIM7DasMicrIp3sZQdqbsHLEooUYbRMUYxKtGKem5e5s6
         bnjFp1PU/23X9gv1JCO8CDdGH+ANCt7uB/x04Qf2nFxpI8CG7a41pGBfVox2sL1m2vKL
         8ltA==
X-Forwarded-Encrypted: i=1; AJvYcCUCplR+/GiH7xAWH3u9ugtpuzTY8QKlqYOpABGZy+QR6mEl3Dantc6lIumbnqCWnqG3cEZcUpSFfSVUsinN/ExylzLeHp1oNcx03L8=
X-Gm-Message-State: AOJu0YwDdq+ILlh9LFo53MHpsho9pzPB+Fxt2bo/CCIgcy6dX1kzD2al
	j8y2rW4W4HFqfyTvyGUnJXmb4Aa1lR2LmrXEryXQuYop+zF/Deq7DIP6nQ3xd0HT92dLZFYCjY1
	G
X-Google-Smtp-Source: AGHT+IEFiT6QR23j8AQiH+ZvELZAbJ3h4uvRzbjZQ3VjXxOaRbhGAJgdjOHSVfxfbHC822IrVv4TXQ==
X-Received: by 2002:a0c:dd93:0:b0:691:826f:5060 with SMTP id v19-20020a0cdd93000000b00691826f5060mr13907395qvk.10.1710945620620;
        Wed, 20 Mar 2024 07:40:20 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id if12-20020a0562141c4c00b006914fd6b64dsm7944582qvb.127.2024.03.20.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:40:20 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:40:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 1/3] fstests: check btrfs profile configs before allowing
 raid56
Message-ID: <20240320144019.GB3014929@perftesting>
References: <cover.1710867187.git.josef@toxicpanda.com>
 <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
 <Zfn8n5jmpTAdzBkK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfn8n5jmpTAdzBkK@infradead.org>

On Tue, Mar 19, 2024 at 01:59:11PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 19, 2024 at 12:55:56PM -0400, Josef Bacik wrote:
> > +++ b/common/btrfs
> > @@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
> >  		_notrun "Feature $feat not supported by the available btrfs version"
> >  
> >  	if [ $feat = "raid56" ]; then
> > -		# Zoned btrfs only supports SINGLE profile
> > -		_require_non_zoned_device "${SCRATCH_DEV}"
> > +		# Make sure it's in our supported configs as well
> > +		_btrfs_get_profile_configs
> > +		if [[ ! "${_btrfs_profile_configs[@]}" =~ "raid5" ]] ||
> > +		   [[ ! "${_btrfs_profile_configs[@]}" =~ "raid6" ]]; then
> > +			_notrun "raid56 excluded from profile configs"
> > +		fi
> 
> Should _require_btrfs_fs_feature check for raid5 and raid6 individually?
> Right now it seems like you need both raid5 and raid6 in the profiles
> to run checks that probably only exercise either?
> 

The tests that use this are testing them both.  I could make them optionally
test one or the other depending on the profile you had set, but I don't think
this is particularly useful.  If you have strong feelings about it I could
alternatively add a helper that is

_require_raid_profile "profile name"

and then add those to the different tests to be more fine grained about it,
since technically this helper is about checking if a specific kernel feature is
available.  Thanks,

Josef


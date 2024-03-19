Return-Path: <linux-btrfs+bounces-3440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA188045E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FFA1F21967
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071C2D057;
	Tue, 19 Mar 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UmRCYg6H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B272C856
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871672; cv=none; b=W7aG2d4cy+/ncUnE5iCn5W1zsowBwr292eVK0BO5XFGuE1ix8iC8BpGrjE7Pkci8iwOurTecrHfgv+F4+Sm2N1oZq3eRO9eGDggcayHP4DQi2QMEXGoisL8NGx5X9bKX5HVQH+xhX9zNNTDfdW5mskhoxLnMCEtupHREO7S8DGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871672; c=relaxed/simple;
	bh=61LK+Gjax14XVqXeDkR2PKvmpw7ZVLB8M+MtbY8LGJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLdkp3HpGTd9Bw20m+SCv4AAlIbfW6k5gxAhJ8CzYo33lpkjuP6K9e6H87EC92DJm6fQkTXw3ZP9iynqCzwHZeqBXPsi22rF2U7mdQVwbf6g5edmm0yI+ZuIoD7mQIr6br8OLqfoDck2J21OwljBGsHTW2B/gKno2PVqQpG7rl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UmRCYg6H; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6900f479e3cso52230986d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710871670; x=1711476470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIoTGIhEaaqi46WjeXIKFj+Y2RLZsXKG/tJl8vWkHCM=;
        b=UmRCYg6HqsCa/jGmthUsdTmkLaZ8PPVz3cC27xPziht9edwG7D5MQGSzVU450xaMt7
         PFma1mv7b9/2ZvVl07uSHtPlVOikB79q7dbMZs+oUlaAKiiwfqlOVwYE8Yz40GPWNlYy
         cgHrTcGjYEuFnCRcrX8yUzf3SVgU4hSKyGRQFcthJor7ClGMd0TIRVtykct5k01EDPFt
         M0k2RIa85RUSMU9dOT/eKU535dXvhfz5uwyniVnyxquhhN+F0We+zI68+FHorkl9LuUt
         +m4LP8C2hou5m9Mz6F5mSNNuECq7glxqDiBYqU5a98S3ed+BLY2vYVChvOLu7YdwSc/X
         aAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871670; x=1711476470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIoTGIhEaaqi46WjeXIKFj+Y2RLZsXKG/tJl8vWkHCM=;
        b=jXHNNN95jPHwa8GJ2eRhkkP8Aqw46t41CVB2GQrC9VjRJjBm7NI4R9Hzhc2ClieD9n
         P4IK+UPAYHEyjnD4xhfKL3n2tFQ+hMbcechsIJz3Q0dEUMartDXJGOX0O8cQTOyhRWQi
         xoiV6ov0vqw0aYpKZa+7dpIkppZ+6wUSEdv3aWADVenMjUjxHZo2+4Lh/BF89Kx+A2Yb
         MiH0HocZtcazzu2PlXs04/rbLfPZMWYjIuu4SYeKyR1t8hASTmnnI8dR8RrqQfj3QjPD
         elYGzttSXwmmSh3mzj8TSrNamxFEQuxugAM2GivWYx4qjv9awi2dOTt9FpGYzyQhmU8d
         g+FQ==
X-Gm-Message-State: AOJu0YycFkzT4GFCHaShOLFhUOMfJVvEb5+H5/t0bFYYuOnKjVZH8nGo
	vQG37c4LEecAk25Ta7Rh98Ht0Xn30brRbicBcfRzunVDtxCh5rhadaUCkLRFBfDnR4tVVyVXVjD
	9
X-Google-Smtp-Source: AGHT+IH47b/kHxW6y9Xwaosxv1UT/ftAYYoASvwdzqpEw8QXMjLWnWozmWbV4LDOFP5ik9IxtepJYA==
X-Received: by 2002:a0c:dd91:0:b0:691:8382:67a0 with SMTP id v17-20020a0cdd91000000b00691838267a0mr3264083qvk.50.1710871670221;
        Tue, 19 Mar 2024 11:07:50 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id hu15-20020a056214234f00b0068d191dfa9fsm6702603qvb.94.2024.03.19.11.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:07:49 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:07:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/29] btrfs: mark_garbage_root rename err to ret2
Message-ID: <20240319180748.GH2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <417f039ffc4db265a98214c8f86e9a36dbfb1c31.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417f039ffc4db265a98214c8f86e9a36dbfb1c31.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:27PM +0530, Anand Jain wrote:
> In this function, the variable err is used as the second return value. If
> it is not zero, rename it to ret2.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This is fine but terrible, a good follow up cleanup would be to make
btrfs_end_transaction() a void and remove the random places we check for an
error.  We don't really need it to tell use we have EROFS, we'll get it in some
other operation down the line if we didn't get it somewhere in here.  Thanks,

Josef


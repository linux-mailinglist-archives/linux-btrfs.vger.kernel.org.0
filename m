Return-Path: <linux-btrfs+bounces-7372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBD95A3DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA45B2215F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E951B2EF7;
	Wed, 21 Aug 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wD4dptY5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840F1B2EEA
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261265; cv=none; b=Z2SdLQE7cDcDOVGAU3NP1CL9TIRMywO5d8JgBxAja3/SpWxO6+4EVyny1rcif7wxDegxHgI3ocGupwiKC/b/CAEn+dS61/b2MC9UOJPO5L2vyJoLKiUuxItKa+UmtVkC6Gxaj7YF8nJ7HxX3035SffWBwqbLty+jUwhn3o8sQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261265; c=relaxed/simple;
	bh=EwPYUFOAxHHrV9LI5kKTTs7eXk5AK9Xan5YrYxSUWKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O470VGHvPiqOvxOD5I0m4P4geyU+aaTUjjHT19yYQS2dmT5jWI3P9GTVasy+JTjk9UzsfBAFdLPdPg/C5KculR1YV8Mxh2hKHQJml5wYddUucr2i9VSXt0lmC9Pzr5xxUg0EyUvgrCsIuHl2qhIkaLS7akrYWzfkAvR0yNAulgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wD4dptY5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6bada443ffeso8680367b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724261263; x=1724866063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IJeme2QamtUXFD3plVI7UdjyKa70GKhd6MD0q2rwJw=;
        b=wD4dptY5plGxrNVj0QAL5hxZhd8CyYeV/8yhbc8kVImzPr/wMrQujnH4MrDBJVWb+0
         RJGHiOjqMfigmOAMAYhsct3d7At/tV3hAJi0OGKgcTpaEk8y40NSEmYtZ9w6tyudZU0+
         roj0dQewAa11OFiqcd9fYPojAhDImRgvhV2eWaJuu5E3rCfSeD0bUAuuDuJNY1Patxe9
         sbs+gbcmdtFOtoW5xXaMSvLKgpmRV+pbxYFm9JjFdKM/Qp9NSaF7aTLuVQcL1vmAs8zD
         VF3+JjxWlFW3DkMfapBRws/L6VzbsFmUZsik6leefYpakQuGQgr0850uelcIxW5Mlw0x
         P9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261263; x=1724866063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IJeme2QamtUXFD3plVI7UdjyKa70GKhd6MD0q2rwJw=;
        b=ToKnypcQMio+64R1z5uhlgtKFJRbpCQwQJIeDh2QcaV8EOBmhXHd/yK4xZT5YXPjBK
         1LUzsWJi6AOebEipAaWxFu64g8hqvzef6DX3NS45Z70MpkqayPZzG6DYOKUCvOeufbBM
         LjZck4DbtY7Fkf/Edg2OCVnkO+qHW+U2Sp3VmoQ7N/F4awvg8gqvtX4EgvF3RmdkaUrQ
         PklYtTlMO4onvbbE4ETmAFKUgBcf+YBIa7wjVm2tUDI0kT+S9rcfTnX1NwhD0nypdPZ7
         UazR14IWqGbVTk3vSV0zjtKrWOMSADJ8A4SbHJp3fagfN1676z4StL4B+yAPJW3gcvtU
         Y8qA==
X-Gm-Message-State: AOJu0Yx1HS/vmOfKlEsr8sdHzrbVIAzR0ePsLZJY4X0uvJF8C8/fF/uO
	MLLG+oO47/Gp766lIQJOyCj3YmZ7lXM3TsgU+k3eK8M3iwsXl2BS9Isyw3/Z/eXOzI6q21B4sfp
	w
X-Google-Smtp-Source: AGHT+IGgg+RKjD8++4y7K+4nPl6u7K0NSMn0cUaPUt3gqGYig6padktGWf8BauiDciZhf/og3eZH7A==
X-Received: by 2002:a05:690c:7010:b0:618:691b:d261 with SMTP id 00721157ae682-6c30496ddefmr3683137b3.13.1724261263181;
        Wed, 21 Aug 2024 10:27:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99db3f95sm22850287b3.30.2024.08.21.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:27:42 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:27:41 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: move clean up code from btrfs_iget_path to
 btrfs_read_locked_inode
Message-ID: <20240821172741.GD1998418@perftesting>
References: <cover.1724184314.git.loemra.dev@gmail.com>
 <de700f3115e6fd5fe73985b87bb431c3b7131aee.1724184314.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de700f3115e6fd5fe73985b87bb431c3b7131aee.1724184314.git.loemra.dev@gmail.com>

On Tue, Aug 20, 2024 at 01:13:19PM -0700, Leo Martins wrote:
> Move all the clean up code from btrfs_iget_path to
> btrfs_read_locked_inode. I had to move btrfs_add_inode_to_root as it
> needs to be called by btrfs_read_locked_inode, but made no changes
> to it.

Same comment as the other patch, missing your SoB, and the title is too long and
it wrapped.  Thanks,

Josef


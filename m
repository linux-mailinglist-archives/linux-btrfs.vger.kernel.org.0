Return-Path: <linux-btrfs+bounces-29-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6547E5A86
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6121C20AED
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547630642;
	Wed,  8 Nov 2023 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="o4v0krdg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61730640
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 15:53:28 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04AA1BC3
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 07:53:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41b7fd8f458so44538851cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699458807; x=1700063607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LsukYvxq58qXkVl/wo6Pj5hPP+aCek6BO+rZd29Onk=;
        b=o4v0krdgzmGqyUTCvwMCC89siU1M7AR5hJWCyJq+tch/aXBJ6+i6IoF5TJKTaVmPc6
         ZjKnnONNsjd3rPBqPybSE33ZqCD8+NHCRPPZ215fo+Kr2PTl39n0su6kJd8p8M6JVCXb
         FSLUYcOtczw4wx1WSpAbjV7l7T+Uyz05zwIFlBTZxNknaDRep0pxqprR3DBx3NWBlQkT
         qW4ofCsa85/L/+6yTc9D8rWjWLn4abnC0oizOeaZVeo11+tLoBM2QB8n1/nXwk9fSuPM
         IJT8Td0bOhorIl9Kc/Cqgn7M1gUKBngnyucQi6zDIas90zV2c+gptHKZ8QfiYH9ddHUs
         u2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699458807; x=1700063607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LsukYvxq58qXkVl/wo6Pj5hPP+aCek6BO+rZd29Onk=;
        b=oEHBG8Sm2N3Z6QSMSgH4EvbY8wGTz9Dq1RIwicIdA0GVB7X4btw2bG5EeFQWUkTt2x
         FtzBY6oTx32HCs5HFxItTx9QumSX6bZlc3YjriKaW+k4hJBrB9qemDp/GvvCpvKHoXH5
         IJYaC/BgBdr5B/BCttzBi+84PmUJhpv88gqOMspWR9KoGu4bIYmJUWU/PV5iDbDCPgMs
         /vJhK7XVCVl4rBDw8t0CEKhYIHcKaY3KKw0yJe98UWo3Kew00BzaahKmiq3kwtzJ5nBZ
         wQnDM56OgK/Zf3OmRQc1W0DyO5CkJ2vOZyk8TLMwC6m2aIIqSHcGRERGThhW4fzL3IFe
         /smw==
X-Gm-Message-State: AOJu0Yy/ePKmri2lxz/ir270Cx+xT23qi+QtlRQ/Muubh2JiHufFDcZ6
	OXfb59/7SzdeCP5ySM0FcEbZCQ==
X-Google-Smtp-Source: AGHT+IGxe6XNKR1fS285mxR7sv5z5P1tFWXduyXPQoNtpt7sKE0pbSzdIksRC2Aayni8Pc+Khka0mQ==
X-Received: by 2002:ac8:5bca:0:b0:403:a262:7751 with SMTP id b10-20020ac85bca000000b00403a2627751mr2829484qtb.12.1699458807097;
        Wed, 08 Nov 2023 07:53:27 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j16-20020ac84f90000000b0041b7f89ad19sm1018975qtw.53.2023.11.08.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:53:26 -0800 (PST)
Date: Wed, 8 Nov 2023 10:53:24 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] btrfs: handle the ro->rw transition for mounting
 different subovls
Message-ID: <20231108155324.GB458562@perftesting>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <0a73915edbb8d05e30d167351ea8c709a9bfe447.1699308010.git.josef@toxicpanda.com>
 <20231108-hallen-heimisch-d6bdb9e23cb7@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108-hallen-heimisch-d6bdb9e23cb7@brauner>

On Wed, Nov 08, 2023 at 09:41:33AM +0100, Christian Brauner wrote:
> On Mon, Nov 06, 2023 at 05:08:21PM -0500, Josef Bacik wrote:
> > This is an oddity that we've carried around since 0723a0473fb4 ("btrfs:
> > allow mounting btrfs subvolumes with different ro/rw options") where
> > we'll under the covers flip the file system to RW if you're mixing and
> > matching ro/rw options with different subvol mounts.  The first mount is
> > what the super gets setup as, so we'd handle this by remount the super
> > as rw under the covers to facilitate this behavior.
> > 
> > With the new mount API we can't really allow this, because user space
> > has the ability to specify the super block settings, and the mount
> > settings.  So if the user explicitly set the super block as read only,
> > and then tried to mount a rw mount with the super block we'll reject
> > this.  However the old API was less descriptive and thus we allowed this
> > kind of behavior.
> > 
> > This patch preserves this behavior for the old api calls.  This is
> > inspired by Christians work, and includes one of his comments, and thus
> > is included in the link below.
> > 
> > Link: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> Looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> Just note that all capitalization was removed from the comment
> preceeding btrfs_reconfigure_for_mount() by accident. You might want to
> fix that up/recopy that comment.
> 

Oops, I accidentally did something with vim that killed capitalization in the
whole file, I thought I undid all of it properly but apparently I didn't.  I'll
fix it up, thanks,

Josef


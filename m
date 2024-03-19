Return-Path: <linux-btrfs+bounces-3437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43988040B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C062C1C22A9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505C2744E;
	Tue, 19 Mar 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JK0EtJFZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE23772
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871041; cv=none; b=rLD3JHD6jHOxOWXUpSHOqnW7xs3Z5ZBWKov0ZD2MUU5SOeS3JremN/NfKtseVUW4IV3oCqHamD4AGER+kk0tDrk7BcpuEDCW7l5H3tI+iMbYi3XiXUnsIRasVuGbcFhjDlTSTNrM5NkgMUPRQeKgpkCVeTKcSY/mhvP9Xbkbso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871041; c=relaxed/simple;
	bh=69RkOoITZUmbQq9/6AeLRUWDIC2JnJRiOrR9Z8nZHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN4Yfc9VuGhmgcrrYTTMwfi1+h0UAguRY0Ux+MWMzH7/TelW0Fv4nPUhwv0fSkVvD8oIXxFoCzu/Nk2pB5IZW2QsLJCzQWhyArxgHe+y11SCq/3TaLKJ9/GLJ7sam67Hjfn5/ydQLthYjn9SxZUyGK51gMERN1hrmfEviSPT1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JK0EtJFZ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78850ab4075so241690085a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710871039; x=1711475839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkAgRCXehrt5J7NuprNh2a5DNFQX15VXdsioODFixSg=;
        b=JK0EtJFZX8aERCiSP7LbyXDG9K+KqfZ8pZkIlfgGcYx+1Dr0cWubZeDImhQUIx884i
         ZFATqivmIyGfvTDMlf0cZzKtXzWtqe1JR8GOoVsuQ2gtV+t12NPsPvxml46HwVyYsoU/
         k7MXt4ip6FriFjiii4/CmAH8GPqUSfXKCN46DZ4WmC5ousA+1Y4NbiQmrkzzEXD5jZuJ
         q6HSQQv/QuriJLjozkq8ee7dbrTsKnRoWvItVRXiSGyEjLGJTdYrxxmvu3DBJ/SfKgJB
         yLNkfGUxqapx7YCQ5nGACYmBOD2Y/LYtJuUVXdJaol/uCuLk/rUjKSzyZzHm5FdgH+1b
         +BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871039; x=1711475839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkAgRCXehrt5J7NuprNh2a5DNFQX15VXdsioODFixSg=;
        b=tef5e/5k8PjJAq6WurdZ7g2+WYfvSOha+OjCRe+Jk6GkyDxCxaONEdhoAcy2lUx76I
         OvcPro108uRa1bCdm466TBEoxf2TGKG6KbHXhd9RBV0Ykqo3gkUIT3rH+q7oNQKWEB83
         3WrpDqHIrpvSaUvtbgxeaob3n1Ty4os3ElGLFVlj1sz+lHdFFJk1D/rTDxDWkv4Dwkx/
         gM+qaTwENOikN4QgmGBJeBS0IDdqPAJKPIGGa4Ry4pBVDVzssRhQp9IsVZkGDM58aEJc
         20eiFf5aFEhz1H+r+5/JMBSrOiY16icKgccrYJ4STh2sAhscvnDmUOobTHzpfKlxhueh
         PKhQ==
X-Gm-Message-State: AOJu0YwAFEMp6IbFO06VN3/MuolEv1CmUWw17gbU1O1CKOWjacKgtb6q
	HCFhCT9UQt6Sw0Esbs7nblAX9lTQ+Bu+Y91hI0Et/ARrFaucM6WG9TTd7dpDlbXSTGWEB5VZI6G
	C
X-Google-Smtp-Source: AGHT+IHzbqvkGQVkE/nDeQwGAN6HFS7U4wILq41/PymU1htqKPFRQHD2nc56F6wN4YF+erY4gMUxcA==
X-Received: by 2002:a05:620a:a4f:b0:789:e3dc:8b96 with SMTP id j15-20020a05620a0a4f00b00789e3dc8b96mr14929721qka.35.1710871039312;
        Tue, 19 Mar 2024 10:57:19 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a0e1300b00788752b4966sm5669515qkm.92.2024.03.19.10.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:57:19 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:57:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/29] btrfs: build_backref_tree rename err to ret and
 ret to ret2
Message-ID: <20240319175718.GE2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <e637177cc89d0b5d5b5fddd343b98c452c70227e.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e637177cc89d0b5d5b5fddd343b98c452c70227e.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:22PM +0530, Anand Jain wrote:
> Code sytle fix in the function build_backref_tree().
> 

This doesn't need 2 ret values, we can get away with just one here.  Thanks,

Josef


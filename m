Return-Path: <linux-btrfs+bounces-4893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A775A8C26C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DDA2812C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F34168AFC;
	Fri, 10 May 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="n87+sEMa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD950168BE
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351147; cv=none; b=hgopngAajhi8tBnn8zJNpDt4Qyxg748AyXcF1cTTt+Ghzo8oSJx+7SeuiRyedjFXFUglLMjPietMEZAEOc+CTzO1GgJqTXyWxnl6317FqPNYraEiV5gWdqHGX8t9QrTMnripefYOLhiyBdANS76MhImFzRjSmlpxX2zG+1Ax64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351147; c=relaxed/simple;
	bh=664EPzv/DlYUVC2JhU1f0SGVFTP0xfCkFEk030jqigA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVTByTZ3NBH5nkQUN2+0x0B84suzf0nqwhItT+eyL4qAgeQ5BGfVI/s92Qil+6VYLxnVNIY6QGZzQN9yS5T0/fOyMEDdRSKphJk4Pen7hGUhrpv9WvIFjPrMVjeNgPorzBdoYaKTClGblU3E+lgrCtuFS8lvAi2MBlL+klND7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=n87+sEMa; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62026f59233so15779067b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715351144; x=1715955944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Qncz6Ah2X1NKCRR43VviudJRO2DRuhT5CUQ2tlXUE=;
        b=n87+sEMa+YvUoKV3GlWHyDAqGjtTFf92vllGVCS1wVzQtez71nCmKtVvlUPv1eYKUd
         IU7gc9ttv8HVzaivKuPQS3uxnMwM+ULTrH2f0Ngw93qkuQkH9Rro5Hd5v36i0i+RHOZ9
         G1kLi9j4J0fcf/edH+TE/YO2GXLa7ViaT7bTrhlMt7ApyybcgptiTQkn71uzEUCR/A4G
         i79lu5UD4HZCb/omxM6LmhIpzlPu6kh7jPXVuwCKDhYPQvapZQQ1I4bP94jKndLj4kxQ
         VTKuXheEf7lPEeIkYsZD+SUuM9nsTeW/E/ST9AHyUJU8TzesxXdcSxUOZGBJ9baAhFEG
         hElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351144; x=1715955944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5Qncz6Ah2X1NKCRR43VviudJRO2DRuhT5CUQ2tlXUE=;
        b=xQFVPSgPyuJx12COzIP9NeFm4tPcozb3ByI70Zfqq7p5H9T47aPWwFH5cMSdgmsHWY
         OEVOwVlyZXOcXsSfMLX4ueg1EKE9Palu+ROhcSOaOjUy0Fys11ZO+wbNwGxl46sr89yz
         lf/I4G9WEY1Y9k/vaQZLd9naVUit9OqHO9+qX7LTT2IpVVo1HXBzS2LYdmrJrPyXydbE
         hxB+l1HO4kPpkPzYPXgeTrg1kAVePdGqyFV7Wt+gIVtgETYbCsNfPCklGaA+3QPQLRkA
         DgMBTJ8KkO4/+07Mxd358yMYl81F9aOC+odekjHsHoSwhp41dG3ZrEgPenM3IcrdKlG8
         0Z7w==
X-Gm-Message-State: AOJu0Yw92Rs4X5RrPdQDIkK++eaJVDdkQlThOXsVszXrFjrffPXf1VrD
	0VFxpU6h1ljxE8V5Yn/X7P4BaY9xHjKh6hqcC4AK9kTQtcOdWMz6Nywrx8w35ki+VmqcbKrBOr+
	i
X-Google-Smtp-Source: AGHT+IHtzxj9LMxiN/4OblloCu7vCo94voF/mOWa6Y1S0g+gxMiq7xSEBqOoyrQu3RIQAaT44T3tUw==
X-Received: by 2002:a0d:d8d0:0:b0:615:1be5:6d33 with SMTP id 00721157ae682-622af89b673mr24985377b3.22.1715351144496;
        Fri, 10 May 2024 07:25:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2347d2sm7534967b3.12.2024.05.10.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:25:44 -0700 (PDT)
Date: Fri, 10 May 2024 10:25:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: make extent_write_locked_range() to handle
 subpage writeback correctly
Message-ID: <20240510142543.GB90506@perftesting>
References: <cover.1709677986.git.wqu@suse.com>
 <dfe1e2ef77292b160806eec23cac575a62ebdbca.1709677986.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe1e2ef77292b160806eec23cac575a62ebdbca.1709677986.git.wqu@suse.com>

On Wed, Mar 06, 2024 at 09:05:34AM +1030, Qu Wenruo wrote:
> When extent_write_locked_range() generated an inline extent, it would
> set and finish the writeback for the whole page.
> 
> Although currently it's safe since subpage disables inline creation,
> for the sake of consistency, let it go with subpage helpers to set and
> clear the writeback flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


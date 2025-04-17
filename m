Return-Path: <linux-btrfs+bounces-13137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A204A91CE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD033A28E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746B3BBF2;
	Thu, 17 Apr 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pJ66Cvfc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2444A1D
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894265; cv=none; b=pfQ54CSzaogNiMDzgnFKCPNQK7Q29znCbXdWKbEbfZ70j/EbZdO977IGGHXAabSwxk6EX8CYyikHJzva3h55vNRKPpK0YxhHqJrKOLWtJA09Y5Ocw2dzqVNUzr+6Tw2PbNWwgM8zI4r8H3N9nwjGM3Jnt7GijRe7EseI+6y7FIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894265; c=relaxed/simple;
	bh=ONyfsgK9X36RFWRZ7ajDfte34SOPfkfUHGhYXwkDWao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqFsRtCxNkJoNMnTZu7rvzhJsOGkAQNywyDD7kQ662HOfNAOqJo/agwPri9/A+6HJM6VD7Q9oeZ6Hqoepx0SeYPTGM82Nd4U37n4e+XoEfjimRcNfN3ZR+MhaU/F9mRJCFwKOKnzws4+jv7r9mYRyU9QQ3U5wGhl7jh2hl4zjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pJ66Cvfc; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff1e375a47so5797637b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744894263; x=1745499063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTHtuzq6aAG7qgUM0iFEonVJaykOht9ciZ2nf2+HpFo=;
        b=pJ66CvfcSZCOgDrNRfr1XFKHr/d6XOlMoO6+Dr93iM4pRaXemf/cpdEhCBKCnt+M7X
         OW50y0iyimtoj8Z/XGl3NpwdBd6NiyZf2Dos9PQi9cNjXvEuYZYWbqtzk8kUayD4e9hI
         pBAshf+mE0lFqKtFTuJVsl1T33NDAuY8MNToiRLEudBeKh+0iwFT5fCibnzn2uGQwtMF
         ag71mFDz6o3chI48El5MjSdOBnDKzDmSSSJL+IleAaRu0DgwnekXTRhIG9iKT41i1hLY
         fB04HU8g0g6a/ZfSHMTa83C1AopmGo5dcs90PU5tnfHMQQmRBIzRCmYEOpzyuiVkVYQi
         QuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744894263; x=1745499063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTHtuzq6aAG7qgUM0iFEonVJaykOht9ciZ2nf2+HpFo=;
        b=kkwkjz5I9WKcU95KVR+wOrYBdb6GmBiYW+I/umDVK9QB3KhU577g/3Qqq/jELBUegL
         xl7ZS9X+HuMuB53FH3SxYYthvDZmEVEXb6JL8QlgiWWPbmCCa/qVOvLZcxOtVgcpYdmR
         qYaQdV0YEd9uPuHhCRnBmapU1orXDI3w/7XNZsvvLWxwkfHkvuayu9P9Z47mNiaV/ypJ
         my5gFCi8wGgKZgJMctSBdYQOLyKJ1//PNPw4Y5ENZFeLSR1M2JUHq49Q1LbCeU6fB+Ty
         RftoMG1XIpVY99fQyv4J0vstwVdyPR7JYQmBSbZ6tvqmOuLkF9Cf6xPm0MoLfoG5q2ii
         IrhA==
X-Gm-Message-State: AOJu0YxF7Ka1OhTX6vryIHzaFGwqV3AXLsLtC18WdcZI9eXyt9gyo8/h
	U3MkR7KnC1u9x5WFlZysBJJX/rF08f/ib8eCCemUf0VqopKGXbQh5P26xAupB3I=
X-Gm-Gg: ASbGncs56K0aTgMPxnEN2jUuRrq5CCqWnOfGbpjMpsExR8vJ43F8W6VnOLpGelfwVkd
	qocBI/Vk116UrT3ayCfu/6yxGBLQckReRTxcXBb17w9VIjcwRlokEGW3pFsSzF9vMOuiMuclRXn
	EHxR2QCKx82cRkqo4RY7HCFP8XDRco6A/ErF2GhVKKHalI2Em3RpHMMSrFwdW1lcdc/XE5a1kNE
	ClG/8G1M0BzM6i7HOu6VL+GxcytDbpbqcvQO5auWJlnYcp5bsc/+1k+owozlE1Am+EnrJhEz17a
	wbvFQ9+ejVj+InQzrQN+zsQXNhYOEHzbUvOcnoG5XfKyxCnxsEesY4EZ0HIVXu9cSmw9GQm9adJ
	wgpusYlOG7h/i
X-Google-Smtp-Source: AGHT+IGlsEjadGvkVqMHtfvmhhw66MK0mgISmiz6douARW1uKaWRxZ5sED4RDi3I4zxXU64YpDBUlw==
X-Received: by 2002:a05:690c:64c6:b0:6ef:761e:cfc with SMTP id 00721157ae682-706b336255fmr79184017b3.25.1744894262925;
        Thu, 17 Apr 2025 05:51:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e3bed99sm47027917b3.124.2025.04.17.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:51:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:51:01 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Assertion and debugging helpers
Message-ID: <20250417125101.GG3574107@perftesting>
References: <cover.1744881159.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744881159.git.dsterba@suse.com>

On Thu, Apr 17, 2025 at 11:16:58AM +0200, David Sterba wrote:
> v2:
> - add the functionality of VASSERT to ASSERT proper
> 
> Hi,
> 
> this is a RFC series. We need to improve debugging and logging helpers
> so there's no ASSERT(0) or the convoluted
> WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)). This was mentioned in past
> discussions so here's my proposal.
> 
> The series is only build tested, I'd like to hear some feedback if this
> is going the right direction or if there are suggestions for fine
> tuning.
> 
> 1) Update ASSERT macro, so we can print additional information when
> it triggers, namely printing the values of the assertion expression.
> More details in the first patch, basic pattern is something like
> 
>     ASSERT(value > limit, "value=%llu limit=%llu", value, limit);
> 
> The second patch shows it's application in volumes.c, converting about
> half where it's relevant. There are about 800 assertions in fs/btrfs/
> and we don't need to convert them all. This can be done incrementally
> and as needed.
> 
> The verbose version is another macro, although with some preprocessor
> magic it should be possible to make ASSERT take variable number of
> arguments. Does not seem worth though.
> 
> 2) Wrap WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN() with
> optional message with printk format. This is used to replace the
> WARN_ON(...) above and also the ASSERT(0).
> 
> The ultimate goal for me is to get rid of all ASSERT(0), it's not used
> consistently and looks like it's a note to the code author. There may be
> several reasons for it's use and although I've converted almost all to
> DEBUG_WARN it may miss the intentions.
> 
> In some cases it may be better to add proper error handling, print a
> message or warn and exit with error. Possibly the are cases where the
> code cannot continue, meaning it should be a BUG_ON but this is also
> something we want to convert to proper error handling.
> 

I love it

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


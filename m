Return-Path: <linux-btrfs+bounces-10168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464299E9836
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CC31617A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7641ACEC5;
	Mon,  9 Dec 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zV5fojD+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479735973
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753111; cv=none; b=GHEFsaJUq5xYP8fTsVnOMsQnrDqxsRZql7JonNjJKyTa9lG8ibduWYgpi74Z7eH+M13q0ZtsrNE4lKcHXZ9rbybWxWE6Kb3LYvmt+YLcLDT6hP2DpovnMb5kp/AztvbXq92FGd2hiYswzukS/MbX68UNWrCX+GXs1TnWTg7rD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753111; c=relaxed/simple;
	bh=qTZr+Mg4xzjnZEZH5WsjqKhet/ef68e7nFmPNXGVZ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPSQxZUhhcGqDAULuCDYyLNSS482nq+9dE8fT8BErFfNhLQ33H9x68Fnb2dLtzIP9ITRyilwNdy0aEKzUpcV5bMQ9im5h04Me/sOKoLmWDS3GqHB4mNhlFhus6tK/7iYdJEeCzZbvCHdshGlot1a4tTQNjC5jhw9Ybu+Uk+m8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zV5fojD+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8fd060e27so16874256d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733753108; x=1734357908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfLgxUFzL5nCyh7Cj9ZqQ7yIxKv//W3i66ybr9JRp/o=;
        b=zV5fojD+8X7s9vddNRFt4+sg0YSjZIWpwrKXnXRSzSQjxhbnwMtiLpvLIID83HlBjo
         GivFgWBO7g63NKguDt9SwswJouxbfw2F6ry5A268y8YzEVtFbJWfJxQBtTR+7+xfwdO3
         msN0z9jaQHWqdCSXngSCy1og3EzZox+MPc0FjebC7ce8RclI6Yw5/LLTzVotBIam2eHu
         Stk+mCduCvUxs6GtTkqKuex7My+5n1MyQESiOuw6KlFWZZUP0eT+58Xc2Or/pjR53X5u
         VGoKLYF8HkxkZ58CV4KfvlDNuvK9t2izRTSC8D2ZQCXGJ2dKUNglzxF2tq2pWy2HbH4a
         1ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753108; x=1734357908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfLgxUFzL5nCyh7Cj9ZqQ7yIxKv//W3i66ybr9JRp/o=;
        b=JupDRocmKASeFKCiPcDZHb9YzOjvKjdzHxMj7Y/GLFFL45dnh5NcEmv5ZJrCb+P8lh
         Sr5XTZ6oAGoWgg4WMR4qbuSoK9MFbYGKTA2iLc+dfoELlNRGrPZsoDvZR/LKy+AZBbVz
         CBOmLWASOKjRGf30js51k+Om7bSL4HANm8ItnxyFx4eaDZkn6XouoXhMrQU4oo0hs7go
         NFb4vZzTN974yy8pLJoShDXEMoXrpZZX+W2m9uRt1blPAagH+jgoZyy2lxECTgx8GeX9
         178si6PVvWhmhpk99LDOvWdz2e4HuNB9I9SeCerYQUj0WjCVl8Q+9+xewIRnnKG9/2pX
         JD3w==
X-Gm-Message-State: AOJu0YxWd1CmtquoY6OAQafZvkqvLuryfByvjjc6BDToxzUX4TTVCOo1
	cffez0AT+HmoWDGoLyH+E6RFJz2v+oPXwS9x4GXbqNntc225B1CfpsDks2aRsb4=
X-Gm-Gg: ASbGncuwV+cGS9tjrS8/ZsOOUj96EE9bfY6hbMOqx4ze7IP/Wh526XLDFM3+HbwkQNl
	0DNd96NAkslAuEMFJts917rFQy8hTuiYy0ljU5P4v1Y4tKP4s7gak28K1g/WgQv/SpiwIuujwti
	kQL6dWwirEmSQEhWOh/+pJmcWVCXqpxMVIWWwLxF8sXkXOptNELwNYQdv1YHIcqgQ1qSDU+y1PQ
	HWLl6vAY2Z8ZVi5deskNR8MGGMOCsQYB9boIckPwBvzDycASbGK2RkhWplerpq4/Npsw3EgU1EP
	CaVYRYUCoag=
X-Google-Smtp-Source: AGHT+IGq582ExRwnrxxTW9eE6qdVLvgogGX2qrrao9lthewCMueFPsoZdiHMa4dGYt88WTwf4v9VKg==
X-Received: by 2002:a05:6214:20c3:b0:6d8:861f:add0 with SMTP id 6a1803df08f44-6d8e71726cbmr219341316d6.31.1733753107982;
        Mon, 09 Dec 2024 06:05:07 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm21302796d6.60.2024.12.09.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:05:07 -0800 (PST)
Date: Mon, 9 Dec 2024 09:05:06 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCHi 0/6] reduce boilerplate code within btrfs
Message-ID: <20241209140506.GD2840216@perftesting>
References: <cover.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>

On Sun, Dec 08, 2024 at 04:37:59PM -0600, Roger L. Beckermeyer III wrote:
> The goal of this patch series is to reduce boilerplate code
> within btrfs. To accomplish this rb_find_add_cached() was added
> to linux/include/rbtree.h. Any replaceable functions were then 
> replaced within btrfs.
> 

Just a few overall comments on the whole series:

1) Make sure you fix up all the kbuilder test bot things.
2) Don't add "Reviewed-by" or "Tested-by" tags to your own patches, that's for
   other people to do.  Generally we use "Tested-by" for people who have tested
   a specific bug fix.

Thanks,

Josef


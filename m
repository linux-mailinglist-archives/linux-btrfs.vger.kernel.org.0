Return-Path: <linux-btrfs+bounces-283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C427F4864
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3445C281494
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC225779;
	Wed, 22 Nov 2023 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JF3t06jG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98261197
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 05:58:39 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5cccd2d4c4dso2708797b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700661519; x=1701266319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIaRnMCnFf33Dk0CGq5Vom1OCMuvBN6qt1lqDDImBdk=;
        b=JF3t06jG0uz3NeOiVBtE/rTDuXfFbSc9ki7R/QMRlG2O8CF7iZ6ZVrstPXS9LyTwhZ
         Kj43FTx17WDhXRDOcKVMhDSHJ0VV/gVDfwo1ZrpwKoO0+sXtvh1zGaZK07eBBlS1mS0g
         nvRM20iH1puEy1Qn2KYfAWsncNX2y0V8wv2HV7dfDxvySArlbZzrRaFS1Dxfhdot0Kme
         i7v4AfDuDb1FbD+cbf4sRbO5o0V1qca0ChPesyEVa/yG+BpwI/mwe8RpPjg3Oivuk+ep
         TLXTdHN5565StgWGT1QwWmJx4BlP8dQdojwsWXcmOphUzRa3k8re5Sk222a8jcGc8f8e
         CnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661519; x=1701266319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIaRnMCnFf33Dk0CGq5Vom1OCMuvBN6qt1lqDDImBdk=;
        b=mZ3zJ/PEn1/dI6fcbS8hgNUgLyZpEt0pfi4wl3RtccjdOfjNP55W5u+iG3HojkHcnl
         SuGTnwdlq+pXDGUUstRZ9s0Nd0dxaUqDEvhdmUP+cyGlA8gdokJLYY65vinpjwKju51L
         AZuEYdFWE8ZhTdi2uHNQRBEuLelg7D/ERMCjN/2hsp3hPC1VKqwWw7qeyBUPce1htJw4
         YmmG304XzLWzP6CnbaV/xnETKowQ/lMpE2E2+WiYoSDQP6io2XaKzNvbTVAfLHMZVl/d
         KgXcXC83mpeDL8bcXqClvkOngrL18HH5cz7yKXjsMM3AANlBSxqflwXge5AeFig7HKY6
         698w==
X-Gm-Message-State: AOJu0YyV0OVuIEQ57mKXMWsoUdMSpSxER8gJVzDSKmhFDvL1rnuI+cRh
	ZvJR17ckFkpt9K7zAydJv0heWg==
X-Google-Smtp-Source: AGHT+IG6W7SD0/Yp3CzRBpKKcOt7lXganat9ICWBIYIFBoEubf9tkmKa200gR3a7sqO3BfjUMZx2IA==
X-Received: by 2002:a0d:d547:0:b0:5b3:26e1:320c with SMTP id x68-20020a0dd547000000b005b326e1320cmr2299541ywd.40.1700661518764;
        Wed, 22 Nov 2023 05:58:38 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w67-20020a816246000000b005a7aef2c1c3sm3728854ywb.132.2023.11.22.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:58:38 -0800 (PST)
Date: Wed, 22 Nov 2023 08:58:37 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/36] btrfs: add fscrypt support
Message-ID: <20231122135837.GA1733890@perftesting>
References: <cover.1696970227.git.josef@toxicpanda.com>
 <20231121230232.GC2172@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121230232.GC2172@sol.localdomain>

On Tue, Nov 21, 2023 at 03:02:32PM -0800, Eric Biggers wrote:
> On Tue, Oct 10, 2023 at 04:40:15PM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > This is the next version of the fscrypt support.  It is based on a combination
> > of Sterba's for-next branch and the fscrypt for-next branch.  The fscrypt stuff
> > should apply cleanly to the fscrypt for-next, but it won't apply cleanly to our
> > btrfs for-next branch.  I did this in case Eric wants to go ahead and merge the
> > fscrypt side, then we can figure out what to do on the btrfs side.
> > 
> > v1 was posted here
> > 
> > https://lore.kernel.org/linux-btrfs/cover.1695750478.git.josef@toxicpanda.com/
> 
> Hi Josef!  Are you planning to send out an updated version of this soon?
> 

Hey Eric,

Yup I meant to have another one out the door a couple of weeks ago but I was
going through your fstests comments and learned about -o test_dummy_encryption
so I implemented that and a few problems fell out, and then I was at Plumbers
and Maintainers Summit.  I'm working through my mount api changes now and the
encryption thing is next, I hope to get it out today as I fixed most of the
problems, I just have to fix one of our IOCTL's that exposes file names that
wasn't decrypting the names and then hopefully it'll be good.

FWIW all the things I had to fix didn't require changes to the fscrypt side, so
it's mostly untouched since last time.  Thanks,

Josef


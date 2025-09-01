Return-Path: <linux-btrfs+bounces-16554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202FB3DA60
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A327316ABF0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 06:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DD25A2B5;
	Mon,  1 Sep 2025 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFz2sxiN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE11E9B3F
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709787; cv=none; b=tZyLMtUIL79+WEv4lneyO9a5s1L0cEvaKLVq60+lCH7p7iOMznnqsit6Z5udTuHQ4x8SE3sm+EwdnhC6Adgb3V4iTtehopEzC2HkNmIESlbUGluqtPA/YQVryIAYhjRnFkNoKhdPOWqvbP3pd+hpwNW49eRXiXno4PZbJs61+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709787; c=relaxed/simple;
	bh=33HQWgDCWthzY9pnRMxLODHpJFg9DFP4Ng1jhrCIPYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghMeF7WYaIZb+/emHatHRqab60zqYE75DkrcOFnuR3HaE3rOkfJR/r+MLi/VlIm3h+b4KF+9z8OP0jI1M/ZkA0ccYMp7x7QAkTsYmccmXwFtRMc+xHE1cEBLRgoi1Y9fecWQBu1WQdyXJbr0DlIh3QzKBZ7Ffwp+zTSFOboPHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFz2sxiN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24602f6d8b6so9766405ad.1
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Aug 2025 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756709785; x=1757314585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXD79EiETxCOzOeL6tH7r4t1YeSLqlAEkhC3ETWZ4yo=;
        b=lFz2sxiNi/gAFosAa0uVqz/maxS9Sjl7tEGChA/Ygp1nY5MeVdqEEBGXqVrYKHIGRC
         EDA0AlrJO/If0WGJiSwlWumSmcxZ2e8iXvDWFyN8mh4y8dP8Mu53PhzC2gxU4CmRbOa8
         z0NDjbl4FF5aGWonoxM1dPalBJYE0jk0efd3QDseCD6V2gOPik0DGIRC4ozc4jce39bp
         WnYEe05klS9Pr7VWYjplKNZsZG5wUuXfe6gAdgt/bQXYZbrVxmiBNUUi7DRm/gn6Fbtu
         dKU4xkpcKE2nWP9mJFn/2Ui0KYD2LA5MsReGR67BY0StO0W8QBJ4rRukxRUDCzGqOeA0
         RCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756709785; x=1757314585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXD79EiETxCOzOeL6tH7r4t1YeSLqlAEkhC3ETWZ4yo=;
        b=P2xtwSnCVrzCyyEhogWFAGYRFaZC2SUteCAefUI4kSiYlRllJ2xSPWSEuVEiaISFlL
         u6XYgt8tENbaMk9uxYnuYENd6ZVkhTheNukBMD+5JT2PtMppDYqSNcUYoeMO/7wjr/ra
         WyxCv3pmgRVTcq7OX/cDVVXwFbqvOpL6GmRFPfTUO1Eyhf2NScWazY6D5duucBPSUwWg
         I/bZcaM+pFx0u18Dz+yHxy435i7Nhlfrj0+Qu6UT1hKkHPCNlmUhkpQUcz9OtQI1mDLE
         PQxOviz0D0AQyySU9UPx1/zUOwJDXz+eZ4sfS2UL4n4evBJWgb4SCm47tVQE1c/ewYsc
         bSXA==
X-Gm-Message-State: AOJu0Yx2avg9A6rF9D0lxMXPbWjqT+p7sxJ+hkbSfZFegHhUfQvZhbhJ
	xsrOuPkqfmXg3p7OAFErBjEoZJ2Tb76wHYG+RViyLMUaGC1fIuuopgieGwpRA5wHRpfRmw==
X-Gm-Gg: ASbGncv14W6Mu1GTSqmDI1ke8G49l/F0THYqsPpY7hMVwMjtGd+coKyoDgjgTnmBak9
	aG/zS7404QJhdIn+7Fum3KrJF/jbeZfOlQgJXEEZGRa8W91pivGoM7BHCGqc0mWxtGxbQqCsyjQ
	SU4WN/6P3Qsb7fkcKDUKReDTCHXvT2rKhyT1awhTw6LCtwV6Qybsu0WoMP1FhVD14ygMHfnRIut
	Bdxe0G+oegGLv0MCgnPM/VWd5o81onXUi8PnYYXOC1NzdlZwCTCA1jervPJzkY28NphFYsNr3oX
	mJNU/8XSRW6VpUz2g3o6JyMcJ9+dEwZuq2KxmhC5GADRXFEegxWRHPK0N66Q9QODkN/KFiMS/53
	5mc+uBRgoSpHBghbLIqb97wzP5cjOKmC6Uy/d/9O4f7fhepgh4Mu76Kw=
X-Google-Smtp-Source: AGHT+IFBYsfFplDy8hfxiUSON9CdiYy9wMg2gnKUXgrLUXb5yx6dUFjYQRmzjTcZxhvKuw2HvaJDAQ==
X-Received: by 2002:a17:902:c40c:b0:248:a01f:a549 with SMTP id d9443c01a7336-2491f27a5ccmr78594045ad.11.1756709785305;
        Sun, 31 Aug 2025 23:56:25 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063961desm95120755ad.103.2025.08.31.23.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:56:24 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Subject: Re: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Mon, 01 Sep 2025 14:56:19 +0800
Message-ID: <5923969.DvuYhMxLoT@saltykitkat>
In-Reply-To: <8c6af9a9-e446-4a18-a31e-3bd924d329b6@gmx.com>
References:
 <20250829084533.17793-1-sunk67188@gmail.com>
 <20250830010802.GB5333@twin.jikos.cz>
 <8c6af9a9-e446-4a18-a31e-3bd924d329b6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

My bad.

I mistakenly removed some cleanup code without converting it to use 
BTRFS_PATH_AUTO_FREE. Thanks a lot for catching this.




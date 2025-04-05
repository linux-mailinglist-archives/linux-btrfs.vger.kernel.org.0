Return-Path: <linux-btrfs+bounces-12812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70759A7C796
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 06:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1CE3AECA8
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 04:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340A1AF0AE;
	Sat,  5 Apr 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj0Ngsl/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948F1E871
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743826449; cv=none; b=BFizNeY45RJkXXtmakHhwd2zZEe1SKn0R0FMZqG1akAygPd0hDUj856+GAinhX3zdznp8gQO3X+p2rqnvfahrsEmfx4k5uAddM9Dce3q7OBV3L+ETnxBiy576uxvmS+qw0q6DbATs/CfDVP/CARQBaSi/ehRzQoVWvh5YVli+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743826449; c=relaxed/simple;
	bh=XY63lWSDiMDUJwJNCAihGADVmyo987vdOXnDETrBeBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=mRTRX3rIAqXKMcL1hP/giOyOTc6+yQMR+K45ipfwPyx0daQmsgQSTE4TF9NsVrex1KKGMCWHTp4yd18EvejHN+AE5eKYORCx2eXR0SXt61b+AqpJSy8fOqqtn5HvdaFlKlq457rvOAERK+Yejq+G4oifqVN9rpvhSV+xjWYTMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj0Ngsl/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-af5f28ecbcaso477281a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743826447; x=1744431247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMnobqYheO8+wM0Q98lE9lveMKgnjT0XDeJs0lj+IOU=;
        b=kj0Ngsl/EzJp/4sRRF8lUVUJNVabVAM2enWECnSxBfLzhfWSP/Rv3MyuFJUpRjd7LX
         tRipbTTbxFGQgkVp/wscxwdUhbzDS2Fufc+PURvq13ntsXwg3+FdR9tYlAAcfrJAK/c5
         jd+185iiphS7XiVF4MGC6aBwdnI6Tt3jqHZn7oV+hmmYywn2rejNHXVzBaKgjNDZUskJ
         aZIdv9c6ZwlTwA7FNYuiscyrhvKtEk0zEKc35429kRd9J6I+3azdJaqIAamYj+67y1qt
         pAni5W01nvl6F2p6nBmGdwF4UpdmEwcfslbYtYr8U7mYeYGAHW62OCJLL4gex1E1+dJ2
         FY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743826447; x=1744431247;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMnobqYheO8+wM0Q98lE9lveMKgnjT0XDeJs0lj+IOU=;
        b=mOZohngAnxD4QS1SLa1IA8YydsbZePartSGQSaV6laJwmGa9nFCGhR7vpxPhLtsPKG
         XnSBCibbezrUf/yXAl2At8nzyGEWkBqnVYyiagOm93nzxQ8Wm312lxOZDQtanuRwjYX8
         PyrWLP05hsGcCyQh8ZuN6tF0XoGQPSWDhfSZ7RebfjloqlJUoZP4BMLR0qQK2GHZ7qMa
         ow6Fr+HrfS+AmEYoi8Q3D72FXY+CWSs8Y1uTCRX2B7E9qZOkJDCb6XKCv3/2X/ipXYk4
         e1GwvOamR/CKcmll/ZklU4rBpVTWISUvxDC1f5GkuZkvxMzKnknUy72JbhiQ2JyAkTLp
         IGOg==
X-Gm-Message-State: AOJu0YydhMBpz2uC7mx74IHDRp4BKSSNOuL3aJnjnzedUiSumBNWDR6D
	JYK0b7L/POv78NUzCvy4PpRhahrGReFARFpGLaqqzKPZqNAcKz04RwV/uuAQx/G7ZA==
X-Gm-Gg: ASbGncvHNJonrsi/ol3hEPdJ1d9vB4k1yr3xCKbfpppgRDwBpjmwYQ9XqB6Ai6ApA/O
	CWNqLrAWDHjfzCAC8a7VFDCKRh5WLiVl9IZUI60v1x5nBcuvZ2Vwn4pS4lmsPXDSXVgiQFBJF4C
	d9FG4d5tSZXz/3vyCzfhWtQS7iwIbArD+wWdHtT3dxGyJ279uxGLHSy+5MSoBVoifUClMS+WJbh
	8UbaJmNIMrTMxA9IvoemZG+mj/URcfE7qF1QQLc3MBEznbk5wUwl2zsgjDb6RDlvzgxfKiV3q1K
	1WGZiTuqsaLGi4uGfkCLNU9Yv13eM4IPp5gldyoNyrAKs5jccfI=
X-Google-Smtp-Source: AGHT+IHT5pyK2VosEPn9Gnw/eagEp9oUMTSC5YG1bimz4GhIJskHL2PxMXk7Br7uSe64VmeBdkfddg==
X-Received: by 2002:a05:6a20:9e4a:b0:1ee:e16a:cfa0 with SMTP id adf61e73a8af0-201047405f1mr3322579637.9.1743826446914;
        Fri, 04 Apr 2025 21:14:06 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.34.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc34fc97sm3684410a12.42.2025.04.04.21.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 21:14:06 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] More btrfs_path auto cleaning
Date: Sat, 05 Apr 2025 12:13:58 +0800
Message-ID: <6162303.lOV4Wx5bFT@saltykitkat>
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I'm new in lore, not having many experience in kernel development. I'm 
currently learning by read the code and patches. I'm just wondering why we 
cannot just make these `btrfs_path` become local variables so they can get 
freed automatically? Is it because the size of `btrfs_path` is too large to 
put them on stack?

Sorry for bothering here. I'm glad to move to else where if it is not prorate 
to discuss here.




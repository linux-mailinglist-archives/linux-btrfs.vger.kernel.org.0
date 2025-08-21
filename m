Return-Path: <linux-btrfs+bounces-16188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C302B2F25D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC11CC6FB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6592EACF7;
	Thu, 21 Aug 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjmr16VO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E751CCEE0
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764807; cv=none; b=p+vMGjLDGxNlv+bcqB2hU3XMj4iFi81o0SgqQHYXCD1AkUVCB5s+kK9YCaczv0dMRZrguMSx9cHtN3HWkPJBI6TqYFf6dUO+fFkOYSMU9zO48E65vlv5Ja0nguJOPvTBwgJuMUCrPersA2JHzbMFMAH1CjvoDu9yiC41EEfSEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764807; c=relaxed/simple;
	bh=mHW0JXKmK4eHXpQY/d3VGXBsDR+c8+O7sH08Ol1l1aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlzIRcCTSI7DZEW2/VSTY1xwN9IlXajFDwNCr4qOhGFxpTNIrg32ntkQwNWVrtpH4bgprr73cdz8R9YOJVUWK/PWYKPO3IypdonPh3o6YiOQLMpdyVqjJbM6VDG6ZLLEr5SPRtVBcCVxBhcgg4MfdvHrW3SpQ4bh/DBWnPO4z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjmr16VO; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-244580692f3so1178395ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755764804; x=1756369604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHW0JXKmK4eHXpQY/d3VGXBsDR+c8+O7sH08Ol1l1aA=;
        b=kjmr16VOGp3rmkHWbfU98n7L82EtQRQRpVocbMu1oPpXNJhkUHEESZbVopDY6if7bn
         zSV7fMdrLeswmLCUF5F5IfwLwVEqdD9YTex3o+bi7PRgF6PAHd1axwtqSc12i2ZwlNgt
         51aygeMQenVXHKt17Tnbh+MDXmuhGin30hWOlBBLnEb9XodviG9fqintvfEUabhivYbc
         Ih42TvuU1Ll5G2dFWd2HJEFm2iE3hNG/n608JE67662nVEersBOeT2oZ4wVF7PkGTyWK
         8HGjSKKD3j08BUGkt57KXSjC2mSLuTbLN7rVRWaJdkAhKn9LhWvkkDz3tyZ2tceJtnDF
         gj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764804; x=1756369604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHW0JXKmK4eHXpQY/d3VGXBsDR+c8+O7sH08Ol1l1aA=;
        b=DVbwTbn0T7PRa8XJjIRLGK745lMj1KuHA/l5jvQZOsZo7oGXzSyGVQAPGyGsh2nlWj
         YmKj4Yn/VYwAaKhlOAERWR7kra2Xxd4bINVqB1P+BA0nvDHv3JCjI3DD7n6PdjcvvAfX
         U6XSswF9qT7tEnXem+XgNlYbQxP8Lt7+Ekk27ml+aMd3z45pPWfizGNQsH1AOTIgESTO
         CfR7jthNeosBLfwS3ef2/3zWhTL92yXhrezHIHAt3bK8ql+QEc9Q1ZbNQceuXN2Z6b7f
         20EJW9qiZw5YE8eXgVM72ePhcwK51GIeow6zA1VxAnEZePch8sw/X+eNFmaV3UIAzWOf
         RKxQ==
X-Gm-Message-State: AOJu0YzMSPP2f1fTzK1m4CpbHCm8GjgAiOkPBqkXDtH8RBsEwLQoEVbe
	b2iS/6AuHh4Xz48vx0EyZxro+OJjNuaC8LriRrm1hE0Fm9OzHcFHX10cRBAf+mB1PGZ12g==
X-Gm-Gg: ASbGnctshgYVPi27exeeNEG7SjDuEZhxRxnc0bYFj8LUErdtQVZPNeis1R6lNhqHG0g
	BIOqwNCbjJpoNQVc266V9tje4/pn7ekXft6KSbjQiC8dz8ZtF9jYiogfbi0E9dTZ07ZThKXMv0f
	vb4XfkBAW64s0+C+EvA1EH5ufxyPIkJw/wkhaXfiRvRMLbPCpPbPOJAOYbjEly7+QSDekxeB2Jp
	Qq4h5ZZYMHyrkUun5j/O17ZmqyZ6uIJSa7yjX7ajZnE9q6hjl2SAdiiuItxQ3W67YVKQRV4ziZ1
	ZOX+anb/N+QIXIQj/QjTjJhKgSAVwNZZOyu56Ef61dT+swP/SSpxt4US0VZk/RsVt4yGbmkSdVK
	OPFhEPMl9cWBgA4D4i0lNitdFkUJZFYxY2QtOCx5uvSMmnfcDpaZtwUQ=
X-Google-Smtp-Source: AGHT+IFlfRnB+C/D/rT6tkcKl4YN2fAIrJ8OxUcI4l3W1YQXMHOCnfaLH7o6Ylm/6m7hSyOoys1Z1w==
X-Received: by 2002:a17:903:2306:b0:242:fcfd:3f94 with SMTP id d9443c01a7336-245ff909543mr14416525ad.11.1755764804122;
        Thu, 21 Aug 2025 01:26:44 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed373e23sm48490495ad.56.2025.08.21.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:26:43 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Newbie questions about DIR_ITEM and DIR_INDEX design
Date: Thu, 21 Aug 2025 16:26:38 +0800
Message-ID: <12736164.O9o76ZdvQC@saltykitkat>
In-Reply-To: <cefd585a-0934-436d-b65f-5ec729ea99f3@harmstone.com>
References:
 <12726025.O9o76ZdvQC@saltykitkat>
 <cefd585a-0934-436d-b65f-5ec729ea99f3@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Mark,

Thank you so much for your incredibly helpful, detailed, and patient respon=
se.
It=E2=80=99s greatly appreciated and has significantly improved my understa=
nding of=20
btrfs design choices.

Best regards,
Sun YangKai




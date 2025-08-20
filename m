Return-Path: <linux-btrfs+bounces-16177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE4B2DE83
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A334E7247
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD3224B00;
	Wed, 20 Aug 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D21Ad2we"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28E222590
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698408; cv=none; b=qDKkO2H5nklRnFBC0I0Bqp6/StWEAnYODyX8BpyI3K5BN6/L+RouF0UzhlMCw6RkOhJGGT3wcotmkRXS0yg3X+FLDwxvdW6q4ZpR4oJLGnVFdayXavVqKlQ8c7gYBh4lWZld0dYKige6w8DqFs7XFBmtt2Hs4634j3lS9NGVmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698408; c=relaxed/simple;
	bh=CJlKGUkFgeswdLcMZHr9pWMxPLGV18mMsFKLfgajRek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsukGcBNmCfsxF7Q1XOw4QF7Hiv3rJeOgRdZohv9RbnGCxQSXU1AZJY9dq4XRvaKNZgnqHcaX5Q76uHwwkuPYlPb37bOUoZ6HeYkmXK2dYwkembEsklruThGqTo5JQ2nUtEg6ZHRnVcpvWoic0ma0siK+2aYNgzWmt9fZ6SbrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D21Ad2we; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32326e25000so563327a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698407; x=1756303207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7DRcg5nWe3QJqDF8a0JYtConlHh8J3cE7PSYaP0Chs=;
        b=D21Ad2weIfcyhHPAY5DGVi7UGHt6DM3RzPj+OPIgKK605K45x6fAWj+0LaH7oEN/3X
         oacasPQaW4BEhtyBgzpAeqLibS5JcRJkE0MWqQbdGHnBHmzpxwNOJtrQmbW7j71zR0i/
         zYbV0T8fH5U4wrIxLWdH0frfDigFXQsMOgoWsPS8N0DKXb3oTXA3noEkB2kJzdmKbYps
         +OQKqwlFtxi5VDA+HCN8LMYfIpIRLy15JEancFMK7f6Pyqf88Nm9vRZrGC19xCFlDWyU
         +3i2jfYrC4SL+XVECwD6NcnSqMdX+xP4Vdks381sIktAj3HkTk7grifi4XDCYJnKkR+M
         IMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698407; x=1756303207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7DRcg5nWe3QJqDF8a0JYtConlHh8J3cE7PSYaP0Chs=;
        b=PoXGNjkJyMM0LVKR/zX8p/6d+JSwtlZmQkW/BrxmQuP6WOfdIsIDdSC1mbGlZWpu3u
         Lz2g3qZBrrwcwDF1BcYrGSSIZjGJh67uVnc9ck9sDgJwMnfevrAFTuAaVKQEhvt5ehAy
         H81j+lZwZDT6pna3yGQx74bbWl1J48mnl47x3uPPH+dsnDVtzQ8HYDXSTC5gdBG5ll6R
         BE/Bzv9x568EYIygM0lKpvH8fT0XAC7z63jXQ2yt+hSIuslvnRQ3GM02kgwhPR1Azbh0
         nyr588EqXdRpsMCV0/1rOU/wxeZHjtHTQKdP2VWFGmy4cYzWM3X5qHDB0dvdp0/3c0H6
         Jljg==
X-Gm-Message-State: AOJu0YwJAnipkAj9STC2g6e7Eis7DxpyJAfXZU0cJEP0KeUTaQKhQDLi
	LCM9lZqvFr1/thTqBFK41OUCWQgptcdH8PszDyzBFISF39mLCCa7pvBlQYdj+rmWx+Vmyw==
X-Gm-Gg: ASbGnctYhJLnUMSncyRP6U1+UjpFY0fc4edIy9CvQGdjwRyL+lO8ugDQkSodiQCgJsr
	+dlu66ke9nYPDFtt4HPQSEXwf6uafiPRYqfvSITixt/4i3kD574Gr6NAzyKmwUrG3BP9Sz6kdyz
	TZ691/0L8qEUaUrj41DThWjUUgeD4Rr5FSVETTJDuk6Zuj78rsldbRnRKdIJFjycvk3ve98UKvY
	BqUTxjJKn1/Wog0RPcL19/CLqe0wtg+CqYFtddMlWSv525CBp0FL0W6cuMq2mtBx/FTpXeotwh6
	N6TZkGFWQxjIPryoCYk5AM4+48nVKeCnAuOohrwfEgTEmbVayWX1OIIWO+VpdUPPXQmEBR5WqML
	EbGexvIYjL/ryedL2a3S37v9AaVkXBN+G6YTRT6PlIHcScfk9+vuWhxFlsmwv99Gb3w==
X-Google-Smtp-Source: AGHT+IEnukmcJnmSRHX0CC1X4MS06TTZ/sj9whRnJs0mtwtaQdJ+Atqpga/+2cSHkmdCaHERHvAtUw==
X-Received: by 2002:a17:90b:1e0d:b0:321:c235:38a6 with SMTP id 98e67ed59e1d1-324e143eb4cmr2174437a91.5.1755698406502;
        Wed, 20 Aug 2025 07:00:06 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e25177ebsm2476266a91.1.2025.08.20.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:00:06 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: sunk67188@gmail.com
Subject: Newbie questions about DIR_ITEM and DIR_INDEX design
Date: Wed, 20 Aug 2025 21:59:58 +0800
Message-ID: <12726025.O9o76ZdvQC@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello btrfs developers

I am a beginner studying the implementation of btrfs. While examining the 
structures of DIR_ITEM and DIR_INDEX, I noticed that both store similar 
content but differ in their offset values. This led me to two questions:

1. The offset field in DIR_ITEM is computed as a CRC32 hash of the filename. In 
practice, is there a risk of hash collisions? If so, how does the current 
implementation handle such collisions?

2. The offset field in DIR_INDEX appears to be an auto-incrementing number, 
possibly indicating the creation order of entries within a directory. Why is 
this necessary, given that DIR_ITEM already exists?

I would greatly appreciate any insights or references to relevant 
documentation or code snippets to help me understand these design choices.

Thank you for your time and guidance.

Best regards,
Sun YangKai




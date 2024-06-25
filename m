Return-Path: <linux-btrfs+bounces-5972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB552917000
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C651F213C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD8179203;
	Tue, 25 Jun 2024 18:19:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A113BC2F
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339543; cv=none; b=SGZv/uyyUhMmv2Rhmhmhk0xbqKmK7iLv0/CE7pfXVenknmQUD521LlK8/GqZwetkclgKRJsYQWsqCyayv7sY30TutJC3Im6LSwt6QTGXK0tWKVQ1PWMO9oj9IPJcPWvX+t9mL/Ra5Feu21mIaPLlexPeQGBhdRYFjiI4Exsvnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339543; c=relaxed/simple;
	bh=R/4fduKCAuyylmEGMBy9V2du4G5os3EgooF8uLxcwgY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OU9kgp/Xj7HQJOTHuEWvGKUWToVD3IBIMo5hecKqB1kZtxc3EidHnzyeTuQIZOuv7otOCQYFbetMxyLyY0g0sSW3o27nTBAXSslSnH2axyR+NYgx5U0nv2h5lGRkfKNL1xF5DoCRq1AxcMTZR/XEM6DljyMpm/pN/CglLE6tsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id C0DC03C406; Tue, 25 Jun 2024 14:13:39 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Ulli Horlacher <framstag@rus.uni-stuttgart.de>, linux-btrfs@vger.kernel.org
Subject: Re: workaround for buggy GNU df
In-Reply-To: <20240621065709.GA598391@tik.uni-stuttgart.de>
References: <20240621065709.GA598391@tik.uni-stuttgart.de>
Date: Tue, 25 Jun 2024 14:13:39 -0400
Message-ID: <87le2s6gbw.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulli Horlacher <framstag@rus.uni-stuttgart.de> writes:

> The GNU tool df does not work correctly on btrfs, example:
>
> root@fex:/test/test/test# df -T phoon.png
> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
> -              -     67107840 16458828  47946692  26% /test/test
>
> root@fex:/test/test/test# grep /test /proc/mounts || echo nope
> nope
>
> The mountpoint is wrong, the kernel knows the truth.

How did you get this to happen?


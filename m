Return-Path: <linux-btrfs+bounces-7479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F695E2FD
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E291F2160D
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970613D882;
	Sun, 25 Aug 2024 10:56:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F072F34
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724583377; cv=none; b=Iwf0NPgew1ZD9fKxiL6/D32kKM2DHOMYVqXhbx8xr77jSKJFAvYJ5GB7831pzBJhEwSo519AOnKEU4DRVik3GAR9NU/AdRET8FOSV1+X16NuI+pGnFflbzhwcRlfnLJDhuyX2bMlPGuRWrcLbS8UX6tJuYkga3mL7t8et614pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724583377; c=relaxed/simple;
	bh=J+F5UgcK5TuX08FRWucmgMiAdVldMiCNXHUZlmJNN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co9EJWIfEKlfEQcR6Yf0hruIUSJTK5oem0WMeCciCnYxtk6lAwelllMM1AD9AoEZvd4Dr+azjKg/1to8AJQfcPOr37jahoED+hOKThTEtcgxeWp52aGo/U/6BAi0wHivRcBAoXXdxx4/TOV+ofH6FcbO/7f48W90rLjcPGtYvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id D36D73F1DA;
	Sun, 25 Aug 2024 10:49:50 +0000 (UTC)
Date: Sun, 25 Aug 2024 15:49:49 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Yuwei Han <hrx@bupt.moe>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: oops on 6.11-rc4 loong64 with RST & subpage enabled.
Message-ID: <20240825154949.2ee502d4@nvm>
In-Reply-To: <EEF4303B52E6A560+21c563de-b84f-478e-897e-e88eb0ce4b94@bupt.moe>
References: <EEF4303B52E6A560+21c563de-b84f-478e-897e-e88eb0ce4b94@bupt.moe>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

On Sun, 25 Aug 2024 16:44:12 +0800
Yuwei Han <hrx@bupt.moe> wrote:

> Hi,
> There is a oops when I am testing RST & subpage support.
> https://fars.ee/vTGd

It is better to post all output in the message itself, even if large - for
archiving purposes, as external websites may disappear later, and also for
better searchability.

If it is complex to deal with auto-wrapping in the client, then I'd suggest to
attach a .txt file.

-- 
With respect,
Roman


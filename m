Return-Path: <linux-btrfs+bounces-19339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97BC8599C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 15:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9560F4EB88E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13332695E;
	Tue, 25 Nov 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfrLXgbo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13121ABDC;
	Tue, 25 Nov 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082594; cv=none; b=kAp8+P+wWWkJvsL1cCTxICQGhWrc8xTBvi7wY+BCIU//SHNfNt0s3atPX0p+FJgxlNxX9jKOo3r3IOWFvb4FKebl1B9IiTk4rmtWgmjhDviT0EGeyXFHHif1pgMw+JRZsIStr9oJSPhjsf/6/Kte+n17x4EOFFHVHYS+GNIihV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082594; c=relaxed/simple;
	bh=h9FyoFHzLBxYwycQk9/joEEebSniALO3/jYxtaMuvc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clbeaQJwPeoCUxuktppux1CmKP16+JCxl5GuJsj60AEE8yGRLZVXFSbf1qnNXt/UP1wwGeHZ022LHP588W0u4d1802MFif+l3+dYI7cGOE6ySMqYycGa7ZtZeI0uY8r3zfMPshytqo2AXtu9WLI/Xew7wEfXMwzdNIU63x6Rw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfrLXgbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E087C4CEF1;
	Tue, 25 Nov 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764082591;
	bh=h9FyoFHzLBxYwycQk9/joEEebSniALO3/jYxtaMuvc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfrLXgboNlPHYPzJRhHYdAFelRXWRLlguZI2AvILWk2xvksOGOlYbeEC9OwUslKx5
	 Rf6VD6c+JObizOUfvK52HIoBOpSAN+qbBH3dgautmDjjNodrDOBFsGlR58O99G2rYw
	 Iug05eQyM+vDd2x3wZCZ4x+ctgUNlPFEmaIZOCb3ykgsZMaAa5CCZjnhqz66HB4YIB
	 hUMuyqxfUTkYtQqw/CNJ5bG8EUtw/exUy3KCYRxNPCjHQG7kOIIpcPCU3C61vzICTJ
	 2vqDwgZyxmNv4ZVV5Z9+sI0uUrFlOiG3M7vk8WFkljvXGuhvYFB4BnQGy6LlIdPkV+
	 R/ryUkjNYxM+Q==
Date: Tue, 25 Nov 2025 07:56:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aSXDnfU_K0YxE07f@kbusch-mbp>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>

On Tue, Nov 25, 2025 at 09:42:11AM -0500, Justin Piszcz wrote:
> I am using the latest Asus ADM/OS which uses the 6.6.x kernel:

It may be a long shot, but there is an update in 6.17 that attempts to
restart the device after a pci function level reset when we detect it's
stuck in nvme level reset. For some devices, that's sufficient to get it
operational again, but it doesn't always work.


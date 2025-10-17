Return-Path: <linux-btrfs+bounces-17968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DFEBEAEDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F217C18F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEA2C0289;
	Fri, 17 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCWUzTUk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B42BE7D2;
	Fri, 17 Oct 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718902; cv=none; b=X1IlLe/Hc3XrDS93h7ktrDYi2VtL5svKKPTp/iIiXeKIhKFy9ADayvyHlR90zsKDnE34QYzRC18jeEKZKp7EAVeUl5J1LXry9c76GDyoXPrcvEdsoBm/OqVGtgqI/eEzqR6M2PkKpzijhOM4h9lzFm7mZ98nW1UiyQH1ZcKbAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718902; c=relaxed/simple;
	bh=qk/Vq0Vfd/XUFZk7lbMJwAZmR4jhXUs9rGtjiVlyVDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCWfVNtPzCiAUNcw5HY7k6IyMewONWhrlbTWypbpf0JnSM/dPbMp84uicVg90bF8y9/qTDHW3Zf2bc2rEhQ3jPzMFn36+iKXwoKabQar8rZiCFHaU5vgh27lyad7RG1mgge2x9d6UNUOkLnB9hm2dIijdrzja4/JBsvzUnu8lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCWUzTUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A419C4CEFE;
	Fri, 17 Oct 2025 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718901;
	bh=qk/Vq0Vfd/XUFZk7lbMJwAZmR4jhXUs9rGtjiVlyVDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCWUzTUkqpk9oU+UFud7B/V8ZYlgAtkjsczFkAoY2/TZfWIjeEn7ZgAOWlFrJYOK/
	 N0+4Wu4cG23MieL0+Ab3UB2tFtGe1W2cB78V43I4bmdwW2XeCZBzZDf/SYL9K69bTz
	 ld8swxcB9o1RF6E7C1JbPDFuXnHKzAWhm8T3644hzA6jEi+ggeqqh53naRO+QK04tG
	 hKCpUztcSbTV5vrDglLcVuXxlebbc2z3c4URzpRo787ieHpezTs5I3LvvVohkeEYqC
	 h+8/WabmEaaYl+fuojdpT94I34azxWn5aBuKOfpJ20DeXwECImRrXZXFvu6mTPgD0Y
	 iGFMgFgqmGxFQ==
Date: Fri, 17 Oct 2025 09:35:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Message-ID: <20251017163500.GC3356773@frogsfrogsfrogs>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
 <20251016154834.GN2591640@frogsfrogsfrogs>
 <05b2e86b-bdc5-4298-afb2-9ca9cf702c42@wdc.com>
 <DDK6JMVR67I6.2RADBK222K8SX@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDK6JMVR67I6.2RADBK222K8SX@wdc.com>

On Fri, Oct 17, 2025 at 12:44:35AM +0000, Naohiro Aota wrote:
> On Fri Oct 17, 2025 at 12:50 AM JST, Johannes Thumshirn wrote:
> > On 10/16/25 5:48 PM, Darrick J. Wong wrote:
> >> Same question as last time: shouldn't we only echo this if the
> >> zloop-control write succeeds?
> >
> > Damn, I thought I've did that.
> 
> Maybe, it's good to call _fail as _create_loop_device() do.

Does that actually work?  _create_loop_dev is often called in a subshell
to capture the device name, so the exit 1 in _fail will exit the
subshell, which won't exit the test.  Right?

zdev=$(_create_zloop_device) || _fail "could not create zloop"

Though if you're standing up a zloop to test zloop, then a zloop
creation failure ought to cause _notrun.

--D


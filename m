Return-Path: <linux-btrfs+bounces-4581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A58B4ED0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 01:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53750280EFF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Apr 2024 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20591CD21;
	Sun, 28 Apr 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="sCZJJ3Kf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D78F59
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Apr 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714347651; cv=none; b=PmkfUeFJikc+AfBpP8cEJAyi/oa0q27/4jKxwbC3YaMttm/YcWPgcKmdegkyCtVCvREfqwZcVeCh6kbS2G4wmDcJBQSnj3GTL9Ez7Sk0D8caHYuBLBmc3ZJ29W7y6Fx2KVWcJvvomF0mLhZmvBPRFxDAUn3KXX1dz3yO/m04o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714347651; c=relaxed/simple;
	bh=hQAnokbNxHMgBnu+13E7xjaSPQVXFxoX1uvKCAAuPR4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b2N6QkSTIL21LQutdbkfIswvKZS5ZcBxom6Pwu64E5aLD8I+KX0zsAmxUOgZS87voVOWzOCAwJpUQ9eyhsIi9KOinO6lXNNz8Vg3U1IgbhZ/b1dy9iHIY9UlKTa1nVftPZ0pZGj+p35875XSMwKVpxayTXkAYdZQ6rvq0J+jsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=sCZJJ3Kf; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 5879F60DFB
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 01:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1714347094; x=
	1716085895; bh=hQAnokbNxHMgBnu+13E7xjaSPQVXFxoX1uvKCAAuPR4=; b=s
	CZJJ3KfHgru/uVkMVygAYiLHw1MPvakeD/Ncrcvhhx6MwAT1/2yEiXcmsAq+hW+S
	shskxrdr41rlsC8h4BZo5EZHsFjiX689XUAU/QdT1g+kXykWzT6pEYZqs4KLRVNa
	h0VD4S/geDyBPV9xbn0r3FeM7CL7eQxUe2ZXWdg7fI8T5Wjraqq8Pou7IDFW3ZPK
	TNQzu+Z7VmjRJGA8/6BOZXGIKr9DoV0IqPfzZQvjewTT7YGrG0nLXdxqy0n597Fk
	u2RFBCQpHX1kUVAHjmB9J2HrcpaPV3SxNoRx6luSQ+l2vi5fjRf+Pe12m1r1J4Sw
	1U3A9ZJe08RX4VWZ/+fZQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id ODmgAhL-A5hh for <linux-btrfs@vger.kernel.org>;
 Mon, 29 Apr 2024 01:31:34 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 29 Apr 2024 01:31:34 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: 2 PB filesystem ok?
Message-ID: <20240428233134.GA355040@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822


We are planing to use a Seagate Exos Corvault System with 2 PB as the
storage backend for restic backup. It has some hundreds hard disks and
exports them as a single virtual disk (via SAS). Linux sees only a big
SCSI disk. This special RAID is all in hardware, no need for BTRFS
software RAID.

So far my biggest btrfs filesystems have only about 100 TB.

Is 2 PB ok for one btrfs filesystem?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240428233134.GA355040@tik.uni-stuttgart.de>


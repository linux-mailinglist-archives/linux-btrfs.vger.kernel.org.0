Return-Path: <linux-btrfs+bounces-6678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191F93AE05
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77AD1F241F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BB14A61E;
	Wed, 24 Jul 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.b="jDOIfDb7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailsender2.cdac.in (mailsender2.cdac.in [196.1.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC21C2AD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=196.1.1.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810822; cv=none; b=tFI/IXzhzay2YapZvA3idU957NKrKyJd9grVBThGTkq86c6MawhQm08wXOQqF+KPLp8QhbLEZFn+PX1JDOpPuHBRXZ4P9Mfjrs+3du/JGA0zmDtugDSALNzLE96CN2Ol9PlLLd2f29WdIO7SjHqUg6xtpRz19qcCO91XlfhIizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810822; c=relaxed/simple;
	bh=dSaW917AzTDDs37yPptjn3lf9VfF7Uhu4eh4OJ8ku34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XPyV3lQU+DSxlv7CAzOHovm24mQsY6gxUOTgqQYmcD+k8qFqfX6K0RwQwU/VLZkLwLXTYc6K4e/Tmq71ypUCxxwHxZAqA0nUOhy1NYrZU9fnVWqBciaXe/DoWFWoff+qBS81zjDAIymIbFaSmjA3mZi8WB81bFeDRmD8cTIbHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in; spf=pass smtp.mailfrom=cdac.in; dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.b=jDOIfDb7; arc=none smtp.client-ip=196.1.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdac.in
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
	t=1721810779; bh=dSaW917AzTDDs37yPptjn3lf9VfF7Uhu4eh4OJ8ku34=;
	h=From:To:Subject:Date:From;
	b=jDOIfDb7nYt+O7P4eq30SVyr4/zgb7bNAJhxcKw2EwpilTNMDt7CyBgKWi8DJCJI0
	 WPM67iJ2XPImc5HdOI6VJtD2O/BD7mptdG05hiUrMji7bW8C4jo4FvXVU8ievPDLZL
	 lxi5blNOobP8nqkCZ8utRv2DT0hD3s5RTr7M5nsk=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
	by mailsender2.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 46O8kJLx3950815
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 14:16:19 +0530
Received: from smtp.cdac.in (mailgw1.pune.cdac.in [10.208.1.26])
	by mscr-int.pune.cdac.in (Postfix) with ESMTP id C6BEE10059D78
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 14:16:50 +0530 (IST)
X-Auth: saranyag@cdac.in
Received: from DESKTOPB0B7HO7 (cfs_saranyadellpc.tvm.cdac.in [10.176.27.169])
	(Authenticated sender: saranyag@cdac.in)
	by smtp.cdac.in (Postfix) with ESMTPSA id D63BF4E00A5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2024 14:16:45 +0530 (IST)
From: <saranyag@cdac.in>
To: <linux-btrfs@vger.kernel.org>
Subject: Striping in Btrfs single and DUP profiles
Date: Wed, 24 Jul 2024 14:18:07 +0530
Message-ID: <001001dadda6$3501a1e0$9f04e5a0$@cdac.in>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrdpjSaCY4NL+QUQBmiyLawirfQYQ==
Content-Language: en-in
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more information
X-CDAC-PUNE-MailScanner-ID: C6BEE10059D78.ABADE
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-0.2, required 6, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80)
X-CDAC-PUNE-MailScanner-From: saranyag@cdac.in

Hi,

Is there any striping used in  Btrfs volumes with single and dup profiles?

I have read the official documentation of Btrfs available. From there I
understood is that, striping is used for multiple device profiles only(ie,
RAID).

But when I am working with a sample Btrfs (with single and dup profiles)
volume, I am getting stripe count as 2 from a single device.

Any hints or pointers to the documentation on this is greatly appreciated.

Thanks in advance
Saranya G
CDAC





------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------



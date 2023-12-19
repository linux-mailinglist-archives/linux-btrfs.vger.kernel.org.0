Return-Path: <linux-btrfs+bounces-1048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF081816A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 07:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8066A1C23490
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83561883A;
	Tue, 19 Dec 2023 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdac.in header.i=@cdac.in header.b="BWpIHQFO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailsender.cdac.in (mailsender.cdac.in [196.1.113.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E087486
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cdac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdac.in
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
	t=1702966662; bh=UEjTvf4l52u6bXtalm/z6Ru5uwENzHdWb7DWcNO6Ch0=;
	h=From:To:Subject:Date:From;
	b=BWpIHQFOzE9yFLdwomIebDxrfu8kEOpNNqnx+SNO53W0+D8xYF8TVfV+dyoTyADSH
	 vrRPo3t9+TMEryl4xRDP7OW6Igw/jLG1dpr8w9eHDa9AEutIODsdZQuAqvVlNXmPK8
	 OUJ8bJ7txbxfAsA0YTqyZ7nJtEmqHxi31C9+PzD4=
Received: from ims.pune.cdac.in (ims.pune.cdac.in [10.208.1.15])
	by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 3BJ6He1p3116147
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 11:47:40 +0530
Received: from smtp.cdac.in (mailgw1.pune.cdac.in [10.208.1.26])
	by ims.pune.cdac.in (8.14.4/8.14.4) with ESMTP id 3BJ6Hctl009075
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 11:47:38 +0530
X-Auth: saranyag@cdac.in
Received: from DESKTOPJN4LLJN (parvathy_pc.tvm.cdac.in [10.176.27.82])
	(Authenticated sender: saranyag@cdac.in)
	by smtp.cdac.in (Postfix) with ESMTPSA id 86D204E00B4
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 11:47:34 +0530 (IST)
From: <saranyag@cdac.in>
To: <linux-btrfs@vger.kernel.org>
Subject: Logical to Physical Address Mapping/Translation in Btrfs
Date: Tue, 19 Dec 2023 10:55:26 -0800
Message-ID: <000a01da32ac$ee868d10$cb93a730$@cdac.in>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdoyrKDvdxadKEpSSU+694OwJoA62A==
Content-Language: en-us
X-CDAC-PUNE-MailScanner-Information: Please contact mailadmin@cdac.in for more information
X-CDAC-PUNE-MailScanner-ID: 3BJ6Hctl009075
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-MCPCheck: 
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=0.801, required 6, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80, BOGUS_THREAD 0.50, FVGT_u_HAS_2LETTERFLDR 0.50,
	URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: saranyag@cdac.in
X-CDAC-PUNE-MailScanner-To: linux-btrfs@vger.kernel.org

Hi,

May I know how the logical address is translated to the physical address in
Btrfs?

I have read the official documentation of Btrfs available here
(https://btrfs.readthedocs.io/en/latest/Introduction.html). It is not
covering the address translation part in detail.

I have also gone through the Btrfs source code
(https://github.com/torvalds/linux/tree/master/fs/btrfs). I could not figure
out the address translation from the code also.

After referring to the following functions, what I could understand is that
after getting the logical address of Chunk tree root from the superblock, we
need to convert it into the corresponding physical address for parsing into
the next level.=A0

int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices
*fs_devices, char *options)

int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)

static int read_one_chunk(struct btrfs_key *key, struct extent_buffer
*leaf,=A0 struct btrfs_chunk *chunk)

Any hints or pointers to the documentation on this is greatly appreciated.


Thanks in advance
Saranya G
CDAC



---------------------------------------------------------------------------=
---------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
---------------------------------------------------------------------------=
---------------------------------



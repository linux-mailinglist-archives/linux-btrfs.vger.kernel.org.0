Return-Path: <linux-btrfs+bounces-10484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706E9F4EBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE3818873B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2F1F75B5;
	Tue, 17 Dec 2024 14:57:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68381F4735
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447427; cv=none; b=rz3fWdpplS0FvP2U4NGuhK20Glz6lkpSq6LSDiqH/KHl4TNjPu4hcKMG3DUNbXdPcS1Xssic7UAKW3vRRaEtdST2utQ52mX8IXA/7Ix+MSwqMOlLGJJz6P4VtRR28HtEC5q7Wka8Cjoqhs+k5q2M5h4SG/sb/JVkp2US/+eujNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447427; c=relaxed/simple;
	bh=AATy07ehHuhlMsz82K4R03c+ylbtEDHChyAGuPYZZcw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=kiESw/9xwT5gVUU9ZhofftV1FMlMyvwqq8HKp91cvOStIDthTbI1rfaQWpKMk7B1/vn6i754AMLESDEAF8HkQJHZLtpvkHnJG5CISRv4m5AW2mDiHcU4/qxOcN3PmDYhjpY8AnMVD7F2vThMZBLXS7VXrfPz/MhiY+xvOzPqUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id 80A803F43E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:56:50 +0000 (UTC)
Date: Tue, 17 Dec 2024 19:56:49 +0500
From: Roman Mamedov <rm@romanrm.net>
To: <linux-btrfs@vger.kernel.org>
Subject: btrfs-progs: -q/--quiet not accepted for "btrfs subvolume"
 subcommands
Message-ID: <20241217195649.143d2c94@nvm>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

# btrfs --version
btrfs-progs v6.6.3

# btrfs sub create --help
usage: btrfs subvolume create [options] [<dest>/]<name> [[<dest2>/]<name2> ...]

    Create subvolume(s)

    Create subvolume(s) at specified destination.  If <dest> is not given
    subvolume <name> will be created in the current directory. Options apply
    to all created subvolumes.

    -i <qgroupid>             add the newly created subvolume(s) to a qgroup. This option can be given multiple times.
    -p|--parents              create any missing parent directories for each argument (like mkdir -p) 
    
    Global options:
    -q|--quiet                print only errors 

# btrfs sub create -q test
btrfs subvolume create: invalid option 'q'
Try 'btrfs subvolume create --help' for more information

# btrfs sub create --quiet test
btrfs subvolume create: unrecognized option '--quiet'
Try 'btrfs subvolume create --help' for more information

Same for "snapshot". Maybe also some or all others, did not check further.

This is the case also on btrfs-progs versions 5.10 and 6.2.

-- 
With respect,
Roman


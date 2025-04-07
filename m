Return-Path: <linux-btrfs+bounces-12858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC53A7EF0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FF97A585C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71321B185;
	Mon,  7 Apr 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axka.fi header.i=@axka.fi header.b="icomNEhQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from axka.fi (axka.fi [45.77.205.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B719AD89
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.205.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057291; cv=none; b=gZV8Orack1ZKjwjmY4rRfytWR8p7yINHmUfBkmXADGd4hzRljFy4v3dcDOOI6+Q76hK26sLznE0/21jER3NFSq0VhNUpymoeA4HE9Ym9x2LSXFC5IwdSj1Gpxe8cqDreWWByM87telbvkHouY8ZI/lH5F+W5wVwRXJws9+vkhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057291; c=relaxed/simple;
	bh=qS9MuCdDRiSBURPTasMf+wHir00196E9C0bJ/G8evmk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fr08Rx1TjBL2d84lyM57xE1DeYjkRA5AHODRM4/OMJBqeIuyuJ2kq8/xMfZVszx8KBIPEaQIrILGUUsAJ4GVpNOuPQ59tKLrT9LtwAlOZNatWMNtNoutZb+XKk6bsCqIsyLsbDaSRlmOQo1iPXkLX0iGBFbY3hCEbzQGF26ayfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=axka.fi; spf=pass smtp.mailfrom=axka.fi; dkim=pass (1024-bit key) header.d=axka.fi header.i=@axka.fi header.b=icomNEhQ; arc=none smtp.client-ip=45.77.205.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=axka.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axka.fi
Received: by axka.fi (Postfix, from userid 1000)
	id 47396400B2; Mon, 07 Apr 2025 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=axka.fi; s=mail;
	t=1744056920; bh=qS9MuCdDRiSBURPTasMf+wHir00196E9C0bJ/G8evmk=;
	h=Date:From:To:Subject;
	b=icomNEhQfv+aJgCZ2Mct4SG/KeyReB+nuCIiaQ5ZSLe1lRLwezIGEFSgUeCiSAE7Z
	 +/jfrKdsaVL/mZyOMPPHg4THOe9mljoBfeVDFySZpc/vMaMwjpV3hPHKTO6B9b6LPi
	 6PYvl/cVLVB4oNM8YG8LH2n3x6AQJuoeBs0BG/9A=
Date: Mon, 7 Apr 2025 20:15:20 +0000
From: Axel Karjalainen <axel@axka.fi>
To: linux-btrfs@vger.kernel.org
Subject: Logical volumes with Btrfs's allocator
Message-ID: <zs7otvd5defwofaoinl7twyvcuaa2hw45axlgkk4sfiyddky7i@hytdwjsb3kb3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The subject does sound very fancy, but I'd like to ask whether it could
be possible to implement encryption and maybe dm-verity partitions on
top of an existing Btrfs filesystem using a custom block group to manage
their extents?

I know, you can get all of this today with LVM, but not with support for
"resizing" partitions by just creating files. Think how you can have
multiple mountpoints of a single Btrfs filesystem affecting each others
df stats.

For encryption, instead of creating a whole new Btrfs partition with
dm-crypt/LUKS in something similar to a loop mount, could there be new
encrypted metadata and data block groups added to the existing Btrfs
filesystem? Over fscrypt and similar, this has the advantage that single
file extents are not usually leaked and (meta)data is never leaked.

The dm-verity idea comes from Android, but I'm not sure if this proposal
could be hooked up to provide boot process security. Maybe fs-verity is
good enough?

On another thought, writeable filesystems are usually not packed, so
having a "resizable loop device" would have either really bad storage
efficiency or really bad performance.

- Axel Karjalainen (https://github.com/axelkar)


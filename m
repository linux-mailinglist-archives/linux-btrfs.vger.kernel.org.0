Return-Path: <linux-btrfs+bounces-15982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB22EB20726
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F64188FBF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB102BF005;
	Mon, 11 Aug 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CjQtsYYR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F882BE7CB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910862; cv=none; b=bY5HWJ2yo3uNlbP9JUi9hhq5eCGgShA9+GJyQAyz5oCdBIYTdjpmYERsNQvpblVkjrFNyQ0o3jApYSLBX0/LC4tUjZ9FnZa1pNOAtCOvIVIma8yRRGr98IY+ZLuv7de7PTkiz5+RDOtcV1fuSrMMHkdmQtDRqoB+MS4xVzi+e/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910862; c=relaxed/simple;
	bh=KAs5jOZENA+23HRC30nHOmdO4LP+gU6V2ANPivN/B7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS/1F/4MutgRqsmV9pIUaRp/+YewN6Y9A5PqZqmhKLVPJ5f/nI184Xkxf5OuOC17ivTFZlpt+StnxIcb2I24I4XsXLqer8WpTN72sa1C6Wm/DFHuAYrCmMFJoGEbGBL2PAWiT/8U3TnLXBkjK6rZT4zaI4iZtRMcTUhVD/BuSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CjQtsYYR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-121.bstnma.fios.verizon.net [173.48.111.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57BBDaM5029819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 07:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754910820; bh=yHFvHo6R+wyvHhllEY32hSJMp83zXaOzd29KX8MLnHU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CjQtsYYRB4hjhMsFcG4MM7KsFeE/ne0VzdfIAZXYral+rbBfboazdcrCorY8copyA
	 /9lJZwoxtASPD5sZV/SlFnG6XNbOiqjpEOjxnUW4WC9tSdT+NEKtkNGueJ88vuAblh
	 I4eTexci9aW1BAwDNmf+Bq+UIQ/aP1lNsAJjqA8yMgP8eB0ohGD81Flq1zMxVV+jzo
	 I0ZJ7vxAzqqNcJHLA6hm8X0UNbnhbZf0TsJCflzsu260J6EIuQJfOxbCCno0TBO9aE
	 7uKTEs5qw7kfPPGMDMZp+/zOHXpj9Budfyg1vGCowkZgTDvwzSZcjPq6YgIr3c+YRm
	 FJplTrp1n8j2A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 525CB2E00D6; Mon, 11 Aug 2025 07:13:36 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:13:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 03/13] ext4: move crypt info pointer to fs-specific
 part of inode
Message-ID: <20250811111336.GB984814@mit.edu>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810075706.172910-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810075706.172910-4-ebiggers@kernel.org>

On Sun, Aug 10, 2025 at 12:56:56AM -0700, Eric Biggers wrote:
> Move the fscrypt_inode_info pointer into the filesystem-specific part of
> the inode by adding the field ext4_inode_info::i_crypt_info and
> configuring fscrypt_operations::inode_info_offs accordingly.
> 
> This is a prerequisite for a later commit that removes
> inode::i_crypt_info, saving memory and improving cache efficiency with
> filesystems that don't support fscrypt.
> 
> Co-developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>


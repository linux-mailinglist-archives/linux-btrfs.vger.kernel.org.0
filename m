Return-Path: <linux-btrfs+bounces-902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 108AB810CD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8D61F211CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99E1EB49;
	Wed, 13 Dec 2023 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ke4ezuC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE8B7;
	Wed, 13 Dec 2023 00:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5X2SvqPtWo7gdK+k/g7tSjg+ZxJIl7QEcfpBU4ieBtM=; b=2ke4ezuCb59ti/+WxgLBeNXl2P
	LveYl5CDnfVWE1Q/vO5SBOt8KtB5XZ01MZS9Zrx+liAyCk/X1L2UmSLzlUsW4QzEDjxRUiHstzV79
	O1edyIh/fCuAZQS+qdL/0yUSROjsVffBTciCD0Qt9oDosBxsprTQdP6tBA7TTceFFd9N2n69SQEyB
	2jBx5Z+wBenMvvEtqpFC8ttaxdkDzAAQ2+rOFEneEePJYr6T6t//cxCKbdFPQdu06lqQeJc+uvzi6
	QqWptSQh7e3eLUgU3gs7sJoXiNZ9+yETXms48+8EZS8NsrLSMhMzqKFI3TcLgHfB9QdapTKViqtZL
	pO57hZ0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKzt-00E5d1-10;
	Wed, 13 Dec 2023 08:53:41 +0000
Date: Wed, 13 Dec 2023 00:53:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] btrfs: untagle if else maze in btrfs_map_block
Message-ID: <ZXlxFdqVZEfWSQe8@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-10-b2d954d9a55b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-10-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Might be worth mentioning that you're using a switch statement :)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207CD14BE98
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1RbB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:31:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgA1RbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7tsk+/qMnjmlOGoiTAWm0dseUwoUHYRtwJPDF0g6z0=; b=Jax0mN8hyn3MKgd0xg2CDGLh/
        +1M2bk0eIKa2lkj4PK2n3UI06imb8bgOobBHtXbgKNcUwgurwxbpo2Abg9y72aFIUOxzGHhkWmA/k
        atecTlpblq2K207qcMGOnZYHQic8bYlkud4x9CNyHn181vJT1PgJ005Lix1p0ugTnfapELFvysRns
        jTut1+BRhCFcnFBJiFXA8gRjGXAnzwqHFLoraVSJaGu8Vo7JGsIKz/Zf845EPjJJUyRAQhY9z40bG
        QtsJFJNaeOfUjAKsv2CjbBC7f69qYozVq4vJjyk0onjeye9H7qktSE2FdXhf7c+kpjJB/F+kG2wop
        xYspxoosg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwUhY-0004iu-GE; Tue, 28 Jan 2020 17:31:00 +0000
Date:   Tue, 28 Jan 2020 09:31:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200128173100.GA16464@infradead.org>
References: <20200127024817.15587-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127024817.15587-1-marcos.souza.org@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 26, 2020 at 11:48:17PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This ioctl will be responsible for deleting a subvolume using it's id.
> This can be used when a system has a file system mounted from a
> subvolume, rather than the root file system, like below:

Isn't BTRFS_IOC_SNAP_DESTROY_BY_ID a better name?

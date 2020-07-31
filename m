Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A697123472D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgGaNsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 09:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaNsa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 09:48:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A32BBB01F;
        Fri, 31 Jul 2020 13:48:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3742DDA82B; Fri, 31 Jul 2020 15:47:59 +0200 (CEST)
Date:   Fri, 31 Jul 2020 15:47:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: Update README.md with editorconfig hint
Message-ID: <20200731134758.GL3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200731010334.47406-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731010334.47406-1-dxu@dxuuu.xyz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 30, 2020 at 06:03:34PM -0700, Daniel Xu wrote:
> Add a helpful hint in the README to encourage contributors to install an
> editorconfig plugin. This should help maintain source file consistency
> in the long term (eg tabs instead of spaces).
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Thanks, I've added references to the coding style and reworded the
paragraph a bit.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC60424039
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhJFOjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 10:39:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59312 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhJFOje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 10:39:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3777420381;
        Wed,  6 Oct 2021 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633531061;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P80PkowqiXUSYPUDr9Yfj7kjuKGMxRTAJzmZ6EwOjRc=;
        b=meE5cPIAXPsFv73/R2sgH/35nqTcqOCCJvsL7xCkSU30eecmeOu9rDkmr2Q9kUpYuLbKog
        ygooSiDjYN8Nro0ac7Chzn6/IrEvuFwSq0Pv1gR7DMcuU1V8CZiCPJyB2zYIOCy7e5GZ/S
        EqVQRFq3q+pw83XxwVboLAwRRPVGup0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633531061;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P80PkowqiXUSYPUDr9Yfj7kjuKGMxRTAJzmZ6EwOjRc=;
        b=efCX6RVQc+Dv33CcDH69KGx4RgONsj3WFrkstoinDhPg9simSp8fJrbO8LecJ6MF4SyySA
        x4BLoUpwamqNBBAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B392FA3BCF;
        Wed,  6 Oct 2021 14:37:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2922DA781; Wed,  6 Oct 2021 16:37:20 +0200 (CEST)
Date:   Wed, 6 Oct 2021 16:37:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: remove data extents from the free space tree
Message-ID: <20211006143720.GT9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0394a30e2d64f3a418c7f502a967b9add5632577.1633458057.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0394a30e2d64f3a418c7f502a967b9add5632577.1633458057.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 02:21:08PM -0400, Josef Bacik wrote:
> Dave reported a failure of mkfs-test 009 with the free space tree
> enabled by default.  This is because 009 pre-populates the file system
> with a given directory, and for some reason our data allocation path
> isn't the same as in the kernel.  Fix this by making sure when we
> allocate a data extent we remove the space from the free space tree, and
> with this our mkfs tests now pass.
> 
> Issue: #410
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.

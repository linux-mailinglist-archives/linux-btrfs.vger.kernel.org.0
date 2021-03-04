Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9232D8B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 18:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhCDRi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 12:38:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:43612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239217AbhCDRiB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Mar 2021 12:38:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDD58AE1C
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Mar 2021 17:37:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C82AEDA81D; Thu,  4 Mar 2021 18:35:23 +0100 (CET)
Date:   Thu, 4 Mar 2021 18:35:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove mirror argument from
 btrfs_csum_verify_data()
Message-ID: <20210304173523.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20210303125537.x2moj2kocknnsm6n@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303125537.x2moj2kocknnsm6n@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 06:55:37AM -0600, Goldwyn Rodrigues wrote:
> Unused variable: mirror.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654EC3D244A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGVMYC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:24:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45110 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGVMXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:23:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 33B37203A6;
        Thu, 22 Jul 2021 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626959010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeHi8yqRRd8C3y1PFFiRFVfBm89RDZYPjYDMNnkbB78=;
        b=wNiM9jaQ3Hqm2v0l5TNrS30VUc8MecLkc6MbUpQgs5inDYza5KCtEOXbYhIMuzOYlTJJ9L
        2Uj1aQw3PQIFcECW4T2b2DYBBOEe7mOA7P5NWERc4bdSxqfmfAS4jSJzUqnteip7Da59mg
        0yXiNWRu7sqWSwC13WixTtYO0r86BjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626959010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeHi8yqRRd8C3y1PFFiRFVfBm89RDZYPjYDMNnkbB78=;
        b=H0CvZ0L8XUstbkxMG4RpBmGTykLBaogRX73SrsxSslYNl/3TsZhfJWmkfntQUbRS3J9Dzo
        dcxti4Ww7Dr6TAAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2D53BA3B84;
        Thu, 22 Jul 2021 13:03:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82217DAF95; Thu, 22 Jul 2021 15:00:48 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:00:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: make the batch insertion of dir index keys
 more efficient
Message-ID: <20210722130048.GS19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1626791739.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626791739.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:05:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch makes the batch insertion of dir index keys (delayed items)
> more efficient. The second patch is a cleanup, but only applies cleanly after
> the first patch.

Added to misc-next, thanks.

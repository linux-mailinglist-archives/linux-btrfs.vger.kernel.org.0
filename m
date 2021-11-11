Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8812244D5EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhKKLi6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 06:38:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhKKLi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 06:38:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 974BE21B37;
        Thu, 11 Nov 2021 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636630568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRlUOEQmLugqrQosFsM93EoAmVat3Iek/kqPtCCZppQ=;
        b=S8B85JFObHp8+xy+aXh4YYmpuK2BBMuCKMVm3oBfhuUbMleVcFP0CTIg+l3qXsccV1ZefU
        WWvEomqfbLEjSvclGMFM7rql8UnRF7LKLjMVuprkxp63zZuZX96eKSZq0NNE+dyqbc3Lwc
        3ZhoYjV1tSA6p9Cg81qPMCQi2G/3CRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636630568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRlUOEQmLugqrQosFsM93EoAmVat3Iek/kqPtCCZppQ=;
        b=ffefrLS5cBNxOJ+5IpkB/XdHt5AKkYGwfGZOkKdi1UPVUlNXsQ/bbEnU6QshER6M1kzDft
        zYv09uTZ3jpFSVDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 90876A3B8B;
        Thu, 11 Nov 2021 11:36:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10C14DA799; Thu, 11 Nov 2021 12:36:08 +0100 (CET)
Date:   Thu, 11 Nov 2021 12:36:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_IOC_BALANCE ioctl
Message-ID: <20211111113607.GZ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211110114104.1140727-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110114104.1140727-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 01:41:04PM +0200, Nikolay Borisov wrote:
> The v2 balance ioctl has been introduced more than 9 years ago. Users of
> the old v1 ioctl should have long been migrated to it. It's time we
> deprecate it and eventually remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next with slight reformatting of the message, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292324367B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJUQ2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:28:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54814 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJUQ2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:28:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 14D4D218E1;
        Thu, 21 Oct 2021 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634833582;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4+vDFen0B1+v0OMv/hxR1JTFvVmuiNBpPsF2/xelqU=;
        b=xz45fZWYXsMR0AsPrDxqWN3KtNeYdv0gzLtEtMSE/XpEbTjWm+4476H01FQahwVWHwPEc1
        SXl/Zl6aXHfBuVXLmE9UYqoxWqLSxk2VHPFiUy/BqCeKUilnCPAy3ZUbXgY2lcd5JdSe5f
        GfpDG8j5PFZvAxUoPHuXe4HgzkGLwvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634833582;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4+vDFen0B1+v0OMv/hxR1JTFvVmuiNBpPsF2/xelqU=;
        b=wHNVrovNcDqBjKDwrEUZfEF9zIrPuaYPbgUpx4xC6RkavIhslgTVB/I0oqMqi+01LvJMnT
        5x6Hzw6MyIxP8dAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0C6B4A3B81;
        Thu, 21 Oct 2021 16:26:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 425B6DA7A3; Thu, 21 Oct 2021 18:25:53 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:25:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] btrfs: sysfs convert scnprintf and snprintf to
 use sysfs_emit
Message-ID: <20211021162553.GF20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1634829757.git.anand.jain@oracle.com>
 <8ff89162573399dec6ce5431243e4b45ec2fc4f0.1634829757.git.anand.jain@oracle.com>
 <20211021161939.GE20319@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021161939.GE20319@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 06:19:39PM +0200, David Sterba wrote:
> On Thu, Oct 21, 2021 at 11:31:16PM +0800, Anand Jain wrote:
> I've applied the patch over the local version 1 but I don't see any
> fix related to the the crash report, is that correct?

I saw the reply, the warning was caused by the removed hunks, so it's
sorted now. Patch added to misc-next, thanks.

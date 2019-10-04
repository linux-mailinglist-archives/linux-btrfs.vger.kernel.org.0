Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D689CB8D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfJDLAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 07:00:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfJDLAv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 07:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D6FDAD12;
        Fri,  4 Oct 2019 11:00:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAF30DA7D7; Fri,  4 Oct 2019 13:01:06 +0200 (CEST)
Date:   Fri, 4 Oct 2019 13:01:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: add const function attribute
Message-ID: <20191004110106.GX2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1569587835.git.dsterba@suse.com>
 <543f96a0b47e4856e6adbf3761a56df96480f358.1569587835.git.dsterba@suse.com>
 <625281f3-90fc-56d8-22e9-76557bb3d410@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625281f3-90fc-56d8-22e9-76557bb3d410@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 02:07:50PM +0300, Nikolay Borisov wrote:
> > +struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
> 
> I'm not entirely sure this function is cons. According to the manual:
> 
> Calls to functions whose return value is not affected by changes to the
> observable state of the program and that have no observable effects on
> such state other than to return a value may lend themselves to
> optimizations such as common subexpression elimination.
> 
> The const attribute prohibits a function from reading objects that
> affect its return value between successive invocations. However,
> functions declared with the attribute can safely read objects that do
> not change their return value, such as non-volatile constants.
> 
> 
> My doubt stems from the fact this function actually references outside
> memory, namely gets the ptr to fs_uuids. There is a specific remark not
> to use const when the function takes a ptr argument but it doesn't say
> anything when getting a ptr from a global var.

The fs_uuids are a non-volatile constant. It does not change accross the
lifetime of the module, so all code executed will always see the same
value.

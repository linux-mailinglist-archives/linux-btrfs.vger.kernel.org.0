Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4C31A0C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Feb 2021 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBLOjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 09:39:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:35834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230493AbhBLOjP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 09:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47DF9AC90;
        Fri, 12 Feb 2021 14:38:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A1202DA6E9; Fri, 12 Feb 2021 15:36:39 +0100 (CET)
Date:   Fri, 12 Feb 2021 15:36:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH 4/5] btrfs: scrub_checksum_tree_block() drop its function
 declaration
Message-ID: <20210212143639.GJ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1613019838.git.anand.jain@oracle.com>
 <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19539f16f4292749e201032459f5b2686709f0a.1613019838.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 09:25:18PM -0800, Anand Jain wrote:
> Move the static function scrub_checksum_tree_block() before its use in
> the scrub.c, and drop its declaration.
> 
> No functional changes.

We've rejected patches that move static function within one file unless
there's another reason for it other than removing the prototype.

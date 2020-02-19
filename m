Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5416445C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 13:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBSMgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 07:36:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:50810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSMgO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 07:36:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 958F0C0AF;
        Wed, 19 Feb 2020 12:36:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0820DA838; Wed, 19 Feb 2020 13:35:54 +0100 (CET)
Date:   Wed, 19 Feb 2020 13:35:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH v5 2/5] btrfs: create read policy framework
Message-ID: <20200219123554.GW2902@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <1581937965-16569-3-git-send-email-anand.jain@oracle.com>
 <202002191535.zA4fBD3N%lkp@intel.com>
 <c06da00e-2cb2-806a-f441-6d5a29c7293c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06da00e-2cb2-806a-f441-6d5a29c7293c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 07:40:47PM +0800, Anand Jain wrote:
> 
> >     In file included from fs/btrfs/volumes.c:18:0:
> >     fs/btrfs/volumes.c: In function 'find_live_mirror':
> 
> >>> fs/btrfs/ctree.h:3143:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
>   This is not a bug. May be we can make the robot happy.

Since 5.5 all fall-trhough switch labels should be annotated properly.

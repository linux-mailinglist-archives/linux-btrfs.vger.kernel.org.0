Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73BD719CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfGWNy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 09:54:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfGWNy2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 09:54:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDB7FB030;
        Tue, 23 Jul 2019 13:54:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC9EEDA7D5; Tue, 23 Jul 2019 15:55:04 +0200 (CEST)
Date:   Tue, 23 Jul 2019 15:55:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2 RESEND Rebased] btrfs-progs: add readmirror policy
Message-ID: <20190723135504.GD2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083723.2094-1-anand.jain@oracle.com>
 <20190626083723.2094-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083723.2094-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 04:37:23PM +0800, Anand Jain wrote:
>  	 prop_object_inode, prop_compression},
> +	{"readmirror", "set/get readmirror policy for filesystem", 0,

The help text for the property is useless.

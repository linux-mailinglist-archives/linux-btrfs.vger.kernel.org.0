Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF00150E82
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgBCRRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 12:17:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:33720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBCRRN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 12:17:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F9ACAF21;
        Mon,  3 Feb 2020 17:17:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CC97DA7A1; Mon,  3 Feb 2020 18:16:59 +0100 (CET)
Date:   Mon, 3 Feb 2020 18:16:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
Message-ID: <20200203171659.GA2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203110012.5954-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 03, 2020 at 07:00:08PM +0800, Anand Jain wrote:
> Resend:
>   Patch 4/4 is already integrated without the cleanup and preparatory
>   patches (1,2,3)/4. So I am resending those 3 patches. And the changes
>   in patch 4/4 as in misc-next is imported into patch v5 4/4 here. Patch
>   4/4 has the details of the changes.

All the patches have been merged and now are in linus/master branch. I
haven't reordered the patches so they're not in a group and the
preparatory patches are about 10 commits above v5.5-rc7 which is the
beginning of the branch.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DAC9F5C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 15:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfJCNYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 09:24:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:37444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfJCNYh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Oct 2019 09:24:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9E4CB17C;
        Thu,  3 Oct 2019 13:24:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 000F2DA890; Thu,  3 Oct 2019 15:24:45 +0200 (CEST)
Date:   Thu, 3 Oct 2019 15:24:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add device scanned-by process name in the scan
 message
Message-ID: <20191003132445.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 06:30:48PM +0800, Anand Jain wrote:
> Its very helpful if we had logged the device scanner process name
> to debug the race condition between the systemd-udevd scan and the
> user initiated device forget command.
> 
> This patch adds scanned-by process name to the scan message.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next with the updated message.

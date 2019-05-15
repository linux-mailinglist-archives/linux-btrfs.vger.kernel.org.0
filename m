Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0741F67D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEOOZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 10:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfEOOZQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 10:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 329D1ACF5;
        Wed, 15 May 2019 14:25:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52D35DA8A7; Wed, 15 May 2019 16:26:15 +0200 (CEST)
Date:   Wed, 15 May 2019 16:26:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: scan: cleanup, return errno when we
 have one
Message-ID: <20190515142615.GS3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1553838594-26013-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553838594-26013-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 29, 2019 at 01:49:53PM +0800, Anand Jain wrote:
> @@ -386,7 +386,9 @@ static int cmd_device_scan(int argc, char **argv)
>  	}
>  
>  out:
> -	return !!ret;
> +	if (ret < 0)
> +		return -ret;
> +	return ret;

No, cmd_device_scan as the command handler returns the error code that's
intepreted by shell. Most commands do just 0 and 1, in documented case
there are other values, but we can't return errno here.

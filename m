Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA11C7420
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgEFPU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 11:20:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgEFPU3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 11:20:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA646AFB1;
        Wed,  6 May 2020 15:20:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89574DA83A; Wed,  6 May 2020 17:19:39 +0200 (CEST)
Date:   Wed, 6 May 2020 17:19:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-btrfs-owner@vger.kernel.org
Subject: Re: [PATCH] Btrfs : improve the speed of compare orphan item and
 dead roots with tree root when mount
Message-ID: <20200506151939.GI18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org, linux-btrfs-owner@vger.kernel.org
References: <20200427080411.13273-1-robbieko@synology.com>
 <20200427154628.GE18421@twin.jikos.cz>
 <31c590f2abee67d60ca8941f5e92e924@synology.com>
 <b0f35dbab104cc8119327343f157a48a@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f35dbab104cc8119327343f157a48a@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 05, 2020 at 09:39:21AM +0800, robbieko wrote:
> Hi
> 
> Does anyone have suggestions ?

Please update the changelog explaining the locking change and resend,
thanks.

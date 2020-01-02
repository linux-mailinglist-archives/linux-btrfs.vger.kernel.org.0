Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C724812E69E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgABNWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 08:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgABNWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 08:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94AEEAD4F;
        Thu,  2 Jan 2020 13:22:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D331EDA790; Thu,  2 Jan 2020 14:22:37 +0100 (CET)
Date:   Thu, 2 Jan 2020 14:22:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20200102132237.GE3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <20191230181318.GC3929@twin.jikos.cz>
 <20191230184930.GA61432@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230184930.GA61432@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 01:49:30PM -0500, Dennis Zhou wrote:
> On Mon, Dec 30, 2019 at 07:13:18PM +0100, David Sterba wrote:
> > On Fri, Dec 13, 2019 at 04:22:09PM -0800, Dennis Zhou wrote:
> > Patches 1-12 merged to a temporary misc-next but I haven't pushed it as
> > misc-next yet (it's misc-next-with-discard-v6 in my github repo). There
> > are some comments to patch 13 and up so please send them either as
> > replies or as a shorter series. Thanks.
> 
> Great! Thanks for taking another pass at it all. Would you prefer a pull
> request or just another series? I'll throw on top a couple patches to
> hopefully address the -1 (I'm still not fully sure how it can happen).

Send the patch series please, you can add a link to git repo/branch but
that's not necessary.

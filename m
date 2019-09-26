Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299BEBF638
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfIZPuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 11:50:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfIZPuo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 11:50:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1811AAD6F;
        Thu, 26 Sep 2019 15:50:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9842DA8E5; Thu, 26 Sep 2019 17:51:02 +0200 (CEST)
Date:   Thu, 26 Sep 2019 17:51:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Long An <lan@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: add clean-test.sh to testsuite-files
Message-ID: <20190926155102.GR2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Long An <lan@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1569496362.4199.11.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569496362.4199.11.camel@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 11:12:43AM +0000, Long An wrote:
>     btrfs-progs: add clean-test.sh to testsuite-files
>     
>     If generate testsuite tarball by 'make testsuite', there is no
>     clean-test.sh in it. But some tests need cleanup if a testcase
> failed.
> 
> Signed-off-by: An Long <lan@suse.com>

Applied, thanks.

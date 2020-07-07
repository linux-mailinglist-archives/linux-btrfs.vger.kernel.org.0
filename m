Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06B216E64
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGOKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:10:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGOKh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 10:10:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58394AF2A;
        Tue,  7 Jul 2020 14:10:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AB79DA818; Tue,  7 Jul 2020 16:10:18 +0200 (CEST)
Date:   Tue, 7 Jul 2020 16:10:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] btrfs: ctree: Add do {} while (0) in
 btrfs_{set|clear}_and_info
Message-ID: <20200707141018.GJ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200706145936.13620-1-marcos@mpdesouza.com>
 <14b394fd-b338-63c9-a8a3-ba3c725f1e79@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14b394fd-b338-63c9-a8a3-ba3c725f1e79@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 11:34:12AM +0300, Nikolay Borisov wrote:
> 
> 
> On 6.07.20 г. 17:59 ч., Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Without this change it's not possible to use these macros and having an
> > if-else construction without using braces.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This change would have been better accompanied with another one showing
> intended usage. If it's part of a bigger rework then postpone it and
> send everything altogether.

I think the change is good as is, multi-statement macros should always be
enclosed in do {} while(0);

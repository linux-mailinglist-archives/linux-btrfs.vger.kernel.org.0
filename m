Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552441A273A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgDHQdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 12:33:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:39396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgDHQdo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 12:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB06DABF5;
        Wed,  8 Apr 2020 16:33:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45EBFDA730; Wed,  8 Apr 2020 18:33:06 +0200 (CEST)
Date:   Wed, 8 Apr 2020 18:33:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] btrfs-progs: mkfs-test: Fix check for truncate command
 failing
Message-ID: <20200408163306.GX5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Erhard Furtner <erhard_f@mailbox.org>
References: <20200408123728.19595-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408123728.19595-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 09:37:28AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Commit 31f477ee ("btrfs-progs: mkfs-tests: skip test if truncate fails
> with EFBIG") tried to detect a failure in truncate command by checking
> the $? expecting it to be an errno, when it actually returns 0 or 1.
> 
> To fix this test just check if the command failed (returned 1) and look
> for the output, skipping the test if the OS cannot create a 6E file.
> 
> Fixes: #241
> 
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to devel, thanks.

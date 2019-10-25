Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81CBE5187
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633093AbfJYQq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 12:46:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633080AbfJYQq2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 12:46:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15547B447;
        Fri, 25 Oct 2019 16:46:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 91360DA785; Fri, 25 Oct 2019 18:46:36 +0200 (CEST)
Date:   Fri, 25 Oct 2019 18:46:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race leading to metadata space leak after
 task received signal
Message-ID: <20191025164636.GR3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191025095341.18704-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025095341.18704-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 10:53:41AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
[...]

Queued for 5.4-rc, thanks.

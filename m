Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC010A2E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKZRAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 12:00:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbfKZRAP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 12:00:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CFC92AFB4;
        Tue, 26 Nov 2019 17:00:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 27058DA898; Tue, 26 Nov 2019 18:00:12 +0100 (CET)
Date:   Tue, 26 Nov 2019 18:00:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, anand.jain@oracle.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 0/2] btrfs qgroup cleanup
Message-ID: <20191126170011.GN2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, anand.jain@oracle.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191126005851.11813-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126005851.11813-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 09:58:49PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> While reading the qgroup code and doing some tests, I found some two things
> that I would like to change:
> * Remove some useless code that was being set only to check if
>   fs_info->quota_root was not NULL
> * Check why creating a qgroup was returning EINVAL
> 
> The answer to the second point was: EINVAL is returned when a user tries to
> create/delete/list/assign a qgroup to a subvolume, but this subvolume does
> not have quota enabled. Talking with David, he suggested to change it to
> ENOTCONN, following what is currently being used in balance and scrub.
> 
> So here are the changes. Please take a look!

Added to misc-next with minor subject edits, thanks.
